From: Serge Semin <fancer.lancer@gmail.com>
Date: Mon, 23 Jan 2023 18:04:56 +0300
Subject: [PATCH v2 02/13] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com>
 <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
Message-ID: <20230123145953.ytaaq3x4tetgepyf@mobilestation>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jan 20, 2023 at 12:23:31AM +0530, Amit Kumar Mahapatra wrote:
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

[nip]

>  drivers/spi/spi-dw-core.c         |  2 +-
>  drivers/spi/spi-dw-mmio.c         |  4 ++--

[nip]

> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 99edddf9958b..4fd1aa800cc3 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -103,7 +103,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  	 * support active-high or active-low CS level.
>  	 */
>  	if (cs_high == enable)
> -		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> +		dw_writel(dws, DW_SPI_SER, BIT(spi_get_chipselect(spi, 0)));
>  	else
>  		dw_writel(dws, DW_SPI_SER, 0);
>  }
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index 26c40ea6dd12..d511da766ce8 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -65,7 +65,7 @@ static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
>  	struct dw_spi *dws = spi_master_get_devdata(spi->master);
>  	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>  	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
> -	u32 cs = spi->chip_select;
> +	u32 cs = spi_get_chipselect(spi, 0);
>  
>  	if (cs < 4) {
>  		u32 sw_mode = MSCC_SPI_MST_SW_MODE_SW_PIN_CTRL_MODE;
> @@ -138,7 +138,7 @@ static void dw_spi_sparx5_set_cs(struct spi_device *spi, bool enable)
>  	struct dw_spi *dws = spi_master_get_devdata(spi->master);
>  	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
>  	struct dw_spi_mscc *dwsmscc = dwsmmio->priv;
> -	u8 cs = spi->chip_select;
> +	u8 cs = spi_get_chipselect(spi, 0);
>  
>  	if (!enable) {
>  		/* CS override drive enable */

For the DW SSI part:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

[nip]
