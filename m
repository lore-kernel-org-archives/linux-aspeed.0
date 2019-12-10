From: Sasha Levin <sashal@kernel.org>
Date: Tue, 10 Dec 2019 16:04:10 -0500
Subject: [PATCH AUTOSEL 5.4 145/350] media: aspeed: set hsync and vsync
 polarities to normal before starting mode detection
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
Message-ID: <20191210210735.9077-106-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 5b3f3c41c5c791c1c22cd91655e7ef4b2a1dff7c ]

Sometimes it detects a weird resolution such as 1024x287 when the
actual resolution is 1024x768. To resolve such an issue, this
commit adds clearing for hsync and vsync polarity register bits
at the beginning of the first mode detection. This is recommended
in the datasheet.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/aspeed-video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index eb12f37930629..84e0650106f51 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -741,6 +741,8 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		}
 
 		set_bit(VIDEO_RES_DETECT, &video->flags);
+		aspeed_video_update(video, VE_CTRL,
+				    VE_CTRL_VSYNC_POL | VE_CTRL_HSYNC_POL, 0);
 		aspeed_video_enable_mode_detect(video);
 
 		rc = wait_event_interruptible_timeout(video->wait,
-- 
2.20.1

