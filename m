From: Sasha Levin <sashal@kernel.org>
Date: Fri, 23 Dec 2022 20:30:20 -0500
Subject: [PATCH AUTOSEL 6.0 04/18] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <20221224013034.392810-1-sashal@kernel.org>
References: <20221224013034.392810-1-sashal@kernel.org>
Message-ID: <20221224013034.392810-4-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Henry Tian <tianxiaofeng@bytedance.com>

[ Upstream commit 83045e19feae937c425248824d1dc0fc95583842 ]

In ast_vhub_epn_handle_ack() when the received data length exceeds the
buffer, it does not check the case and just copies to req.buf and cause
a buffer overflow, kernel oops on this case.

This issue could be reproduced on a BMC with an OS that enables the
lan over USB:
1. In OS, enable the usb eth dev, verify it pings the BMC OK;
2. In OS, set the usb dev mtu to 2000. (Default is 1500);
3. In OS, ping the BMC with `-s 2000` argument.

The BMC kernel will get oops with below logs:

    skbuff: skb_over_panic: text:8058e098 len:2048 put:2048 head:84c678a0 data:84c678c2 tail:0x84c680c2 end:0x84c67f00 dev:usb0
    ------------[ cut here ]------------
    kernel BUG at net/core/skbuff.c:113!
    Internal error: Oops - BUG: 0 [#1] ARM
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.69-c9fb275-dirty-d1e579a #1
    Hardware name: Generic DT based system
    PC is at skb_panic+0x60/0x6c
    LR is at irq_work_queue+0x6c/0x94

Fix the issue by checking the length and set `-EOVERFLOW`.

Tested: Verify the BMC kernel does not get oops in the above case, and
the usb ethernet gets RX packets errors instead.

Signed-off-by: Lei YU <yulei.sh@bytedance.com>
Signed-off-by: Henry Tian <tianxiaofeng@bytedance.com>
Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Link: https://lore.kernel.org/r/20221024094853.2877441-1-yulei.sh at bytedance.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c |  2 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c  | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..ac3ca24f8b04 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -37,7 +37,7 @@ void ast_vhub_done(struct ast_vhub_ep *ep, struct ast_vhub_req *req,
 
 	list_del_init(&req->queue);
 
-	if (req->req.status == -EINPROGRESS)
+	if ((req->req.status == -EINPROGRESS) ||  (status == -EOVERFLOW))
 		req->req.status = status;
 
 	if (req->req.dma) {
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index b5252880b389..56e55472daa1 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -84,6 +84,7 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
 {
 	struct ast_vhub_req *req;
 	unsigned int len;
+	int status = 0;
 	u32 stat;
 
 	/* Read EP status */
@@ -119,9 +120,15 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
 	len = VHUB_EP_DMA_TX_SIZE(stat);
 
 	/* If not using DMA, copy data out if needed */
-	if (!req->req.dma && !ep->epn.is_in && len)
-		memcpy(req->req.buf + req->req.actual, ep->buf, len);
-
+	if (!req->req.dma && !ep->epn.is_in && len) {
+		if (req->req.actual + len > req->req.length) {
+			req->last_desc = 1;
+			status = -EOVERFLOW;
+			goto done;
+		} else {
+			memcpy(req->req.buf + req->req.actual, ep->buf, len);
+		}
+	}
 	/* Adjust size */
 	req->req.actual += len;
 
@@ -129,9 +136,10 @@ static void ast_vhub_epn_handle_ack(struct ast_vhub_ep *ep)
 	if (len < ep->ep.maxpacket)
 		req->last_desc = 1;
 
+done:
 	/* That's it ? complete the request and pick a new one */
 	if (req->last_desc >= 0) {
-		ast_vhub_done(ep, req, 0);
+		ast_vhub_done(ep, req, status);
 		req = list_first_entry_or_null(&ep->queue, struct ast_vhub_req,
 					       queue);
 
-- 
2.35.1

