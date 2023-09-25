From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 25 Sep 2023 11:54:54 +0200
Subject: [PATCH 03/40] soc/aspeed: aspeed-p2a-ctrl: Convert to platform remove callback returning void
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230925095532.1984344-4-u.kleine-koenig@pengutronix.de>
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
 drivers/soc/aspeed/aspeed-p2a-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-p2a-ctrl.c b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
index 548f44da28a9..8610ddacc7bc 100644
--- a/drivers/soc/aspeed/aspeed-p2a-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
@@ -383,13 +383,11 @@ static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int aspeed_p2a_ctrl_remove(struct platform_device *pdev)
+static void aspeed_p2a_ctrl_remove(struct platform_device *pdev)
 {
 	struct aspeed_p2a_ctrl *p2a_ctrl = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&p2a_ctrl->miscdev);
-
-	return 0;
 }
 
 #define SCU2C_DRAM	BIT(25)
@@ -433,7 +431,7 @@ static struct platform_driver aspeed_p2a_ctrl_driver = {
 		.of_match_table = aspeed_p2a_ctrl_match,
 	},
 	.probe = aspeed_p2a_ctrl_probe,
-	.remove = aspeed_p2a_ctrl_remove,
+	.remove_new = aspeed_p2a_ctrl_remove,
 };
 
 module_platform_driver(aspeed_p2a_ctrl_driver);
-- 
2.40.1

