From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 31 May 2019 15:15:45 -0700
Subject: [PATCH v3 07/10] media: aspeed: refine interrupt handling logic
In-Reply-To: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
References: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190531221548.14757-8-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are cases that interrupt bits are cleared by a 500ms delayed
work which causes unnecessary irq calls. Also, the current
interrupt handler returns IRQ_HANDLED always but it should return
IRQ_NONE if there is any unhandled interrupt. So this commit
refines the interrupt handling logic to fix these issues.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
v2 -> v3:
 None.

v1 -> v2:
 None.

 drivers/media/platform/aspeed-video.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 1cba582918cc..c0b889141b8f 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -488,6 +488,7 @@ static void aspeed_video_off(struct aspeed_video *video)
 
 	/* Disable interrupts */
 	aspeed_video_write(video, VE_INTERRUPT_CTRL, 0);
+	aspeed_video_write(video, VE_INTERRUPT_STATUS, 0xffffffff);
 
 	/* Turn off the relevant clocks */
 	clk_disable(video->vclk);
@@ -554,7 +555,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 					    VE_INTERRUPT_MODE_DETECT, 0);
 			aspeed_video_write(video, VE_INTERRUPT_STATUS,
 					   VE_INTERRUPT_MODE_DETECT);
-
+			sts &= ~VE_INTERRUPT_MODE_DETECT;
 			set_bit(VIDEO_MODE_DETECT_DONE, &video->flags);
 			wake_up_interruptible_all(&video->wait);
 		} else {
@@ -599,12 +600,12 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 				    VE_INTERRUPT_COMP_COMPLETE, 0);
 		aspeed_video_write(video, VE_INTERRUPT_STATUS,
 				   VE_INTERRUPT_COMP_COMPLETE);
-
+		sts &= ~VE_INTERRUPT_COMP_COMPLETE;
 		if (test_bit(VIDEO_STREAMING, &video->flags) && buf)
 			aspeed_video_start_frame(video);
 	}
 
-	return IRQ_HANDLED;
+	return sts ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
-- 
2.21.0

