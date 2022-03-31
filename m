From: Pratyush Yadav <p.yadav@ti.com>
Date: Thu, 31 Mar 2022 22:11:15 +0530
Subject: [PATCH v4 08/11] spi: aspeed: Calibrate read timings
In-Reply-To: <20220325100849.2019209-9-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-9-clg@kaod.org>
Message-ID: <20220331164115.w5q3wxlmwcg3w4ns@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 25/03/22 11:08AM, C?dric Le Goater wrote:
> To accommodate the different response time of SPI transfers on different
> boards and different SPI NOR devices, the Aspeed controllers provide a
> set of Read Timing Compensation registers to tune the timing delays
> depending on the frequency being used. The AST2600 SoC has one of these
> registers per device. On the AST2500 and AST2400 SoCs, the timing
> register is shared by all devices which is problematic to get good
> results other than for one device.
> 
> The algorithm first reads a golden buffer at low speed and then performs
> reads with different clocks and delay cycle settings to find a breaking
> point. This selects a default good frequency for the CEx control register.
> The current settings are a bit optimistic as we pick the first delay giving
> good results. A safer approach would be to determine an interval and
> choose the middle value.
> 
> Calibration is performed when the direct mapping for reads is created.
> Since the underlying spi-nor object needs to be initialized to create
> the spi_mem operation for direct mapping, we should be fine. Having a
> specific API would clarify the requirements though.
> 
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
> 
[...]
> @@ -517,6 +527,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>  	return 0;
>  }
>  
> +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
> +
>  static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  {
>  	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
> @@ -565,6 +577,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
>  	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>  
> +	ret = aspeed_spi_do_calibration(chip);
> +

I am still not convinced this is a good idea. The API does not say 
anywhere what dirmap_create must be called after the flash is completely 
initialized, though that is what is done currently in practice. I think 
an explicit API to mark flash as "ready for calibration" would be a 
better idea.

Tudor/Mark/Miquel, what do you think?

>  	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
>  		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
>  
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
