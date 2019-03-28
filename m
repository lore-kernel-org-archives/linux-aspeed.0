From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Mar 2019 10:48:32 +1030
Subject: [RFC linux 2/2] rtc: aspeed: Add alarm support
In-Reply-To: <20190328001832.11076-1-joel@jms.id.au>
References: <20190328001832.11076-1-joel@jms.id.au>
Message-ID: <20190328001832.11076-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/rtc/rtc-aspeed.c | 97 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index a423ce6483f8..8b6163567d10 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -11,12 +11,23 @@ struct aspeed_rtc {
 	struct rtc_device *rtc_dev;
 	void __iomem *base;
 	spinlock_t lock;
+	int irq;
 };
 
 #define RTC_TIME	0x00
 #define RTC_YEAR	0x04
+#define RTC_ALARM	0x08
 #define RTC_CTRL	0x10
-
+#define RTC_ALARM_STS	0x14
+
+/* Control register */
+#define ALARM_WAKEUP	BIT(8)
+#define ALARM_IRQ_SEC	BIT(7)
+#define ALARM_DAY	BIT(6)
+#define ALARM_HOUR	BIT(5)
+#define ALARM_MIN	BIT(4)
+#define ALARM_SEC	BIT(3)
+#define ALARM_COMBINED	BIT(2)
 #define RTC_UNLOCK	BIT(1)
 #define RTC_ENABLE	BIT(0)
 
@@ -87,9 +98,81 @@ static int aspeed_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int aspeed_rtc_alarm_irq_enable(struct device *dev, unsigned int en)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	u32 reg = readl(rtc->base + RTC_CTRL);
+
+	if (en)
+		reg |= ALARM_DAY | ALARM_HOUR | ALARM_MIN | ALARM_SEC |
+			ALARM_COMBINED;
+
+	writel(reg, rtc->base + RTC_CTRL);
+
+	return 0;
+}
+
+static int aspeed_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(rtc->base + RTC_ALARM);
+
+	alarm->time.tm_mday = (reg >> 24) & 0x1f;
+	alarm->time.tm_hour = (reg >> 16) & 0x1f;
+	alarm->time.tm_min = (reg >> 8) & 0x3f;
+	alarm->time.tm_sec = reg & 0x3f;
+
+	return 0;
+}
+
+
+static int aspeed_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	u8 day, hour, min, sec;
+	u32 reg;
+
+	aspeed_rtc_alarm_irq_enable(dev, 0);
+
+	day = alarm->time.tm_mday & 0x1f;
+	hour = alarm->time.tm_hour & 0x1f;
+	min = alarm->time.tm_min & 0x3f;
+	sec = alarm->time.tm_sec & 0x3f;
+
+	reg = (day << 24) | (hour << 16) | (min << 8) | sec;
+
+	writel(reg, rtc->base + RTC_ALARM);
+
+	aspeed_rtc_alarm_irq_enable(dev, alarm->enabled);
+
+	return 0;
+}
+
+static irqreturn_t aspeed_rtc_irq_handler(int irq, void *id)
+{
+	struct device *dev = id;
+	struct aspeed_rtc *rtc = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(rtc->base + RTC_ALARM_STS);
+	if (reg & BIT(0))
+		return IRQ_NONE;
+
+	writel(reg, rtc->base + RTC_ALARM_STS);
+	rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
+	return IRQ_HANDLED;
+}
+
+
+
 static const struct rtc_class_ops aspeed_rtc_ops = {
 	.read_time = aspeed_rtc_read_time,
 	.set_time = aspeed_rtc_set_time,
+	.read_alarm = aspeed_rtc_read_alarm,
+	.set_alarm = aspeed_rtc_set_alarm,
+	.alarm_irq_enable = aspeed_rtc_alarm_irq_enable,
 };
 
 static int aspeed_rtc_probe(struct platform_device *pdev)
@@ -107,6 +190,10 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0)
+		return -EINVAL;
+
 	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
@@ -117,6 +204,14 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
 	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
 
+	ret = devm_request_irq(&pdev->dev, rtc->irq,
+			       aspeed_rtc_irq_handler, 0,
+			       dev_name(&pdev->dev), &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request irq\n");
+		return ret;
+	}
+
 	ret = rtc_register_device(rtc->rtc_dev);
 	if (ret)
 		return ret;
-- 
2.20.1

