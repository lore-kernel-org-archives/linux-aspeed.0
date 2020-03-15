From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 15 Mar 2020 12:16:31 -0700
Subject: [PATCH v2 5/6] usb: gadget: aspeed: fixup usb1 device descriptor at
 init time
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Message-ID: <20200315191632.12536-6-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This patch moves patch-usb1-dev-desc logic from get-descriptor handler
to "ast_vhub_fixup_usb1_dev_desc" function so the code is executed only
once (at vhub initial time).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - update per-vhub device descriptor instance instead of the global
     default descriptor.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 13fba91aad6a..6497185ec4e7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -73,13 +73,6 @@ static const struct usb_device_descriptor ast_vhub_dev_desc = {
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
@@ -303,10 +296,6 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 	if (len > dsize)
 		len = dsize;
 
-	/* Patch it if forcing USB1 */
-	if (desc_type == USB_DT_DEVICE && ep->vhub->force_usb1)
-		ast_vhub_patch_dev_desc_usb1(ep->buf);
-
 	/* Shoot it from the EP buffer */
 	return ast_vhub_reply(ep, NULL, len);
 }
@@ -907,6 +896,12 @@ static void ast_vhub_of_parse_dev_desc(struct ast_vhub *vhub,
 	}
 }
 
+static void ast_vhub_fixup_usb1_dev_desc(struct ast_vhub *vhub)
+{
+	vhub->vhub_dev_desc.bcdUSB = cpu_to_le16(0x0100);
+	vhub->vhub_dev_desc.bDeviceProtocol = 0;
+}
+
 static struct usb_gadget_string_container*
 ast_vhub_str_container_alloc(struct ast_vhub *vhub)
 {
@@ -1021,6 +1016,8 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
 		sizeof(vhub->vhub_dev_desc));
 	ast_vhub_of_parse_dev_desc(vhub, vhub_np);
+	if (vhub->force_usb1)
+		ast_vhub_fixup_usb1_dev_desc(vhub);
 
 	/* Initialize vhub Configuration Descriptor. */
 	memcpy(&vhub->vhub_conf_desc, &ast_vhub_conf_desc,
-- 
2.17.1

