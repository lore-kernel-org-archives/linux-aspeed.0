From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 24 Jan 2022 17:33:44 +0800
Subject: [PATCH v3 3/4] media: aspeed: Correct values for detected timing
In-Reply-To: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
References: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
Message-ID: <20220124093345.3935-4-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correct timing's fp/sync/bp value based on the information below.
It should be noticed that the calculation formula should be changed
per sync polarity.

The sequence of signal: sync - backporch - video data - frontporch

The following registers start counting from sync's rising edge:
1. VR090: frame edge's left and right
2. VR094: frame edge's top and bottom
3. VR09C: counting from sync's rising edge to falling edge

[Vertical timing]
            +--+     +-------------------+     +--+
            |  |     |     v i d e o     |     |  |
         +--+  +-----+                   +-----+  +---+
       vsync+--+
   frame_top+--------+
frame_bottom+----------------------------+

                  +-------------------+
                  |     v i d e o     |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       vsync+-------------------------------+
   frame_top+-----+
frame_bottom+-------------------------+

[Horizontal timing]
            +--+     +-------------------+     +--+
            |  |     |     v i d e o     |     |  |
         +--+  +-----+                   +-----+  +---+
       hsync+--+
  frame_left+--------+
 frame_right+----------------------------+

                  +-------------------+
                  |     v i d e o     |
      +--+  +-----+                   +-----+  +---+
         |  |                               |  |
         +--+                               +--+
       hsync+-------------------------------+
  frame_left+-----+
 frame_right+-------------------------+

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v3:
  - Add API, aspeed_video_get_timings(), to handle the calculation of timings.
 v2:
  - Code refined per Joel's suggestion
  - Update commit message to have name matching variable
---
 drivers/media/platform/aspeed-video.c | 30 ++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index c241038ee27c..7e988cd05161 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -925,6 +925,87 @@ static void aspeed_video_calc_compressed_size(struct aspeed_video *video,
 		 video->max_compressed_size);
 }
 
+/*
+ * Update v4l2_bt_timings per current status.
+ * frame_top/frame_bottom/frame_left/frame_right need to be ready.
+ *
+ * The following registers start counting from sync's rising edge:
+ * 1. VR090: frame edge's left and right
+ * 2. VR094: frame edge's top and bottom
+ * 3. VR09C: counting from sync's rising edge to falling edge
+ *
+ * [Vertical timing]
+ *             +--+     +-------------------+     +--+
+ *             |  |     |     v i d e o     |     |  |
+ *          +--+  +-----+                   +-----+  +---+
+ *        vsync+--+
+ *    frame_top+--------+
+ * frame_bottom+----------------------------+
+ *
+ *                   +-------------------+
+ *                   |     v i d e o     |
+ *       +--+  +-----+                   +-----+  +---+
+ *          |  |                               |  |
+ *          +--+                               +--+
+ *        vsync+-------------------------------+
+ *    frame_top+-----+
+ * frame_bottom+-------------------------+
+ *
+ * [Horizontal timing]
+ *             +--+     +-------------------+     +--+
+ *             |  |     |     v i d e o     |     |  |
+ *          +--+  +-----+                   +-----+  +---+
+ *        hsync+--+
+ *   frame_left+--------+
+ *  frame_right+----------------------------+
+ *
+ *                   +-------------------+
+ *                   |     v i d e o     |
+ *       +--+  +-----+                   +-----+  +---+
+ *          |  |                               |  |
+ *          +--+                               +--+
+ *        hsync+-------------------------------+
+ *   frame_left+-----+
+ *  frame_right+-------------------------+
+ *
+ * @v: the struct of aspeed_video
+ * @det: v4l2_bt_timings to be updated.
+ */
+static void aspeed_video_get_timings(struct aspeed_video *v,
+				     struct v4l2_bt_timings *det)
+{
+	u32 mds, sync, htotal, vtotal, vsync, hsync;
+
+	mds = aspeed_video_read(v, VE_MODE_DETECT_STATUS);
+	sync = aspeed_video_read(v, VE_SYNC_STATUS);
+	htotal = aspeed_video_read(v, VE_H_TOTAL_PIXELS);
+	vtotal = FIELD_GET(VE_MODE_DETECT_V_LINES, mds);
+	vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+	hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+
+	if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
+		det->vbackporch = v->frame_top - vsync;
+		det->vfrontporch = vtotal - v->frame_bottom;
+		det->vsync = vsync;
+	} else {
+		det->vbackporch = v->frame_top;
+		det->vfrontporch = vsync - v->frame_bottom;
+		det->vsync = vtotal - vsync;
+	}
+
+	if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
+		det->hbackporch = v->frame_left - hsync;
+		det->hfrontporch = htotal - v->frame_right;
+		det->hsync = hsync;
+	} else {
+		det->hbackporch = v->frame_left;
+		det->hfrontporch = hsync - v->frame_right;
+		det->hsync = htotal - hsync;
+	}
+}
+
 #define res_check(v) test_and_clear_bit(VIDEO_MODE_DETECT_DONE, &(v)->flags)
 
 static void aspeed_video_get_resolution(struct aspeed_video *video)
@@ -935,8 +1016,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	u32 mds;
 	u32 src_lr_edge;
 	u32 src_tb_edge;
-	u32 sync;
-	u32 htotal;
 	struct v4l2_bt_timings *det = &video->detected_timings;
 
 	det->width = MIN_WIDTH;
@@ -980,24 +1059,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		src_lr_edge = aspeed_video_read(video, VE_SRC_LR_EDGE_DET);
 		src_tb_edge = aspeed_video_read(video, VE_SRC_TB_EDGE_DET);
-		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
-		sync = aspeed_video_read(video, VE_SYNC_STATUS);
-		htotal = aspeed_video_read(video, VE_H_TOTAL_PIXELS);
 
 		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
-		det->vfrontporch = video->frame_top;
-		det->vbackporch = FIELD_GET(VE_MODE_DETECT_V_LINES, mds) -
-			video->frame_bottom;
-		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+
 		if (video->frame_top > video->frame_bottom)
 			continue;
 
 		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
-		det->hfrontporch = video->frame_left;
-		det->hbackporch = htotal - video->frame_right;
-		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+
 		if (video->frame_left > video->frame_right)
 			continue;
 
@@ -1013,6 +1084,8 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	det->width = (video->frame_right - video->frame_left) + 1;
 	video->v4l2_input_status = 0;
 
+	aspeed_video_get_timings(video, det);
+
 	/*
 	 * Enable mode-detect watchdog, resolution-change watchdog and
 	 * automatic compression after frame capture.
-- 
2.25.1

