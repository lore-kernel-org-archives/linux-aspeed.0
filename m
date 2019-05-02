From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu,  2 May 2019 12:13:16 -0700
Subject: [PATCH 6/7] media: aspeed: remove checking of
 VE_INTERRUPT_CAPTURE_COMPLETE
In-Reply-To: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190502191317.29698-7-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

VE_INTERRUPT_CAPTURE_COMPLETE and VE_INTERRUPT_COMP_COMPLETE are
not set at the same time but the current interrupt handling
mechanism of this driver doesn't clear the interrupt flag until
both two are set, and this behavior causes unnecessary interrupt
handler calls. In fact, this driver provides JPEG format only so
taking care of the VE_INTERRUPT_COMP_COMPLETE is enough for getting
compressed image frame so this commit gets rid of the
VE_INTERRUPT_CAPTURE_COMPLETE checking logic to simplify the logic.
Handling of VE_INTERRUPT_CAPTURE_COMPLETE could be added back later
when it's actually needed.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/media/platform/aspeed-video.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 6dc66d6e8b8b..8d0bb395e46d 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -463,8 +463,7 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
 	aspeed_video_write(video, VE_COMP_ADDR, addr);
 
 	aspeed_video_update(video, VE_INTERRUPT_CTRL, 0,
-			    VE_INTERRUPT_COMP_COMPLETE |
-			    VE_INTERRUPT_CAPTURE_COMPLETE);
+			    VE_INTERRUPT_COMP_COMPLETE);
 
 	aspeed_video_update(video, VE_SEQ_CTRL, 0,
 			    VE_SEQ_CTRL_TRIG_CAPTURE | VE_SEQ_CTRL_TRIG_COMP);
@@ -570,8 +569,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 		}
 	}
 
-	if ((sts & VE_INTERRUPT_COMP_COMPLETE) &&
-	    (sts & VE_INTERRUPT_CAPTURE_COMPLETE)) {
+	if (sts & VE_INTERRUPT_COMP_COMPLETE) {
 		struct aspeed_video_buffer *buf;
 		u32 frame_size = aspeed_video_read(video,
 						   VE_OFFSET_COMP_STREAM);
@@ -600,11 +598,9 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 				    VE_SEQ_CTRL_FORCE_IDLE |
 				    VE_SEQ_CTRL_TRIG_COMP, 0);
 		aspeed_video_update(video, VE_INTERRUPT_CTRL,
-				    VE_INTERRUPT_COMP_COMPLETE |
-				    VE_INTERRUPT_CAPTURE_COMPLETE, 0);
+				    VE_INTERRUPT_COMP_COMPLETE, 0);
 		aspeed_video_write(video, VE_INTERRUPT_STATUS,
-				   VE_INTERRUPT_COMP_COMPLETE |
-				   VE_INTERRUPT_CAPTURE_COMPLETE);
+				   VE_INTERRUPT_COMP_COMPLETE);
 
 		if (test_bit(VIDEO_STREAMING, &video->flags) && buf)
 			aspeed_video_start_frame(video);
-- 
2.21.0

