From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 14 Dec 2020 20:45:41 -0600
Subject: [PATCH 2/3] aspeed-video: clear spurious interrupt bits
 unconditionally
In-Reply-To: <20201215024542.18888-1-zev@bewilderbeest.net>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
Message-ID: <20201215024542.18888-3-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Instead of testing and conditionally clearing them one by one, we can
instead just unconditionally clear them all at once.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/media/platform/aspeed-video.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb02043532e3..218aae3be809 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -558,6 +558,14 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
 	schedule_delayed_work(&video->res_work, delay);
 }
 
+/*
+ * Interrupts that we don't use but have to explicitly ignore because the
+ * hardware asserts them even when they're disabled in the VE_INTERRUPT_CTRL
+ * register.
+ */
+#define VE_SPURIOUS_IRQS \
+	(VE_INTERRUPT_CAPTURE_COMPLETE | VE_INTERRUPT_FRAME_COMPLETE)
+
 static irqreturn_t aspeed_video_irq(int irq, void *arg)
 {
 	struct aspeed_video *video = arg;
@@ -630,15 +638,8 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 			aspeed_video_start_frame(video);
 	}
 
-	/*
-	 * CAPTURE_COMPLETE and FRAME_COMPLETE interrupts come even when these
-	 * are disabled in the VE_INTERRUPT_CTRL register so clear them to
-	 * prevent unnecessary interrupt calls.
-	 */
-	if (sts & VE_INTERRUPT_CAPTURE_COMPLETE)
-		sts &= ~VE_INTERRUPT_CAPTURE_COMPLETE;
-	if (sts & VE_INTERRUPT_FRAME_COMPLETE)
-		sts &= ~VE_INTERRUPT_FRAME_COMPLETE;
+	/* Squash known bogus interrupts */
+	sts &= ~VE_SPURIOUS_IRQS;
 
 	if (sts)
 		dev_err_ratelimited(video->dev, "unexpected interrupt asserted:"
-- 
2.29.2

