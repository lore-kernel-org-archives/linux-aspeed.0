From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu,  2 May 2019 12:13:15 -0700
Subject: [PATCH 5/7] media: aspeed: reduce noisy log printing outs
In-Reply-To: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190502191317.29698-6-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently, this driver prints out too much log messages when a
mode change happens, video turned off by screen saver and etc.
Actually, all cases are reported to user space properly. Also,
these are not critical errors but recoverable things, so this
commit changes the log level of some noisy printing outs.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index d88e8d238c49..6dc66d6e8b8b 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -441,7 +441,7 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
 
 	if (!(seq_ctrl & VE_SEQ_CTRL_COMP_BUSY) ||
 	    !(seq_ctrl & VE_SEQ_CTRL_CAP_BUSY)) {
-		dev_err(video->dev, "Engine busy; don't start frame\n");
+		dev_dbg(video->dev, "Engine busy; don't start frame\n");
 		return -EBUSY;
 	}
 
@@ -771,7 +771,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 						      res_check(video),
 						      MODE_DETECT_TIMEOUT);
 		if (!rc) {
-			dev_err(video->dev, "Timed out; first mode detect\n");
+			dev_dbg(video->dev, "Timed out; first mode detect\n");
 			clear_bit(VIDEO_RES_DETECT, &video->flags);
 			return;
 		}
@@ -789,7 +789,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 						      MODE_DETECT_TIMEOUT);
 		clear_bit(VIDEO_RES_DETECT, &video->flags);
 		if (!rc) {
-			dev_err(video->dev, "Timed out; second mode detect\n");
+			dev_dbg(video->dev, "Timed out; second mode detect\n");
 			return;
 		}
 
@@ -823,7 +823,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	} while (invalid_resolution && (tries++ < INVALID_RESOLUTION_RETRIES));
 
 	if (invalid_resolution) {
-		dev_err(video->dev, "Invalid resolution detected\n");
+		dev_dbg(video->dev, "Invalid resolution detected\n");
 		return;
 	}
 
@@ -1471,7 +1471,7 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
 				!test_bit(VIDEO_FRAME_INPRG, &video->flags),
 				STOP_TIMEOUT);
 	if (!rc) {
-		dev_err(video->dev, "Timed out when stopping streaming\n");
+		dev_dbg(video->dev, "Timed out when stopping streaming\n");
 
 		/*
 		 * Need to force stop any DMA and try and get HW into a good
-- 
2.21.0

