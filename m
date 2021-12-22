From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 22 Dec 2021 16:21:39 +0800
Subject: [PATCH v2 4/4] media: aspeed: Fix timing polarity incorrect
In-Reply-To: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
References: <20211222082139.26933-1-jammy_huang@aspeedtech.com>
Message-ID: <20211222082139.26933-5-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a workaround for sync polarity unstable.
Sync value get by VR09C counts from sync's rising edge, which means
sync's polarity is negative if sync value is bigger than total/2.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2:
  - Use 'total/2' rather than 'total<<1'
  - Update comment
---
 drivers/media/platform/aspeed-video.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 7c50567f5ab0..c3e3343d91e1 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -989,6 +989,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		video->frame_bottom = FIELD_GET(VE_SRC_TB_EDGE_DET_BOT, src_tb_edge);
 		video->frame_top = FIELD_GET(VE_SRC_TB_EDGE_DET_TOP, src_tb_edge);
+
+		/*
+		 * This is a workaround for polarity detection when the sync
+		 * value is larger than half.
+		 */
+		if (vsync > (vtotal / 2))
+			det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_VSYNC_POS_POL;
+
 		if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 			det->vbackporch = video->frame_top - vsync;
 			det->vfrontporch = vtotal - video->frame_bottom;
@@ -1003,6 +1013,16 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 
 		video->frame_right = FIELD_GET(VE_SRC_LR_EDGE_DET_RT, src_lr_edge);
 		video->frame_left = FIELD_GET(VE_SRC_LR_EDGE_DET_LEFT, src_lr_edge);
+
+		/*
+		 * This is a workaround for polarity detection when the sync
+		 * value is larger than half.
+		 */
+		if (hsync > (htotal / 2))
+			det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+		else
+			det->polarities |= V4L2_DV_HSYNC_POS_POL;
+
 		if (det->polarities & V4L2_DV_HSYNC_POS_POL) {
 			det->hbackporch = video->frame_left - hsync;
 			det->hfrontporch = htotal - video->frame_right;
-- 
2.25.1

