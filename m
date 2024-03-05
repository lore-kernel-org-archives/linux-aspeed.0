From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue,  5 Mar 2024 17:27:02 +0100
Subject: [PATCH 5/6] ipmi: kcs_bmc_aspeed: Convert to platform remove callback returning void
In-Reply-To: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
Message-ID: <d125e83788ddc27fc52a3f11b2c329b40cbdd6f9.1709655755.git.u.kleine-koenig@pengutronix.de>
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 72640da55380..227bf06c7ca4 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -641,7 +641,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_kcs_remove(struct platform_device *pdev)
+static void aspeed_kcs_remove(struct platform_device *pdev)
 {
 	struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
 	struct kcs_bmc_device *kcs_bmc = &priv->kcs_bmc;
@@ -656,8 +656,6 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 	priv->obe.remove = true;
 	spin_unlock_irq(&priv->obe.lock);
 	del_timer_sync(&priv->obe.timer);
-
-	return 0;
 }
 
 static const struct of_device_id ast_kcs_bmc_match[] = {
@@ -674,7 +672,7 @@ static struct platform_driver ast_kcs_bmc_driver = {
 		.of_match_table = ast_kcs_bmc_match,
 	},
 	.probe  = aspeed_kcs_probe,
-	.remove = aspeed_kcs_remove,
+	.remove_new = aspeed_kcs_remove,
 };
 module_platform_driver(ast_kcs_bmc_driver);
 
-- 
2.43.0

