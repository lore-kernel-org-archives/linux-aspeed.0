From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 5 Sep 2024 19:47:54 +0800
Subject: [PATCH 2/2] net: mdio: aspeed: Add AST2700 support
In-Reply-To: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
References: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
Message-ID: <20240905114754.519609-3-jacky_chou@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add AST2700 compatible for Aspeed MDIO driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index c2170650415c..607e5c56434f 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -188,6 +188,7 @@ static void aspeed_mdio_remove(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_mdio_of_match[] = {
 	{ .compatible = "aspeed,ast2600-mdio", },
+	{ .compatible = "aspeed,ast2700-mdio", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_mdio_of_match);
-- 
2.25.1

