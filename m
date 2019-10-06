From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:26 +0800
Subject: [PATCH -next 07/34] rtc: davinci: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-8-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index d8e0db2..390b735 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -469,7 +469,6 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct davinci_rtc *davinci_rtc;
-	struct resource *res;
 	int ret = 0;
 
 	davinci_rtc = devm_kzalloc(&pdev->dev, sizeof(struct davinci_rtc), GFP_KERNEL);
@@ -480,8 +479,7 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 	if (davinci_rtc->irq < 0)
 		return davinci_rtc->irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	davinci_rtc->base = devm_ioremap_resource(dev, res);
+	davinci_rtc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(davinci_rtc->base))
 		return PTR_ERR(davinci_rtc->base);
 
-- 
2.7.4


