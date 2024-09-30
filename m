From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:27 +0000
Subject: [PATCH 32/45] media: i2c: tvp7002: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-32-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/i2c/tvp7002.c:775:5-22: opportunity for str_yes_no(device -> streaming)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/tvp7002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/tvp7002.c b/drivers/media/i2c/tvp7002.c
index c09a5bd71fd0..2acf93a90c34 100644
--- a/drivers/media/i2c/tvp7002.c
+++ b/drivers/media/i2c/tvp7002.c
@@ -772,7 +772,7 @@ static int tvp7002_log_status(struct v4l2_subdev *sd)
 				bt->width, bt->height);
 	}
 	v4l2_info(sd, "Streaming enabled: %s\n",
-					device->streaming ? "yes" : "no");
+					str_yes_no(device->streaming));
 
 	/* Print the current value of the gain control */
 	v4l2_ctrl_handler_log_status(&device->hdl, sd->name);

-- 
2.46.1.824.gd892dcdcdd-goog

