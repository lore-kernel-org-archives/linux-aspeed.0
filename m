From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 15 Mar 2023 12:23:45 +0200
Subject: [PATCH -next] mmc: sdhci-of-aspeed: Use
 devm_platform_get_and_ioremap_resource()
In-Reply-To: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
References: <20230315055023.61779-1-yang.lee@linux.alibaba.com>
Message-ID: <08ce7ccc-5590-1adb-bba9-71e6051e7058@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 15/03/23 07:50, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ba6677bf7372..25b4073f698b 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -547,8 +547,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> +	sdc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &sdc->res);
>  	if (IS_ERR(sdc->regs)) {
>  		ret = PTR_ERR(sdc->regs);
>  		goto err_clk;

