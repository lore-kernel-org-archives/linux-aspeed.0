From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 14:09:33 +0200
Subject: [PATCH 15/16] mtd: spi-nor: aspeed: Introduce a HCLK mask for training
In-Reply-To: <20191004120934.21662-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004120934.21662-1-clg@kaod.org>
Message-ID: <20191004120934.21662-2-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 handles more HCLK divisors than its predecessors.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 85b7ff3bcc91..5fa9956d183e 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -41,6 +41,7 @@ struct aspeed_smc_info {
 	u8 we0;			/* shift for write enable bit for CE0 */
 	u8 ctl0;		/* offset in regs of ctl for CE0 */
 	u8 timing;		/* offset in regs of timing */
+	u32 hclk_mask;          /* clock frequency mask in CEx Control reg */
 	u32 hdiv_max;           /* Max HCLK divisor on read timing reg */
 
 	void (*set_4b)(struct aspeed_smc_chip *chip);
@@ -75,6 +76,7 @@ static const struct aspeed_smc_info fmc_2400_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hclk_mask = 0xfffff0ff,
 	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
@@ -91,6 +93,7 @@ static const struct aspeed_smc_info spi_2400_info = {
 	.we0 = 0,
 	.ctl0 = 0x04,
 	.timing = 0x14,
+	.hclk_mask = 0xfffff0ff,
 	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b_spi_2400,
 	.optimize_read = aspeed_smc_optimize_read,
@@ -105,6 +108,7 @@ static const struct aspeed_smc_info fmc_2500_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hclk_mask = 0xfffff0ff,
 	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
@@ -121,6 +125,7 @@ static const struct aspeed_smc_info spi_2500_info = {
 	.we0 = 16,
 	.ctl0 = 0x10,
 	.timing = 0x94,
+	.hclk_mask = 0xfffff0ff,
 	.hdiv_max = 1,
 	.set_4b = aspeed_smc_chip_set_4b,
 	.optimize_read = aspeed_smc_optimize_read,
@@ -1058,7 +1063,7 @@ static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
 	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
 
 	/* Establish our read mode with freq field set to 0 (HCLK/16) */
-	chip->ctl_val[smc_read] = save_read_val & 0xfffff0ff;
+	chip->ctl_val[smc_read] = save_read_val & info->hclk_mask;
 
 	/* Check if calibration data is suitable */
 	if (!aspeed_smc_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
-- 
2.21.0

