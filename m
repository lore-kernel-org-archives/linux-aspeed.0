From: Eduardo Valentin <eduval@amazon.com>
Date: Fri, 11 Feb 2022 18:10:33 -0800
Subject: [PATCH 1/1] watchdog: aspeed: add nowayout support
Message-ID: <20220212021033.2344-1-eduval@amazon.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for not stopping the watchdog
when the userspace application quits. At
closing of the device, the driver cannot
determine if this was a graceful closure
or if the app crashed. If the support
of nowayout on this driver, the system integrator
can select the behaviour by setting the kernel
config and enabling it.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org> (maintainer:WATCHDOG DEVICE DRIVERS)
Cc: Guenter Roeck <linux@roeck-us.net> (maintainer:WATCHDOG DEVICE DRIVERS)
Cc: Joel Stanley <joel@jms.id.au> (supporter:ARM/ASPEED MACHINE SUPPORT)
Cc: Andrew Jeffery <andrew@aj.id.au> (reviewer:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-watchdog at vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS)
Cc: linux-arm-kernel at lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-aspeed at lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
Cc: linux-kernel at vger.kernel.org (open list)
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Eduardo Valentin <evalenti@kernel.org>
---
 drivers/watchdog/aspeed_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 436571b6fc79..bd06622813eb 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -13,6 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
 struct aspeed_wdt {
 	struct watchdog_device	wdd;
 	void __iomem		*base;
@@ -266,6 +271,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
+	watchdog_set_nowayout(&wdt->wdd, nowayout);
+
 	np = dev->of_node;
 
 	ofdid = of_match_node(aspeed_wdt_of_table, np);
-- 
2.17.1

