From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Jan 2020 14:13:23 +1030
Subject: [PATCH 2/3] media: aspeed: Use runtime configuration
In-Reply-To: <20200107034324.38073-1-joel@jms.id.au>
References: <20200107034324.38073-1-joel@jms.id.au>
Message-ID: <20200107034324.38073-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed video IP has some differences between SoC families. Currently
the driver decides which registers to use at compile time, which means
a single kernel can not be used between platforms.

Switch to using runtime configuration of the registers that vary between
SoC families. This is in preparation for upcoming ast2600 support.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/media/platform/aspeed-video.c | 53 ++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 8f849d9866af..d70b893fd4cf 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -72,11 +72,8 @@
 #define  VE_SEQ_CTRL_CAP_BUSY		BIT(16)
 #define  VE_SEQ_CTRL_COMP_BUSY		BIT(18)
 
-#ifdef CONFIG_MACH_ASPEED_G5
-#define  VE_SEQ_CTRL_JPEG_MODE		BIT(13)	/* AST2500 */
-#else
-#define  VE_SEQ_CTRL_JPEG_MODE		BIT(8)	/* AST2400 */
-#endif /* CONFIG_MACH_ASPEED_G5 */
+#define AST2500_VE_SEQ_CTRL_JPEG_MODE	BIT(13)
+#define AST2400_VE_SEQ_CTRL_JPEG_MODE	BIT(8)
 
 #define VE_CTRL				0x008
 #define  VE_CTRL_HSYNC_POL		BIT(0)
@@ -220,6 +217,9 @@ struct aspeed_video {
 	struct video_device vdev;
 	struct mutex video_lock;	/* v4l2 and videobuf2 lock */
 
+	u32 jpeg_mode;
+	u32 comp_size_read;
+
 	wait_queue_head_t wait;
 	spinlock_t lock;		/* buffer list lock */
 	struct delayed_work res_work;
@@ -243,6 +243,21 @@ struct aspeed_video {
 
 #define to_aspeed_video(x) container_of((x), struct aspeed_video, v4l2_dev)
 
+struct aspeed_video_config {
+	u32 jpeg_mode;
+	u32 comp_size_read;
+};
+
+static const struct aspeed_video_config ast2400_config = {
+	.jpeg_mode = AST2400_VE_SEQ_CTRL_JPEG_MODE,
+	.comp_size_read = VE_OFFSET_COMP_STREAM,
+};
+
+static const struct aspeed_video_config ast2500_config = {
+	.jpeg_mode = AST2500_VE_SEQ_CTRL_JPEG_MODE,
+	.comp_size_read = VE_OFFSET_COMP_STREAM,
+};
+
 static const u32 aspeed_video_jpeg_header[ASPEED_VIDEO_JPEG_HEADER_SIZE] = {
 	0xe0ffd8ff, 0x464a1000, 0x01004649, 0x60000101, 0x00006000, 0x0f00feff,
 	0x00002d05, 0x00000000, 0x00000000, 0x00dbff00
@@ -572,7 +587,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
 	if (sts & VE_INTERRUPT_COMP_COMPLETE) {
 		struct aspeed_video_buffer *buf;
 		u32 frame_size = aspeed_video_read(video,
-						   VE_OFFSET_COMP_STREAM);
+						   video->comp_size_read);
 
 		spin_lock(&video->lock);
 		clear_bit(VIDEO_FRAME_INPRG, &video->flags);
@@ -907,7 +922,7 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
 		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
 		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
 	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
-	u32 seq_ctrl = VE_SEQ_CTRL_JPEG_MODE;
+	u32 seq_ctrl = video->jpeg_mode;;
 
 	if (video->frame_rate)
 		ctrl |= FIELD_PREP(VE_CTRL_FRC, video->frame_rate);
@@ -1653,8 +1668,17 @@ static int aspeed_video_init(struct aspeed_video *video)
 	return rc;
 }
 
+static const struct of_device_id aspeed_video_of_match[] = {
+	{ .compatible = "aspeed,ast2400-video-engine", .data = &ast2400_config },
+	{ .compatible = "aspeed,ast2500-video-engine", .data = &ast2500_config },
+	{}
+};
+MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
+
 static int aspeed_video_probe(struct platform_device *pdev)
 {
+	const struct aspeed_video_config *config;
+	const struct of_device_id *match;
 	struct aspeed_video *video;
 	int rc;
 
@@ -1666,6 +1690,14 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	if (IS_ERR(video->base))
 		return PTR_ERR(video->base);
 
+	match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
+	if (!match)
+		return -EINVAL;
+
+	config = match->data;
+	video->jpeg_mode = config->jpeg_mode;
+	video->comp_size_read = config->comp_size_read;
+
 	video->frame_rate = 30;
 	video->dev = &pdev->dev;
 	spin_lock_init(&video->lock);
@@ -1712,13 +1744,6 @@ static int aspeed_video_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id aspeed_video_of_match[] = {
-	{ .compatible = "aspeed,ast2400-video-engine" },
-	{ .compatible = "aspeed,ast2500-video-engine" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
-
 static struct platform_driver aspeed_video_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-- 
2.24.1

