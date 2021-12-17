From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 17 Dec 2021 17:54:03 +0800
Subject: [PATCH 4/4] media: aspeed: Fix timing polarity incorrect
In-Reply-To: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
References: <20211217095403.2618-1-jammy_huang@aspeedtech.com>
Message-ID: <20211217095403.2618-5-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a workaround for polarity unstable.
Sync value get by VR09C counts from sync's rising edge, which means
sync's polarity is negative if sync value is bigger than total/2.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 5ad3a20c5bac..f628f69bb7dd 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -989,6 +989,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP,
 					     src_tb_edge);
 		det->vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
+		/*
+		 * Workaround for polarity detection
+		 * Use sync(VR098) counts from sync's rising edge till falling
+		 * edge to tell sync polarity.
+		 */
+		if (det->vsync > (FIELD_GET(VE_MODE_DETECT_V_LINES, mds) >> 1))
+			det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_VSYNC_POS_POL;
 		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 			det->vbackporch = video->frame_top - det->vsync;
 			det->vfrontporch =
@@ -1010,6 +1019,15 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT,
 					      src_lr_edge);
 		det->hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
+		/*
+		 * Workaround for polarity detection
+		 * Use sync(VR098) counts from sync's rising edge till falling
+		 * edge to tell sync polarity.
+		 */
+		if (det->hsync > (htotal >> 1))
+			det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_HSYNC_POS_POL;
 		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
 			det->hbackporch = video->frame_left - det->hsync;
 			det->hfrontporch = htotal - video->frame_right;
-- 
2.25.1

