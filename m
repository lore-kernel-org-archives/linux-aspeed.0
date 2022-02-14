From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 14 Feb 2022 10:42:28 +0100
Subject: [PATCH 07/10] spi: aspeed: Add support for the AST2400 SPI controller
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
Message-ID: <20220214094231.3753686-8-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Extend the driver for the AST2400 SPI Flash Controller (SPI). This
controller has a slightly different interface which requires
adaptation of the 4B handling. Summary of features :

   . host Firmware
   . 1 chip select pin (CE0)
   . slightly different register set, between AST2500 and the legacy
     controller
   . no segment registers
   . single, dual mode.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index c6ac3253d7d5..e44e80bab50f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -32,6 +32,7 @@
 #define   CTRL_IO_DUAL_DATA		BIT(29)
 #define   CTRL_IO_QUAD_DATA		BIT(30)
 #define   CTRL_COMMAND_SHIFT		16
+#define   CTRL_IO_ADDRESS_4B		BIT(13)	/* AST2400 SPI only */
 #define   CTRL_IO_DUMMY_SET(dummy)					\
 	(((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
 #define   CTRL_CE_STOP_ACTIVE		BIT(2)
@@ -293,6 +294,8 @@ static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op
 	return true;
 }
 
+static const struct aspeed_spi_data ast2400_spi_data;
+
 static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
@@ -322,6 +325,9 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 			addr_mode |= (0x11 << chip->cs);
 		else
 			addr_mode &= ~(0x11 << chip->cs);
+
+		if (op->addr.nbytes == 4 && chip->aspi->data == &ast2400_spi_data)
+			ctl_val |= CTRL_IO_ADDRESS_4B;
 	}
 
 	if (op->dummy.buswidth && op->dummy.nbytes)
@@ -413,7 +419,13 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
 	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
 	struct aspeed_spi_window *win = &windows[chip->cs];
 
-	aspeed_spi_get_windows(aspi, windows);
+	/* No segment registers for the AST2400 SPI controller */
+	if (aspi->data == &ast2400_spi_data) {
+		win->offset = 0;
+		win->size = aspi->ahb_window_size;
+	} else {
+		aspeed_spi_get_windows(aspi, windows);
+	}
 
 	chip->ahb_base = aspi->ahb_base + win->offset;
 	chip->ahb_window_size = win->size;
@@ -476,6 +488,10 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	struct aspeed_spi_window *win = &windows[chip->cs];
 	int ret;
 
+	/* No segment registers for the AST2400 SPI controller */
+	if (aspi->data == &ast2400_spi_data)
+		return 0;
+
 	/*
 	 * Due to an HW issue on the AST2500 SPI controller, the CE0
 	 * window size should be smaller than the maximum 128MB.
@@ -560,6 +576,12 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 		else
 			addr_mode &= ~(0x11 << chip->cs);
 		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+
+		/* AST2400 SPI controller sets 4BYTE address mode in
+		 * CE0 Control Register
+		 */
+		if (op->addr.nbytes == 4 && chip->aspi->data == &ast2400_spi_data)
+			ctl_val |= CTRL_IO_ADDRESS_4B;
 	}
 
 	/* READ mode is the controller default setting */
@@ -860,6 +882,14 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
 	.segment_reg   = aspeed_spi_segment_reg,
 };
 
+static const struct aspeed_spi_data ast2400_spi_data = {
+	.max_cs	       = 1,
+	.hastype       = false,
+	.we0	       = 0,
+	.ctl0	       = 0x04,
+	/* No segment registers */
+};
+
 static const struct aspeed_spi_data ast2500_fmc_data = {
 	.max_cs	       = 3,
 	.hastype       = true,
@@ -904,6 +934,7 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 
 static const struct of_device_id aspeed_spi_matches[] = {
 	{ .compatible = "aspeed,ast2400-fmc", .data = &ast2400_fmc_data },
+	{ .compatible = "aspeed,ast2400-spi", .data = &ast2400_spi_data },
 	{ .compatible = "aspeed,ast2500-fmc", .data = &ast2500_fmc_data },
 	{ .compatible = "aspeed,ast2500-spi", .data = &ast2500_spi_data },
 	{ .compatible = "aspeed,ast2600-fmc", .data = &ast2600_fmc_data },
-- 
2.34.1

