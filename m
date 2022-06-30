From: Sebin Sebastian <mailmesebin00@gmail.com>
Date: Thu, 30 Jun 2022 04:47:33 -0000
Subject: [PATCH v2 -next] usb: gadget: dereference before null check
Message-ID: <20220630044706.10772-1-mailmesebin00@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix coverity warning dereferencing before null check. _ep and desc is
dereferenced on all paths until the check for null. Move the
initializations after the check for null.
Coverity issue: 1518209

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
---
 Changes since v1: Fix the build errors and warnings due to first patch.
 Fix the undeclared 'ep' and 'maxpacket' error. Fix the ISO C90 warning.

 drivers/usb/gadget/udc/aspeed_udc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..a43cf8dde2a8 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -341,26 +341,33 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
 static int ast_udc_ep_enable(struct usb_ep *_ep,
 			     const struct usb_endpoint_descriptor *desc)
 {
-	u16 maxpacket = usb_endpoint_maxp(desc);
-	struct ast_udc_ep *ep = to_ast_ep(_ep);
-	struct ast_udc_dev *udc = ep->udc;
-	u8 epnum = usb_endpoint_num(desc);
 	unsigned long flags;
 	u32 ep_conf = 0;
 	u8 dir_in;
 	u8 type;
+	u16 maxpacket;
+	struct ast_udc_ep *ep;
+	struct ast_udc_dev *udc;
+	u8 epnum;
 
-	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
-	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
+	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		EP_DBG(ep, "Failed, invalid EP enable param\n");
 		return -EINVAL;
 	}
-
 	if (!udc->driver) {
 		EP_DBG(ep, "bogus device state\n");
 		return -ESHUTDOWN;
 	}
 
+	maxpacket = usb_endpoint_maxp(desc);
+	ep = to_ast_ep(_ep);
+	udc = ep->udc;
+	epnum = usb_endpoint_num(desc);
+	if (maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
+		EP_DBG(ep, "Failed, invalid EP enable param\n");
+		return -EINVAL;
+	}
+
 	EP_DBG(ep, "maxpacket:0x%x\n", maxpacket);
 
 	spin_lock_irqsave(&udc->lock, flags);
-- 
2.34.1

