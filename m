From: Iwona Winiarska <iwona.winiarska@intel.com>
Date: Wed, 17 Apr 2024 15:48:49 +0200
Subject: [PATCH] peci: aspeed: Clear clock_divider value before setting it
Message-ID: <20240417134849.5793-1-iwona.winiarska@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

PECI clock divider is programmed on 10:8 bits of PECI Control register.
Before setting a new value, clear bits read from hardware.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
---
 drivers/peci/controller/peci-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 7fdc25afcf2f..de7046e6b9c4 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -351,6 +351,7 @@ static int clk_aspeed_peci_set_rate(struct clk_hw *hw, unsigned long rate,
 	clk_aspeed_peci_find_div_values(this_rate, &msg_timing, &clk_div_exp);
 
 	val = readl(aspeed_peci->base + ASPEED_PECI_CTRL);
+	val &= ~ASPEED_PECI_CTRL_CLK_DIV_MASK;
 	val |= FIELD_PREP(ASPEED_PECI_CTRL_CLK_DIV_MASK, clk_div_exp);
 	writel(val, aspeed_peci->base + ASPEED_PECI_CTRL);
 
-- 
2.44.0

