From: SebinSebastian <mailmesebin00@gmail.com>
Date: Wed, 29 Jun 2022 08:07:59 -0000
Subject: [PATCH -next] usb: gadget: dereference before null check
Message-ID: <20220629080726.107297-1-mailmesebin00@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix coverity warning dereferencing before null check. _ep and desc is
dereferenced on all paths until the check for null. Move the
initializations after the check for null.
Coverity issue: 1518209

Signed-off-by: SebinSebastian <mailmesebin00@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index d75a4e070bf7..96f8193fca15 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -341,10 +341,6 @@ static void ast_udc_stop_activity(struct ast_udc_dev *udc)
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
@@ -356,6 +352,11 @@ static int ast_udc_ep_enable(struct usb_ep *_ep,
 		return -EINVAL;
 	}

+	u16 maxpacket = usb_endpoint_maxp(desc);
+	struct ast_udc_ep *ep = to_ast_ep(_ep);
+	struct ast_udc_dev *udc = ep->udc;
+	u8 epnum = usb_endpoint_num(desc);
+
 	if (!udc->driver) {
 		EP_DBG(ep, "bogus device state\n");
 		return -ESHUTDOWN;
--
2.34.1

