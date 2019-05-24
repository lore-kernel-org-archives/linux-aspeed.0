From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 24 May 2019 16:17:24 -0700
Subject: [PATCH v2 10/11] media: aspeed: fix an incorrect timeout checking in
 mode detection
In-Reply-To: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190524231725.12320-11-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There is an incorrect timeout checking in mode detection logic so
it misses resolution detecting chances. This commit fixes the bug.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v1 -> v2:
 New.

 drivers/media/platform/aspeed-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 67f476bf0a03..b05b073b63bc 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -735,7 +735,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 	do {
 		if (tries) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (schedule_timeout(INVALID_RESOLUTION_DELAY))
+			if (!schedule_timeout(INVALID_RESOLUTION_DELAY))
 				return;
 		}
 
-- 
2.21.0

