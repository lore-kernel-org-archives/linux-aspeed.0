From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:19 +0000
Subject: [PATCH 24/45] media: cx18: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-24-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/pci/cx18/cx18-av-core.c:1013:40-46: opportunity for str_enable_disable(enable)
drivers/media/pci/cx18/cx18-av-core.c:1118:8-24: opportunity for str_yes_no(( mute_ctl & 0x2 ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/cx18/cx18-av-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-av-core.c b/drivers/media/pci/cx18/cx18-av-core.c
index ee6e71157786..5701abdf9427 100644
--- a/drivers/media/pci/cx18/cx18-av-core.c
+++ b/drivers/media/pci/cx18/cx18-av-core.c
@@ -1010,7 +1010,7 @@ static int cx18_av_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct cx18 *cx = v4l2_get_subdevdata(sd);
 
-	CX18_DEBUG_INFO_DEV(sd, "%s output\n", enable ? "enable" : "disable");
+	CX18_DEBUG_INFO_DEV(sd, "%s output\n", str_enable_disable(enable));
 	if (enable) {
 		cx18_av_write(cx, 0x115, 0x8c);
 		cx18_av_write(cx, 0x116, 0x07);
@@ -1115,7 +1115,7 @@ static void log_audio_status(struct cx18 *cx)
 	}
 	CX18_INFO_DEV(sd, "Detected audio standard:   %s\n", p);
 	CX18_INFO_DEV(sd, "Audio muted:               %s\n",
-		      (mute_ctl & 0x2) ? "yes" : "no");
+		      str_yes_no(mute_ctl & 0x2));
 	CX18_INFO_DEV(sd, "Audio microcontroller:     %s\n",
 		      (download_ctl & 0x10) ? "running" : "stopped");
 

-- 
2.46.1.824.gd892dcdcdd-goog

