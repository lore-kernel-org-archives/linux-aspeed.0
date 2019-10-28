From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 28 Oct 2019 11:58:26 -0500
Subject: [PATCH v2] media: aspeed-video: Fix memory leaks in aspeed_video_probe
In-Reply-To: <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
References: <d9c04318-586a-bfc2-fce6-6218c6bab1d6@linux.intel.com>
Message-ID: <20191028165827.24949-1-navid.emamdoost@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the implementation of aspeed_video_probe() the allocated memory for
video should be released if either devm_ioremap_resource()
or aspeed_video_init() or aspeed_video_setup_video() fails. Replace
kzalloc() with devm_kzalloc to avoid explicit release for video.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- replace kzalloc with devm_kzalloc based on Jae Hyun Yoo
suggestion

 drivers/media/platform/aspeed-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb12f3793062..2aa8ea2f9824 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1646,7 +1646,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct resource *res;
-	struct aspeed_video *video = kzalloc(sizeof(*video), GFP_KERNEL);
+	struct aspeed_video *video = devm_kzalloc(sizeof(*video), GFP_KERNEL);
 
 	if (!video)
 		return -ENOMEM;
-- 
2.17.1

