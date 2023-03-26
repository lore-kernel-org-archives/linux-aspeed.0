From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sun, 26 Mar 2023 16:30:44 +0200
Subject: [PATCH 017/117] media: aspeed-video: Convert to platform remove callback returning void
In-Reply-To: <20230326143224.572654-1-u.kleine-koenig@pengutronix.de>
References: <20230326143224.572654-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230326143224.572654-20-u.kleine-koenig@pengutronix.de>
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
 drivers/media/platform/aspeed/aspeed-video.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 794d4dc3a654..374eb7781936 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2206,7 +2206,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aspeed_video_remove(struct platform_device *pdev)
+static void aspeed_video_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev);
@@ -2228,8 +2228,6 @@ static int aspeed_video_remove(struct platform_device *pdev)
 	aspeed_video_free_buf(video, &video->jpeg);
 
 	of_reserved_mem_device_release(dev);
-
-	return 0;
 }
 
 static struct platform_driver aspeed_video_driver = {
@@ -2238,7 +2236,7 @@ static struct platform_driver aspeed_video_driver = {
 		.of_match_table = aspeed_video_of_match,
 	},
 	.probe = aspeed_video_probe,
-	.remove = aspeed_video_remove,
+	.remove_new = aspeed_video_remove,
 };
 
 module_platform_driver(aspeed_video_driver);
-- 
2.39.2

