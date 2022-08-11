From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 11 Aug 2022 13:49:26 +0300
Subject: [PATCH] peci: Fix platform_get_irq() error checking
Message-ID: <YvTettdmRKZw46mb@kili>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The platform_get_irq() function returns success or negative error codes
on failure.

Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/peci/controller/peci-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 1925ddc13f00..731c5d8f75c6 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -523,7 +523,7 @@ static int aspeed_peci_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (!priv->irq)
+	if (priv->irq < 0)
 		return priv->irq;
 
 	ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
-- 
2.35.1

