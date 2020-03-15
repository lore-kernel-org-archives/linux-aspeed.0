From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 15 Mar 2020 12:16:29 -0700
Subject: [PATCH v2 3/6] usb: gadget: aspeed: allow to set usb strings in
 device tree
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Message-ID: <20200315191632.12536-4-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

If "vhub,string-descriptor" device tree property is defined, the driver
will load string descriptors from device tree; otherwise, the default
string descriptors will be used.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2:
   - the patch is added into the series since v2.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 58 +++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 35edf37553f0..421631d86a17 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -941,9 +941,61 @@ static int ast_vhub_str_alloc_add(struct ast_vhub *vhub,
 	return 0;
 }
 
+static const struct {
+	const char *name;
+	u8 id;
+} str_id_map[] = {
+	{"manufacturer",	AST_VHUB_STR_MANUF},
+	{"product",		AST_VHUB_STR_PRODUCT},
+	{"serial-number",	AST_VHUB_STR_SERIAL},
+	{},
+};
+
+static int ast_vhub_of_parse_str_desc(struct ast_vhub *vhub,
+				      const struct device_node *desc_np)
+{
+	u32 langid;
+	int ret = 0;
+	int i, offset;
+	const char *str;
+	struct device_node *child;
+	struct usb_string str_array[AST_VHUB_STR_INDEX_MAX];
+	struct usb_gadget_strings lang_str = {
+		.strings = (struct usb_string *)str_array,
+	};
+
+	for_each_child_of_node(desc_np, child) {
+		if (of_property_read_u32(child, "reg", &langid))
+			continue; /* no language identifier specified */
+
+		if (!usb_validate_langid(langid))
+			continue; /* invalid language identifier */
+
+		lang_str.language = langid;
+		for (i = offset = 0; str_id_map[i].name; i++) {
+			str = of_get_property(child, str_id_map[i].name, NULL);
+			if (str) {
+				str_array[offset].s = str;
+				str_array[offset].id = str_id_map[i].id;
+				offset++;
+			}
+		}
+		str_array[offset].id = 0;
+		str_array[offset].s = NULL;
+
+		ret = ast_vhub_str_alloc_add(vhub, &lang_str);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int ast_vhub_init_desc(struct ast_vhub *vhub)
 {
 	int ret;
+	struct device_node *desc_np;
+	const struct device_node *vhub_np = vhub->pdev->dev.of_node;
 
 	/* Initialize vhub Device Descriptor. */
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
@@ -960,7 +1012,11 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 
 	/* Initialize vhub String Descriptors. */
 	INIT_LIST_HEAD(&vhub->vhub_str_desc);
-	ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
+	desc_np = of_get_child_by_name(vhub_np, "vhub-strings");
+	if (desc_np)
+		ret = ast_vhub_of_parse_str_desc(vhub, desc_np);
+	else
+		ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
 
 	return ret;
 }
-- 
2.17.1

