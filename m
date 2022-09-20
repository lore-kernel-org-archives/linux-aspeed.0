From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 20 Sep 2022 11:21:18 +0800
Subject: [PATCH -next] crypto: aspeed - Fix check for platform_get_irq() errors
Message-ID: <20220920032118.6440-1-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The platform_get_irq() function returns negative on error and
positive non-zero values on success. It never returns zero, but if it
did then treat that as a success.

Also remove redundant dev_err() print as platform_get_irq() already
prints an error.

Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/crypto/aspeed/aspeed-hace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 3f880aafb6a2..f7f1d33defb1 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -130,10 +130,8 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 
 	/* Get irq number and register it */
 	hace_dev->irq = platform_get_irq(pdev, 0);
-	if (!hace_dev->irq) {
-		dev_err(&pdev->dev, "Failed to get interrupt\n");
+	if (hace_dev->irq < 0)
 		return -ENXIO;
-	}
 
 	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
 			      dev_name(&pdev->dev), hace_dev);
-- 
2.17.1

