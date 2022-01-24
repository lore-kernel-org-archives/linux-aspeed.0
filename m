From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 24 Jan 2022 17:33:45 +0800
Subject: [PATCH v3 4/4] media: aspeed: Fix timing polarity incorrect
In-Reply-To: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
References: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
Message-ID: <20220124093345.3935-5-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is a workaround for polarity detection unstable.
Because h/v sync polarity got from VR098 could be wrong, we try to use
ast SoC's characteristic to confirm sync polarity.

In ast SoC's design, sync value got by VR09C counts from sync's rising
edge, which means sync value = bp + active + fp if negative polarity.
Thus, sync value would be larger than de if negative.

Ex. 1920x1200 at 60
  VR098: c4d3efff, VR09C: 04cc001f
  v-total = 0x4D3 (VR098[27:16]) = 1235
  v-sync  = 0x4CC (VR09C[27:16]) = 1228

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v3:
  - Use active rather than 'total/2' as critera for workaround
 v2:
  - Use 'total/2' rather than 'total<<1'
  - Update comment
---
 drivers/media/platform/aspeed-video.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 7e988cd05161..a135a31b4234 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -985,6 +985,20 @@ static void aspeed_video_get_timings(struct aspeed_video *v,
 	vsync = FIELD_GET(VE_SYNC_STATUS_VSYNC, sync);
 	hsync = FIELD_GET(VE_SYNC_STATUS_HSYNC, sync);
 
+	/*
+	 * This is a workaround for polarity detection.
+	 * Because ast-soc counts sync from sync's rising edge, the reg value
+	 * of sync would be larger than video's active area if negative.
+	 */
+	if (vsync > det->height)
+		det->polarities &= ~V4L2_DV_VSYNC_POS_POL;
+	else
+		det->polarities |= V4L2_DV_VSYNC_POS_POL;
+	if (hsync > det->width)
+		det->polarities &= ~V4L2_DV_HSYNC_POS_POL;
+	else
+		det->polarities |= V4L2_DV_HSYNC_POS_POL;
+
 	if (det->polarities & V4L2_DV_VSYNC_POS_POL) {
 		det->vbackporch = v->frame_top - vsync;
 		det->vfrontporch = vtotal - v->frame_bottom;
-- 
2.25.1

