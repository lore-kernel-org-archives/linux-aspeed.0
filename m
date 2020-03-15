From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 15 Mar 2020 12:16:30 -0700
Subject: [PATCH v2 4/6] usb: gadget: aspeed: allow to set device IDs in device
 tree
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Message-ID: <20200315191632.12536-5-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch overrides idVendor, idProduct and bcdDevice fields in vhub
Device Descriptor if according device tree properties are defined.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - update per-vhub device descriptor instance instead of the global
     default descriptor.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 421631d86a17..13fba91aad6a 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -887,6 +887,26 @@ void ast_vhub_hub_reset(struct ast_vhub *vhub)
 	writel(0, vhub->regs + AST_VHUB_EP1_STS_CHG);
 }
 
+static void ast_vhub_of_parse_dev_desc(struct ast_vhub *vhub,
+				       const struct device_node *vhub_np)
+{
+	u16 id;
+	u32 data;
+
+	if (!of_property_read_u32(vhub_np, "vhub-vendor-id", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.idVendor = cpu_to_le16(id);
+	}
+	if (!of_property_read_u32(vhub_np, "vhub-product-id", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.idProduct = cpu_to_le16(id);
+	}
+	if (!of_property_read_u32(vhub_np, "vhub-device-revision", &data)) {
+		id = (u16)data;
+		vhub->vhub_dev_desc.bcdDevice = cpu_to_le16(id);
+	}
+}
+
 static struct usb_gadget_string_container*
 ast_vhub_str_container_alloc(struct ast_vhub *vhub)
 {
@@ -1000,6 +1020,7 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 	/* Initialize vhub Device Descriptor. */
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
 		sizeof(vhub->vhub_dev_desc));
+	ast_vhub_of_parse_dev_desc(vhub, vhub_np);
 
 	/* Initialize vhub Configuration Descriptor. */
 	memcpy(&vhub->vhub_conf_desc, &ast_vhub_conf_desc,
-- 
2.17.1

