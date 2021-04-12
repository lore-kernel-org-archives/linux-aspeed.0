From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Apr 2021 17:54:57 +0800
Subject: [PATCH 4/4] pwm: Add support for aspeed pwm controller
In-Reply-To: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
Message-ID: <20210412095457.15095-5-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for the pwm controller which can be found at aspeed ast2600
soc. This driver is part function of multi-funciton of device "pwm-tach
controller".

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pwm/Kconfig  | 6 ++++++
 drivers/pwm/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..947ed642debe 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -42,6 +42,12 @@ config PWM_DEBUG
 	  It is expected to introduce some runtime overhead and diagnostic
 	  output to the kernel log, so only enable while working on a driver.
 
+config PWM_ASPEED_G6
+	tristate "ASPEEDG6 PWM support"
+	help
+	  This driver provides support for ASPEED G6 PWM controllers.
+
+
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69ee..4a74c68547bf 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
+obj-$(CONFIG_PWM_ASPEED_G6)	+= pwm-aspeed-g6.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
-- 
2.25.1

