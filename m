From: Heiko Stübner <heiko@sntech.de>
Date: Fri, 20 Jan 2023 10:47:37 +0100
Subject: [PATCH v2 02/13] spi: Replace all spi->chip_select and spi->cs_gpiod
 references with function call
In-Reply-To: <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
 <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
Message-ID: <3658396.MHq7AAxBmi@diego>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Donnerstag, 19. Januar 2023, 19:53:31 CET schrieb Amit Kumar Mahapatra:
> Supporting multi-cs in spi drivers would require the chip_select & cs_gpiod
> members of struct spi_device to be an array. But changing the type of these
> members to array would break the spi driver functionality. To make the
> transition smoother introduced four new APIs to get/set the
> spi->chip_select & spi->cs_gpiod and replaced all spi->chip_select and
> spi->cs_gpiod references with get or set API calls.
> While adding multi-cs support in further patches the chip_select & cs_gpiod
> members of the spi_device structure would be converted to arrays & the
> "idx" parameter of the APIs would be used as array index i.e.,
> spi->chip_select[idx] & spi->cs_gpiod[idx] respectively.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---

> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index bd87d3c92dd3..246e81453ec3 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -346,7 +346,7 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
>  
>  	/* set the Controller */
>  	ctrl |= SFC_CTRL_PHASE_SEL_NEGETIVE;
> -	cmd |= mem->spi->chip_select << SFC_CMD_CS_SHIFT;
> +	cmd |= spi_get_chipselect(mem->spi, 0) << SFC_CMD_CS_SHIFT;
>  
>  	dev_dbg(sfc->dev, "sfc addr.nbytes=%x(x%d) dummy.nbytes=%x(x%d)\n",
>  		op->addr.nbytes, op->addr.buswidth,
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 79242dc5272d..adc5638eff4b 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -246,28 +246,30 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>  	bool cs_asserted = spi->mode & SPI_CS_HIGH ? enable : !enable;
>  
>  	/* Return immediately for no-op */
> -	if (cs_asserted == rs->cs_asserted[spi->chip_select])
> +	if (cs_asserted == rs->cs_asserted[spi_get_chipselect(spi, 0)])
>  		return;
>  
>  	if (cs_asserted) {
>  		/* Keep things powered as long as CS is asserted */
>  		pm_runtime_get_sync(rs->dev);
>  
> -		if (spi->cs_gpiod)
> +		if (spi_get_csgpiod(spi, 0))
>  			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
>  		else
> -			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, BIT(spi->chip_select));
> +			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
> +					      BIT(spi_get_chipselect(spi, 0)));
>  	} else {
> -		if (spi->cs_gpiod)
> +		if (spi_get_csgpiod(spi, 0))
>  			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
>  		else
> -			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, BIT(spi->chip_select));
> +			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
> +					      BIT(spi_get_chipselect(spi, 0)));
>  
>  		/* Drop reference from when we first asserted CS */
>  		pm_runtime_put(rs->dev);
>  	}
>  
> -	rs->cs_asserted[spi->chip_select] = cs_asserted;
> +	rs->cs_asserted[spi_get_chipselect(spi, 0)] = cs_asserted;
>  }
>  
>  static void rockchip_spi_handle_err(struct spi_controller *ctlr,
> @@ -541,7 +543,7 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
>  	if (spi->mode & SPI_LSB_FIRST)
>  		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
>  	if (spi->mode & SPI_CS_HIGH)
> -		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
> +		cr0 |= BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
>  
>  	if (xfer->rx_buf && xfer->tx_buf)
>  		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
> @@ -724,7 +726,7 @@ static int rockchip_spi_setup(struct spi_device *spi)
>  	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
>  	u32 cr0;
>  
> -	if (!spi->cs_gpiod && (spi->mode & SPI_CS_HIGH) && !rs->cs_high_supported) {
> +	if (!spi_get_csgpiod(spi, 0) && (spi->mode & SPI_CS_HIGH) && !rs->cs_high_supported) {
>  		dev_warn(&spi->dev, "setup: non GPIO CS can't be active-high\n");
>  		return -EINVAL;
>  	}
> @@ -735,10 +737,10 @@ static int rockchip_spi_setup(struct spi_device *spi)
>  
>  	cr0 &= ~(0x3 << CR0_SCPH_OFFSET);
>  	cr0 |= ((spi->mode & 0x3) << CR0_SCPH_OFFSET);
> -	if (spi->mode & SPI_CS_HIGH && spi->chip_select <= 1)
> -		cr0 |= BIT(spi->chip_select) << CR0_SOI_OFFSET;
> -	else if (spi->chip_select <= 1)
> -		cr0 &= ~(BIT(spi->chip_select) << CR0_SOI_OFFSET);
> +	if (spi->mode & SPI_CS_HIGH && spi_get_chipselect(spi, 0) <= 1)
> +		cr0 |= BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
> +	else if (spi_get_chipselect(spi, 0) <= 1)
> +		cr0 &= ~(BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET);
>  
>  	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);

for the two Rockchip drivers
Acked-by: Heiko Stuebner <heiko@sntech.de>


