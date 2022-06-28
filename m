From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 28 Jun 2022 11:21:43 +0300
Subject: [PATCH v3] usb: gadget: aspeed_udc: fix handling of tx_len == 0
Message-ID: <Yrq6F5okoX1y05rT@kili>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bug is that we should still enter this loop if "tx_len" is zero.

After adding the "last" variable, then the "chunk >= 0" condition is no
longer required but I left it for readability.

Reported-by: Neal Liu <neal_liu@aspeedtech.com>
Fixes: c09b1f372e74 ("usb: gadget: aspeed_udc: cleanup loop in ast_dma_descriptor_setup()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
---
v3:  We went back and forth on the style on this.  This is just v1 but
with Neal's Reviewed-by.

 drivers/usb/gadget/udc/aspeed_udc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..01968e2167f9 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -476,6 +476,7 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32 dma_buf,
 {
 	struct ast_udc_dev *udc = ep->udc;
 	struct device *dev = &udc->pdev->dev;
+	bool last = false;
 	int chunk, count;
 	u32 offset;
 
@@ -493,14 +494,16 @@ static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32 dma_buf,
 	       "tx_len", tx_len);
 
 	/* Create Descriptor Lists */
-	while (chunk > 0 && count < AST_UDC_DESCS_COUNT) {
+	while (chunk >= 0 && !last && count < AST_UDC_DESCS_COUNT) {
 
 		ep->descs[ep->descs_wptr].des_0 = dma_buf + offset;
 
-		if (chunk > ep->chunk_max)
+		if (chunk > ep->chunk_max) {
 			ep->descs[ep->descs_wptr].des_1 = ep->chunk_max;
-		else
+		} else {
 			ep->descs[ep->descs_wptr].des_1 = chunk;
+			last = true;
+		}
 
 		chunk -= ep->chunk_max;
 
-- 
2.35.1

