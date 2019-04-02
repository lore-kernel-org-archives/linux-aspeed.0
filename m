From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  2 Apr 2019 18:25:00 +0000
Subject: [PATCH 1/5] media: platform: Aspeed: Remove use of reset line
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1554229504-5661-2-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The reset line is toggled by enabling the clocks, so it's not necessary
to manually toggle the reset as well.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 692e08e..55c55a6 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -14,7 +14,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -208,7 +207,6 @@ struct aspeed_video {
 	void __iomem *base;
 	struct clk *eclk;
 	struct clk *vclk;
-	struct reset_control *rst;
 
 	struct device *dev;
 	struct v4l2_ctrl_handler ctrl_handler;
@@ -483,19 +481,10 @@ static void aspeed_video_enable_mode_detect(struct aspeed_video *video)
 	aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_TRIG_MODE_DET);
 }
 
-static void aspeed_video_reset(struct aspeed_video *video)
-{
-	/* Reset the engine */
-	reset_control_assert(video->rst);
-
-	/* Don't usleep here; function may be called in interrupt context */
-	udelay(100);
-	reset_control_deassert(video->rst);
-}
-
 static void aspeed_video_off(struct aspeed_video *video)
 {
-	aspeed_video_reset(video);
+	/* Disable interrupts */
+	aspeed_video_write(video, VE_INTERRUPT_CTRL, 0);
 
 	/* Turn off the relevant clocks */
 	clk_disable_unprepare(video->vclk);
@@ -507,8 +496,6 @@ static void aspeed_video_on(struct aspeed_video *video)
 	/* Turn on the relevant clocks */
 	clk_prepare_enable(video->eclk);
 	clk_prepare_enable(video->vclk);
-
-	aspeed_video_reset(video);
 }
 
 static void aspeed_video_bufs_done(struct aspeed_video *video,
@@ -1464,7 +1451,9 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
 		 * Need to force stop any DMA and try and get HW into a good
 		 * state for future calls to start streaming again.
 		 */
-		aspeed_video_reset(video);
+		aspeed_video_off(video);
+		aspeed_video_on(video);
+
 		aspeed_video_init_regs(video);
 
 		aspeed_video_get_resolution(video);
@@ -1619,12 +1608,6 @@ static int aspeed_video_init(struct aspeed_video *video)
 		return PTR_ERR(video->vclk);
 	}
 
-	video->rst = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(video->rst)) {
-		dev_err(dev, "Unable to get VE reset\n");
-		return PTR_ERR(video->rst);
-	}
-
 	rc = of_reserved_mem_device_init(dev);
 	if (rc) {
 		dev_err(dev, "Unable to reserve memory\n");
-- 
1.8.3.1

