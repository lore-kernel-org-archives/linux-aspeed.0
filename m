From: Tom Rix <trix@redhat.com>
Date: Sun, 10 Apr 2022 11:08:28 -0400
Subject: [PATCH] usb: gadget: udc: clean up comments
Message-ID: <20220410150828.1891123-1-trix@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

SPDX
*.h use /* */ style comments

For double words, remove
with, also

Spelling replacements
wayt to way
wakup to wakeup
Contrl to Control
cheks to checks
initiaization to initialization
dyanmic to dynamic

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
 drivers/usb/gadget/udc/at91_udc.c         | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
 drivers/usb/gadget/udc/core.c             | 4 ++--
 drivers/usb/gadget/udc/trace.h            | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.h b/drivers/usb/gadget/udc/amd5536udc.h
index 055436016503..e670d251e16f 100644
--- a/drivers/usb/gadget/udc/amd5536udc.h
+++ b/drivers/usb/gadget/udc/amd5536udc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller
  *
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..8eba6d744090 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -180,7 +180,7 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	* We do *NOT* set the VHUB_CTRL_CLK_STOP_SUSPEND bit
 	* to stop the logic clock during suspend because
 	* it causes the registers to become inaccessible and
-	* we haven't yet figured out a good wayt to bring the
+	* we haven't yet figured out a good way to bring the
 	* controller back into life to issue a wakeup.
 	*/
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
index b4cf46249fea..3c64c00546ec 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
@@ -366,7 +366,7 @@ static int ast_vhub_ep0_queue(struct usb_ep* u_ep, struct usb_request *u_req,
 	struct device *dev = &vhub->pdev->dev;
 	unsigned long flags;
 
-	/* Paranoid cheks */
+	/* Paranoid checks */
 	if (!u_req || (!u_req->complete && !req->internal)) {
 		dev_warn(dev, "Bogus EP0 request ! u_req=%p\n", u_req);
 		if (u_req) {
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 65cd4e46f031..70001decf8c0 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -551,7 +551,7 @@ void ast_vhub_device_connect(struct ast_vhub *vhub,
 					  0, true);
 
 	/*
-	 * If the hub is set to wakup the host on connection events
+	 * If the hub is set to wakeup the host on connection events
 	 * then send a wakeup.
 	 */
 	if (vhub->wakeup_en)
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
index 6b9dfa6e10eb..81b92d683c35 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
+++ b/drivers/usb/gadget/udc/aspeed-vhub/vhub.h
@@ -23,9 +23,9 @@
 #define AST_VHUB_USBSTS		0x24	/* USB Status Register */
 #define AST_VHUB_EP_TOGGLE	0x28	/* Programmable Endpoint Pool Data Toggle Value Set */
 #define AST_VHUB_ISO_FAIL_ACC	0x2C	/* Isochronous Transaction Fail Accumulator */
-#define AST_VHUB_EP0_CTRL	0x30	/* Endpoint 0 Contrl/Status Register */
+#define AST_VHUB_EP0_CTRL	0x30	/* Endpoint 0 Control/Status Register */
 #define AST_VHUB_EP0_DATA	0x34	/* Base Address of Endpoint 0 In/OUT Data Buffer Register */
-#define AST_VHUB_EP1_CTRL	0x38	/* Endpoint 1 Contrl/Status Register */
+#define AST_VHUB_EP1_CTRL	0x38	/* Endpoint 1 Control/Status Register */
 #define AST_VHUB_EP1_STS_CHG	0x3C	/* Endpoint 1 Status Change Bitmap Data */
 #define AST_VHUB_SETUP0		0x80	/* Root Device Setup Data Buffer0 */
 #define AST_VHUB_SETUP1		0x84	/* Root Device Setup Data Buffer1 */
diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 728987280373..c80d0902bb30 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -994,7 +994,7 @@ static const struct usb_gadget_ops at91_udc_ops = {
 	.udc_stop		= at91_stop,
 
 	/*
-	 * VBUS-powered devices may also also want to support bigger
+	 * VBUS-powered devices may also want to support bigger
 	 * power budgets after an appropriate SET_CONFIGURATION.
 	 */
 	/* .vbus_power		= at91_vbus_power, */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 9849e0c86e23..223e08e53f94 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -296,7 +296,7 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 			for (i = 1; i < bdc->num_eps; ++i)
 				bdc->bdc_ep_array[i]->flags = 0;
 	} else {
-		/* One time initiaization only */
+		/* One time initialization only */
 		/* Enable status report function pointers */
 		bdc->sr_handler[0] = bdc_sr_xsf;
 		bdc->sr_handler[1] = bdc_sr_uspc;
@@ -361,7 +361,7 @@ int bdc_reinit(struct bdc *bdc)
 	return ret;
 }
 
-/* Allocate all the dyanmic memory */
+/* Allocate all the dynamic memory */
 static int bdc_mem_alloc(struct bdc *bdc)
 {
 	u32 page_size;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 85b194011a16..bf472478239b 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(usb_ep_disable);
 
 /**
  * usb_ep_alloc_request - allocate a request object to use with this endpoint
- * @ep:the endpoint to be used with with the request
+ * @ep:the endpoint to be used with the request
  * @gfp_flags:GFP_* flags to use
  *
  * Request objects must be allocated with this call, since they normally
@@ -897,7 +897,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
 
 /**
  * usb_gadget_giveback_request - give the request back to the gadget layer
- * @ep: the endpoint to be used with with the request
+ * @ep: the endpoint to be used with the request
  * @req: the request being given back
  *
  * This is called by device controller drivers in order to return the
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 98584f6b6c66..75987cae2a15 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * udc.c - Core UDC Framework
  *
-- 
2.27.0

