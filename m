From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 20 Oct 2023 09:55:29 +0200
Subject: [PATCH 07/42] crypto: aspeed-hace - Convert to platform remove callback returning void
In-Reply-To: <20231020075521.2121571-44-u.kleine-koenig@pengutronix.de>
References: <20231020075521.2121571-44-u.kleine-koenig@pengutronix.de>
Message-ID: <20231020075521.2121571-51-u.kleine-koenig@pengutronix.de>
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
 drivers/crypto/aspeed/aspeed-hace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
index d9da04fb816e..062f2a66dd23 100644
--- a/drivers/crypto/aspeed/aspeed-hace.c
+++ b/drivers/crypto/aspeed/aspeed-hace.c
@@ -245,7 +245,7 @@ static int aspeed_hace_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int aspeed_hace_remove(struct platform_device *pdev)
+static void aspeed_hace_remove(struct platform_device *pdev)
 {
 	struct aspeed_hace_dev *hace_dev = platform_get_drvdata(pdev);
 	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
@@ -260,15 +260,13 @@ static int aspeed_hace_remove(struct platform_device *pdev)
 	tasklet_kill(&crypto_engine->done_task);
 
 	clk_disable_unprepare(hace_dev->clk);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, aspeed_hace_of_matches);
 
 static struct platform_driver aspeed_hace_driver = {
 	.probe		= aspeed_hace_probe,
-	.remove		= aspeed_hace_remove,
+	.remove_new	= aspeed_hace_remove,
 	.driver         = {
 		.name   = KBUILD_MODNAME,
 		.of_match_table = aspeed_hace_of_matches,
-- 
2.42.0

