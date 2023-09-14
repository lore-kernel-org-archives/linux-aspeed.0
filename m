From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 14 Sep 2023 11:31:35 +0800
Subject: [PATCH] media: aspeed: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
Message-ID: <20230914033135.3760727-1-ruanjinjie@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since debugfs_create_file() returns ERR_PTR and never NULL, use IS_ERR() to
check the return value.

And so return the err code based on IS_ERR instead of checking NULL.

Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index a9c2c69b2ed9..f4e624c13d3b 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1975,10 +1975,12 @@ static int aspeed_video_debugfs_create(struct aspeed_video *video)
 	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
 					    video,
 					    &aspeed_video_debugfs_fops);
-	if (!debugfs_entry)
+	if (IS_ERR(debugfs_entry)) {
 		aspeed_video_debugfs_remove(video);
+		return -EIO;
+	}
 
-	return !debugfs_entry ? -EIO : 0;
+	return 0;
 }
 #else
 static void aspeed_video_debugfs_remove(struct aspeed_video *video) { }
-- 
2.34.1

