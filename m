From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 13 Sep 2019 11:11:04 -0700
Subject: [PATCH -next v2 1/2] media: aspeed: refine hsync/vsync polarity
 setting logic
In-Reply-To: <20190913181105.11836-1-jae.hyun.yoo@linux.intel.com>
References: <20190913181105.11836-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190913181105.11836-2-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

To prevent inaccurate detections of resolution, this commit enables
clearing of hsync/vsync polarity bits based on probed sync state.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
Changes since v1:
 * Updated commit message.

 drivers/media/platform/aspeed-video.c | 43 +++++++++++++--------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb12f3793062..8f77079da55a 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -614,7 +614,7 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
 	int i;
 	int hsync_counter = 0;
 	int vsync_counter = 0;
-	u32 sts;
+	u32 sts, ctrl;
 
 	for (i = 0; i < NUM_POLARITY_CHECKS; ++i) {
 		sts = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
@@ -629,30 +629,29 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
 			hsync_counter++;
 	}
 
-	if (hsync_counter < 0 || vsync_counter < 0) {
-		u32 ctrl = 0;
+	ctrl = aspeed_video_read(video, VE_CTRL);
 
-		if (hsync_counter < 0) {
-			ctrl = VE_CTRL_HSYNC_POL;
-			video->detected_timings.polarities &=
-				~V4L2_DV_HSYNC_POS_POL;
-		} else {
-			video->detected_timings.polarities |=
-				V4L2_DV_HSYNC_POS_POL;
-		}
-
-		if (vsync_counter < 0) {
-			ctrl = VE_CTRL_VSYNC_POL;
-			video->detected_timings.polarities &=
-				~V4L2_DV_VSYNC_POS_POL;
-		} else {
-			video->detected_timings.polarities |=
-				V4L2_DV_VSYNC_POS_POL;
-		}
+	if (hsync_counter < 0) {
+		ctrl |= VE_CTRL_HSYNC_POL;
+		video->detected_timings.polarities &=
+			~V4L2_DV_HSYNC_POS_POL;
+	} else {
+		ctrl &= ~VE_CTRL_HSYNC_POL;
+		video->detected_timings.polarities |=
+			V4L2_DV_HSYNC_POS_POL;
+	}
 
-		if (ctrl)
-			aspeed_video_update(video, VE_CTRL, 0, ctrl);
+	if (vsync_counter < 0) {
+		ctrl |= VE_CTRL_VSYNC_POL;
+		video->detected_timings.polarities &=
+			~V4L2_DV_VSYNC_POS_POL;
+	} else {
+		ctrl &= ~VE_CTRL_VSYNC_POL;
+		video->detected_timings.polarities |=
+			V4L2_DV_VSYNC_POS_POL;
 	}
+
+	aspeed_video_write(video, VE_CTRL, ctrl);
 }
 
 static bool aspeed_video_alloc_buf(struct aspeed_video *video,
-- 
2.23.0

