From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 26 Nov 2021 19:09:53 +0800
Subject: [PATCH 2/3] usb: aspeed-vhub: support remote wakeup feature
In-Reply-To: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
Message-ID: <20211126110954.2677627-3-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remote wakeup signaling will be automatically issued
whenever any write commands has been received in suspend
state.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c |  3 +++
 drivers/usb/gadget/udc/aspeed-vhub/dev.c  | 18 ++++++++++++++----
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 22 ++++++++++++++++------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..122ee7ef0b03 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -240,6 +240,9 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	if (vhub->force_usb1)
 		ctrl |= VHUB_CTRL_FULL_SPEED_ONLY;
 
+	/* Enable auto remote wakeup */
+	ctrl |= VHUB_CTRL_AUTO_REMOTE_WAKEUP;
+
 	ctrl |= VHUB_CTRL_UPSTREAM_CONNECT;
 	writel(ctrl, vhub->regs + AST_VHUB_CTRL);
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d918e8b2af3c..4462f4b73b04 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct ast_vhub_dev *d,
 				u16 wIndex, u16 wValue,
 				bool is_set)
 {
+	u32 val;
+
 	DDBG(d, "%s_FEATURE(dev val=%02x)\n",
 	     is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_driver;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		d->wakeup_en = is_set;
+		return std_req_complete;
 
-	d->wakeup_en = is_set;
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(d->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, d->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_driver;
 }
 
 static int ast_vhub_ep_feature(struct ast_vhub_dev *d,
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index d76f83bc7762..ac589d3ba7a2 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct ast_vhub_ep *ep,
 				    u16 wIndex, u16 wValue,
 				    bool is_set)
 {
+	u32 val;
+
 	EPDBG(ep, "%s_FEATURE(dev val=%02x)\n",
 	      is_set ? "SET" : "CLEAR", wValue);
 
-	if (wValue != USB_DEVICE_REMOTE_WAKEUP)
-		return std_req_stall;
+	if (wValue == USB_DEVICE_REMOTE_WAKEUP) {
+		ep->vhub->wakeup_en = is_set;
+		EPDBG(ep, "Hub remote wakeup %s\n",
+		      is_set ? "enabled" : "disabled");
+		return std_req_complete;
 
-	ep->vhub->wakeup_en = is_set;
-	EPDBG(ep, "Hub remote wakeup %s\n",
-	      is_set ? "enabled" : "disabled");
+	} else if (wValue == USB_DEVICE_TEST_MODE) {
+		val = readl(ep->vhub->regs + AST_VHUB_CTRL);
+		val &= ~GENMASK(10, 8);
+		val |= VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
+		writel(val, ep->vhub->regs + AST_VHUB_CTRL);
 
-	return std_req_complete;
+		return std_req_complete;
+	}
+
+	return std_req_stall;
 }
 
 static int ast_vhub_hub_ep_feature(struct ast_vhub_ep *ep,
-- 
2.25.1

