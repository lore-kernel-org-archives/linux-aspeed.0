From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 16 Oct 2020 14:48:48 -0700
Subject: [PATCH v1] i2c: aspeed: add KUnit tests for clock parameters
Message-ID: <20201016214848.1365719-1-brendanhiggins@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add KUnit tests for Aspeed I2C driver to test setting clock divider
registers given an input clock speed.

I wrote this test a while ago and it found a bug in the Aspeed I2C
driver a couple years ago[1].

Link[1]: https://lore.kernel.org/patchwork/patch/989312/
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS                          |   1 +
 drivers/i2c/busses/Kconfig           |  18 ++-
 drivers/i2c/busses/i2c-aspeed-test.c | 218 +++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-aspeed.c      |   4 +
 4 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i2c/busses/i2c-aspeed-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361c..683382df2434a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,6 +1653,7 @@ L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
+F:	drivers/i2c/busses/i2c-aspeed-test.c
 F:	drivers/i2c/busses/i2c-aspeed.c
 F:	drivers/irqchip/irq-aspeed-i2c-ic.c
 
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 293e7a0760e77..0f12090f9fe26 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -379,7 +379,7 @@ config I2C_ALTERA
 
 config I2C_ASPEED
 	tristate "Aspeed I2C Controller"
-	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on ARCH_ASPEED || COMPILE_TEST || KUNIT=y
 	help
 	  If you say yes to this option, support will be included for the
 	  Aspeed I2C controller.
@@ -387,6 +387,22 @@ config I2C_ASPEED
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-aspeed.
 
+config I2C_ASPEED_KUNIT_TEST
+	bool "Aspeed I2C Controller KUnit test"
+	depends on I2C_ASPEED=y
+	help
+	  This builds the Aspeed I2C KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/i2c/busses/i2c-aspeed-test.c b/drivers/i2c/busses/i2c-aspeed-test.c
new file mode 100644
index 0000000000000..93e73af95b645
--- /dev/null
+++ b/drivers/i2c/busses/i2c-aspeed-test.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed 24XX/25XX I2C Controller KUnit tests.
+ *
+ *  Copyright (C) 2020 Google LLC.
+ */
+
+#include <kunit/test.h>
+
+#define ASPEED_I2C_MAX_BASE_DIVISOR		(1 << ASPEED_I2CD_TIME_BASE_DIVISOR_MASK)
+#define ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK	GENMASK(2, 0)
+#define ASPEED_I2C_24XX_CLK_HIGH_LOW_MAX	((ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK + 1) * 2)
+#define ASPEED_I2C_24XX_MAX_DIVISOR		\
+		(ASPEED_I2C_MAX_BASE_DIVISOR * ASPEED_I2C_24XX_CLK_HIGH_LOW_MAX)
+#define ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK	GENMASK(3, 0)
+#define ASPEED_I2C_25XX_CLK_HIGH_LOW_MAX	((ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK + 1) * 2)
+#define ASPEED_I2C_25XX_MAX_DIVISOR		\
+		(ASPEED_I2C_MAX_BASE_DIVISOR * ASPEED_I2C_25XX_CLK_HIGH_LOW_MAX)
+
+static u32 aspeed_i2c_get_base_clk(u32 reg_val)
+{
+	return reg_val & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
+}
+
+static u32 aspeed_i2c_get_clk_high(u32 reg_val)
+{
+	return (reg_val & ASPEED_I2CD_TIME_SCL_HIGH_MASK) >>
+			ASPEED_I2CD_TIME_SCL_HIGH_SHIFT;
+}
+
+static u32 aspeed_i2c_get_clk_low(u32 reg_val)
+{
+	return (reg_val & ASPEED_I2CD_TIME_SCL_LOW_MASK) >>
+			ASPEED_I2CD_TIME_SCL_LOW_SHIFT;
+}
+
+static void aspeed_i2c_get_clk_reg_val_params_test(struct kunit *test,
+						   u32 (*get_clk_reg_val)(struct device *, u32),
+						   u32 divisor,
+						   u32 base_clk,
+						   u32 clk_high,
+						   u32 clk_low)
+{
+	u32 reg_val;
+
+	reg_val = get_clk_reg_val(NULL, divisor);
+	KUNIT_ASSERT_EQ(test,
+			(u32)(reg_val & ~(ASPEED_I2CD_TIME_SCL_HIGH_MASK |
+					  ASPEED_I2CD_TIME_SCL_LOW_MASK |
+					  ASPEED_I2CD_TIME_BASE_DIVISOR_MASK)),
+			(u32)0);
+	KUNIT_EXPECT_EQ(test, aspeed_i2c_get_base_clk(reg_val), base_clk);
+	KUNIT_EXPECT_EQ(test, aspeed_i2c_get_clk_high(reg_val), clk_high);
+	KUNIT_EXPECT_EQ(test, aspeed_i2c_get_clk_low(reg_val), clk_low);
+}
+
+static void aspeed_i2c_24xx_get_clk_reg_val_params_test(struct kunit *test,
+							u32 divisor,
+							u32 base_clk,
+							u32 clk_high,
+							u32 clk_low)
+{
+	aspeed_i2c_get_clk_reg_val_params_test(test,
+					       aspeed_i2c_24xx_get_clk_reg_val,
+					       divisor,
+					       base_clk,
+					       clk_high,
+					       clk_low);
+}
+
+/*
+ * Verify that smallest possible divisors are handled correctly.
+ */
+static void aspeed_i2c_24xx_get_clk_reg_val_test_min(struct kunit *test)
+{
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 0, 0, 0, 0);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 1, 0, 0, 0);
+}
+
+/*
+ * Verify that largest possible divisors are handled correctly.
+ */
+static void aspeed_i2c_24xx_get_clk_reg_val_test_max(struct kunit *test)
+{
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test,
+						    ASPEED_I2C_24XX_MAX_DIVISOR,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test,
+						    ASPEED_I2C_24XX_MAX_DIVISOR + 1,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test,
+						    U32_MAX,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_24XX_CLK_HIGH_LOW_MASK);
+}
+
+/*
+ * Spot check values from the datasheet table.
+ */
+static void aspeed_i2c_24xx_get_clk_reg_val_test_datasheet(struct kunit *test)
+{
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 6, 0, 2, 2);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 7, 0, 3, 2);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 16, 0, 7, 7);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 18, 1, 4, 3);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 491520, 15, 7, 6);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 524288, 15, 7, 7);
+}
+
+/*
+ * Check that a divisor that cannot be represented exactly is rounded up to the
+ * next divisor that can be represented.
+ */
+static void aspeed_i2c_24xx_get_clk_reg_val_test_round_up(struct kunit *test)
+{
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 16, 0, 7, 7);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 17, 1, 4, 3);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 18, 1, 4, 3);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 19, 1, 4, 4);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 491519, 15, 7, 6);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 491520, 15, 7, 6);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 524287, 15, 7, 7);
+	aspeed_i2c_24xx_get_clk_reg_val_params_test(test, 524288, 15, 7, 7);
+}
+
+static void aspeed_i2c_25xx_get_clk_reg_val_params_test(struct kunit *test,
+							u32 divisor,
+							u32 base_clk,
+							u32 clk_high,
+							u32 clk_low)
+{
+	aspeed_i2c_get_clk_reg_val_params_test(test,
+					       aspeed_i2c_25xx_get_clk_reg_val,
+					       divisor,
+					       base_clk,
+					       clk_high,
+					       clk_low);
+}
+
+/*
+ * Verify that smallest possible divisors are handled correctly.
+ */
+static void aspeed_i2c_25xx_get_clk_reg_val_test_min(struct kunit *test)
+{
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 0, 0, 0, 0);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 1, 0, 0, 0);
+}
+
+/*
+ * Verify that largest possible divisors are handled correctly.
+ */
+static void aspeed_i2c_25xx_get_clk_reg_val_test_max(struct kunit *test)
+{
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test,
+						    ASPEED_I2C_25XX_MAX_DIVISOR,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test,
+						    ASPEED_I2C_25XX_MAX_DIVISOR + 1,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test,
+						    U32_MAX,
+						    ASPEED_I2CD_TIME_BASE_DIVISOR_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK,
+						    ASPEED_I2C_25XX_CLK_HIGH_LOW_MASK);
+}
+
+/*
+ * Spot check values from the datasheet table.
+ */
+static void aspeed_i2c_25xx_get_clk_reg_val_test_datasheet(struct kunit *test)
+{
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 6, 0, 2, 2);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 7, 0, 3, 2);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 32, 0, 15, 15);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 34, 1, 8, 7);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2048, 6, 15, 15);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2176, 7, 8, 7);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 3072, 7, 11, 11);
+}
+
+/*
+ * Check that a divisor that cannot be represented exactly is rounded up to the
+ * next divisor that can be represented.
+ */
+static void aspeed_i2c_25xx_get_clk_reg_val_test_round_up(struct kunit *test)
+{
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2047, 6, 15, 15);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2048, 6, 15, 15);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2175, 7, 8, 7);
+	aspeed_i2c_25xx_get_clk_reg_val_params_test(test, 2176, 7, 8, 7);
+}
+
+static struct kunit_case aspeed_i2c_test_cases[] = {
+	KUNIT_CASE(aspeed_i2c_24xx_get_clk_reg_val_test_min),
+	KUNIT_CASE(aspeed_i2c_24xx_get_clk_reg_val_test_max),
+	KUNIT_CASE(aspeed_i2c_24xx_get_clk_reg_val_test_datasheet),
+	KUNIT_CASE(aspeed_i2c_24xx_get_clk_reg_val_test_round_up),
+	KUNIT_CASE(aspeed_i2c_25xx_get_clk_reg_val_test_min),
+	KUNIT_CASE(aspeed_i2c_25xx_get_clk_reg_val_test_max),
+	KUNIT_CASE(aspeed_i2c_25xx_get_clk_reg_val_test_datasheet),
+	KUNIT_CASE(aspeed_i2c_25xx_get_clk_reg_val_test_round_up),
+	{},
+};
+
+static struct kunit_suite aspeed_i2c_test = {
+	.name = "aspeed-i2c",
+	.test_cases = aspeed_i2c_test_cases,
+};
+kunit_test_suite(aspeed_i2c_test);
diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 31268074c4221..68c460b7d4def 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -1082,6 +1082,10 @@ static struct platform_driver aspeed_i2c_bus_driver = {
 };
 module_platform_driver(aspeed_i2c_bus_driver);
 
+#ifdef CONFIG_I2C_ASPEED_KUNIT_TEST
+#include "i2c-aspeed-test.c"
+#endif /* CONFIG_I2C_ASPEED_KUNIT_TEST */
+
 MODULE_AUTHOR("Brendan Higgins <brendanhiggins@google.com>");
 MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
 MODULE_LICENSE("GPL v2");

base-commit: 1abdd39f14b25dd2d69096b624a4f86f158a9feb
-- 
2.29.0.rc1.297.gfa9743e501-goog

