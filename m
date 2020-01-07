From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Jan 2020 14:13:22 +1030
Subject: [PATCH 1/3] media: aspeed: Rework memory mapping in probe
In-Reply-To: <20200107034324.38073-1-joel@jms.id.au>
References: <20200107034324.38073-1-joel@jms.id.au>
Message-ID: <20200107034324.38073-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the recently introduced function devm_platform_ioremap_resource to
save a few lines of code. This makes the driver match common platform
device probe patterns.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/media/platform/aspeed-video.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index d8593cb2ae84..8f849d9866af 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1655,14 +1655,17 @@ static int aspeed_video_init(struct aspeed_video *video)
 
 static int aspeed_video_probe(struct platform_device *pdev)
 {
+	struct aspeed_video *video;
 	int rc;
-	struct resource *res;
-	struct aspeed_video *video =
-		devm_kzalloc(&pdev->dev, sizeof(*video), GFP_KERNEL);
 
+	video = devm_kzalloc(&pdev->dev, sizeof(*video), GFP_KERNEL);
 	if (!video)
 		return -ENOMEM;
 
+	video->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(video->base))
+		return PTR_ERR(video->base);
+
 	video->frame_rate = 30;
 	video->dev = &pdev->dev;
 	spin_lock_init(&video->lock);
@@ -1671,13 +1674,6 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&video->res_work, aspeed_video_resolution_work);
 	INIT_LIST_HEAD(&video->buffers);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	video->base = devm_ioremap_resource(video->dev, res);
-
-	if (IS_ERR(video->base))
-		return PTR_ERR(video->base);
-
 	rc = aspeed_video_init(video);
 	if (rc)
 		return rc;
-- 
2.24.1

