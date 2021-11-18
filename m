From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 18 Nov 2021 15:40:30 +0800
Subject: [PATCH v5 09/10] media: aspeed: add comments and macro
In-Reply-To: <20211118074030.685-1-jammy_huang@aspeedtech.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
Message-ID: <20211118074030.685-10-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add comments to describe video-stat and 'struct aspeed_video'.
Add macro, ASPEED_VIDEO_V4L2_MIN_BUF_REQ, to describe the buffers
needed.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v5:
  - no update
v4:
  - update comments
v3:
  - no update
v2:
  - no update
---
 drivers/media/platform/aspeed-video.c | 39 ++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 419825ed7737..03bb6c46f2a1 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -33,6 +33,8 @@
 #include <linux/videodev2.h>
 #include <uapi/linux/aspeed-video.h>
 
+#define ASPEED_VIDEO_V4L2_MIN_BUF_REQ 3
+
 #define DEVICE_NAME			"aspeed-video"
 
 #define ASPEED_VIDEO_JPEG_NUM_QUALITIES	12
@@ -193,6 +195,15 @@
 #define VE_MEM_RESTRICT_START		0x310
 #define VE_MEM_RESTRICT_END		0x314
 
+/*
+ * @VIDEO_MODE_DETECT_DONE:	a flag raised if signal lock
+ * @VIDEO_RES_CHANGE:		a flag raised if res_change work on-going
+ * @VIDEO_RES_DETECT:		a flag raised if res. detection on-going
+ * @VIDEO_STREAMING:		a flag raised if user requires stream-on
+ * @VIDEO_FRAME_INPRG:		a flag raised if hw working on a frame
+ * @VIDEO_STOPPED:		a flag raised if device release
+ * @VIDEO_CLOCKS_ON:		a flag raised if clk is on
+ */
 enum {
 	VIDEO_MODE_DETECT_DONE,
 	VIDEO_RES_CHANGE,
@@ -231,6 +242,28 @@ struct aspeed_video_perf {
 #define to_aspeed_video_buffer(x) \
 	container_of((x), struct aspeed_video_buffer, vb)
 
+/**
+ * struct aspeed_video - driver data
+ *
+ * @flags:		holds the state of video
+ * @sequence:		holds the last number of frame completed
+ * @max_compressed_size:holds max compressed stream's size
+ * @srcs:		holds the buffer information for srcs
+ * @jpeg:		holds the buffer information for jpeg header
+ * @bcd:		holds the buffer information for bcd work
+ * @yuv420:		a flag raised if JPEG subsampling is 420
+ * @format:		holds the video format
+ * @hq_mode:		a flag raised if HQ is enabled. Only for VIDEO_FMT_ASPEED
+ * @frame_rate:		holds the frame_rate
+ * @jpeg_quality:	holds jpeq's quality (0~11)
+ * @jpeg_hq_quality:	holds hq's quality (0~11) only if hq_mode enabled
+ * @compression_mode:	holds jpeg compression mode
+ * @frame_bottom:	end position of video data in vertical direction
+ * @frame_left:		start position of video data in horizontal direction
+ * @frame_right:	end position of video data in horizontal direction
+ * @frame_top:		start position of video data in vertical direction
+ * @perf:		holds the statistics primary for debugfs
+ */
 struct aspeed_video {
 	void __iomem *base;
 	struct clk *eclk;
@@ -1305,7 +1338,7 @@ static int aspeed_video_get_parm(struct file *file, void *fh,
 	struct aspeed_video *video = video_drvdata(file);
 
 	a->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
-	a->parm.capture.readbuffers = 3;
+	a->parm.capture.readbuffers = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
 	a->parm.capture.timeperframe.numerator = 1;
 	if (!video->frame_rate)
 		a->parm.capture.timeperframe.denominator = MAX_FRAME_RATE;
@@ -1322,7 +1355,7 @@ static int aspeed_video_set_parm(struct file *file, void *fh,
 	struct aspeed_video *video = video_drvdata(file);
 
 	a->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
-	a->parm.capture.readbuffers = 3;
+	a->parm.capture.readbuffers = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
 
 	if (a->parm.capture.timeperframe.numerator)
 		frame_rate = a->parm.capture.timeperframe.denominator /
@@ -1906,7 +1939,7 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
 	vbq->drv_priv = video;
 	vbq->buf_struct_size = sizeof(struct aspeed_video_buffer);
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vbq->min_buffers_needed = 3;
+	vbq->min_buffers_needed = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
 
 	rc = vb2_queue_init(vbq);
 	if (rc) {
-- 
2.25.1

