From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 12 Jan 2022 14:07:25 +0800
Subject: [PATCH v2] media: aspeed: Fix no complete irq for non-64-aligned width
Message-ID: <20220112060725.13751-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In ast2500, engine will stop occasionally for 1360x768.

This is a bug which has been addressed, but the workaround is specific
for 1680 only. Here we make it more complete.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/media/platform/aspeed-video.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 4c75dc58a33c..4f5f5dd364ee 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1068,18 +1068,19 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
 
-	if (video->active_timings.width == 1680) {
+	if (!IS_ALIGNED(act->width, 64)) {
 		/*
-		 * This is a workaround to fix a silicon bug on A1 and A2
-		 * revisions. Since it doesn't break capturing operation of
+		 * This is a workaround to fix a AST2500 silicon bug on A1 and
+		 * A2 revisions. Since it doesn't break capturing operation of
 		 * other revisions, use it for all revisions without checking
-		 * the revision ID. It picked 1728 which is a very next
-		 * 64-pixels aligned value to 1680 to minimize memory bandwidth
+		 * the revision ID. It picked new width which is a very next
+		 * 64-pixels aligned value to minimize memory bandwidth
 		 * and to get better access speed from video engine.
 		 */
-		aspeed_video_write(video, VE_CAP_WINDOW,
-				   1728 << 16 | act->height);
-		size += (1728 - 1680) * video->active_timings.height;
+		u32 width = ALIGN(act->width, 64);
+
+		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
+		size = width * act->height;
 	} else {
 		aspeed_video_write(video, VE_CAP_WINDOW,
 				   act->width << 16 | act->height);
-- 
2.25.1

