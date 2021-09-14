From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 14 Sep 2021 17:49:20 +0800
Subject: [PATCH resend] media: aspeed: refine to avoid full jpeg update
Message-ID: <20210914094919.3506-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The switch of jpeg 420/444 subsampling will update full jpeg header for
aspeed now.

Just update the 420/444 subsampling part of jpeg header is fine.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 resend the patch becuase cc-list isn't complete.

 drivers/media/platform/aspeed-video.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 3c90f3f3cf14..8b3939b8052d 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -401,6 +401,21 @@ static void aspeed_video_init_jpeg_table(u32 *table, bool yuv420)
 	}
 }
 
+// just update jpeg dct table per 420/444
+static void aspeed_video_update_jpeg_table(u32 *table, bool yuv420)
+{
+	int i;
+	unsigned int base;
+
+	for (i = 0; i < ASPEED_VIDEO_JPEG_NUM_QUALITIES; i++) {
+		base = 256 * i;	/* AST HW requires this header spacing */
+		base += ASPEED_VIDEO_JPEG_HEADER_SIZE +
+			ASPEED_VIDEO_JPEG_DCT_SIZE;
+
+		table[base + 2] = (yuv420) ? 0x00220103 : 0x00110103;
+	}
+}
+
 static void aspeed_video_update(struct aspeed_video *video, u32 reg, u32 clear,
 				u32 bits)
 {
@@ -1274,7 +1289,7 @@ static void aspeed_video_update_jpeg_quality(struct aspeed_video *video)
 static void aspeed_video_update_subsampling(struct aspeed_video *video)
 {
 	if (video->jpeg.virt)
-		aspeed_video_init_jpeg_table(video->jpeg.virt, video->yuv420);
+		aspeed_video_update_jpeg_table(video->jpeg.virt, video->yuv420);
 
 	if (video->yuv420)
 		aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_YUV420);
-- 
2.25.1

