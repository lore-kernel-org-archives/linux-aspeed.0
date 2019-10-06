From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:34 +0800
Subject: [PATCH -next 15/34] rtc: lpc32xx: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-16-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-lpc32xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index ac39323..b6a0d4a 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -185,7 +185,6 @@ static const struct rtc_class_ops lpc32xx_rtc_ops = {
 
 static int lpc32xx_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct lpc32xx_rtc *rtc;
 	int err;
 	u32 tmp;
@@ -194,8 +193,7 @@ static int lpc32xx_rtc_probe(struct platform_device *pdev)
 	if (unlikely(!rtc))
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rtc->rtc_base = devm_ioremap_resource(&pdev->dev, res);
+	rtc->rtc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->rtc_base))
 		return PTR_ERR(rtc->rtc_base);
 
-- 
2.7.4


