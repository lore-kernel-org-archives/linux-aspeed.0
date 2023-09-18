From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Sep 2023 21:50:44 +0200
Subject: [PATCH net-next 01/19] net: mdio: aspeed: Convert to platform remove callback returning void
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230918195102.1302746-2-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/net/mdio/mdio-aspeed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index c727103c8b05..70edeeb7771e 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -177,15 +177,13 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_mdio_remove(struct platform_device *pdev)
+static void aspeed_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = (struct mii_bus *)platform_get_drvdata(pdev);
 	struct aspeed_mdio *ctx = bus->priv;
 
 	reset_control_assert(ctx->reset);
 	mdiobus_unregister(bus);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_mdio_of_match[] = {
@@ -200,7 +198,7 @@ static struct platform_driver aspeed_mdio_driver = {
 		.of_match_table = aspeed_mdio_of_match,
 	},
 	.probe = aspeed_mdio_probe,
-	.remove = aspeed_mdio_remove,
+	.remove_new = aspeed_mdio_remove,
 };
 
 module_platform_driver(aspeed_mdio_driver);
-- 
2.40.1

