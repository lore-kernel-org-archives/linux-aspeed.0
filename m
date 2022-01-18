From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 18 Jan 2022 16:44:48 +0800
Subject: [PATCH v3 1/2] media: aspeed: Add macro for the fields of the
 mode-detect registers
In-Reply-To: <20220118084449.5182-1-jammy_huang@aspeedtech.com>
References: <20220118084449.5182-1-jammy_huang@aspeedtech.com>
Message-ID: <20220118084449.5182-2-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

VE_MODE_DT_HOR_TOLER: the tolerance in detecting for stable horizontal
signal.
VE_MODE_DT_VER_TOLER: the tolerance in detecting for stable vertical
signal.
VE_MODE_DT_HOR_STABLE: the minimum required count in detecting stable
HSYNC signal to set mode detection horizontal signal stable.
VE_MODE_DT_VER_STABLE: the minimum required count in detecting stable
VSYNC signal to set mode detection vertical signal stable.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 4f5f5dd364ee..5ba4d70c8dab 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -190,6 +190,12 @@
 #define  VE_INTERRUPT_VSYNC_DESC	BIT(11)
 
 #define VE_MODE_DETECT			0x30c
+#define  VE_MODE_DT_HOR_TOLER		GENMASK(31, 28)
+#define  VE_MODE_DT_VER_TOLER		GENMASK(27, 24)
+#define  VE_MODE_DT_HOR_STABLE		GENMASK(23, 20)
+#define  VE_MODE_DT_VER_STABLE		GENMASK(19, 16)
+#define  VE_MODE_DT_EDG_THROD		GENMASK(15, 8)
+
 #define VE_MEM_RESTRICT_START		0x310
 #define VE_MEM_RESTRICT_END		0x314
 
@@ -1238,7 +1244,12 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
 	aspeed_video_write(video, VE_SCALING_FILTER3, 0x00200000);
 
 	/* Set mode detection defaults */
-	aspeed_video_write(video, VE_MODE_DETECT, 0x22666500);
+	aspeed_video_write(video, VE_MODE_DETECT,
+			   FIELD_PREP(VE_MODE_DT_HOR_TOLER, 2) |
+			   FIELD_PREP(VE_MODE_DT_VER_TOLER, 2) |
+			   FIELD_PREP(VE_MODE_DT_HOR_STABLE, 6) |
+			   FIELD_PREP(VE_MODE_DT_VER_STABLE, 6) |
+			   FIELD_PREP(VE_MODE_DT_EDG_THROD, 0x65));
 
 	aspeed_video_write(video, VE_BCD_CTRL, 0);
 }
-- 
2.25.1

