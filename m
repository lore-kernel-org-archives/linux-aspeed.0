From: Zheng Bin <zhengbin13@huawei.com>
Date: Thu, 16 Jun 2022 21:35:08 +0800
Subject: [PATCH -next] usb: gadget: aspeed_udc: fix missing spin_unlock_irqrestore in ast_udc_ep_queue
Message-ID: <20220616133508.3655864-1-zhengbin13@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ast_udc_ep_queue misses spin_unlock_irqrestore in an error path,
this patch fixes that.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 1fc15228ff15..6c91f7f288a2 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -665,7 +665,8 @@ static int ast_udc_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
 	if (ep->ep.desc == NULL) {
 		if ((req->req.dma % 4) != 0) {
 			dev_warn(dev, "EP0 req dma alignment error\n");
-			return -ESHUTDOWN;
+			rc = -ESHUTDOWN;
+			goto end;
 		}

 		ast_udc_ep0_queue(ep, req);
--
2.31.1

