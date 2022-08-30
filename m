From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Aug 2022 04:01:22 +0000
Subject: [PATCH] crypto: aspeed: fix return value check in
 aspeed_hace_probe()
In-Reply-To: <20220830031347.810217-1-sunke32@huawei.com>
References: <20220830031347.810217-1-sunke32@huawei.com>
Message-ID: <TY2PR06MB3213B139F88D72C3EEED7A0780799@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Sun Ke <sunke32@huawei.com>
> Sent: Tuesday, August 30, 2022 11:14 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; herbert at gondor.apana.org.au;
> davem at davemloft.net; joel at jms.id.au
> Cc: linux-aspeed at lists.ozlabs.org; linux-crypto at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; kernel-janitors at vger.kernel.org;
> sunke32 at huawei.com
> Subject: [PATCH] crypto: aspeed: fix return value check in aspeed_hace_probe()
> 
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() not NULL. The NULL test in the return value check must be replaced
> with IS_ERR().
> 
> Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Thanks for the fix.
Reviewed-by: Neal Liu<neal_liu@aspeedtech.com>

> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-hace.c
> b/drivers/crypto/aspeed/aspeed-hace.c
> index 4fefc9e69d72..3f880aafb6a2 100644
> --- a/drivers/crypto/aspeed/aspeed-hace.c
> +++ b/drivers/crypto/aspeed/aspeed-hace.c
> @@ -123,9 +123,9 @@ static int aspeed_hace_probe(struct platform_device
> *pdev)
>  	platform_set_drvdata(pdev, hace_dev);
> 
>  	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
> -	if (!hace_dev->regs) {
> +	if (IS_ERR(hace_dev->regs)) {
>  		dev_err(&pdev->dev, "Failed to map resources\n");
> -		return -ENOMEM;
> +		return PTR_ERR(hace_dev->regs);
>  	}
> 
>  	/* Get irq number and register it */
> --
> 2.31.1

