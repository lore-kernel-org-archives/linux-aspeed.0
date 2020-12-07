From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Mon, 7 Dec 2020 09:10:05 +0000
Subject: [PATCH v4 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <20201207090013.14145-3-troy_lee@aspeedtech.com>
References: <20201207090013.14145-1-troy_lee@aspeedtech.com>
 <20201207090013.14145-3-troy_lee@aspeedtech.com>
Message-ID: <1B46140C-F028-42C4-8FEA-F1561CFB37BE@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Adding AST2400 and AST2600 edac driver support.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>


> ---
     drivers/edac/Kconfig       | 6 +++---
>  drivers/edac/aspeed_edac.c | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7a47680d6f07..c410331e8ee8 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -515,10 +515,10 @@ config EDAC_QCOM
>  	  health, you should probably say 'Y' here.
>
>  config EDAC_ASPEED
> -	tristate "Aspeed AST 2500 SoC"
> -	depends on MACH_ASPEED_G5
> +	tristate "Aspeed AST BMC SoC"
> +	depends on ARCH_ASPEED
>  	help
> -	  Support for error detection and correction on the Aspeed AST 2500 SoC.
> +	  Support for error detection and correction on the Aspeed AST BMC SoC.
>
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fde809efc520..a46da56d6d54 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -239,7 +239,7 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	int rc;
>
>  	/* retrieve info about physical memory from device tree */
> -	np = of_find_node_by_path("/memory");
> +	np = of_find_node_by_name(NULL, "memory");
>  	if (!np) {
>  		dev_err(mci->pdev, "dt: missing /memory node\n");
>  		return -ENODEV;
> @@ -375,10 +375,13 @@ static int aspeed_remove(struct platform_device *pdev)
>
>
>  static const struct of_device_id aspeed_of_match[] = {
> +	{ .compatible = "aspeed,ast2400-sdram-edac" },
>  	{ .compatible = "aspeed,ast2500-sdram-edac" },
> +	{ .compatible = "aspeed,ast2600-sdram-edac" },
>  	{},
>  };
>
> +MODULE_DEVICE_TABLE(of, aspeed_of_match);
>
>  static struct platform_driver aspeed_driver = {
>  	.driver		= {
> @@ -392,5 +395,5 @@ module_platform_driver(aspeed_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> -MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> +MODULE_DESCRIPTION("Aspeed BMC SoC EDAC driver");
>  MODULE_VERSION("1.0");
> -- 
> 2.17.1


