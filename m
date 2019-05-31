From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 31 May 2019 15:15:46 -0700
Subject: [PATCH v3 08/10] media: aspeed: remove source buffer allocation
 before mode detection
In-Reply-To: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
References: <20190531221548.14757-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190531221548.14757-9-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Mode detection doesn't require source buffer allocation so this
commit removes that.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
v2 -> v3:
 Corrected re-allocation logic of source buffers.

v1 -> v2:
 New.

 drivers/media/platform/aspeed-video.c | 37 ++++-----------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index c0b889141b8f..d6708ddb0391 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -731,27 +731,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	det->height = MIN_HEIGHT;
 	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
 
-	/*
-	 * Since we need max buffer size for detection, free the second source
-	 * buffer first.
-	 */
-	if (video->srcs[1].size)
-		aspeed_video_free_buf(video, &video->srcs[1]);
-
-	if (video->srcs[0].size < VE_MAX_SRC_BUFFER_SIZE) {
-		if (video->srcs[0].size)
-			aspeed_video_free_buf(video, &video->srcs[0]);
-
-		if (!aspeed_video_alloc_buf(video, &video->srcs[0],
-					    VE_MAX_SRC_BUFFER_SIZE)) {
-			dev_err(video->dev,
-				"Failed to allocate source buffers\n");
-			return;
-		}
-	}
-
-	aspeed_video_write(video, VE_SRC0_ADDR, video->srcs[0].dma);
-
 	do {
 		if (tries) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -871,20 +850,14 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 
 	size *= 4;
 
-	if (size == video->srcs[0].size / 2) {
-		aspeed_video_write(video, VE_SRC1_ADDR,
-				   video->srcs[0].dma + size);
-	} else if (size == video->srcs[0].size) {
-		if (!aspeed_video_alloc_buf(video, &video->srcs[1], size))
-			goto err_mem;
-
-		aspeed_video_write(video, VE_SRC1_ADDR, video->srcs[1].dma);
-	} else {
-		aspeed_video_free_buf(video, &video->srcs[0]);
+	if (size != video->srcs[0].size) {
+		if (video->srcs[0].size)
+			aspeed_video_free_buf(video, &video->srcs[0]);
+		if (video->srcs[1].size)
+			aspeed_video_free_buf(video, &video->srcs[1]);
 
 		if (!aspeed_video_alloc_buf(video, &video->srcs[0], size))
 			goto err_mem;
-
 		if (!aspeed_video_alloc_buf(video, &video->srcs[1], size))
 			goto err_mem;
 
-- 
2.21.0

