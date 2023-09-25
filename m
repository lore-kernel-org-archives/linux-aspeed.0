From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 25 Sep 2023 11:54:55 +0200
Subject: [PATCH 04/40] soc/aspeed: aspeed-uart-routing: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230925095532.1984344-5-u.kleine-koenig@pengutronix.de>
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
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index 3a4c1f28cb34..a2195f062e01 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -565,14 +565,12 @@ static int aspeed_uart_routing_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_uart_routing_remove(struct platform_device *pdev)
+static void aspeed_uart_routing_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct aspeed_uart_routing *uart_routing = platform_get_drvdata(pdev);
 
 	sysfs_remove_group(&dev->kobj, uart_routing->attr_grp);
-
-	return 0;
 }
 
 static const struct of_device_id aspeed_uart_routing_table[] = {
@@ -591,7 +589,7 @@ static struct platform_driver aspeed_uart_routing_driver = {
 		.of_match_table = aspeed_uart_routing_table,
 	},
 	.probe = aspeed_uart_routing_probe,
-	.remove = aspeed_uart_routing_remove,
+	.remove_new = aspeed_uart_routing_remove,
 };
 
 module_platform_driver(aspeed_uart_routing_driver);
-- 
2.40.1

