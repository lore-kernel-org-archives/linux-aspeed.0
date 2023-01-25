From: William Zhang <william.zhang@broadcom.com>
Date: Tue, 24 Jan 2023 16:57:49 -0800
Subject: [PATCH v2 02/13] spi: Replace all spi->chip_select and
 spi->cs_gpiod references with function call
In-Reply-To: <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
References: <20230119185342.2093323-1-amit.kumar-mahapatra@amd.com> <20230119185342.2093323-3-amit.kumar-mahapatra@amd.com>
Message-ID: <36840e0caeca5f53eef4fab615fc7976@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/19/2023 10:53 AM, 'Amit Kumar Mahapatra' via
BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c
> b/drivers/spi/spi-bcm63xx-hsspi.c
> index b871fd810d80..dc179c4677d4 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -130,7 +130,7 @@ static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi
> *bs, unsigned int cs,
>   static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
>   				  struct spi_device *spi, int hz)
>   {
> -	unsigned int profile = spi->chip_select;
> +	unsigned int profile = spi_get_chipselect(spi, 0);
>   	u32 reg;
>
>   	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
> @@ -157,7 +157,7 @@ static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi
> *bs,
>   static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct
> spi_transfer *t)
>   {
>   	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
> -	unsigned int chip_select = spi->chip_select;
> +	unsigned int chip_select = spi_get_chipselect(spi, 0);
>   	u16 opcode = 0;
>   	int pending = t->len;
>   	int step_size = HSSPI_BUFFER_LEN;
> @@ -165,7 +165,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device
> *spi, struct spi_transfer *t)
>   	u8 *rx = t->rx_buf;
>
>   	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
> -	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
> +	bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), true);
>
>   	if (tx && rx)
>   		opcode = HSSPI_OP_READ_WRITE;
> @@ -228,14 +228,14 @@ static int bcm63xx_hsspi_setup(struct spi_device
> *spi)
>   	u32 reg;
>
>   	reg = __raw_readl(bs->regs +
> -			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
> +			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
>   	reg &= ~(SIGNAL_CTRL_LAUNCH_RISING | SIGNAL_CTRL_LATCH_RISING);
>   	if (spi->mode & SPI_CPHA)
>   		reg |= SIGNAL_CTRL_LAUNCH_RISING;
>   	else
>   		reg |= SIGNAL_CTRL_LATCH_RISING;
>   	__raw_writel(reg, bs->regs +
> -		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
> +		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi_get_chipselect(spi, 0)));
>
>   	mutex_lock(&bs->bus_mutex);
>   	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
> @@ -243,16 +243,16 @@ static int bcm63xx_hsspi_setup(struct spi_device
> *spi)
>   	/* only change actual polarities if there is no transfer */
>   	if ((reg & GLOBAL_CTRL_CS_POLARITY_MASK) == bs->cs_polarity) {
>   		if (spi->mode & SPI_CS_HIGH)
> -			reg |= BIT(spi->chip_select);
> +			reg |= BIT(spi_get_chipselect(spi, 0));
>   		else
> -			reg &= ~BIT(spi->chip_select);
> +			reg &= ~BIT(spi_get_chipselect(spi, 0));
>   		__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
>   	}
>
>   	if (spi->mode & SPI_CS_HIGH)
> -		bs->cs_polarity |= BIT(spi->chip_select);
> +		bs->cs_polarity |= BIT(spi_get_chipselect(spi, 0));
>   	else
> -		bs->cs_polarity &= ~BIT(spi->chip_select);
> +		bs->cs_polarity &= ~BIT(spi_get_chipselect(spi, 0));
>
>   	mutex_unlock(&bs->bus_mutex);
>
> @@ -283,7 +283,7 @@ static int bcm63xx_hsspi_transfer_one(struct
> spi_master *master,
>   	 * e. At the end restore the polarities again to their default values.
>   	 */
>
> -	dummy_cs = !spi->chip_select;
> +	dummy_cs = !spi_get_chipselect(spi, 0);
>   	bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
>
>   	list_for_each_entry(t, &msg->transfers, transfer_list) {
> @@ -296,7 +296,7 @@ static int bcm63xx_hsspi_transfer_one(struct
> spi_master *master,
>   		spi_transfer_delay_exec(t);
>
>   		if (t->cs_change)
> -			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
> +			bcm63xx_hsspi_set_cs(bs, spi_get_chipselect(spi, 0), false);
>   	}
>
>   	mutex_lock(&bs->bus_mutex);

For bcm63xx-hsspi driver,

Acked-by: William Zhang <william.zhang@broadcom.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4212 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230124/af425631/attachment.p7s>
