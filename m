From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 17 Dec 2018 12:14:35 +0000
Subject: [PATCH -next] media: platform: Fix missing spin_lock_init()
Message-ID: <1545048875-157403-1-git-send-email-weiyongjun1@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/media/platform/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index dfec813..692e08e 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1661,6 +1661,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 
 	video->frame_rate = 30;
 	video->dev = &pdev->dev;
+	spin_lock_init(&video->lock);
 	mutex_init(&video->video_lock);
 	init_waitqueue_head(&video->wait);
 	INIT_DELAYED_WORK(&video->res_work, aspeed_video_resolution_work);



