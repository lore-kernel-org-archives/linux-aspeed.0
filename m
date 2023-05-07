From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sun,  7 May 2023 18:25:28 +0200
Subject: [PATCH 05/53] drm/aspeed: Convert to platform remove callback returning void
In-Reply-To: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230507162616.1368908-6-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index ecfb060d2557..d0089e7fbfae 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -351,20 +351,18 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int aspeed_gfx_remove(struct platform_device *pdev)
+static void aspeed_gfx_remove(struct platform_device *pdev)
 {
 	struct drm_device *drm = platform_get_drvdata(pdev);
 
 	sysfs_remove_group(&pdev->dev.kobj, &aspeed_sysfs_attr_group);
 	drm_dev_unregister(drm);
 	aspeed_gfx_unload(drm);
-
-	return 0;
 }
 
 static struct platform_driver aspeed_gfx_platform_driver = {
 	.probe		= aspeed_gfx_probe,
-	.remove		= aspeed_gfx_remove,
+	.remove_new	= aspeed_gfx_remove,
 	.driver = {
 		.name = "aspeed_gfx",
 		.of_match_table = aspeed_gfx_match,
-- 
2.39.2

