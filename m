From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 3 Nov 2021 16:23:54 +0800
Subject: [Resend PATCH v3] media: aspeed: fix mode-detect always time out at
 2nd run
Message-ID: <20211103082354.408-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

aspeed_video_get_resolution() will try to do res-detect again if the
timing got in last try is invalid. But it will always time out because
VE_SEQ_CTRL_TRIG_MODE_DET is only cleared after 1st mode-detect.

To fix the problem, just clear VE_SEQ_CTRL_TRIG_MODE_DET before setting
it in aspeed_video_enable_mode_detect().

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
v3:
  - add tag
v2:
  - update commit message
---
 drivers/media/platform/aspeed-video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 5ffbabf884eb..fea5e4d0927e 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -518,6 +518,10 @@ static void aspeed_video_enable_mode_detect(struct aspeed_video *video)
 	aspeed_video_update(video, VE_INTERRUPT_CTRL, 0,
 			    VE_INTERRUPT_MODE_DETECT);
 
+	/* Disable mode detect in order to re-trigger */
+	aspeed_video_update(video, VE_SEQ_CTRL,
+			    VE_SEQ_CTRL_TRIG_MODE_DET, 0);
+
 	/* Trigger mode detect */
 	aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_TRIG_MODE_DET);
 }
@@ -809,10 +813,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 			return;
 		}
 
-		/* Disable mode detect in order to re-trigger */
-		aspeed_video_update(video, VE_SEQ_CTRL,
-				    VE_SEQ_CTRL_TRIG_MODE_DET, 0);
-
 		aspeed_video_check_and_set_polarity(video);
 
 		aspeed_video_enable_mode_detect(video);
-- 
2.25.1

