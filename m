From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 24 Apr 2019 10:16:58 -0500
Subject: [PATCH v2 2/4] media: platform: Aspeed: Make reserved memory optional
In-Reply-To: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1556119020-7609-3-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reserved memory doesn't need to be required; system memory would work
fine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/media/platform/aspeed-video.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 55c55a6..8144fe3 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1608,11 +1608,7 @@ static int aspeed_video_init(struct aspeed_video *video)
 		return PTR_ERR(video->vclk);
 	}
 
-	rc = of_reserved_mem_device_init(dev);
-	if (rc) {
-		dev_err(dev, "Unable to reserve memory\n");
-		return rc;
-	}
+	of_reserved_mem_device_init(dev);
 
 	rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (rc) {
-- 
1.8.3.1

