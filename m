From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu,  2 May 2019 12:13:14 -0700
Subject: [PATCH 4/7] media: aspeed: remove IRQF_SHARED flag
In-Reply-To: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
References: <20190502191317.29698-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20190502191317.29698-5-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Video Engine has a dedicated interrupt line so this driver doesn't
need to use IRQF_SHARED flag so remove it. Also, it'd be good for
following what Thomas recommended in the IRQF_ONESHOT support
patch like below:

"Note that for now IRQF_ONESHOT cannot be used with IRQF_SHARED to
avoid complex accounting mechanisms."

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index e1bdafeed007..d88e8d238c49 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1616,8 +1616,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 	}
 
 	rc = devm_request_threaded_irq(dev, irq, NULL, aspeed_video_irq,
-				       IRQF_ONESHOT | IRQF_SHARED, DEVICE_NAME,
-				       video);
+				       IRQF_ONESHOT, DEVICE_NAME, video);
 	if (rc < 0) {
 		dev_err(dev, "Unable to request IRQ %d\n", irq);
 		return rc;
-- 
2.21.0

