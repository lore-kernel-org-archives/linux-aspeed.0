From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:05 +0200
Subject: [PATCH 02/16] mtd: spi-nor: aspeed: Add support for SPI dual IO read
 mode
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-3-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implements support for the dual IO read mode on aspeed SMC/FMC
controllers which uses both MISO and MOSI lines for data during a read
to double the read bandwidth.

Based on work from Robert Lippert <roblip@gmail.com>

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 56 +++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 148bbc934efc..c775e0612613 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -369,18 +369,49 @@ static void aspeed_smc_send_cmd_addr(struct spi_nor *nor, u8 cmd, u32 addr)
 	}
 }
 
+static int aspeed_smc_get_io_mode(struct aspeed_smc_chip *chip)
+{
+	switch (chip->nor.read_proto) {
+	case SNOR_PROTO_1_1_1:
+		return 0;
+	case SNOR_PROTO_1_1_2:
+		return CONTROL_IO_DUAL_DATA;
+	case SNOR_PROTO_1_2_2:
+		return CONTROL_IO_DUAL_ADDR_DATA;
+	default:
+		dev_err(chip->nor.dev, "unsupported SPI read mode\n");
+		return -EINVAL;
+	}
+}
+
+static void aspeed_smc_set_io_mode(struct aspeed_smc_chip *chip, u32 io_mode)
+{
+	u32 ctl;
+
+	if (io_mode > 0) {
+		ctl = readl(chip->ctl) & ~CONTROL_IO_MODE_MASK;
+		ctl |= io_mode;
+		writel(ctl, chip->ctl);
+	}
+}
+
 static ssize_t aspeed_smc_read_user(struct spi_nor *nor, loff_t from,
 				    size_t len, u_char *read_buf)
 {
 	struct aspeed_smc_chip *chip = nor->priv;
 	int i;
 	u8 dummy = 0xFF;
+	int io_mode = aspeed_smc_get_io_mode(chip);
 
 	aspeed_smc_start_user(nor);
 	aspeed_smc_send_cmd_addr(nor, nor->read_opcode, from);
 	for (i = 0; i < chip->nor.read_dummy / 8; i++)
 		aspeed_smc_write_to_ahb(chip->ahb_base, &dummy, sizeof(dummy));
 
+	/* Set IO mode only for data */
+	if (io_mode == CONTROL_IO_DUAL_DATA)
+		aspeed_smc_set_io_mode(chip, io_mode);
+
 	aspeed_smc_read_from_ahb(read_buf, chip->ahb_base, len);
 	aspeed_smc_stop_user(nor);
 	return len;
@@ -731,6 +762,7 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
 {
 	struct aspeed_smc_controller *controller = chip->controller;
 	const struct aspeed_smc_info *info = controller->info;
+	int io_mode;
 	u32 cmd;
 
 	if (chip->nor.addr_width == 4 && info->set_4b)
@@ -753,22 +785,21 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
 	 * TODO: Adjust clocks if fast read is supported and interpret
 	 * SPI-NOR flags to adjust controller settings.
 	 */
-	if (chip->nor.read_proto == SNOR_PROTO_1_1_1) {
-		if (chip->nor.read_dummy == 0)
-			cmd = CONTROL_COMMAND_MODE_NORMAL;
-		else
-			cmd = CONTROL_COMMAND_MODE_FREAD;
-	} else {
-		dev_err(chip->nor.dev, "unsupported SPI read mode\n");
-		return -EINVAL;
-	}
+	io_mode = aspeed_smc_get_io_mode(chip);
+	if (io_mode < 0)
+		return io_mode;
 
-	chip->ctl_val[smc_read] |= cmd |
+	if (chip->nor.read_dummy == 0)
+		cmd = CONTROL_COMMAND_MODE_NORMAL;
+	else
+		cmd = CONTROL_COMMAND_MODE_FREAD;
+
+	chip->ctl_val[smc_read] |= cmd | io_mode |
 		chip->nor.read_opcode << CONTROL_COMMAND_SHIFT |
 		CONTROL_IO_DUMMY_SET(chip->nor.read_dummy / 8);
 
-	dev_dbg(controller->dev, "base control register: %08x\n",
-		chip->ctl_val[smc_read]);
+	dev_info(controller->dev, "read control register: %08x\n",
+		 chip->ctl_val[smc_read]);
 	return 0;
 }
 
@@ -778,6 +809,7 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 	const struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ |
 			SNOR_HWCAPS_READ_FAST |
+			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_PP,
 	};
 	const struct aspeed_smc_info *info = controller->info;
-- 
2.21.0

