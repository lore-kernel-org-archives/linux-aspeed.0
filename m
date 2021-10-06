From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Tue,  5 Oct 2021 17:03:14 -0700
Subject: [PATCH 3/6] mtd: spi-nor: aspeed: Refactor
 registration/unregistration
In-Reply-To: <20210929115409.21254-4-zev@bewilderbeest.net>
References: <20210929115409.21254-4-zev@bewilderbeest.net>
Message-ID: <1633478594-16793-1-git-send-email-dphadke@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 29 Sep 2021, Zev Weiss wrote:

> We now have separate functions for registering and unregistering
> individual flash chips, instead of the entire controller.  This is a
> preparatory step for allowing userspace to request that a specific
> chip be attached or detached at runtime.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
> drivers/mtd/spi-nor/controllers/aspeed-smc.c | 73 ++++++++++++--------
> 1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> index 7225870e8b18..3c153104a905 100644
> --- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> +++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> @@ -107,9 +107,10 @@ struct aspeed_smc_controller {
> 	const struct aspeed_smc_info *info;	/* type info of controller */
> 	void __iomem *regs;			/* controller registers */
> 	void __iomem *ahb_base;			/* per-chip windows resource */
> +	struct resource *ahb_res;		/* resource for AHB address space */
> 	u32 ahb_window_size;			/* full mapping window size */
>
> -	struct aspeed_smc_chip *chips[];	/* pointers to attached chips */
> +	struct aspeed_smc_chip *chips[];	/* pointers to connected chips */
> };
>
> /*
> @@ -399,15 +400,24 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
> 	return len;
> }
>
> +static int aspeed_smc_unregister_chip(struct aspeed_smc_chip *chip)
> +{
> +	return mtd_device_unregister(&chip->nor.mtd);
> +}
> +
> static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
> {
> 	struct aspeed_smc_chip *chip;
> -	int n;
> +	int n, ret;
>
> 	for (n = 0; n < controller->info->nce; n++) {
> 		chip = controller->chips[n];
> -		if (chip)
> -			mtd_device_unregister(&chip->nor.mtd);
> +		if (chip) {
> +			ret = aspeed_smc_unregister_chip(chip);
> +			if (ret)
> +				dev_warn(controller->dev, "failed to unregister CS%d: %d\n",
> +				         n, ret);
> +		}
> 	}
>
> 	return 0;
> @@ -756,14 +766,39 @@ static const struct spi_nor_controller_ops aspeed_smc_controller_ops = {
> 	.write = aspeed_smc_write_user,
> };
>
> -static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
> -				  struct device_node *np, struct resource *r)
> +static int aspeed_smc_register_chip(struct aspeed_smc_chip *chip)
> {
> -	const struct spi_nor_hwcaps hwcaps = {
> +	static const struct spi_nor_hwcaps hwcaps = {
> 		.mask = SNOR_HWCAPS_READ |
> 			SNOR_HWCAPS_READ_FAST |
> 			SNOR_HWCAPS_PP,
> 	};
> +	int ret;
> +
> +	ret = aspeed_smc_chip_setup_init(chip, chip->controller->ahb_res);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * TODO: Add support for Dual and Quad SPI protocols attach when board
> +	 * support is present as determined by of property.
> +	 */
> +	ret = spi_nor_scan(&chip->nor, NULL, &hwcaps);
> +	if (ret)
> +		goto out;
> +
> +	ret = aspeed_smc_chip_setup_finish(chip);
> +	if (ret)
> +		goto out;
> +
> +	ret = mtd_device_register(&chip->nor.mtd, NULL, 0);
> +out:
> +	return ret;
> +}

I was looking into this driver probe walking sub-nodes.

It looks like all controller drivers are doing / have to do similar work -

(1) Parse common dt bindings documented in Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
(2) Run spi_nor_scan() with tweaked/reduced capabilities.
(3) mtd_register_device().

It would be good to absorb this workflow in mtd/spi-nor core and add 'reserved' as common
dt property to avoid (2) and (3) from probe.


Regards,
Dhananjay

