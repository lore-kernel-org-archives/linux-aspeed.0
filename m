From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 18:42:53 +0800
Subject: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
Message-ID: <20211130104256.3106797-2-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Support qualifier descriptor to pass USB30CV compliance test.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 24 +++++++++++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index b9960fdd8a51..93f27a745760 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -68,6 +68,18 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bNumConfigurations	= 1,
 };
 
+static const struct usb_qualifier_descriptor ast_vhub_qual_desc = {
+	.bLength = 0xA,
+	.bDescriptorType = USB_DT_DEVICE_QUALIFIER,
+	.bcdUSB = cpu_to_le16(0x0200),
+	.bDeviceClass = USB_CLASS_HUB,
+	.bDeviceSubClass = 0,
+	.bDeviceProtocol = 0,
+	.bMaxPacketSize0 = 64,
+	.bNumConfigurations = 1,
+	.bRESERVED = 0,
+};
+
 /*
  * Configuration descriptor: same comments as above
  * regarding handling USB1 mode.
@@ -271,9 +283,11 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_dev_desc));
 		BUILD_BUG_ON(USB_DT_DEVICE_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
+	case USB_DT_OTHER_SPEED_CONFIG:
 	case USB_DT_CONFIG:
 		dsize = AST_VHUB_CONF_DESC_SIZE;
 		memcpy(ep->buf, &vhub->vhub_conf_desc, dsize);
+		((u8 *)ep->buf)[1] = desc_type;
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_conf_desc));
 		BUILD_BUG_ON(AST_VHUB_CONF_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
@@ -283,6 +297,10 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		BUILD_BUG_ON(dsize > sizeof(vhub->vhub_hub_desc));
 		BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
+	case USB_DT_DEVICE_QUALIFIER:
+		dsize = sizeof(vhub->vhub_qual_desc);
+		memcpy(ep->buf, &vhub->vhub_qual_desc, dsize);
+		break;
 	default:
 		return std_req_stall;
 	}
@@ -428,6 +446,8 @@ enum std_req_rc ast_vhub_std_hub_request(struct ast_vhub_ep *ep,
 		switch (wValue >> 8) {
 		case USB_DT_DEVICE:
 		case USB_DT_CONFIG:
+		case USB_DT_DEVICE_QUALIFIER:
+		case USB_DT_OTHER_SPEED_CONFIG:
 			return ast_vhub_rep_desc(ep, wValue >> 8,
 						 wLength);
 		case USB_DT_STRING:
@@ -1033,6 +1053,10 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	else
 		ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
 
+	/* Initialize vhub Qualifier Descriptor. */
+	memcpy(&vhub->vhub_qual_desc, &ast_vhub_qual_desc,
+		sizeof(vhub->vhub_qual_desc));
+
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 87a5dea12d3c..6b9dfa6e10eb 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -425,6 +425,7 @@ struct ast_vhub {
 	struct ast_vhub_full_cdesc	vhub_conf_desc;
 	struct usb_hub_descriptor	vhub_hub_desc;
 	struct list_head		vhub_str_desc;
+	struct usb_qualifier_descriptor	vhub_qual_desc;
 };
 
 /* Standard request handlers result codes */
-- 
2.25.1

