From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 11:41:39 -0500
Subject: [PATCH AUTOSEL 5.4 124/205] media: aspeed-video: Fix memory leaks in
 aspeed_video_probe
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
Message-ID: <20200116164300.6705-124-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit c3df30a01da4955e04fa068c503cd784b31dad92 ]

In the implementation of aspeed_video_probe() the allocated memory for
video should be released if either devm_ioremap_resource()
or aspeed_video_init() or aspeed_video_setup_video() fails. Replace
kzalloc() with devm_kzalloc to avoid explicit release for video.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/aspeed-video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 096a7c9a8963..4eaaf39b9223 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1658,7 +1658,8 @@ static int aspeed_video_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct resource *res;
-	struct aspeed_video *video = kzalloc(sizeof(*video), GFP_KERNEL);
+	struct aspeed_video *video =
+		devm_kzalloc(&pdev->dev, sizeof(*video), GFP_KERNEL);
 
 	if (!video)
 		return -ENOMEM;
-- 
2.20.1

