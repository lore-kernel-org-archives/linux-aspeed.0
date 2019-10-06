From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:27 +0800
Subject: [PATCH -next 08/34] rtc: digicolor: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-9-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-digicolor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
index 0aecc3f..200d85b 100644
--- a/drivers/rtc/rtc-digicolor.c
+++ b/drivers/rtc/rtc-digicolor.c
@@ -175,7 +175,6 @@ static irqreturn_t dc_rtc_irq(int irq, void *dev_id)
 
 static int __init dc_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct dc_rtc *rtc;
 	int irq, ret;
 
@@ -183,8 +182,7 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
 	if (!rtc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	rtc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->regs))
 		return PTR_ERR(rtc->regs);
 
-- 
2.7.4


