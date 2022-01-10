From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 10 Jan 2022 09:01:48 -0800
Subject: [PATCH v3] fsi: Aspeed: Fix a potential double free
In-Reply-To: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
References: <2c123f8b0a40dc1a061fae982169fe030b4f47e6.1641765339.git.christophe.jaillet@wanadoo.fr>
Message-ID: <3c4ff68f-3686-bcc6-c370-0732860b4d80@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/9/22 1:56 PM, Christophe JAILLET wrote:
> A struct device can never be devm_alloc()'ed.
> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
> embedded in "struct fsi_master_aspeed".
> 
> Since "struct device" is embedded, the data structure embedding it must be
> released with the release function, as is already done here.
> 
> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed" and
> update all error handling branches accordingly.
> 
> This prevent a potential double free().
> 
> This also fix another issue if opb_readl() fails. Instead of a direct
> return, it now jumps in the error handling path.
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: Keep the release function which is correct
>      s/devm_kzalloc()/kzalloc()/ instead
> 
> v3: Update the error handling path to free "aspeed" [Guenter Roeck]
>      Fix another issue when opb_readl() fails [Guenter Roeck]
> 
> I hope that fixing both issues in the same patch is ok. It makes no sense
> to me not to update the goto to the correct label if opb_readl() fails.
> ---
>   drivers/fsi/fsi-master-aspeed.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..0bed2fab8055 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -542,25 +542,28 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   		return rc;
>   	}
>   
> -	aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
> +	aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);
>   	if (!aspeed)
>   		return -ENOMEM;
>   
>   	aspeed->dev = &pdev->dev;
>   
>   	aspeed->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(aspeed->base))
> -		return PTR_ERR(aspeed->base);
> +	if (IS_ERR(aspeed->base)) {
> +		rc = PTR_ERR(aspeed->base);
> +		goto err_free_aspeed;
> +	}
>   
>   	aspeed->clk = devm_clk_get(aspeed->dev, NULL);
>   	if (IS_ERR(aspeed->clk)) {
>   		dev_err(aspeed->dev, "couldn't get clock\n");
> -		return PTR_ERR(aspeed->clk);
> +		rc = PTR_ERR(aspeed->clk);
> +		goto err_free_aspeed;
>   	}
>   	rc = clk_prepare_enable(aspeed->clk);
>   	if (rc) {
>   		dev_err(aspeed->dev, "couldn't enable clock\n");
> -		return rc;
> +		goto err_free_aspeed;
>   	}
>   
>   	rc = setup_cfam_reset(aspeed);
> @@ -595,7 +598,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   	rc = opb_readl(aspeed, ctrl_base + FSI_MVER, &raw);
>   	if (rc) {
>   		dev_err(&pdev->dev, "failed to read hub version\n");
> -		return rc;
> +		goto err_release;
>   	}
>   
>   	reg = be32_to_cpu(raw);
> @@ -634,6 +637,8 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   
>   err_release:
>   	clk_disable_unprepare(aspeed->clk);
> +err_free_aspeed:
> +	kfree(aspeed);
>   	return rc;
>   }
>   
> 

