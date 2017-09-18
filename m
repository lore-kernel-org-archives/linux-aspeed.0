From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 18 Sep 2017 15:19:05 +0930
Subject: [PATCH 4/4] watchdog: aspeed: Move init to arch_initcall
In-Reply-To: <20170918054905.16470-1-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au>
Message-ID: <20170918054905.16470-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Probing at device_initcall time lead to perverse cases where the
watchdog was probed after, say, I2C, which then leaves a potentially
running watchdog at the mercy of I2C device behaviour and bus
conditions.

Load the watchdog driver early to ensure that the kernel is patting it
well before initialising peripherals.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/watchdog/Kconfig      | 6 ++----
 drivers/watchdog/aspeed_wdt.c | 7 ++++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a1b92ebe74b6..6103185983ed 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -741,8 +741,9 @@ config RENESAS_RZAWDT
 	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
 
 config ASPEED_WATCHDOG
-	tristate "Aspeed BMC watchdog support"
+	bool "Aspeed BMC watchdog support"
 	depends on ARCH_ASPEED || COMPILE_TEST
+	default y if ARCH_ASPEED
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include support for the watchdog timer
@@ -750,9 +751,6 @@ config ASPEED_WATCHDOG
 
 	  This driver is required to reboot the SoC.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called aspeed_wdt.
-
 config ZX2967_WATCHDOG
 	tristate "ZTE zx2967 SoCs watchdog support"
 	depends on ARCH_ZX
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 99bc6fbd8852..679c35abadc4 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -313,7 +313,12 @@ static struct platform_driver aspeed_watchdog_driver = {
 		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
 	},
 };
-module_platform_driver(aspeed_watchdog_driver);
+
+static int __init aspeed_wdt_init(void)
+{
+	return platform_driver_register(&aspeed_watchdog_driver);
+}
+arch_initcall(aspeed_wdt_init);
 
 MODULE_DESCRIPTION("Aspeed Watchdog Driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0

