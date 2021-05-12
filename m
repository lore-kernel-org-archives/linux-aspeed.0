From: Zou Wei <zou_wei@huawei.com>
Date: Wed, 12 May 2021 11:30:04 +0800
Subject: [PATCH net-next] net: mdio: Add missing MODULE_DEVICE_TABLE
Message-ID: <1620790204-15658-1-git-send-email-zou_wei@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/net/mdio/mdio-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index cad8205..bb9933f 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -141,6 +141,7 @@ static const struct of_device_id aspeed_mdio_of_match[] = {
 	{ .compatible = "aspeed,ast2600-mdio", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_mdio_of_match);
 
 static struct platform_driver aspeed_mdio_driver = {
 	.driver = {
-- 
2.6.2

