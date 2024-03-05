From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Tue,  5 Mar 2024 22:20:57 +0100
Subject: [PATCH 1/4] fsi: master-aspeed: Convert to platform remove callback returning void
In-Reply-To: <cover.1709673414.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709673414.git.u.kleine-koenig@pengutronix.de>
Message-ID: <de0f2d4cb529a433d4620ca0e8fda0dfb1e950db.1709673414.git.u.kleine-koenig@pengutronix.de>
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
 drivers/fsi/fsi-master-aspeed.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f0a19cd451a0..b0b624c3717b 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -646,14 +646,12 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int fsi_master_aspeed_remove(struct platform_device *pdev)
+static void fsi_master_aspeed_remove(struct platform_device *pdev)
 {
 	struct fsi_master_aspeed *aspeed = platform_get_drvdata(pdev);
 
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
-
-	return 0;
 }
 
 static const struct of_device_id fsi_master_aspeed_match[] = {
@@ -668,7 +666,7 @@ static struct platform_driver fsi_master_aspeed_driver = {
 		.of_match_table	= fsi_master_aspeed_match,
 	},
 	.probe	= fsi_master_aspeed_probe,
-	.remove = fsi_master_aspeed_remove,
+	.remove_new = fsi_master_aspeed_remove,
 };
 
 module_platform_driver(fsi_master_aspeed_driver);
-- 
2.43.0

