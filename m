From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:37 +0000
Subject: [PATCH 42/45] media: i2c: saa7110: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-42-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed
drivers/media/i2c/saa7110.c:313:37-43: opportunity for str_on_off(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/saa7110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/saa7110.c b/drivers/media/i2c/saa7110.c
index 942aeeb40c52..15134ac706d7 100644
--- a/drivers/media/i2c/saa7110.c
+++ b/drivers/media/i2c/saa7110.c
@@ -310,7 +310,7 @@ static int saa7110_s_stream(struct v4l2_subdev *sd, int enable)
 	if (decoder->enable != enable) {
 		decoder->enable = enable;
 		saa7110_write(sd, 0x0E, enable ? 0x18 : 0x80);
-		v4l2_dbg(1, debug, sd, "YUV %s\n", enable ? "on" : "off");
+		v4l2_dbg(1, debug, sd, "YUV %s\n", str_on_off(enable));
 	}
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog

