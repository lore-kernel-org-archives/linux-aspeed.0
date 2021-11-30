From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 19:38:46 +0800
Subject: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
In-Reply-To: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
Message-ID: <20211130113847.1405873-4-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

+Ben.
---

If multiple devices in vhub are enumerated simultaneously, ep0 OUT
ack might received wrong data length. Using expected data length
instead.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index 74ea36c19b1e..bea9cbb191a2 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct ast_vhub_ep *ep, struct ast_vhub_req
 		len = remain;
 		rc = -EOVERFLOW;
 	}
+
+	/* HW return wrong data len */
+	if (len < ep->ep.maxpacket && len != remain) {
+		EPDBG(ep, "using expected data len instead\n");
+		len = remain;
+	}
+
 	if (len && req->req.buf)
 		memcpy(req->req.buf + req->req.actual, ep->buf, len);
 	req->req.actual += len;
-- 
2.25.1

