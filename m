From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 14:09:32 +0200
Subject: [PATCH 14/16] mtd: spi-nor: aspeed: Introduce training operations per
 platform
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004120934.21662-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The read timing compensation register records the read delay settings
for a range of HCLK. Its encoding is different on the AST2600 and the
read training will be slightly more complex.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index fad08738e534..85b7ff3bcc91 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -41,9 +41,13 @@ struct aspeed_smc_info {
 	u8 we0;			/* shift for write enable bit for CE0 */
 	u8 ctl0;		/* offset in regs of ctl for CE0 */
 	u8 timing;		/* offset in regs of timing */
+	u32 hdiv_max;           /* Max HCLK divisor on read timing reg */
 
 	void (*set_4b)(struct aspeed_smc_chip *chip);
 	int (*optimize_read)(struct aspeed_smc_chip *chip, u32 max_freq);
+	int (*calibrate)(struct aspeed_smc_chip *chip, u32 hdiv,
+			 const u8 *golden_buf, u8 *test_buf);
+
 	u32 (*segment_start)(struct aspeed_smc_controller *controller, u32 reg);
 	u32 (*segment_end)(struct aspeed_smc_controller *controller, u32 reg);
 	u32 (*segment_reg)(struct aspeed_smc_controller *controller,
@@ -54,6 +58,8 @@ static void aspeed_smc_chip_set_4b_spi_2400(struct aspeed_smc_chip *chip);
 static void aspeed_smc_chip_set_4b(struct aspeed_smc_chip *chip);
 static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 				    u32 max_freq);
+static int aspeed_smc_calibrate_reads(struct aspeed_smc_chip *chip, u32 hdiv,
+				      const u8 *golden_buf, u8 *test_buf);
 
 static u32 aspeed_smc_segment_start(struct aspeed_smc_controller *controller,
 				    u32 reg);
@@ -69,8 +75,10 @@ static const struct aspeed_smc_info fmc_2400_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads,
 	.segment_start = aspeed_smc_segment_start,
 	.segment_end = aspeed_smc_segment_end,
 	.segment_reg = aspeed_smc_segment_reg,
@@ -83,8 +91,10 @@ static const struct aspeed_smc_info spi_2400_info = {
 	.we0 = 0,
 	.ctl0 = 0x04,
 	.timing = 0x14,
+	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b_spi_2400,
 	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads,
 	/* No segment registers */
 };
 
@@ -95,8 +105,10 @@ static const struct aspeed_smc_info fmc_2500_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads,
 	.segment_start = aspeed_smc_segment_start,
 	.segment_end = aspeed_smc_segment_end,
 	.segment_reg = aspeed_smc_segment_reg,
@@ -109,8 +121,10 @@ static const struct aspeed_smc_info spi_2500_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
+	.calibrate = aspeed_smc_calibrate_reads,
 	.segment_start = aspeed_smc_segment_start,
 	.segment_end = aspeed_smc_segment_end,
 	.segment_reg = aspeed_smc_segment_reg,
@@ -1022,6 +1036,8 @@ static u32 aspeed_smc_default_read(struct aspeed_smc_chip *chip)
 static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 				    u32 max_freq)
 {
+	struct aspeed_smc_controller *controller = chip->controller;
+	const struct aspeed_smc_info *info = controller->info;
 	u8 *golden_buf, *test_buf;
 	int i, rc, best_div = -1;
 	u32 save_read_val = chip->ctl_val[smc_read];
@@ -1054,7 +1070,8 @@ static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 	}
 
 	/* Now we iterate the HCLK dividers until we find our breaking point */
-	for (i = ARRAY_SIZE(aspeed_smc_hclk_divs); i > 0; i--) {
+	for (i = ARRAY_SIZE(aspeed_smc_hclk_divs);
+	     i > info->hdiv_max - 1; i--) {
 		u32 tv, freq;
 
 		/* Compare timing to max */
@@ -1065,8 +1082,8 @@ static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 		/* Set the timing */
 		tv = chip->ctl_val[smc_read] | ASPEED_SMC_HCLK_DIV(i);
 		writel(tv, chip->ctl);
-		dev_dbg(chip->nor.dev, "Trying HCLK/%d...", i);
-		rc = aspeed_smc_calibrate_reads(chip, i, golden_buf, test_buf);
+		dev_dbg(chip->nor.dev, "Trying HCLK/%d [%08x] ...", i, tv);
+		rc = info->calibrate(chip, i, golden_buf, test_buf);
 		if (rc == 0)
 			best_div = i;
 	}
-- 
2.21.0

