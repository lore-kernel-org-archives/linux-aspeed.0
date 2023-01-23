From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 23 Jan 2023 14:10:05 +0100
Subject: [PATCH v2 02/13] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
 <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
Message-ID: <d1743abc-3d9f-cdf4-dfbe-67aac4b1b8cd@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/19/23 19:53, Amit Kumar Mahapatra wrote:
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 873ff2cf72c9..b7a9ec550ba1 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -296,7 +296,7 @@ static const struct aspeed_spi_data ast2400_spi_data;
>   static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
> -	struct aspeed_spi_chip *chip = &aspi->chips[mem->spi->chip_select];
> +	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(mem->spi, 0)];
>   	u32 addr_mode, addr_mode_backup;
>   	u32 ctl_val;
>   	int ret = 0;
> @@ -377,7 +377,8 @@ static const char *aspeed_spi_get_name(struct spi_mem *mem)
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
>   	struct device *dev = aspi->dev;
>   
> -	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
> +	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
> +			      spi_get_chipselect(mem->spi, 0));
>   }
>   
>   struct aspeed_spi_window {
> @@ -553,7 +554,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
>   static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> -	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
> +	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(desc->mem->spi, 0)];
>   	struct spi_mem_op *op = &desc->info.op_tmpl;
>   	u32 ctl_val;
>   	int ret = 0;
> @@ -620,7 +621,7 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
>   				      u64 offset, size_t len, void *buf)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> -	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
> +	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(desc->mem->spi, 0)];
>   
>   	/* Switch to USER command mode if mapping window is too small */
>   	if (chip->ahb_window_size < offset + len) {
> @@ -670,7 +671,7 @@ static int aspeed_spi_setup(struct spi_device *spi)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
>   	const struct aspeed_spi_data *data = aspi->data;
> -	unsigned int cs = spi->chip_select;
> +	unsigned int cs = spi_get_chipselect(spi, 0);
>   	struct aspeed_spi_chip *chip = &aspi->chips[cs];
>   
>   	chip->aspi = aspi;
> @@ -697,7 +698,7 @@ static int aspeed_spi_setup(struct spi_device *spi)
>   static void aspeed_spi_cleanup(struct spi_device *spi)
>   {
>   	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
> -	unsigned int cs = spi->chip_select;
> +	unsigned int cs = spi_get_chipselect(spi, 0);
>   
>   	aspeed_spi_chip_enable(aspi, cs, false);
>   

For the Aspeed driver,

Reviewed-by: C?dric Le Goater <clg@kaod.org>

Thanks,

C.
