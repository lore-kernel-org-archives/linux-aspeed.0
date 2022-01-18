From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 18 Jan 2022 18:07:29 +0800
Subject: [PATCH v4 2/2] media: aspeed: Fix unstable timing detection
In-Reply-To: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
References: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
Message-ID: <20220118100729.7651-3-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using stable-signal in resolution detection, and try detection again
if unstable.

VE_MODE_DETECT_EXTSRC_ADC: 1 if video source is from ADC output.
VE_MODE_DETECT_H_STABLE: 1 if horizontal signal detection is stable.
VE_MODE_DETECT_V_STABLE: 1 if vertical signal detection is stable.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 5ba4d70c8dab..585ee2997d44 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -165,9 +165,14 @@
 
 #define VE_MODE_DETECT_STATUS		0x098
 #define  VE_MODE_DETECT_H_PERIOD	GENMASK(11, 0)
+#define  VE_MODE_DETECT_EXTSRC_ADC	BIT(12)
+#define  VE_MODE_DETECT_H_STABLE	BIT(13)
+#define  VE_MODE_DETECT_V_STABLE	BIT(14)
 #define  VE_MODE_DETECT_V_LINES		GENMASK(27, 16)
 #define  VE_MODE_DETECT_STATUS_VSYNC	BIT(28)
 #define  VE_MODE_DETECT_STATUS_HSYNC	BIT(29)
+#define  VE_MODE_DETECT_VSYNC_RDY	BIT(30)
+#define  VE_MODE_DETECT_HSYNC_RDY	BIT(31)
 
 #define VE_SYNC_STATUS			0x09c
 #define  VE_SYNC_STATUS_HSYNC		GENMASK(11, 0)
@@ -971,6 +976,13 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 			return;
 		}
 
+		mds = aspeed_video_read(video, VE_MODE_DETECT_STATUS);
+		// try detection again if current signal isn't stable
+		if (!(mds & VE_MODE_DETECT_H_STABLE) ||
+		    !(mds & VE_MODE_DETECT_V_STABLE) ||
+		    (mds & VE_MODE_DETECT_EXTSRC_ADC))
+			continue;
+
 		aspeed_video_check_and_set_polarity(video);
 
 		aspeed_video_enable_mode_detect(video);
-- 
2.25.1

