From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:34 +0000
Subject: [PATCH 39/45] media: i2c: saa717x: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-39-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/i2c/saa717x.c:1091:3-9: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/saa717x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/saa717x.c b/drivers/media/i2c/saa717x.c
index b0793bb0c02a..2337cef45e3a 100644
--- a/drivers/media/i2c/saa717x.c
+++ b/drivers/media/i2c/saa717x.c
@@ -1088,7 +1088,7 @@ static int saa717x_s_stream(struct v4l2_subdev *sd, int enable)
 	struct saa717x_state *decoder = to_state(sd);
 
 	v4l2_dbg(1, debug, sd, "decoder %s output\n",
-			enable ? "enable" : "disable");
+			str_enable_disable(enable));
 	decoder->enable = enable;
 	saa717x_write(sd, 0x193, enable ? 0xa6 : 0x26);
 	return 0;

-- 
2.46.1.824.gd892dcdcdd-goog

