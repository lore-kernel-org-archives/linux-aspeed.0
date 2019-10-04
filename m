From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:08 +0200
Subject: [PATCH 05/16] mtd: spi-nor: aspeed: Limit the maximum SPI frequency
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-6-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The read training algorithm can choose a 100MHz SPI frequency which
might be a bit too high for dual output IO on some chips, for the
W25Q256 on palmetto for instance. The MX66L1G45G on witherspoon should
be fine though. Also, the second chip of the FMC controller does not
get any optimize settings for reads. Only the first is configured by
U-Boot.

To fix these two issues, we introduce a "spi-max-frequency" property
in the device tree which will be used to cap the read training
algorithm. It is now considered safe to run the read training on the
FMC controller chips as well.

By default, the frequency setting is 50MHz.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 155c407c2bdf..1c1822a13407 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -58,6 +58,7 @@ static const struct aspeed_smc_info fmc_2400_info = {
 	.ctl0 = 0x10,
 	.timing = 0x94,
 	.set_4b = aspeed_smc_chip_set_4b,
+	.optimize_read = aspeed_smc_optimize_read,
 };
 
 static const struct aspeed_smc_info spi_2400_info = {
@@ -79,6 +80,7 @@ static const struct aspeed_smc_info fmc_2500_info = {
 	.ctl0 = 0x10,
 	.timing = 0x94,
 	.set_4b = aspeed_smc_chip_set_4b,
+	.optimize_read = aspeed_smc_optimize_read,
 };
 
 static const struct aspeed_smc_info spi_2500_info = {
@@ -110,6 +112,7 @@ struct aspeed_smc_chip {
 	u32 ctl_val[smc_max];			/* control settings */
 	enum aspeed_smc_flash_type type;	/* what type of flash */
 	struct spi_nor nor;
+	u32 clk_rate;
 };
 
 struct aspeed_smc_controller {
@@ -126,6 +129,8 @@ struct aspeed_smc_controller {
 	struct aspeed_smc_chip *chips[0];	/* pointers to attached chips */
 };
 
+#define ASPEED_SPI_DEFAULT_FREQ		50000000
+
 /*
  * SPI Flash Configuration Register (AST2500 SPI)
  *     or
@@ -1002,11 +1007,8 @@ static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
 	dev_info(controller->dev, "read control register: %08x\n",
 		 chip->ctl_val[smc_read]);
 
-	/*
-	 * TODO: get max freq from chip
-	 */
 	if (optimize_read && info->optimize_read)
-		info->optimize_read(chip, 104000000);
+		info->optimize_read(chip, chip->clk_rate);
 	return 0;
 }
 
@@ -1060,6 +1062,13 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 			break;
 		}
 
+		if (of_property_read_u32(child, "spi-max-frequency",
+					 &chip->clk_rate)) {
+			chip->clk_rate = ASPEED_SPI_DEFAULT_FREQ;
+		}
+		dev_info(dev, "Using %d MHz SPI frequency\n",
+			 chip->clk_rate / 1000000);
+
 		chip->controller = controller;
 		chip->ctl = controller->regs + info->ctl0 + cs * 4;
 		chip->cs = cs;
-- 
2.21.0

