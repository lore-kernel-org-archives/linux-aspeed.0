From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Tue, 18 Feb 2020 15:56:00 -0800
Subject: [PATCH 2/2] usb: gadget: aspeed: fixup usb1 device descriptor at init
 time
In-Reply-To: <20200218235600.6763-1-rentao.bupt@gmail.com>
References: <20200218235600.6763-1-rentao.bupt@gmail.com>
Message-ID: <20200218235600.6763-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This patch moves fixup-usb1-device-descriptor logic from get_descriptor
handler to "ast_vhub_fixup_dev_desc" function so the device descriptor
is only patched once (at vhub init time).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 4e3ef83283a6..b8bf54b12adc 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -76,13 +76,6 @@ static struct usb_device_descriptor ast_vhub_dev_desc = {
 	.bNumConfigurations	= 1,
 };
 
-/* Patches to the above when forcing USB1 mode */
-static void ast_vhub_patch_dev_desc_usb1(struct usb_device_descriptor *desc)
-{
-	desc->bcdUSB = cpu_to_le16(0x0100);
-	desc->bDeviceProtocol = 0;
-}
-
 /*
  * Configuration descriptor: same comments as above
  * regarding handling USB1 mode.
@@ -316,10 +309,6 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 	if (len > dsize)
 		len = dsize;
 
-	/* Patch it if forcing USB1 */
-	if (desc_type == USB_DT_DEVICE && ep->vhub->force_usb1)
-		ast_vhub_patch_dev_desc_usb1(ep->buf);
-
 	/* Shoot it from the EP buffer */
 	return ast_vhub_reply(ep, NULL, len);
 }
@@ -878,6 +867,15 @@ static void ast_vhub_fixup_dev_desc(struct ast_vhub *vhub)
 		if (of_str[id])
 			ast_vhub_str_array[i].s = of_str[id];
 	}
+
+	/*
+	 * Update USB Release Number and Protocol code if vhub is running
+	 * at USB 1.x speed.
+	 */
+	if (vhub->force_usb1) {
+		ast_vhub_dev_desc.bcdUSB = cpu_to_le16(0x0100);
+		ast_vhub_dev_desc.bDeviceProtocol = 0;
+	}
 }
 
 void ast_vhub_init_hub(struct ast_vhub *vhub)
-- 
2.17.1

