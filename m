From: Yang Li <yang.lee@linux.alibaba.com>
Date: Mon, 20 Feb 2023 20:39:21 +0800
Subject: [PATCH -next] crypto: Use devm_platform_ioremap_resource()
Message-ID: <20230220123921.7191-1-yang.lee@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to Use devm_platform_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/aspeed/aspeed-acry.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
index 1f77ebd73489..857a7a222922 100644
--- a/drivers/crypto/aspeed/aspeed-acry.c
+++ b/drivers/crypto/aspeed/aspeed-acry.c
@@ -712,7 +712,6 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 {
 	struct aspeed_acry_dev *acry_dev;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int rc;
 
 	acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
@@ -724,13 +723,11 @@ static int aspeed_acry_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, acry_dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	acry_dev->regs = devm_ioremap_resource(dev, res);
+	acry_dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(acry_dev->regs))
 		return PTR_ERR(acry_dev->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	acry_dev->acry_sram = devm_ioremap_resource(dev, res);
+	acry_dev->acry_sram = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(acry_dev->acry_sram))
 		return PTR_ERR(acry_dev->acry_sram);
 
-- 
2.20.1.7.g153144c

