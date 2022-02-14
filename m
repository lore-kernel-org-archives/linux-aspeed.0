From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 14 Feb 2022 16:09:09 +0800
Subject: [PATCH v2] media: aspeed: Use of_device_get_match_data() helper
Message-ID: <20220214080909.2792-1-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2:
  - Add a check for null pointer for of_device_get_match_data
---
 drivers/media/platform/aspeed-video.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 3904ded2052a..91ec7eec1e6e 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
@@ -2451,7 +2452,6 @@ MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
 static int aspeed_video_probe(struct platform_device *pdev)
 {
 	const struct aspeed_video_config *config;
-	const struct of_device_id *match;
 	struct aspeed_video *video;
 	int rc;
 
@@ -2463,11 +2463,10 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	if (IS_ERR(video->base))
 		return PTR_ERR(video->base);
 
-	match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
-	if (!match)
-		return -EINVAL;
+	config = of_device_get_match_data(&pdev->dev);
+	if (!config)
+		return -ENODEV;
 
-	config = match->data;
 	video->version = config->version;
 	video->jpeg_mode = config->jpeg_mode;
 	video->comp_size_read = config->comp_size_read;
-- 
2.25.1

