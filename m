From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Jun 2022 05:15:07 +0000
Subject: [PATCH v3 1/2] spi: aspeed: Add dev_dbg() to dump the spi-mem
 direct mapping descriptor
In-Reply-To: <20220622161617.3719096-2-clg@kaod.org>
References: <20220622161617.3719096-1-clg@kaod.org> <20220622161617.3719096-2-clg@kaod.org>
Message-ID: <CACPK8XdeEmv7exWngQkEYs+oj5vV6YjqSvvfuq+5fn8MotxpsA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Jun 2022 at 16:16, C?dric Le Goater <clg@kaod.org> wrote:
>
> The default value of the control register is set using the direct
> mapping information passed to the ->dirmap_create() handler. Dump the
> mapping range and the SPI memory operation characteristics to analyze
> how the register value has been computed.
>
>   spi-aspeed-smc 1e630000.spi: CE0 read dirmap [ 0x00000000 - 0x04000000 ] OP 0x6c mode:1.1.1.4 naddr:0x4 ndummies:0x1
>   ...
>   spi-aspeed-smc 1e630000.spi: CE0 write dirmap [ 0x00000000 - 0x04000000 ] OP 0x12 mode:1.1.0.1 naddr:0x4 ndummies:0x0
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Very handy! Thanks C?dric.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 496f3e1e9079..ac64be289e59 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -558,6 +558,14 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>         u32 ctl_val;
>         int ret = 0;
>
> +       dev_dbg(aspi->dev,
> +               "CE%d %s dirmap [ 0x%.8llx - 0x%.8llx ] OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x\n",
> +               chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
> +               desc->info.offset, desc->info.offset + desc->info.length,
> +               op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +               op->dummy.buswidth, op->data.buswidth,
> +               op->addr.nbytes, op->dummy.nbytes);
> +
>         chip->clk_freq = desc->mem->spi->max_speed_hz;
>
>         /* Only for reads */
> --
> 2.35.3
>
