From: Rob Herring <robh@kernel.org>
Date: Fri, 14 Jul 2023 11:46:04 -0600
Subject: [PATCH] hwmon: Explicitly include correct DT includes
Message-ID: <20230714174607.4057185-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/hwmon/ad7418.c           | 2 +-
 drivers/hwmon/ads7828.c          | 2 +-
 drivers/hwmon/adt7475.c          | 1 -
 drivers/hwmon/as370-hwmon.c      | 3 ++-
 drivers/hwmon/aspeed-pwm-tacho.c | 3 +--
 drivers/hwmon/g762.c             | 1 -
 drivers/hwmon/gxp-fan-ctrl.c     | 2 +-
 drivers/hwmon/ina2xx.c           | 1 -
 drivers/hwmon/lm63.c             | 2 +-
 drivers/hwmon/lm75.c             | 2 +-
 drivers/hwmon/lm85.c             | 2 +-
 drivers/hwmon/lm90.c             | 2 +-
 drivers/hwmon/lochnagar-hwmon.c  | 1 -
 drivers/hwmon/ltq-cputemp.c      | 3 ++-
 drivers/hwmon/max31730.c         | 1 -
 drivers/hwmon/max6621.c          | 2 +-
 drivers/hwmon/max6697.c          | 1 -
 drivers/hwmon/mcp3021.c          | 1 -
 drivers/hwmon/nsa320-hwmon.c     | 2 --
 drivers/hwmon/pmbus/dps920ab.c   | 2 +-
 drivers/hwmon/pmbus/ibm-cffps.c  | 2 +-
 drivers/hwmon/pmbus/ir38064.c    | 4 ++--
 drivers/hwmon/pmbus/max20730.c   | 2 +-
 drivers/hwmon/pmbus/mp5023.c     | 2 +-
 drivers/hwmon/pmbus/mpq7932.c    | 2 +-
 drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
 drivers/hwmon/pmbus/tps53679.c   | 2 +-
 drivers/hwmon/pmbus/ucd9000.c    | 2 +-
 drivers/hwmon/pmbus/ucd9200.c    | 2 +-
 drivers/hwmon/sbtsi_temp.c       | 1 -
 drivers/hwmon/scpi-hwmon.c       | 2 +-
 drivers/hwmon/tmp421.c           | 2 +-
 drivers/hwmon/tmp464.c           | 2 +-
 drivers/hwmon/tps23861.c         | 2 +-
 drivers/hwmon/ultra45_env.c      | 3 ++-
 drivers/hwmon/vexpress-hwmon.c   | 1 -
 drivers/hwmon/w83773g.c          | 2 +-
 37 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index ffe81e445010..bcea66eac82b 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -16,7 +16,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 1932613ec095..e86894e35639 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_data/ads7828.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index c0ce88324ea6..5363254644da 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
index fffbf385a57f..316454bd983d 100644
--- a/drivers/hwmon/as370-hwmon.c
+++ b/drivers/hwmon/as370-hwmon.c
@@ -11,7 +11,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #define CTRL		0x0
 #define  PD		BIT(0)
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index d11f674e3dc3..997df4b40509 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 1b6ff4712138..fad69ef56c75 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -39,7 +39,6 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_data/g762.h>
 
 #define DRVNAME "g762"
diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
index 2e05bc2f627a..00e057050437 100644
--- a/drivers/hwmon/gxp-fan-ctrl.c
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -6,7 +6,7 @@
 #include <linux/hwmon.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index cfd7efef5cdf..a47973e2d606 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -31,7 +31,6 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/util_macros.h>
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 6972454eb4e0..562c94c7d831 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -33,7 +33,7 @@
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 72e634d1b857..72cdc405a3b0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -13,7 +13,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8540178f5b74..2a62ea7b25a9 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -12,7 +12,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 90101c236f35..b25ae8b7ec90 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -106,7 +106,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
diff --git a/drivers/hwmon/lochnagar-hwmon.c b/drivers/hwmon/lochnagar-hwmon.c
index 6350904a8a8b..5202dddfd61e 100644
--- a/drivers/hwmon/lochnagar-hwmon.c
+++ b/drivers/hwmon/lochnagar-hwmon.c
@@ -16,7 +16,6 @@
 #include <linux/mfd/lochnagar2_regs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/hwmon/ltq-cputemp.c b/drivers/hwmon/ltq-cputemp.c
index 08e09a82acab..f7e4a4ca5239 100644
--- a/drivers/hwmon/ltq-cputemp.c
+++ b/drivers/hwmon/ltq-cputemp.c
@@ -9,8 +9,9 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
 
diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
index b1300ca9db1f..7d237db6e57c 100644
--- a/drivers/hwmon/max31730.c
+++ b/drivers/hwmon/max31730.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index 7f709fd1af89..af7e62685898 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -12,7 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 #define MAX6621_DRV_NAME		"max6621"
diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 3a67778f111c..fe826fcf9990 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -15,7 +15,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 
 #include <linux/platform_data/max6697.h>
diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index 127e15ff3e76..9814eaf24564 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -20,7 +20,6 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 /* Vdd / reference voltage in millivolt */
 #define MCP3021_VDD_REF_MAX	5500
diff --git a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
index ebe6b031e56f..e26334469549 100644
--- a/drivers/hwmon/nsa320-hwmon.c
+++ b/drivers/hwmon/nsa320-hwmon.c
@@ -20,8 +20,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 /* Tests for error return values rely upon this value being < 0x80 */
diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
index f7ff3e4650b7..04e0d598a6e5 100644
--- a/drivers/hwmon/pmbus/dps920ab.c
+++ b/drivers/hwmon/pmbus/dps920ab.c
@@ -9,7 +9,7 @@
 #include <linux/debugfs.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 struct dps920ab_data {
diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index c791925b8907..5b11aacda4d2 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -13,7 +13,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 
 #include "pmbus.h"
diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
index 871c322d3d51..04185be3fdb6 100644
--- a/drivers/hwmon/pmbus/ir38064.c
+++ b/drivers/hwmon/pmbus/ir38064.c
@@ -6,7 +6,7 @@
  *
  * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
  * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
- *          
+ *
  * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
  * this driver does not currently support them.
  */
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 7bcf27995033..6f99085c2c3b 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 #include <linux/util_macros.h>
 #include "pmbus.h"
diff --git a/drivers/hwmon/pmbus/mp5023.c b/drivers/hwmon/pmbus/mp5023.c
index c4c4324d2b74..21acb7fd9a1a 100644
--- a/drivers/hwmon/pmbus/mp5023.c
+++ b/drivers/hwmon/pmbus/mp5023.c
@@ -5,7 +5,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 static struct pmbus_driver_info mp5023_info = {
diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index 865d42edda1a..6c62f01da7c6 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 #include "pmbus.h"
 
diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index b830f3b02bcc..a235c1cdf4fe 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -10,7 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 #define STORE_DEFAULT_ALL		0x11
diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index ef99005a3af5..e77b12f342b4 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 enum chips {
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index c404d306e8f7..b1d1d4214e69 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index a82847945508..e4aad64b2d94 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -7,7 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index b79cece4ac9a..dd85cf89f008 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -13,7 +13,6 @@
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 
 /*
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 121e5e9f487f..a0d220609565 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -8,7 +8,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 3cde3916ab6d..10b66c9ce045 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -20,7 +20,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
index 4b79c3f4d9fe..f58ca4c6acb6 100644
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 8fbbb29ae11d..d33ecbac00d6 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -14,7 +14,7 @@
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 #define TEMPERATURE			0x2c
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index b23cff2e3d5d..3b580f229887 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -9,7 +9,8 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
diff --git a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
index 2ac5fb96bba4..d82a3b454d0e 100644
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -13,7 +13,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/vexpress.h>
 
diff --git a/drivers/hwmon/w83773g.c b/drivers/hwmon/w83773g.c
index 7f3615f5587c..045eea8378c2 100644
--- a/drivers/hwmon/w83773g.c
+++ b/drivers/hwmon/w83773g.c
@@ -12,7 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 /* W83773 has 3 channels */
-- 
2.40.1

