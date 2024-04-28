From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Sun, 28 Apr 2024 22:29:36 +0800
Subject: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
Message-ID: <20240428142937.785925-2-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 78 +++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..4393625c2e96 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,10 +11,12 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -22,10 +24,32 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+//AST SCU Register
+#define POWERON_RESET_FLAG		BIT(0)
+#define EXTERN_RESET_FLAG		BIT(1)
+
+#define AST2400_AST2500_SYSTEM_RESET_EVENT	0x3C
+#define   AST2400_WATCHDOG_RESET_FLAG	BIT(1)
+#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
+
+#define   AST2500_WATCHDOG_RESET_FLAG	GENMASK(4, 2)
+#define   AST2500_RESET_FLAG_CLEAR	(AST2500_WATCHDOG_RESET_FLAG | \
+					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
+
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
+#define   AST2600_RESET_FLAG_CLEAR	(AST2600_WATCHDOG_RESET_FLAG | \
+					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
+
 struct aspeed_wdt_config {
 	u32 ext_pulse_width_mask;
 	u32 irq_shift;
 	u32 irq_mask;
+	const char *compatible;
+	u32 reset_event;
+	u32 watchdog_reset_flag;
+	u32 extern_reset_flag;
+	u32 reset_flag_clear;
 };
 
 struct aspeed_wdt {
@@ -39,18 +63,33 @@ static const struct aspeed_wdt_config ast2400_config = {
 	.ext_pulse_width_mask = 0xff,
 	.irq_shift = 0,
 	.irq_mask = 0,
+	.compatible = "aspeed,ast2400-scu",
+	.reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2400_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = 0,
+	.reset_flag_clear = AST2400_RESET_FLAG_CLEAR,
 };
 
 static const struct aspeed_wdt_config ast2500_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 12,
 	.irq_mask = GENMASK(31, 12),
+	.compatible = "aspeed,ast2500-scu",
+	.reset_event = AST2400_AST2500_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2500_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = EXTERN_RESET_FLAG,
+	.reset_flag_clear = AST2500_RESET_FLAG_CLEAR,
 };
 
 static const struct aspeed_wdt_config ast2600_config = {
 	.ext_pulse_width_mask = 0xfffff,
 	.irq_shift = 0,
 	.irq_mask = GENMASK(31, 10),
+	.compatible = "aspeed,ast2600-scu",
+	.reset_event = AST2600_SYSTEM_RESET_EVENT,
+	.watchdog_reset_flag = AST2600_WATCHDOG_RESET_FLAG,
+	.extern_reset_flag = EXTERN_RESET_FLAG,
+	.reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
 };
 
 static const struct of_device_id aspeed_wdt_of_table[] = {
@@ -310,6 +349,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
+	struct regmap *scu_base;
 	const char *reset_type;
 	u32 duration;
 	u32 status;
@@ -458,14 +498,36 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
-
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
-	}
+	/*
+	 * Power on reset is set when triggered by AC or SRSRST.
+	 * Thereforce, we clear flag to ensure
+	 * next boot cause is a real watchdog case.
+	 * We use the external reset flag to determine
+	 * if it is an external reset or card reset.
+	 * However, The ast2400 watchdog flag is cleared by an external reset,
+	 * so it only supports WDIOF_CARDRESET.
+	 */
+	scu_base = syscon_regmap_lookup_by_compatible(wdt->cfg->compatible);
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
+	ret = regmap_read(scu_base, wdt->cfg->reset_event, &status);
+	if (ret)
+		return ret;
+
+	if (!(status & POWERON_RESET_FLAG) &&
+	      status & wdt->cfg->watchdog_reset_flag)
+		wdt->wdd.bootstatus = (status & wdt->cfg->extern_reset_flag) ?
+				WDIOF_EXTERN1 : WDIOF_CARDRESET;
+
+	status = wdt->cfg->reset_flag_clear;
+	ret = regmap_write(scu_base, wdt->cfg->reset_event, status);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
+	    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
+		wdt->wdd.groups = bswitch_groups;
 
 	dev_set_drvdata(dev, wdt);
 
-- 
2.25.1

