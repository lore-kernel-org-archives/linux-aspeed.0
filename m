From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:32 +0800
Subject: [PATCH -next 13/34] rtc: jz4740: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-14-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-jz4740.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 3089645..18023e4 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -307,7 +307,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_rtc *rtc;
-	struct resource *mem;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	const struct of_device_id *of_id = of_match_device(
 			jz4740_rtc_of_match, &pdev->dev);
@@ -326,8 +325,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq < 0)
 		return -ENOENT;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rtc->base = devm_ioremap_resource(&pdev->dev, mem);
+	rtc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-- 
2.7.4


