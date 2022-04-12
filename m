From: cgel.zte@gmail.com <cgel.zte@gmail.com>
Date: Tue, 12 Apr 2022 09:01:47 +0000
Subject: [PATCH] peci: fix error check return value of platform_get_irq()
Message-ID: <20220412090148.2533219-1-lv.ruyi@zte.com.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Lv Ruyi <lv.ruyi@zte.com.cn>

platform_get_irq() return negative value on failure, so null check of
priv->irq is incorrect. Fix it by comparing whether it is less than zero.

Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
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
2.25.1

