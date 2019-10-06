From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:43 +0800
Subject: [PATCH -next 24/34] rtc: spear: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-25-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-spear.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 9f23b24..833daeb 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -347,7 +347,6 @@ static const struct rtc_class_ops spear_rtc_ops = {
 
 static int spear_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct spear_rtc_config *config;
 	int status = 0;
 	int irq;
@@ -369,8 +368,7 @@ static int spear_rtc_probe(struct platform_device *pdev)
 		return status;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	config->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	config->ioaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(config->ioaddr))
 		return PTR_ERR(config->ioaddr);
 
-- 
2.7.4


