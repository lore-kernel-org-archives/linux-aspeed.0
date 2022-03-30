From: Pratyush Yadav <p.yadav@ti.com>
Date: Thu, 31 Mar 2022 01:03:43 +0530
Subject: [PATCH v4 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
In-Reply-To: <20220325100849.2019209-4-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-4-clg@kaod.org>
Message-ID: <20220330193343.qg5kcr6twerde6ho@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Cedric,

Thanks for doing the conversion.

On 25/03/22 11:08AM, C?dric Le Goater wrote:
> This SPI driver adds support for the Aspeed static memory controllers
> of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.
> 
>  * AST2600 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . Only supports SPI type flash memory
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2600 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . different segment register interface
>    . single, dual and quad mode.
> 
>  * AST2500 Firmware SPI Memory Controller (FMC)
>    . BMC firmware
>    . 3 chip select pins (CE0 ~ CE2)
>    . supports SPI type flash memory (CE0-CE1)
>    . CE2 can be of NOR type flash but this is not supported by the driver
>    . single, dual mode.
> 
>  * AST2500 SPI Flash Controller (SPI1 and SPI2)
>    . host firmware
>    . 2 chip select pins (CE0 ~ CE1)
>    . single, dual mode.
> 
>  * AST2400 New Static Memory Controller (also referred as FMC)
>    . BMC firmware
>    . New register set
>    . 5 chip select pins (CE0 ? CE4)
>    . supports NOR flash, NAND flash and SPI flash memory.
>    . single, dual and quad mode.
> 
> Each controller has a memory range on which flash devices contents are
> mapped. Each device is assigned a window that can be changed at bootime
> with the Segment Address Registers.
> 
> Each SPI flash device can then be accessed in two modes: Command and
> User. When in User mode, SPI transfers are initiated with accesses to
> the memory segment of a device. When in Command mode, memory
> operations on the memory segment of a device generate SPI commands
> automatically using a Control Register for the settings.
> 
> This initial patch adds support for User mode. Command mode needs a little
> more work to check that the memory window on the AHB bus fits the device
> size. It will come later when support for direct mapping is added.
> 
> Single and dual mode RX transfers are supported. Other types than SPI
> are not supported.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Tao Ren <rentao.bupt@gmail.com>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 910 ------------------
>  drivers/spi/spi-aspeed-smc.c                  | 709 ++++++++++++++
>  .../devicetree/bindings/mtd/aspeed-smc.txt    |  51 -
>  MAINTAINERS                                   |   1 +
>  drivers/mtd/spi-nor/controllers/Kconfig       |  10 -
>  drivers/mtd/spi-nor/controllers/Makefile      |   1 -
>  drivers/spi/Kconfig                           |  11 +
>  drivers/spi/Makefile                          |   1 +
>  8 files changed, 722 insertions(+), 972 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
>  create mode 100644 drivers/spi/spi-aspeed-smc.c
>  delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
> 
[...]
> +static void aspeed_spi_send_cmd_addr(struct aspeed_spi_chip *chip, u8 addr_nbytes,
> +				     u64 offset, u32 opcode)
> +{
> +	struct aspeed_spi *aspi = chip->aspi;
> +	__be32 temp;
> +	u32 cmdaddr;
> +
> +	switch (addr_nbytes) {
> +	default:
> +		dev_warn_once(aspi->dev, "Unexpected address width %u, defaulting to 3",
> +			      addr_nbytes);
> +		fallthrough;

I think it is better if you reject ops where addr width is not 3 or 4. 
This you can drop this. Or if you really want to keep it, you can change 
it to a WARN_ON() and return an error.

> +	case 3:
> +		cmdaddr = offset & 0xFFFFFF;
> +		cmdaddr |= opcode << 24;
> +
> +		temp = cpu_to_be32(cmdaddr);
> +		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
> +		break;
> +	case 4:
> +		temp = cpu_to_be32(offset);
> +		aspeed_spi_write_to_ahb(chip->ahb_base, &opcode, 1);
> +		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
> +		break;
> +	}
> +}
> +
[...]
> +/* support for 1-1-1, 1-1-2 or 1-1-4 */
> +static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	if (op->cmd.buswidth > 1)
> +		return false;
> +
> +	if (op->addr.nbytes != 0) {
> +		if (op->addr.buswidth > 1 || op->addr.nbytes > 4)

As mentioned above, this should reject ops with addr width 1 and 2.

> +			return false;
> +	}
> +
> +	if (op->dummy.nbytes != 0) {
> +		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
> +			return false;
> +	}
> +
> +	if (op->data.nbytes != 0 && op->data.buswidth > 4)
> +		return false;
> +
> +	return spi_mem_default_supports_op(mem, op);
> +}
> +
> +static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
> +	struct aspeed_spi_chip *chip = &aspi->chips[mem->spi->chip_select];
> +	u32 addr_mode, addr_mode_backup;
> +	u32 ctl_val;
> +	int ret = 0;
> +
> +	dev_dbg(aspi->dev,
> +		"CE%d %s OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x len:%#x",
> +		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
> +		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +		op->dummy.buswidth, op->data.buswidth,
> +		op->addr.nbytes, op->dummy.nbytes, op->data.nbytes);
> +
> +	addr_mode = readl(aspi->regs + CE_CTRL_REG);
> +	addr_mode_backup = addr_mode;
> +
> +	ctl_val = chip->ctl_val[ASPEED_SPI_BASE];
> +	ctl_val &= ~CTRL_IO_CMD_MASK;
> +
> +	ctl_val |= op->cmd.opcode << CTRL_COMMAND_SHIFT;
> +
> +	/* 4BYTE address mode */
> +	if (op->addr.nbytes) {
> +		if (op->addr.nbytes == 4)
> +			addr_mode |= (0x11 << chip->cs);
> +		else
> +			addr_mode &= ~(0x11 << chip->cs);
> +	}
> +
> +	if (op->dummy.buswidth && op->dummy.nbytes)

Nitpick: op->dummy.nbytes being set should imply op->dummy.buswidth > 0.

> +		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
> +
> +	if (op->data.nbytes != 0) {
> +		if (op->data.buswidth)

Nitpick: op->data.nbytes != 0 should imply op->data.buswidth > 0.

> +			ctl_val |= aspeed_spi_get_io_mode(op);
> +	}
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		ctl_val |= CTRL_IO_MODE_WRITE;
> +	else
> +		ctl_val |= CTRL_IO_MODE_READ;
> +
> +	if (addr_mode != addr_mode_backup)
> +		writel(addr_mode, aspi->regs + CE_CTRL_REG);
> +	writel(ctl_val, chip->ctl);
> +
> +	if (op->data.dir == SPI_MEM_DATA_IN) {
> +		if (!op->addr.nbytes)
> +			ret = aspeed_spi_read_reg(chip, op);
> +		else
> +			ret = aspeed_spi_read_user(chip, op, op->addr.val,
> +						   op->data.nbytes, op->data.buf.in);
> +	} else {
> +		if (!op->addr.nbytes)
> +			ret = aspeed_spi_write_reg(chip, op);
> +		else
> +			ret = aspeed_spi_write_user(chip, op);
> +	}
> +
> +	/* Restore defaults */
> +	if (addr_mode != addr_mode_backup)
> +		writel(addr_mode_backup, aspi->regs + CE_CTRL_REG);
> +	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);

Why do you need to restore defaults here? Do you expect some other piece 
of software to use it as well?

The patch looks good to me apart from these.

> +	return ret;
> +}
> +
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
