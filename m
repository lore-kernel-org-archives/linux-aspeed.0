From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 22 Jun 2022 12:34:12 +0200
Subject: [PATCH v2 1/2] spi: aspeed: Add pr_debug in
 aspeed_spi_dirmap_create()
In-Reply-To: <20220622094233.3681843-2-clg@kaod.org>
References: <20220622094233.3681843-1-clg@kaod.org>
 <20220622094233.3681843-2-clg@kaod.org>
Message-ID: <babc9b4e-7f6c-6ca2-1132-b4571f524eb8@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear C?dric,


Am 22.06.22 um 11:42 schrieb C?dric Le Goater:
> It helps to analyze the default setting of the control register.

Maybe paste the new log line to the commit message.

> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>   drivers/spi/spi-aspeed-smc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 496f3e1e9079..ac64be289e59 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -558,6 +558,14 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>   	u32 ctl_val;
>   	int ret = 0;
>   
> +	dev_dbg(aspi->dev,

The commit message summary says `pr_debug()`.

> +		"CE%d %s dirmap [ 0x%.8llx - 0x%.8llx ] OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x\n",
> +		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
> +		desc->info.offset, desc->info.offset + desc->info.length,
> +		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +		op->dummy.buswidth, op->data.buswidth,
> +		op->addr.nbytes, op->dummy.nbytes);
> +
>   	chip->clk_freq = desc->mem->spi->max_speed_hz;
>   
>   	/* Only for reads */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
