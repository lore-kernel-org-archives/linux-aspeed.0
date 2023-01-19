From: ye.xingchen@zte.com.cn <ye.xingchen@zte.com.cn>
Date: Thu, 19 Jan 2023 15:36:49 +0800 (CST)
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGNyeXB0bzogYXNwZWVkIC0gVXNlIGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Message-ID: <202301191536493046780@zte.com.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/aspeed/aspeed-hace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 656cb92c8bb6..d2871e1de9c2 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -99,7 +99,6 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	const struct of_device_id *hace_dev_id;
 	struct aspeed_engine_hash *hash_engine;
 	struct aspeed_hace_dev *hace_dev;
-	struct resource *res;
 	int rc;

 	hace_dev = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
@@ -118,11 +117,9 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	hash_engine = &hace_dev->hash_engine;
 	crypto_engine = &hace_dev->crypto_engine;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
 	platform_set_drvdata(pdev, hace_dev);

-	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
+	hace_dev->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(hace_dev->regs))
 		return PTR_ERR(hace_dev->regs);

-- 
2.25.1
