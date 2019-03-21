From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Thu, 21 Mar 2019 10:27:56 +0800
Subject: [v3 PATCH] usb: introduce usb_ep_type_string() function
Message-ID: <dfa55cfc48369945983d7cb9f97d09daf2670927.1553134542.git.chunfeng.yun@mediatek.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In some places, the code prints a human-readable USB endpoint
transfer type (e.g. "bulk"). This involves a switch statement
sometimes wrapped around in ({ ... }) block leading to code
repetition.
To make this scenario easier, here introduces usb_ep_type_string()
function, which returns a human-readable name of provided
endpoint type.
It also changes a few places switch was used to use this
new function.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2 changes:
    1. keep type string consistent with type_show() used in endpoint.c
v3 changes:
    1. abandon changes that will break user/kernel apis
---
 drivers/usb/common/common.c              | 16 ++++++++++++++++
 drivers/usb/core/hcd.c                   | 17 ++---------------
 drivers/usb/gadget/udc/aspeed-vhub/epn.c |  6 +-----
 drivers/usb/gadget/udc/dummy_hcd.c       | 16 +---------------
 include/linux/usb/ch9.h                  |  8 ++++++++
 5 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 48277bbc15e4..2174dd9ec176 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -16,6 +16,22 @@
 #include <linux/usb/otg.h>
 #include <linux/of_platform.h>
 
+static const char *const ep_type_names[] = {
+	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
+	[USB_ENDPOINT_XFER_ISOC] = "isoc",
+	[USB_ENDPOINT_XFER_BULK] = "bulk",
+	[USB_ENDPOINT_XFER_INT] = "intr",
+};
+
+const char *usb_ep_type_string(int ep_type)
+{
+	if (ep_type < 0 || ep_type >= ARRAY_SIZE(ep_type_names))
+		return "unknown";
+
+	return ep_type_names[ep_type];
+}
+EXPORT_SYMBOL_GPL(usb_ep_type_string);
+
 const char *usb_otg_state_string(enum usb_otg_state state)
 {
 	static const char *const names[] = {
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3189181bb628..0ccf2efeb40b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1878,23 +1878,10 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
 		/* kick hcd */
 		unlink1(hcd, urb, -ESHUTDOWN);
 		dev_dbg (hcd->self.controller,
-			"shutdown urb %pK ep%d%s%s\n",
+			"shutdown urb %pK ep%d%s-%s\n",
 			urb, usb_endpoint_num(&ep->desc),
 			is_in ? "in" : "out",
-			({	char *s;
-
-				 switch (usb_endpoint_type(&ep->desc)) {
-				 case USB_ENDPOINT_XFER_CONTROL:
-					s = ""; break;
-				 case USB_ENDPOINT_XFER_BULK:
-					s = "-bulk"; break;
-				 case USB_ENDPOINT_XFER_INT:
-					s = "-intr"; break;
-				 default:
-					s = "-iso"; break;
-				};
-				s;
-			}));
+			usb_ep_type_string(usb_endpoint_type(&ep->desc)));
 		usb_put_urb (urb);
 
 		/* list contents may have changed */
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 83340f4fdc6e..35941dc125f9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -593,10 +593,6 @@ static int ast_vhub_epn_disable(struct usb_ep* u_ep)
 static int ast_vhub_epn_enable(struct usb_ep* u_ep,
 			       const struct usb_endpoint_descriptor *desc)
 {
-	static const char *ep_type_string[] __maybe_unused = { "ctrl",
-							       "isoc",
-							       "bulk",
-							       "intr" };
 	struct ast_vhub_ep *ep = to_ast_ep(u_ep);
 	struct ast_vhub_dev *dev;
 	struct ast_vhub *vhub;
@@ -646,7 +642,7 @@ static int ast_vhub_epn_enable(struct usb_ep* u_ep,
 	ep->epn.wedged = false;
 
 	EPDBG(ep, "Enabling [%s] %s num %d maxpacket=%d\n",
-	      ep->epn.is_in ? "in" : "out", ep_type_string[type],
+	      ep->epn.is_in ? "in" : "out", usb_ep_type_string(type),
 	      usb_endpoint_num(desc), maxpacket);
 
 	/* Can we use DMA descriptor mode ? */
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index baf72f95f0f1..40c6a484e232 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -617,21 +617,7 @@ static int dummy_enable(struct usb_ep *_ep,
 		_ep->name,
 		desc->bEndpointAddress & 0x0f,
 		(desc->bEndpointAddress & USB_DIR_IN) ? "in" : "out",
-		({ char *val;
-		 switch (usb_endpoint_type(desc)) {
-		 case USB_ENDPOINT_XFER_BULK:
-			 val = "bulk";
-			 break;
-		 case USB_ENDPOINT_XFER_ISOC:
-			 val = "iso";
-			 break;
-		 case USB_ENDPOINT_XFER_INT:
-			 val = "intr";
-			 break;
-		 default:
-			 val = "ctrl";
-			 break;
-		 } val; }),
+		usb_ep_type_string(usb_endpoint_type(desc)),
 		max, ep->stream_en ? "enabled" : "disabled");
 
 	/* at this point real hardware should be NAKing transfers
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 523aa088f6ab..da82606be605 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -36,6 +36,14 @@
 #include <linux/device.h>
 #include <uapi/linux/usb/ch9.h>
 
+/**
+ * usb_ep_type_string() - Returns human readable-name of the endpoint type.
+ * @ep_type: The endpoint type to return human-readable name for.  If it's not
+ *   any of the types: USB_ENDPOINT_XFER_{CONTROL, ISOC, BULK, INT},
+ *   usually got by usb_endpoint_type(), the string 'unknown' will be returned.
+ */
+extern const char *usb_ep_type_string(int ep_type);
+
 /**
  * usb_speed_string() - Returns human readable-name of the speed.
  * @speed: The speed to return human-readable name for.  If it's not
-- 
2.20.1

