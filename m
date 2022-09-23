From: Shang XiaoJing <shangxiaojing@huawei.com>
Date: Fri, 23 Sep 2022 18:01:59 +0800
Subject: [PATCH -next] crypto: aspeed - Remove redundant dev_err call
Message-ID: <20220923100159.15705-1-shangxiaojing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

devm_ioremap_resource() prints error message in itself. Remove the
dev_err call to avoid redundant error message.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/crypto/aspeed/aspeed-hace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 3f880aafb6a2..e05c32c31842 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -123,10 +123,8 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hace_dev);
 
 	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hace_dev->regs)) {
-		dev_err(&pdev->dev, "Failed to map resources\n");
+	if (IS_ERR(hace_dev->regs))
 		return PTR_ERR(hace_dev->regs);
-	}
 
 	/* Get irq number and register it */
 	hace_dev->irq = platform_get_irq(pdev, 0);
-- 
2.17.1

