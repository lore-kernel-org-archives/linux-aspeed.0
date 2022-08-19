From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Fri, 19 Aug 2022 17:49:05 +0800
Subject: [PATCH] watchdog: aspeed_wdt: Reorder output signal register configuration
Message-ID: <20220819094905.1962513-1-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If the output driving type is push-pull mode, the output
polarity should be selected in advance. Otherwise, an unexpected
value will be output at the moment of changing to push-pull mode.
Thus, output polarity, WDT18[31], must be configured before
changing driving type, WDT18[30].

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 436571b6fc79..a03e4ff812a2 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -325,18 +325,18 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 
 		reg &= config->ext_pulse_width_mask;
-		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
-			reg |= WDT_PUSH_PULL_MAGIC;
+		if (of_property_read_bool(np, "aspeed,ext-active-high"))
+			reg |= WDT_ACTIVE_HIGH_MAGIC;
 		else
-			reg |= WDT_OPEN_DRAIN_MAGIC;
+			reg |= WDT_ACTIVE_LOW_MAGIC;
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 
 		reg &= config->ext_pulse_width_mask;
-		if (of_property_read_bool(np, "aspeed,ext-active-high"))
-			reg |= WDT_ACTIVE_HIGH_MAGIC;
+		if (of_property_read_bool(np, "aspeed,ext-push-pull"))
+			reg |= WDT_PUSH_PULL_MAGIC;
 		else
-			reg |= WDT_ACTIVE_LOW_MAGIC;
+			reg |= WDT_OPEN_DRAIN_MAGIC;
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
 	}
-- 
2.25.1

