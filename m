From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:13 +0200
Subject: [PATCH 10/16] mtd: spi-nor: aspeed: Introduce segment operations
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-11-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 will use a different encoding for the addresses defined in the
Segment Register.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 78 ++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index c5a0c8d94371..7cdd84a2ca82 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -32,6 +32,7 @@ enum aspeed_smc_flash_type {
 };
 
 struct aspeed_smc_chip;
+struct aspeed_smc_controller;
 
 struct aspeed_smc_info {
 	u32 maxsize;		/* maximum size of chip window */
@@ -43,6 +44,10 @@ struct aspeed_smc_info {
 
 	void (*set_4b)(struct aspeed_smc_chip *chip);
 	int (*optimize_read)(struct aspeed_smc_chip *chip, u32 max_freq);
+	u32 (*segment_start)(struct aspeed_smc_controller *controller, u32 reg);
+	u32 (*segment_end)(struct aspeed_smc_controller *controller, u32 reg);
+	u32 (*segment_reg)(struct aspeed_smc_controller *controller,
+			   u32 start, u32 end);
 };
 
 static void aspeed_smc_chip_set_4b_spi_2400(struct aspeed_smc_chip *chip);
@@ -50,6 +55,13 @@ static void aspeed_smc_chip_set_4b(struct aspeed_smc_chip *chip);
 static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 				    u32 max_freq);
 
+static u32 aspeed_smc_segment_start(struct aspeed_smc_controller *controller,
+				    u32 reg);
+static u32 aspeed_smc_segment_end(struct aspeed_smc_controller *controller,
+				  u32 reg);
+static u32 aspeed_smc_segment_reg(struct aspeed_smc_controller *controller,
+				  u32 start, u32 end);
+
 static const struct aspeed_smc_info fmc_2400_info = {
 	.maxsize = 64 * 1024 * 1024,
 	.nce = 5,
@@ -59,6 +71,9 @@ static const struct aspeed_smc_info fmc_2400_info = {
 	.timing = 0x94,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.segment_start = aspeed_smc_segment_start,
+	.segment_end = aspeed_smc_segment_end,
+	.segment_reg = aspeed_smc_segment_reg,
 };
 
 static const struct aspeed_smc_info spi_2400_info = {
@@ -70,6 +85,7 @@ static const struct aspeed_smc_info spi_2400_info = {
 	.timing = 0x14,
 	.set_4b = aspeed_smc_chip_set_4b_spi_2400,
 	.optimize_read = aspeed_smc_optimize_read,
+	/* No segment registers */
 };
 
 static const struct aspeed_smc_info fmc_2500_info = {
@@ -81,6 +97,9 @@ static const struct aspeed_smc_info fmc_2500_info = {
 	.timing = 0x94,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.segment_start = aspeed_smc_segment_start,
+	.segment_end = aspeed_smc_segment_end,
+	.segment_reg = aspeed_smc_segment_reg,
 };
 
 static const struct aspeed_smc_info spi_2500_info = {
@@ -92,6 +111,9 @@ static const struct aspeed_smc_info spi_2500_info = {
 	.timing = 0x94,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.segment_start = aspeed_smc_segment_start,
+	.segment_end = aspeed_smc_segment_end,
+	.segment_reg = aspeed_smc_segment_reg,
 };
 
 enum aspeed_smc_ctl_reg_value {
@@ -201,22 +223,34 @@ struct aspeed_smc_controller {
 	(CONTROL_AAF_MODE | CONTROL_CE_INACTIVE_MASK | CONTROL_CLK_DIV4 | \
 	 CONTROL_CLOCK_FREQ_SEL_MASK | CONTROL_LSB_FIRST | CONTROL_CLOCK_MODE_3)
 
-/*
- * The Segment Register uses a 8MB unit to encode the start address
- * and the end address of the mapping window of a flash SPI slave :
- *
- *        | byte 1 | byte 2 | byte 3 | byte 4 |
- *        +--------+--------+--------+--------+
- *        |  end   |  start |   0    |   0    |
- */
 #define SEGMENT_ADDR_REG0		0x30
-#define SEGMENT_ADDR_START(_r)		((((_r) >> 16) & 0xFF) << 23)
-#define SEGMENT_ADDR_END(_r)		((((_r) >> 24) & 0xFF) << 23)
-#define SEGMENT_ADDR_VALUE(start, end)					\
-	(((((start) >> 23) & 0xFF) << 16) | ((((end) >> 23) & 0xFF) << 24))
 #define SEGMENT_ADDR_REG(controller, cs)	\
 	((controller)->regs + SEGMENT_ADDR_REG0 + (cs) * 4)
 
+/*
+ * The Segment Registers of the AST2400 and AST2500 have a 8MB
+ * unit. The address range of a flash SPI slave is encoded with
+ * absolute addresses which should be part of the overall controller
+ * window.
+ */
+static u32 aspeed_smc_segment_start(struct aspeed_smc_controller *controller,
+				    u32 reg)
+{
+	return ((reg >> 16) & 0xFF) << 23;
+}
+
+static u32 aspeed_smc_segment_end(struct aspeed_smc_controller *controller,
+				  u32 reg)
+{
+	return ((reg >> 24) & 0xFF) << 23;
+}
+
+static u32 aspeed_smc_segment_reg(struct aspeed_smc_controller *controller,
+				  u32 start, u32 end)
+{
+	return (((start >> 23) & 0xFF) << 16) | (((end >> 23) & 0xFF) << 24);
+}
+
 /*
  * Switch to turn off read optimisation if needed
  */
@@ -519,16 +553,19 @@ static void __iomem *aspeed_smc_chip_base(struct aspeed_smc_chip *chip,
 					  struct resource *res)
 {
 	struct aspeed_smc_controller *controller = chip->controller;
+	const struct aspeed_smc_info *info = controller->info;
 	u32 offset = 0;
 	u32 reg;
 
-	if (controller->info->nce > 1) {
+	if (info->nce > 1) {
 		reg = readl(SEGMENT_ADDR_REG(controller, chip->cs));
 
-		if (SEGMENT_ADDR_START(reg) >= SEGMENT_ADDR_END(reg))
+		if (info->segment_start(controller, reg) >=
+		    info->segment_end(controller, reg)) {
 			return NULL;
+		}
 
-		offset = SEGMENT_ADDR_START(reg) - res->start;
+		offset = info->segment_start(controller, reg) - res->start;
 	}
 
 	return controller->ahb_base + offset;
@@ -538,6 +575,7 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 			    u32 size)
 {
 	struct aspeed_smc_controller *controller = chip->controller;
+	const struct aspeed_smc_info *info = controller->info;
 	void __iomem *seg_reg;
 	u32 seg_oldval, seg_newval, end;
 	u32 ahb_base_phy = controller->ahb_base_phy;
@@ -551,7 +589,7 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 	 * previous segment
 	 */
 	if (!size)
-		size = SEGMENT_ADDR_END(seg_oldval) - start;
+		size = info->segment_end(controller, seg_oldval) - start;
 
 	/*
 	 * The segment cannot exceed the maximum window size of the
@@ -564,7 +602,7 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 	}
 
 	end = start + size;
-	seg_newval = SEGMENT_ADDR_VALUE(start, end);
+	seg_newval = info->segment_reg(controller, start, end);
 	writel(seg_newval, seg_reg);
 
 	/*
@@ -575,8 +613,8 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 	if (seg_newval != readl(seg_reg)) {
 		dev_err(chip->nor.dev, "CE%d window invalid", cs);
 		writel(seg_oldval, seg_reg);
-		start = SEGMENT_ADDR_START(seg_oldval);
-		end = SEGMENT_ADDR_END(seg_oldval);
+		start = info->segment_start(controller, seg_oldval);
+		end = info->segment_end(controller, seg_oldval);
 		size = end - start;
 	}
 
@@ -639,7 +677,7 @@ static u32 aspeed_smc_chip_set_segment(struct aspeed_smc_chip *chip)
 	if (chip->cs) {
 		u32 prev = readl(SEGMENT_ADDR_REG(controller, chip->cs - 1));
 
-		start = SEGMENT_ADDR_END(prev);
+		start = controller->info->segment_end(controller, prev);
 	} else {
 		start = ahb_base_phy;
 	}
-- 
2.21.0

