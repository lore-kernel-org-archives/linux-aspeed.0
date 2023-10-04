From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed,  4 Oct 2023 15:12:36 +0200
Subject: [PATCH 03/21] EDAC/aspeed: Convert to platform remove callback returning void
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20231004131254.2673842-4-u.kleine-koenig@pengutronix.de>
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
 drivers/edac/aspeed_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 6bd5f8815919..157a480eb761 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -357,7 +357,7 @@ static int aspeed_probe(struct platform_device *pdev)
 }
 
 
-static int aspeed_remove(struct platform_device *pdev)
+static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
 
@@ -369,8 +369,6 @@ static int aspeed_remove(struct platform_device *pdev)
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (mci)
 		edac_mc_free(mci);
-
-	return 0;
 }
 
 
@@ -389,7 +387,7 @@ static struct platform_driver aspeed_driver = {
 		.of_match_table = aspeed_of_match
 	},
 	.probe		= aspeed_probe,
-	.remove		= aspeed_remove
+	.remove_new	= aspeed_remove
 };
 module_platform_driver(aspeed_driver);
 
-- 
2.40.1

