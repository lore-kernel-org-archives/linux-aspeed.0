From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 18 Jun 2022 11:54:53 +0300
Subject: [PATCH 2/2] usb: gadget: aspeed_udc: unlock on error in
 ast_udc_ep_queue()
In-Reply-To: <Yq2SvM2bbrtSd1H9@kili>
Message-ID: <Yq2S3aF0MPChLD/e@kili>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Call spin_unlock_irqrestore(&udc->lock, flags); before returning an
error code.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 77376ae04224..4dead40895dd 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -663,7 +663,8 @@ static int ast_udc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (ep->ep.desc == NULL) {
 		if ((req->req.dma % 4) != 0) {
 			dev_warn(dev, "EP0 req dma alignment error\n");
-			return -ESHUTDOWN;
+			rc = -ESHUTDOWN;
+			goto end;
 		}
 
 		ast_udc_ep0_queue(ep, req);
-- 
2.35.1

