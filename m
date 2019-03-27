From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Mar 2019 11:32:15 +1030
Subject: [PATCH v3 2/2] rtc: Add ASPEED RTC driver
In-Reply-To: <20190327010215.10231-1-joel@jms.id.au>
References: <20190327010215.10231-1-joel@jms.id.au>
Message-ID: <20190327010215.10231-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Read and writes the time to the non-battery backed RTC in the ASPEED BMC
system on chip families.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3:
 - Use %ptR
 - Remove spinlock, as callback happen under the rtc_device.ops_lock
v2: Address review from Alexandre
 - Use devm_rtc_allocate_device
 - Fill in range_min
 - Direcly fill in tm struct
 - Return EINVAL when RTC is not enabled

v1: https://lore.kernel.org/linux-arm-kernel/20181003133155.27494-2-joel at jms.id.au/

Update kconfig text

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/rtc/Kconfig      |  11 ++++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-aspeed.c | 138 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 drivers/rtc/rtc-aspeed.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index dc0d66e80038..fd1321875cb1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1841,6 +1841,17 @@ config RTC_DRV_RTD119X
 	  If you say yes here, you get support for the RTD1295 SoC
 	  Real Time Clock.
 
+config RTC_DRV_ASPEED
+	tristate "ASPEED RTC"
+	depends on OF
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  If you say yes here you get support for the ASPEED BMC SoC real time
+	  clocks.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-aspeed".
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index fe3962496685..9d997faa2c26 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_RTC_DRV_AC100)	+= rtc-ac100.o
 obj-$(CONFIG_RTC_DRV_ARMADA38X)	+= rtc-armada38x.o
 obj-$(CONFIG_RTC_DRV_AS3722)	+= rtc-as3722.o
 obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
+obj-$(CONFIG_RTC_DRV_ASPEED)	+= rtc-aspeed.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
 obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
new file mode 100644
index 000000000000..bd709feea695
--- /dev/null
+++ b/drivers/rtc/rtc-aspeed.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2015 IBM Corp.
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/io.h>
+
+struct aspeed_rtc {
+	struct rtc_device *rtc_dev;
+	void __iomem *base;
+};
+
+#define RTC_TIME	0x00
+#define RTC_YEAR	0x04
+#define RTC_CTRL	0x10
+
+#define RTC_UNLOCK	BIT(1)
+#define RTC_ENABLE	BIT(0)
+
+static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	unsigned int cent, year;
+	unsigned long flags;
+	u32 reg1, reg2;
+
+	if (!(readl(rtc->base + RTC_CTRL) & RTC_ENABLE)) {
+		dev_dbg(dev, "%s failing as rtc disabled\n", __func__);
+		return -EINVAL;
+	}
+
+	do {
+		reg2 = readl(rtc->base + RTC_YEAR);
+		reg1 = readl(rtc->base + RTC_TIME);
+	} while (reg2 != readl(rtc->base + RTC_YEAR));
+
+	tm->tm_mday = (reg1 >> 24) & 0x1f;
+	tm->tm_hour = (reg1 >> 16) & 0x1f;
+	tm->tm_min = (reg1 >> 8) & 0x3f;
+	tm->tm_sec = (reg1 >> 0) & 0x3f;
+
+	cent = (reg2 >> 16) & 0x1f;
+	year = (reg2 >> 8) & 0x7f;
+	tm->tm_mon = ((reg2 >>  0) & 0x0f) - 1;
+	tm->tm_year = year + (cent * 100) - 1900;
+
+	dev_dbg(dev, "%s %ptR", __func__, tm);
+
+	return 0;
+}
+
+static int aspeed_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 reg1, reg2, ctrl;
+	int year, cent;
+
+	cent = (tm->tm_year + 1900) / 100;
+	year = tm->tm_year % 100;
+
+	reg1 = (tm->tm_mday << 24) | (tm->tm_hour << 16) | (tm->tm_min << 8) |
+		tm->tm_sec;
+
+	reg2 = ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
+		((tm->tm_mon + 1) & 0xf);
+
+	ctrl = readl(rtc->base + RTC_CTRL);
+	writel(ctrl | RTC_UNLOCK, rtc->base + RTC_CTRL);
+
+	writel(reg1, rtc->base + RTC_TIME);
+	writel(reg2, rtc->base + RTC_YEAR);
+
+	/* Re-lock and ensure enable is set now that a time is programmed */
+	writel(ctrl | RTC_ENABLE, rtc->base + RTC_CTRL);
+
+	return 0;
+}
+
+static const struct rtc_class_ops aspeed_rtc_ops = {
+	.read_time = aspeed_rtc_read_time,
+	.set_time = aspeed_rtc_set_time,
+};
+
+static int aspeed_rtc_probe(struct platform_device *pdev)
+{
+	struct aspeed_rtc *rtc;
+	struct resource *res;
+	int ret;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rtc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rtc->base))
+		return PTR_ERR(rtc->base);
+
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc_dev->ops = &aspeed_rtc_ops;
+	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
+
+	ret = rtc_register_device(rtc->rtc_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id aspeed_rtc_match[] = {
+	{ .compatible = "aspeed,ast2400-rtc", },
+	{ .compatible = "aspeed,ast2500-rtc", },
+	{ .compatible = "aspeed,ast2600-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, aspeed_rtc_match);
+
+static struct platform_driver aspeed_rtc_driver = {
+	.driver = {
+		.name = "aspeed-rtc",
+		.of_match_table = of_match_ptr(aspeed_rtc_match),
+	},
+};
+
+module_platform_driver_probe(aspeed_rtc_driver, aspeed_rtc_probe);
+
+MODULE_DESCRIPTION("ASPEED RTC driver");
+MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

