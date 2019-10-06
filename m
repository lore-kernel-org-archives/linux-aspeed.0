From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:33 +0800
Subject: [PATCH -next 14/34] rtc: lpc24xx: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-15-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-lpc24xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-lpc24xx.c b/drivers/rtc/rtc-lpc24xx.c
index a8bb156..00ef16b 100644
--- a/drivers/rtc/rtc-lpc24xx.c
+++ b/drivers/rtc/rtc-lpc24xx.c
@@ -194,15 +194,13 @@ static const struct rtc_class_ops lpc24xx_rtc_ops = {
 static int lpc24xx_rtc_probe(struct platform_device *pdev)
 {
 	struct lpc24xx_rtc *rtc;
-	struct resource *res;
 	int irq, ret;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rtc->rtc_base = devm_ioremap_resource(&pdev->dev, res);
+	rtc->rtc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->rtc_base))
 		return PTR_ERR(rtc->rtc_base);
 
-- 
2.7.4


