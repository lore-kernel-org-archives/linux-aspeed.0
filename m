From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 25 Sep 2019 15:22:17 -0400
Subject: [v2, 2/2] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569439337-10482-1-git-send-email-hongweiz@ami.com>
References: <1569439337-10482-1-git-send-email-hongweiz@ami.com>
Message-ID: <1569439337-10482-3-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add SGPIO driver support for Aspeed AST2500 SoC.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 drivers/gpio/Kconfig             |  8 ++++++++
 drivers/gpio/Makefile            |  1 +

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bb13c26..e94f903 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -120,6 +120,14 @@ config GPIO_ASPEED
 	help
 	  Say Y here to support Aspeed AST2400 and AST2500 GPIO controllers.
 
+config SGPIO_ASPEED
+	bool "Aspeed SGPIO support"
+	depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	help
+	  Say Y here to support Aspeed AST2500 SGPIO functionality.
+
 config GPIO_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X GPIO support"
 	default y if ATH79
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a4e9117..bebbd82 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_GPIO_AMD_FCH)		+= gpio-amd-fch.o
 obj-$(CONFIG_GPIO_AMDPT)		+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)		+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ASPEED)		+= gpio-aspeed.o
+obj-$(CONFIG_SGPIO_ASPEED)		+= sgpio-aspeed.o
 obj-$(CONFIG_GPIO_ATH79)		+= gpio-ath79.o
 obj-$(CONFIG_GPIO_BCM_KONA)		+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD70528)		+= gpio-bd70528.o
-- 
2.7.4

