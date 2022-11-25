From: Zheng Yongjun <zhengyongjun3@huawei.com>
Date: Fri, 25 Nov 2022 09:24:15 +0000
Subject: [PATCH] media: aspeed: Fix return value check in aspeed_video_debugfs_create()
Message-ID: <20221125092415.29635-1-zhengyongjun3@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case of error, the function debugfs_create_file() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 20f795ccc11b..c8fc2450e409 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1780,10 +1780,12 @@ static int aspeed_video_debugfs_create(struct aspeed_video *video)
 	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
 					    video,
 					    &aspeed_video_debugfs_ops);
-	if (!debugfs_entry)
+	if (IS_ERR(debugfs_entry)) {
 		aspeed_video_debugfs_remove(video);
+		return ERR_PTR(debugfs_entry);
+	}

-	return !debugfs_entry ? -EIO : 0;
+	return 0;
 }
 #else
 static void aspeed_video_debugfs_remove(struct aspeed_video *video) { }
--
2.17.1

