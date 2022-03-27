From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Date: Sun, 27 Mar 2022 14:24:31 +0800
Subject: [PATCH] aspeed-vhub: epn: fix an incorrect member check on list
 iterator
Message-ID: <20220327062431.5847-1-xiam0nd.tong@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The bug is here:
	if (&req->req == u_req) {

The list iterator 'req' will point to a bogus position containing
HEAD if the list is empty or no element is found. This case must
be checked before any use of the iterator, otherwise it may bypass
the 'if (&req->req == u_req) {' check in theory, if '*u_req' obj is
just allocated in the same addr with '&req->req'.

To fix this bug, just mova all thing inside the loop and return 0,
otherwise return error.

Cc: stable at vger.kernel.org
Fixes: 7ecca2a4080cb ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 917892ca8753..aae4ce3e1029 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -468,27 +468,24 @@ static int ast_vhub_epn_dequeue(struct usb_ep* u_ep, struct usb_request *u_req)
 	struct ast_vhub *vhub = ep->vhub;
 	struct ast_vhub_req *req;
 	unsigned long flags;
-	int rc = -EINVAL;
 
 	spin_lock_irqsave(&vhub->lock, flags);
 
 	/* Make sure it's actually queued on this endpoint */
 	list_for_each_entry (req, &ep->queue, queue) {
-		if (&req->req == u_req)
-			break;
-	}
-
-	if (&req->req == u_req) {
-		EPVDBG(ep, "dequeue req @%p active=%d\n",
-		       req, req->active);
-		if (req->active)
-			ast_vhub_stop_active_req(ep, true);
-		ast_vhub_done(ep, req, -ECONNRESET);
-		rc = 0;
+		if (&req->req == u_req) {
+			EPVDBG(ep, "dequeue req @%p active=%d\n",
+				req, req->active);
+			if (req->active)
+				ast_vhub_stop_active_req(ep, true);
+			ast_vhub_done(ep, req, -ECONNRESET);
+			spin_unlock_irqrestore(&vhub->lock, flags);
+			return 0;
+		}
 	}
 
 	spin_unlock_irqrestore(&vhub->lock, flags);
-	return rc;
+	return -EINVAL;
 }
 
 void ast_vhub_update_epn_stall(struct ast_vhub_ep *ep)
-- 
2.17.1

