From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 14:09:34 +0200
Subject: [PATCH 16/16] mtd: spi-nor: aspeed: Add read training support for the
 AST2600
In-Reply-To: <20191004120934.21662-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004120934.21662-1-clg@kaod.org>
Message-ID: <20191004120934.21662-3-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The read training algorithm consists of finding the appropriate read
timing delays for the HCLK dividers in range [ 2 - 5 ] and store the
results in the Read Timing Compensation register. The previous AST2500
and AST2400 SoCs were covering a broader HCLK range [ 1 - 5 ] because
the AHB frequency was lower.

The algorithm first reads a golden buffer at low speed and then
performs reads with different clocks and delay cycle settings to find
a breaking point. This selects the default clock frequency for the CEx
control register. The current settings are bit optimistic as we pick
the first delay giving good results. A safer approach would be to
determine an interval and choose the middle value. We might change the
approach depending on the results on other systems.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 5fa9956d183e..1176ad0c4fe5 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -141,6 +141,9 @@ static u32 aspeed_smc_segment_end_ast2600(struct aspeed_smc_controller *ctrl,
 					  u32 reg);
 static u32 aspeed_smc_segment_reg_ast2600(struct aspeed_smc_controller *ctrl,
 					  u32 start, u32 end);
+static int aspeed_smc_calibrate_reads_ast2600(struct aspeed_smc_chip *chip,
+					      u32 hdiv, const u8 *golden_buf,
+					      u8 *test_buf);
 
 static const struct aspeed_smc_info fmc_2600_info = {
 	.maxsize = 256 * 1024 * 1024,
@@ -149,7 +152,11 @@ static const struct aspeed_smc_info fmc_2600_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hclk_mask = 0xf0fff0ff,
+	.hdiv_max = 2,
 	.set_4b = aspeed_smc_chip_set_4b,
+	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads_ast2600,
 	.segment_start = aspeed_smc_segment_start_ast2600,
 	.segment_end = aspeed_smc_segment_end_ast2600,
 	.segment_reg = aspeed_smc_segment_reg_ast2600,
@@ -162,7 +169,11 @@ static const struct aspeed_smc_info spi_2600_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hclk_mask = 0xf0fff0ff,
+	.hdiv_max = 2,
 	.set_4b = aspeed_smc_chip_set_4b,
+	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads_ast2600,
 	.segment_start = aspeed_smc_segment_start_ast2600,
 	.segment_end = aspeed_smc_segment_end_ast2600,
 	.segment_reg = aspeed_smc_segment_reg_ast2600,
@@ -1107,6 +1118,67 @@ static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 	return 0;
 }
 
+#define TIMING_DELAY_DI         BIT(3)
+#define TIMING_DELAY_HCYCLE_MAX     5
+#define TIMING_REG_AST2600(chip)					\
+	((chip)->controller->regs + (chip)->controller->info->timing +	\
+	 (chip)->cs * 4)
+
+static int aspeed_smc_calibrate_reads_ast2600(struct aspeed_smc_chip *chip,
+					      u32 hdiv, const u8 *golden_buf,
+					      u8 *test_buf)
+{
+	int hcycle;
+	u32 shift = (hdiv - 2) << 3;
+	u32 mask = ~(0xfu << shift);
+	u32 fread_timing_val = 0;
+
+	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
+		int delay_ns;
+		bool pass = false;
+
+		fread_timing_val &= mask;
+		fread_timing_val |= hcycle << shift;
+
+		/* no DI input delay first  */
+		writel(fread_timing_val, TIMING_REG_AST2600(chip));
+		pass = aspeed_smc_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(chip->nor.dev,
+			"  * [%08x] %d HCLK delay, DI delay none : %s",
+			fread_timing_val, hcycle, pass ? "PASS" : "FAIL");
+		if (pass)
+			return 0;
+
+		/* Add DI input delays  */
+		fread_timing_val &= mask;
+		fread_timing_val |= (TIMING_DELAY_DI | hcycle) << shift;
+
+		for (delay_ns = 0; delay_ns < 0x10; delay_ns++) {
+			fread_timing_val &= ~(0xf << (4 + shift));
+			fread_timing_val |= delay_ns << (4 + shift);
+
+			writel(fread_timing_val, TIMING_REG_AST2600(chip));
+			pass = aspeed_smc_check_reads(chip, golden_buf,
+						      test_buf);
+			dev_dbg(chip->nor.dev,
+				"  * [%08x] %d HCLK delay, DI delay %d.%dns : %s",
+				fread_timing_val, hcycle, (delay_ns + 1) / 2,
+				(delay_ns + 1) & 1 ? 5 : 5,
+				pass ? "PASS" : "FAIL");
+			/*
+			 * TODO: This is optimistic. We should look
+			 * for a working interval and save the middle
+			 * value in the read timing register.
+			 */
+			if (pass)
+				return 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	return -1;
+}
+
 static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
 {
 	struct aspeed_smc_controller *controller = chip->controller;
-- 
2.21.0

