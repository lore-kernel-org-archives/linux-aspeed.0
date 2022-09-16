From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 16 Sep 2022 13:09:36 +0100
Subject: [PATCH] hwmon: (aspeed-pwm-tacho): Add dependency on ARCH_ASPEED
Message-ID: <20220916120936.372591-1-pbrobinson@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SENSORS_ASPEED is part of the Aspeed silicon so it makes
sense to depend on ARCH_ASPEED and for compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e70d9614bec2..006af099955f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -393,6 +393,7 @@ config SENSORS_ASB100
 
 config SENSORS_ASPEED
 	tristate "ASPEED AST2400/AST2500 PWM and Fan tach driver"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on THERMAL || THERMAL=n
 	select REGMAP
 	help
-- 
2.37.3

