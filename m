From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 9 Nov 2021 11:12:27 +0800
Subject: [PATCH v2] media: aspeed: Update signal status immediately to ensure
 sane hw state
Message-ID: <20211109031227.1792-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If res-chg, VE_INTERRUPT_MODE_DETECT_WD irq will be raised. But
v4l2_input_status won't be updated to no-signal immediately until
aspeed_video_get_resolution() in aspeed_video_resolution_work().

During the period of time, aspeed_video_start_frame() could be called
because it doesn't know signal becomes unstable now. If it goes with
aspeed_video_init_regs() of aspeed_video_irq_res_change()
simultaneously, it will mess up hw state.

To fix this problem, v4l2_input_status is updated to no-signal
immediately for VE_INTERRUPT_MODE_DETECT_WD irq.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2:
  - update subject and commit message
---
 drivers/media/platform/aspeed-video.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 1ade264a8b69..3facd7ecc1a1 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -762,6 +762,8 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
 	set_bit(VIDEO_RES_CHANGE, &video->flags);
 	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
 
+	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
+
 	aspeed_video_off(video);
 	aspeed_video_on(video);
 	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
@@ -1889,7 +1891,6 @@ static void aspeed_video_resolution_work(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct aspeed_video *video = container_of(dwork, struct aspeed_video,
 						  res_work);
-	u32 input_status = video->v4l2_input_status;
 
 	/* Exit early in case no clients remain */
 	if (test_bit(VIDEO_STOPPED, &video->flags))
@@ -1902,8 +1903,7 @@ static void aspeed_video_resolution_work(struct work_struct *work)
 	aspeed_video_get_resolution(video);
 
 	if (video->detected_timings.width != video->active_timings.width ||
-	    video->detected_timings.height != video->active_timings.height ||
-	    input_status != video->v4l2_input_status) {
+	    video->detected_timings.height != video->active_timings.height) {
 		static const struct v4l2_event ev = {
 			.type = V4L2_EVENT_SOURCE_CHANGE,
 			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
-- 
2.25.1

