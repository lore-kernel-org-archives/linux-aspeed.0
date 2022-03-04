From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Mar 2022 09:36:37 +0100
Subject: [PATCH v3 05/11] spi: aspeed: Add support for direct mapping
In-Reply-To: <20220304083643.1079142-1-clg@kaod.org>
References: <20220304083643.1079142-1-clg@kaod.org>
Message-ID: <20220304083643.1079142-6-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use direct mapping to read the flash device contents. This operation
mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
Control Register for the settings to apply when a memory operation is
performed on the flash device mapping window.

If the window is not big enough, fall back to the "User mode" to
perform the read.

Since direct mapping now handles all reads of the flash device
contents, also use memcpy_fromio for other address spaces, such as
SFDP.

Direct mapping for writes will come later when validated.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 997ec2e45118..0951766baef4 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -322,8 +322,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		if (!op->addr.nbytes)
 			ret = aspeed_spi_read_reg(chip, op);
 		else
-			ret = aspeed_spi_read_user(chip, op, op->addr.val,
-						   op->data.nbytes, op->data.buf.in);
+			memcpy_fromio(op->data.buf.in, chip->ahb_base + op->addr.val,
+				      op->data.nbytes);
 	} else {
 		if (!op->addr.nbytes)
 			ret = aspeed_spi_write_reg(chip, op);
@@ -403,10 +403,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	return chip->ahb_window_size ? 0 : -1;
 }
 
+static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+	struct spi_mem_op *op = &desc->info.op_tmpl;
+	u32 ctl_val;
+	int ret = 0;
+
+	chip->clk_freq = desc->mem->spi->max_speed_hz;
+
+	/* Only for reads */
+	if (op->data.dir != SPI_MEM_DATA_IN)
+		return -EOPNOTSUPP;
+
+	if (desc->info.length > chip->ahb_window_size)
+		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
+			 chip->cs, chip->ahb_window_size >> 20);
+
+	/* Define the default IO read settings */
+	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
+	ctl_val |= aspeed_spi_get_io_mode(op) |
+		op->cmd.opcode << CTRL_COMMAND_SHIFT |
+		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
+		CTRL_IO_MODE_READ;
+
+	/* Tune 4BYTE address mode */
+	if (op->addr.nbytes) {
+		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
+
+		if (op->addr.nbytes == 4)
+			addr_mode |= (0x11 << chip->cs);
+		else
+			addr_mode &= ~(0x11 << chip->cs);
+		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+	}
+
+	/* READ mode is the controller default setting */
+	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+
+	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
+		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
+
+	return ret;
+}
+
+static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offset, size_t len, void *buf)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
+
+	/* Switch to USER command mode if mapping window is too small */
+	if (chip->ahb_window_size < offset + len)
+		aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
+	else
+		memcpy_fromio(buf, chip->ahb_base + offset, len);
+
+	return len;
+}
+
 static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
 	.supports_op = aspeed_spi_supports_op,
 	.exec_op = aspeed_spi_exec_op,
 	.get_name = aspeed_spi_get_name,
+	.dirmap_create = aspeed_spi_dirmap_create,
+	.dirmap_read = aspeed_spi_dirmap_read,
 };
 
 static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
-- 
2.34.1

