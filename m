From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 07 Dec 2020 11:32:57 +1030
Subject: [PATCH v3 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <20201202101218.18393-3-troy_lee@aspeedtech.com>
References: <20201202101218.18393-1-troy_lee@aspeedtech.com>
 <20201202101218.18393-3-troy_lee@aspeedtech.com>
Message-ID: <21488758-f839-4762-93d6-0e6c3397394f@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 2 Dec 2020, at 20:42, Troy Lee wrote:
> Adding AST2400 and AST2600 edac driver support.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
> Changes since v2:
> - Remove cross dependencies export functions
> - Update Kconfig depends on ARCH_ASPEED
> - Patch create against latest Linux kernel mainline
> 
> ---
>  drivers/edac/Kconfig       |  6 +++---
>  drivers/edac/aspeed_edac.c | 15 +++++----------
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
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
> index fde809efc520..c9d1d8a8fcba 100644
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
> @@ -282,7 +282,6 @@ static int aspeed_probe(struct platform_device *pdev)
>  	struct edac_mc_layer layers[2];
>  	struct mem_ctl_info *mci;
>  	void __iomem *regs;
> -	u32 reg04;
>  	int rc;
>  
>  	regs = devm_platform_ioremap_resource(pdev, 0);
> @@ -294,13 +293,6 @@ static int aspeed_probe(struct platform_device *pdev)
>  	if (IS_ERR(aspeed_regmap))
>  		return PTR_ERR(aspeed_regmap);
>  
> -	/* bail out if ECC mode is not configured */
> -	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
> -	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> -		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> -		return -EPERM;
> -	}
> -

It might pay to separate this out as I think it's unrelated to the supporting 
the AST2[45]00?

Other than that I think the patch is on the right track.

Thanks for the quick responses Troy!

Andrew

>  	edac_op_state = EDAC_OPSTATE_INT;
>  
>  	/* allocate & init EDAC MC data structure */
> @@ -375,10 +367,13 @@ static int aspeed_remove(struct platform_device *pdev)
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
> @@ -392,5 +387,5 @@ module_platform_driver(aspeed_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> -MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
> +MODULE_DESCRIPTION("Aspeed BMC SoC EDAC driver");
>  MODULE_VERSION("1.0");
> -- 
> 2.17.1
> 
>
