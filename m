From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 9 Jan 2022 12:05:26 -0800
Subject: [PATCH v2] fsi: Aspeed: Fix a potential double free
In-Reply-To: <3b5c9b693749a956b525c54bed0eeac9f958b8e8.1641734402.git.christophe.jaillet@wanadoo.fr>
References: <3b5c9b693749a956b525c54bed0eeac9f958b8e8.1641734402.git.christophe.jaillet@wanadoo.fr>
Message-ID: <5ecd3555-092c-e11d-deb4-98da7c0e3e01@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/9/22 5:20 AM, Christophe JAILLET wrote:
> A struct device can never be devm_alloc()'ed.
> Here, it is embedded in "struct fsi_master", and "struct fsi_master" is
> embedded in "struct fsi_master_aspeed".
> 
> Since "struct device" is embedded, the data structure embedding it must be
> released with the release function, as is already done here.
> 
> So use kzalloc() instead of devm_kzalloc() when allocating "aspeed".
> This prevent a potential double free().
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Keep the release function which is correct
>      s/devm_kzalloc()/kzalloc()/ instead
> ---
>   drivers/fsi/fsi-master-aspeed.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index 8606e55c1721..ae6319818b14 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -542,7 +542,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>   		return rc;
>   	}
>   
> -	aspeed = devm_kzalloc(&pdev->dev, sizeof(*aspeed), GFP_KERNEL);
> +	aspeed = kzalloc(sizeof(*aspeed), GFP_KERNEL);

Unfortunately it isn't that easy. error handling in the probe function must take this
into account and free the memory. Looking at that exposes another bug: The
failure in opb_readl() should not result in a direct return but disable and
unprepare the clock.

Guenter
