From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Mar 2019 10:48:31 +1030
Subject: [RFC linux 1/2] rtc: aspeed: Add locking when touching registers
In-Reply-To: <20190328001832.11076-1-joel@jms.id.au>
References: <20190328001832.11076-1-joel@jms.id.au>
Message-ID: <20190328001832.11076-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/rtc/rtc-aspeed.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index af3eb676d7c3..a423ce6483f8 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -10,6 +10,7 @@
 struct aspeed_rtc {
 	struct rtc_device *rtc_dev;
 	void __iomem *base;
+	spinlock_t lock;
 };
 
 #define RTC_TIME	0x00
@@ -25,7 +26,10 @@ static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned int cent, year;
 	u32 reg1, reg2;
 
+	spin_lock_irqsave(&rtc->lock, flags);
+
 	if (!(readl(rtc->base + RTC_CTRL) & RTC_ENABLE)) {
+		spin_unlock_irqrestore(&rtc->lock, flags);
 		dev_dbg(dev, "%s failing as rtc disabled\n", __func__);
 		return -EINVAL;
 	}
@@ -47,6 +51,8 @@ static int aspeed_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	dev_dbg(dev, "%s %ptR", __func__, tm);
 
+	spin_unlock_irqrestore(&rtc->lock, flags);
+
 	return 0;
 }
 
@@ -65,6 +71,8 @@ static int aspeed_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	reg2 = ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
 		((tm->tm_mon + 1) & 0xf);
 
+	spin_lock_irqsave(&rtc->lock, flags);
+
 	ctrl = readl(rtc->base + RTC_CTRL);
 	writel(ctrl | RTC_UNLOCK, rtc->base + RTC_CTRL);
 
@@ -74,6 +82,8 @@ static int aspeed_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	/* Re-lock and ensure enable is set now that a time is programmed */
 	writel(ctrl | RTC_ENABLE, rtc->base + RTC_CTRL);
 
+	spin_unlock_irqrestore(&rtc->lock, flags);
+
 	return 0;
 }
 
@@ -111,6 +121,8 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&rtc->lock);
+
 	return 0;
 }
 
-- 
2.20.1

