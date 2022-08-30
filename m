From: Sun Ke <sunke32@huawei.com>
Date: Tue, 30 Aug 2022 11:13:47 +0800
Subject: [PATCH] crypto: aspeed: fix return value check in aspeed_hace_probe()
Message-ID: <20220830031347.810217-1-sunke32@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case of error, the function devm_ioremap_resource() returns
ERR_PTR() not NULL. The NULL test in the return value check must be
replaced with IS_ERR().

Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 drivers/crypto/aspeed/aspeed-hace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index 4fefc9e69d72..3f880aafb6a2 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -123,9 +123,9 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hace_dev);
 
 	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (!hace_dev->regs) {
+	if (IS_ERR(hace_dev->regs)) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
-		return -ENOMEM;
+		return PTR_ERR(hace_dev->regs);
 	}
 
 	/* Get irq number and register it */
-- 
2.31.1

