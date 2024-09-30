From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:31 +0000
Subject: [PATCH 36/45] media: i2c: st-mipid02: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-36-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/i2c/st-mipid02.c:552:3-9: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/st-mipid02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index b947a55281f0..70a691504eed 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -549,7 +549,7 @@ static int mipid02_s_stream(struct v4l2_subdev *sd, int enable)
 		       mipid02_stream_disable(bridge);
 	if (ret)
 		dev_err(&client->dev, "failed to stream %s (%d)\n",
-			enable ? "enable" : "disable", ret);
+			str_enable_disable(enable), ret);
 
 	return ret;
 }

-- 
2.46.1.824.gd892dcdcdd-goog

