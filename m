From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Mon, 7 Oct 2024 14:34:08 +0800
Subject: [PATCH 4/4] watchdog: aspeed: Add support for SW restart
In-Reply-To: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
References: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20241007063408.2360874-5-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

WDT reset can be triggered when system hangs or a deliberate
SW restart scenario. Originally, system can only know it is
reset by WDT through a reset flag. However, since AST2600,
a SW reset mechanism is created, SW can trigger the reset
event consciously and directly without wait for WDT timeout.
This function can be achieved by adding "aspeed,restart-sw"
property in dts. After that, an independent reset event flag
will be set after system reset by SW.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/watchdog/aspeed_wdt.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 68eaada8a564..eefca972dfa4 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -61,6 +61,7 @@ struct aspeed_wdt {
 	int			idx;
 	u32			ctrl;
 	const struct aspeed_wdt_config *cfg;
+	u32			flags;
 };
 
 static const struct aspeed_wdt_config ast2400_config = {
@@ -130,6 +131,11 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
+#define WDT_SW_RESET_CTRL	0x24
+#define   WDT_SW_RESET_COUNT_CLEAR	0xDEADDEAD
+#define   WDT_SW_RESET_ENABLE	0xAEEDF123
+#define WDT_SW_RESET_MASK1	0x28
+#define WDT_SW_RESET_MASK2	0x2c
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -170,6 +176,9 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_DEFAULT_TIMEOUT	30
 #define WDT_RATE_1MHZ		1000000
 
+/* WDT behavior control flag */
+#define WDT_RESTART_SYSTEM_SW	0x00000001
+
 static struct aspeed_wdt *to_aspeed_wdt(struct watchdog_device *wdd)
 {
 	return container_of(wdd, struct aspeed_wdt, wdd);
@@ -249,11 +258,31 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static void aspeed_wdt_sw_reset(struct watchdog_device *wdd)
+{
+	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
+	u32 ctrl = WDT_CTRL_RESET_MODE_SOC |
+		   WDT_CTRL_RESET_SYSTEM;
+
+	writel(ctrl, wdt->base + WDT_CTRL);
+	writel(WDT_SW_RESET_COUNT_CLEAR,
+	       wdt->base + WDT_SW_RESET_CTRL);
+	writel(WDT_SW_RESET_ENABLE, wdt->base + WDT_SW_RESET_CTRL);
+
+	/* system must be reset immediately */
+	mdelay(1000);
+}
+
 static int aspeed_wdt_restart(struct watchdog_device *wdd,
 			      unsigned long action, void *data)
 {
 	struct aspeed_wdt *wdt = to_aspeed_wdt(wdd);
 
+	if (wdt->flags & WDT_RESTART_SYSTEM_SW) {
+		aspeed_wdt_sw_reset(wdd);
+		return 0;
+	}
+
 	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
 	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
 
@@ -521,8 +550,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
 		if (!ret) {
 			writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
-			if (nrstmask > 1)
+			writel(reset_mask[0], wdt->base + WDT_SW_RESET_MASK1);
+			if (nrstmask > 1) {
 				writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
+				writel(reset_mask[1], wdt->base + WDT_SW_RESET_MASK2);
+			}
 		}
 	}
 
@@ -552,6 +584,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	wdt->flags = 0;
+	if (!of_device_is_compatible(np, "aspeed,ast2400-wdt") &&
+	    !of_device_is_compatible(np, "aspeed,ast2500-wdt") &&
+	    of_property_read_bool(np, "aspeed,restart-sw"))
+		wdt->flags |= WDT_RESTART_SYSTEM_SW;
+
 	ret = aspeed_wdt_get_bootstatus(dev, wdt);
 	if (ret)
 		return ret;
-- 
2.34.1

