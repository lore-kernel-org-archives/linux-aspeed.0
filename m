From: Liu Shixin <liushixin2@huawei.com>
Date: Thu, 22 Sep 2022 22:30:38 +0800
Subject: [PATCH] media: aspeed: use DEFINE_SHOW_ATTRIBUTE to simplify code
Message-ID: <20220922143038.3251456-1-liushixin2@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
No functional change.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 20f795ccc11b..26f067c77217 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1753,19 +1753,7 @@ static int aspeed_video_debugfs_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
-static int aspeed_video_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, aspeed_video_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations aspeed_video_debugfs_ops = {
-	.owner   = THIS_MODULE,
-	.open    = aspeed_video_proc_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(aspeed_video_debugfs);
 
 static struct dentry *debugfs_entry;
 
@@ -1779,7 +1767,7 @@ static int aspeed_video_debugfs_create(struct aspeed_video *video)
 {
 	debugfs_entry = debugfs_create_file(DEVICE_NAME, 0444, NULL,
 					    video,
-					    &aspeed_video_debugfs_ops);
+					    &aspeed_video_debugfs_fops);
 	if (!debugfs_entry)
 		aspeed_video_debugfs_remove(video);
 
-- 
2.25.1

