From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu,  2 May 2019 12:13:12 -0700
Subject: [PATCH 2/7] media: aspeed: refine clock control logic
In-Reply-To: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190502191317.29698-3-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, this driver calls clk_prepare and clk_unprepare from
interrupt context too but these should be called from sleepable
context only. To fix this issue, this commit splits out
clk_enable/disable and clk_prepare/unprepare, and it places
clk_prepare/unprepare calls into the module probe/remove function.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 38 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 2dac6d20b180..8f4cac41da14 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -491,8 +491,8 @@ static void aspeed_video_off(struct aspeed_video *video)
 	aspeed_video_write(video, VE_INTERRUPT_CTRL, 0);
 
 	/* Turn off the relevant clocks */
-	clk_disable_unprepare(video->vclk);
-	clk_disable_unprepare(video->eclk);
+	clk_disable(video->vclk);
+	clk_disable(video->eclk);
 
 	clear_bit(VIDEO_CLOCKS_ON, &video->flags);
 }
@@ -503,8 +503,8 @@ static void aspeed_video_on(struct aspeed_video *video)
 		return;
 
 	/* Turn on the relevant clocks */
-	clk_prepare_enable(video->eclk);
-	clk_prepare_enable(video->vclk);
+	clk_enable(video->eclk);
+	clk_enable(video->vclk);
 
 	set_bit(VIDEO_CLOCKS_ON, &video->flags);
 }
@@ -1628,12 +1628,21 @@ static int aspeed_video_init(struct aspeed_video *video)
 		return PTR_ERR(video->eclk);
 	}
 
+	rc = clk_prepare(video->eclk);
+	if (rc)
+		return rc;
+
 	video->vclk = devm_clk_get(dev, "vclk");
 	if (IS_ERR(video->vclk)) {
 		dev_err(dev, "Unable to get VCLK\n");
-		return PTR_ERR(video->vclk);
+		rc = PTR_ERR(video->vclk);
+		goto err_unprepare_eclk;
 	}
 
+	rc = clk_prepare(video->vclk);
+	if (rc)
+		goto err_unprepare_eclk;
+
 	rc = of_reserved_mem_device_init(dev);
 	if (rc) {
 		dev_err(dev, "Unable to reserve memory\n");
@@ -1643,20 +1652,26 @@ static int aspeed_video_init(struct aspeed_video *video)
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "Failed to set DMA mask\n");
-		of_reserved_mem_device_release(dev);
-		return rc;
+		goto err_release_reserved_mem;
 	}
 
 	if (!aspeed_video_alloc_buf(video, &video->jpeg,
 				    VE_JPEG_HEADER_SIZE)) {
 		dev_err(dev, "Failed to allocate DMA for JPEG header\n");
-		of_reserved_mem_device_release(dev);
-		return rc;
+		goto err_release_reserved_mem;
 	}
 
 	aspeed_video_init_jpeg_table(video->jpeg.virt, video->yuv420);
 
 	return 0;
+
+err_release_reserved_mem:
+	of_reserved_mem_device_release(dev);
+	clk_unprepare(video->vclk);
+err_unprepare_eclk:
+	clk_unprepare(video->eclk);
+
+	return rc;
 }
 
 static int aspeed_video_probe(struct platform_device *pdev)
@@ -1700,6 +1715,11 @@ static int aspeed_video_remove(struct platform_device *pdev)
 	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev);
 	struct aspeed_video *video = to_aspeed_video(v4l2_dev);
 
+	aspeed_video_off(video);
+
+	clk_unprepare(video->vclk);
+	clk_unprepare(video->eclk);
+
 	video_unregister_device(&video->vdev);
 
 	vb2_queue_release(&video->queue);
-- 
2.21.0

