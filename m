From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 13 Sep 2019 11:11:05 -0700
Subject: [PATCH -next v2 2/2] media: aspeed: set hsync and vsync polarities to
 normal before starting mode detection
In-Reply-To: <20190913181105.11836-1-jae.hyun.yoo@linux.intel.com>
References: <20190913181105.11836-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190913181105.11836-3-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sometimes it detects a weird resolution such as 1024x287 when the
actual resolution is 1024x768. To resolve such an issue, this
commit adds clearing for hsync and vsync polarity register bits
at the beginning of the first mode detection. This is recommended
in the datasheet.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
Changes since v1:
 None

 drivers/media/platform/aspeed-video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 8f77079da55a..929b3a5b8849 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -740,6 +740,8 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 		}
 
 		set_bit(VIDEO_RES_DETECT, &video->flags);
+		aspeed_video_update(video, VE_CTRL,
+				    VE_CTRL_VSYNC_POL | VE_CTRL_HSYNC_POL, 0);
 		aspeed_video_enable_mode_detect(video);
 
 		rc = wait_event_interruptible_timeout(video->wait,
-- 
2.23.0

