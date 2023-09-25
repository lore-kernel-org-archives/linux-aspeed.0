From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 25 Sep 2023 11:54:53 +0200
Subject: [PATCH 02/40] soc/aspeed: aspeed-lpc-snoop: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230925095532.1984344-3-u.kleine-koenig@pengutronix.de>
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
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 773dbcbc03a6..888b5840c015 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -331,7 +331,7 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
+static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
 {
 	struct aspeed_lpc_snoop *lpc_snoop = dev_get_drvdata(&pdev->dev);
 
@@ -340,8 +340,6 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	aspeed_lpc_disable_snoop(lpc_snoop, 1);
 
 	clk_disable_unprepare(lpc_snoop->clk);
-
-	return 0;
 }
 
 static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {
@@ -368,7 +366,7 @@ static struct platform_driver aspeed_lpc_snoop_driver = {
 		.of_match_table = aspeed_lpc_snoop_match,
 	},
 	.probe = aspeed_lpc_snoop_probe,
-	.remove = aspeed_lpc_snoop_remove,
+	.remove_new = aspeed_lpc_snoop_remove,
 };
 
 module_platform_driver(aspeed_lpc_snoop_driver);
-- 
2.40.1

