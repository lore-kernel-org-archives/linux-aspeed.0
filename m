From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:15 +0200
Subject: [PATCH 12/16] mtd: spi-nor: aspeed: Add initial support for the
 AST2600
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-13-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The HW interface of AST2600 SoC SMC controllers is very similar to the
the AST2500. The AST2600 Firmware Memory Controller is now SPI only.

The Segment Registers also have a different encoding. A 1MB unit is
used and the address range of a flash SPI device is encoded with
offsets in the overall controller window. The previous SoC AST2400 and
AST2500 used absolute addresses. Only bits [27:20] are relevant and
the end address is an upper bound limit.

Read training yet to come.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 7cdd84a2ca82..c977f8f28aef 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -116,6 +116,39 @@ static const struct aspeed_smc_info spi_2500_info = {
 	.segment_reg = aspeed_smc_segment_reg,
 };
 
+static u32 aspeed_smc_segment_start_ast2600(struct aspeed_smc_controller *ctrl,
+					    u32 reg);
+static u32 aspeed_smc_segment_end_ast2600(struct aspeed_smc_controller *ctrl,
+					  u32 reg);
+static u32 aspeed_smc_segment_reg_ast2600(struct aspeed_smc_controller *ctrl,
+					  u32 start, u32 end);
+
+static const struct aspeed_smc_info fmc_2600_info = {
+	.maxsize = 256 * 1024 * 1024,
+	.nce = 3,
+	.hastype = false, /* SPI Only */
+	.we0 = 16,
+	.ctl0 = 0x10,
+	.timing = 0x94,
+	.set_4b = aspeed_smc_chip_set_4b,
+	.segment_start = aspeed_smc_segment_start_ast2600,
+	.segment_end = aspeed_smc_segment_end_ast2600,
+	.segment_reg = aspeed_smc_segment_reg_ast2600,
+};
+
+static const struct aspeed_smc_info spi_2600_info = {
+	.maxsize = 256 * 1024 * 1024,
+	.nce = 2,
+	.hastype = false,
+	.we0 = 16,
+	.ctl0 = 0x10,
+	.timing = 0x94,
+	.set_4b = aspeed_smc_chip_set_4b,
+	.segment_start = aspeed_smc_segment_start_ast2600,
+	.segment_end = aspeed_smc_segment_end_ast2600,
+	.segment_reg = aspeed_smc_segment_reg_ast2600,
+};
+
 enum aspeed_smc_ctl_reg_value {
 	smc_base,		/* base value without mode for other commands */
 	smc_read,		/* command reg for (maybe fast) reads */
@@ -251,6 +284,39 @@ static u32 aspeed_smc_segment_reg(struct aspeed_smc_controller *controller,
 	return (((start >> 23) & 0xFF) << 16) | (((end >> 23) & 0xFF) << 24);
 }
 
+/*
+ * The Segment Registers of the AST2600 have a 1MB unit. The address
+ * range of a flash SPI slave is encoded with offsets in the overall
+ * controller window. The previous SoC AST2400 and AST2500 used
+ * absolute addresses. Only bits [27:20] are relevant and the end
+ * address is an upper bound limit.
+ */
+
+#define AST2600_SEG_ADDR_MASK 0x0ff00000
+
+static u32 aspeed_smc_segment_start_ast2600(struct aspeed_smc_controller *ctlr,
+					    u32 reg)
+{
+	u32 start_offset = (reg << 16) & AST2600_SEG_ADDR_MASK;
+
+	return ctlr->ahb_base_phy + start_offset;
+}
+
+static u32 aspeed_smc_segment_end_ast2600(struct aspeed_smc_controller *ctlr,
+					  u32 reg)
+{
+	u32 end_offset = reg & AST2600_SEG_ADDR_MASK;
+
+	return ctlr->ahb_base_phy + end_offset + 0x100000;
+}
+
+static u32 aspeed_smc_segment_reg_ast2600(struct aspeed_smc_controller *ctlr,
+					  u32 start, u32 end)
+{
+	return ((start & AST2600_SEG_ADDR_MASK) >> 16) |
+		((end - 1) & AST2600_SEG_ADDR_MASK);
+}
+
 /*
  * Switch to turn off read optimisation if needed
  */
@@ -538,6 +604,8 @@ static const struct of_device_id aspeed_smc_matches[] = {
 	{ .compatible = "aspeed,ast2400-spi", .data = &spi_2400_info },
 	{ .compatible = "aspeed,ast2500-fmc", .data = &fmc_2500_info },
 	{ .compatible = "aspeed,ast2500-spi", .data = &spi_2500_info },
+	{ .compatible = "aspeed,ast2600-fmc", .data = &fmc_2600_info },
+	{ .compatible = "aspeed,ast2600-spi", .data = &spi_2600_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_smc_matches);
-- 
2.21.0

