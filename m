From: Pratyush Yadav <p.yadav@ti.com>
Date: Mon, 13 Jun 2022 14:09:52 +0530
Subject: [PATCH] spi: aspeed: Fix division by zero
In-Reply-To: <20220611103929.1484062-1-clg@kaod.org>
References: <20220611103929.1484062-1-clg@kaod.org>
Message-ID: <20220613083952.4z45ulaxdy2okbho@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/06/22 12:39PM, C?dric Le Goater wrote:
> When using the normal read operation for data transfers, the dummy bus
> width is zero. In that case, they are no dummy bytes to transfer and
> setting the dummy field in the controller register becomes useless.
> 
> Issue was found on a custom "Bifrost" board with a AST2500 SoC and
> using a MX25L51245GMI-08G SPI Flash.
> 
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Reported-by: Ian Woloschin <ian.woloschin@akamai.com>
> Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 496f3e1e9079..3e891bf22470 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -558,6 +558,14 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	u32 ctl_val;
>  	int ret = 0;
>  
> +	dev_dbg(aspi->dev,
> +		"CE%d %s dirmap [ 0x%.8llx - 0x%.8llx ] OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x\n",
> +		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
> +		desc->info.offset, desc->info.offset + desc->info.length,
> +		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +		op->dummy.buswidth, op->data.buswidth,
> +		op->addr.nbytes, op->dummy.nbytes);
> +

Unrelated change. Please send as a separate patch.

>  	chip->clk_freq = desc->mem->spi->max_speed_hz;
>  
>  	/* Only for reads */
> @@ -574,9 +582,11 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
>  	ctl_val |= aspeed_spi_get_io_mode(op) |
>  		op->cmd.opcode << CTRL_COMMAND_SHIFT |
> -		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
>  		CTRL_IO_MODE_READ;
>  
> +	if (op->dummy.nbytes)
> +		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
> +

LGTM. With the above fixed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

>  	/* Tune 4BYTE address mode */
>  	if (op->addr.nbytes) {
>  		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
> -- 
> 2.35.3
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
