From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Mar 2022 22:30:08 +0000
Subject: [PATCH v2 07/10] spi: aspeed: Workaround AST2500 limitations
In-Reply-To: <20220302173114.927476-8-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
 <20220302173114.927476-8-clg@kaod.org>
Message-ID: <CACPK8Xesu-3cfH+fPvNGW=JfntTarTSv1njb1FBZ7pD2-TMbMA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Mar 2022 at 17:31, C?dric Le Goater <clg@kaod.org> wrote:
>
> It is not possible to configure a full 128MB window for a chip of the
> same size on the AST2500 SPI controller. For his case, the maximum

typo: this

> window size is restricted to 120MB for CE0.
>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 974ab215ec34..e133984d3c95 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -445,6 +445,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
>   * - ioremap each window, not strictly necessary since the overall window
>   *   is correct.
>   */
> +static const struct aspeed_spi_data ast2500_spi_data;
> +
>  static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>                                          u32 local_offset, u32 size)
>  {
> @@ -453,6 +455,16 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>         struct aspeed_spi_window *win = &windows[chip->cs];
>         int ret;
>
> +       /*
> +        * Due to an HW issue on the AST2500 SPI controller, the CE0
> +        * window size should be smaller than the maximum 128MB.
> +        */
> +       if (aspi->data == &ast2500_spi_data && chip->cs == 0 && size == SZ_128M) {
> +               size = 120 << 20;
> +               dev_info(aspi->dev, "CE%d window resized to %dMB (AST2500 HW quirk)",
> +                        chip->cs, size >> 20);
> +       }
> +
>         aspeed_spi_get_windows(aspi, windows);
>
>         /* Adjust this chip window */
> --
> 2.34.1
>
