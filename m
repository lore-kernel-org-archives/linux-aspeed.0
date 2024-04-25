From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 25 Apr 2024 17:07:26 +0800
Subject: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
Message-ID: <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
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
 drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..4c58593658bc 100644
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
@@ -82,6 +84,16 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
 
+//AST SCU Register
+#define AST2400_AST2500_SYSTEM_RESET_EVENT	0x3C
+#define   AST2400_WATCHDOG_RESET_FLAG	BIT(1)
+#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
+#define   AST2500_WATCHDOG_RESET_FLAG	GENMASK(4, 2)
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+#define   POWERON_RESET_FLAG		BIT(0)
+#define   EXTERN_RESET_FLAG		BIT(1)
+#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
+
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -310,6 +322,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
+	struct regmap *scu_base;
 	const char *reset_type;
 	u32 duration;
 	u32 status;
@@ -458,15 +471,99 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	/*
+	 * Power on reset is set when triggered by AC or SRSRST.
+	 * Thereforce, we clear flag to ensure
+	 * next boot cause is a real watchdog case.
+	 * We use the external reset flag to determine
+	 * if it is an external reset or card reset
+	 */
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2600-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2600_WATCHDOG_RESET_FLAG) {
+			if(status & EXTERN_RESET_FLAG)
+				wdt->wdd.bootstatus = WDIOF_EXTERN1;
+			else
+				wdt->wdd.bootstatus = WDIOF_CARDRESET;
+		}
+		status = AST2600_WATCHDOG_RESET_FLAG |
+			 POWERON_RESET_FLAG |
+			 EXTERN_RESET_FLAG;
+
+		ret = regmap_write(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  status);
+	} else if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2500-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2500_WATCHDOG_RESET_FLAG) {
+			if(status & EXTERN_RESET_FLAG)
+				wdt->wdd.bootstatus = WDIOF_EXTERN1;
+			else
+				wdt->wdd.bootstatus = WDIOF_CARDRESET;
+		}
+
+		status = AST2500_WATCHDOG_RESET_FLAG |
+			 POWERON_RESET_FLAG |
+			 EXTERN_RESET_FLAG;
+
+		ret = regmap_write(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  status);
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+		wdt->wdd.groups = bswitch_groups;
+	} else {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2400-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+		/*
+		 * Ast2400 external reset can clear watdog dog rest flag, so
+		 * only support WDIOF_CARDRESET
+		 */
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2400_WATCHDOG_RESET_FLAG)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+		status = AST2400_RESET_FLAG_CLEAR;
+
+		ret = regmap_write(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  status);
+
+		wdt->wdd.groups = bswitch_groups;
 	}
 
+	if (ret)
+		return ret;
+
 	dev_set_drvdata(dev, wdt);
 
 	return devm_watchdog_register_device(dev, &wdt->wdd);
-- 
2.25.1

