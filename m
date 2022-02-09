From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 9 Feb 2022 10:43:12 +0800
Subject: [PATCH v1] media: aspeed: Fix incorrect color
Message-ID: <20220209024312.2218-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Current settings for rgb-2-yuv is BT.601(studio swing), but JFIF
uses BT.601(full swing).

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb9c17ac0e14..08b63b8297f0 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1089,7 +1089,7 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
 	u32 comp_ctrl = VE_COMP_CTRL_RSVD |
 		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
 		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
-	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR;
+	u32 ctrl = VE_CTRL_AUTO_OR_CURSOR | VE_CTRL_YUV;
 	u32 seq_ctrl = video->jpeg_mode;
 
 	if (video->frame_rate)
-- 
2.25.1

