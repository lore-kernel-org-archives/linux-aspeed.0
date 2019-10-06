From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:31 +0800
Subject: [PATCH -next 12/34] rtc: ep93xx: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-13-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-ep93xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
index 1766496..8ec9ea1 100644
--- a/drivers/rtc/rtc-ep93xx.c
+++ b/drivers/rtc/rtc-ep93xx.c
@@ -122,15 +122,13 @@ static const struct attribute_group ep93xx_rtc_sysfs_files = {
 static int ep93xx_rtc_probe(struct platform_device *pdev)
 {
 	struct ep93xx_rtc *ep93xx_rtc;
-	struct resource *res;
 	int err;
 
 	ep93xx_rtc = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_rtc), GFP_KERNEL);
 	if (!ep93xx_rtc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep93xx_rtc->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	ep93xx_rtc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_rtc->mmio_base))
 		return PTR_ERR(ep93xx_rtc->mmio_base);
 
-- 
2.7.4


