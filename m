From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 26 Jul 2023 09:54:59 +0300
Subject: [PATCH v2 34/61] mmc: sdhci-of-aspeed: Convert to platform remove
In-Reply-To: <20230726040041.26267-34-frank.li@vivo.com>
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-34-frank.li@vivo.com>
Message-ID: <6cd56798-dbdf-35d8-a381-a569cbbe00ee@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/07/23 07:00, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index b4867bb4a564..42d54532cabe 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -450,7 +450,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int aspeed_sdhci_remove(struct platform_device *pdev)
> +static void aspeed_sdhci_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> @@ -463,8 +463,6 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(pltfm_host->clk);
>  
>  	sdhci_pltfm_free(pdev);
> -
> -	return 0;
>  }
>  
>  static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
> @@ -520,7 +518,7 @@ static struct platform_driver aspeed_sdhci_driver = {
>  		.of_match_table = aspeed_sdhci_of_match,
>  	},
>  	.probe		= aspeed_sdhci_probe,
> -	.remove		= aspeed_sdhci_remove,
> +	.remove_new	= aspeed_sdhci_remove,
>  };
>  
>  static int aspeed_sdc_probe(struct platform_device *pdev)
> @@ -573,13 +571,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int aspeed_sdc_remove(struct platform_device *pdev)
> +static void aspeed_sdc_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
>  
>  	clk_disable_unprepare(sdc->clk);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id aspeed_sdc_of_match[] = {
> @@ -599,7 +595,7 @@ static struct platform_driver aspeed_sdc_driver = {
>  		.of_match_table = aspeed_sdc_of_match,
>  	},
>  	.probe		= aspeed_sdc_probe,
> -	.remove		= aspeed_sdc_remove,
> +	.remove_new	= aspeed_sdc_remove,
>  };
>  
>  #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)

