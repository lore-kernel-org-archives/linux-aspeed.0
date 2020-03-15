From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 15 Mar 2020 12:16:28 -0700
Subject: [PATCH v2 2/6] usb: gadget: add "usb_validate_langid" function
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Message-ID: <20200315191632.12536-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The USB LANGID validation code in "check_user_usb_string" function is
moved to "usb_validate_langid" function which can be used by other usb
gadget drivers.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2:
   - the patch is added into the series since v2.

 drivers/usb/gadget/configfs.c  | 14 +-------------
 drivers/usb/gadget/usbstring.c | 24 ++++++++++++++++++++++++
 include/linux/usb/gadget.h     |  3 +++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 32b637e3e1fa..822ef0470c5f 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -13,8 +13,6 @@
 int check_user_usb_string(const char *name,
 		struct usb_gadget_strings *stringtab_dev)
 {
-	unsigned primary_lang;
-	unsigned sub_lang;
 	u16 num;
 	int ret;
 
@@ -22,17 +20,7 @@ int check_user_usb_string(const char *name,
 	if (ret)
 		return ret;
 
-	primary_lang = num & 0x3ff;
-	sub_lang = num >> 10;
-
-	/* simple sanity check for valid langid */
-	switch (primary_lang) {
-	case 0:
-	case 0x62 ... 0xfe:
-	case 0x100 ... 0x3ff:
-		return -EINVAL;
-	}
-	if (!sub_lang)
+	if (!usb_validate_langid(num))
 		return -EINVAL;
 
 	stringtab_dev->language = num;
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 7c24d1ce1088..58a4d3325090 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -65,3 +65,27 @@ usb_gadget_get_string (const struct usb_gadget_strings *table, int id, u8 *buf)
 	return buf [0];
 }
 EXPORT_SYMBOL_GPL(usb_gadget_get_string);
+
+/**
+ * usb_validate_langid - validate usb language identifiers
+ * @lang: usb language identifier
+ *
+ * Returns true for valid language identifier, otherwise false.
+ */
+bool usb_validate_langid(u16 langid)
+{
+	u16 primary_lang = langid & 0x3ff;	/* bit [9:0] */
+	u16 sub_lang = langid >> 10;		/* bit [15:10] */
+
+	switch (primary_lang) {
+	case 0:
+	case 0x62 ... 0xfe:
+	case 0x100 ... 0x3ff:
+		return false;
+	}
+	if (!sub_lang)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_validate_langid);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 124462d65eac..1a05227bdfae 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -773,6 +773,9 @@ struct usb_gadget_string_container {
 /* put descriptor for string with that id into buf (buflen >= 256) */
 int usb_gadget_get_string(const struct usb_gadget_strings *table, int id, u8 *buf);
 
+/* check if the given language identifier is valid */
+bool usb_validate_langid(u16 langid);
+
 /*-------------------------------------------------------------------------*/
 
 /* utility to simplify managing config descriptors */
-- 
2.17.1

