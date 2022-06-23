From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date: Thu, 23 Jun 2022 16:43:47 +0800
Subject: [PATCH] usb: gadget: Fix unsigned comparison with less than zero
Message-ID: <20220623084347.38207-1-jiapeng.chong@linux.alibaba.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This was found by coccicheck:

./drivers/usb/gadget/udc/aspeed_udc.c:496:8-13: WARNING: Unsigned expression compared with zero: chunk >= 0.

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 1fc15228ff15..387a7abdcee4 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -476,8 +476,8 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32 dma_buf,
 {
 	struct ast_udc_dev *udc = ep->udc;
 	struct device *dev = &udc->pdev->dev;
-	u32 offset, chunk;
-	int count, last;
+	u32 offset;
+	int count, last, chunk;
 
 	if (!ep->descs) {
 		dev_warn(dev, "%s: Empty DMA descs list failure\n",
-- 
2.20.1.7.g153144c

