From: Yan Zhen <yanzhen@vivo.com>
Date: Fri, 20 Sep 2024 16:47:05 +0800
Subject: [PATCH v1] usb: gadget: udc: fix typo in the comment
Message-ID: <20240920084708.1967059-1-yanzhen@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'trasmit' -> 'transmit',
'structres' -> 'structures',
'divisble' -> 'divisible',
'trainsmited' -> 'transmitted',
'packect's' -> 'packet's',
'timmer' -> 'timer',
'devcice' -> 'device',
'delelate' -> 'delegate',
'lengh' -> 'length'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c    | 2 +-
 drivers/usb/gadget/udc/dummy_hcd.c     | 2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c    | 6 +++---
 drivers/usb/gadget/udc/fusb300_udc.c   | 2 +-
 drivers/usb/gadget/udc/net2272.c       | 2 +-
 drivers/usb/gadget/udc/renesas_usbf.c  | 2 +-
 drivers/usb/gadget/udc/snps_udc_core.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611aaa..5b62f43b36f7 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -156,7 +156,7 @@
 #define AST_EP_DMA_DESC_PID_DATA1	(2 << 14)
 #define AST_EP_DMA_DESC_PID_MDATA	(3 << 14)
 #define EP_DESC1_IN_LEN(x)		((x) & 0x1fff)
-#define AST_EP_DMA_DESC_MAX_LEN		(7680) /* Max packet length for trasmit in 1 desc */
+#define AST_EP_DMA_DESC_MAX_LEN		(7680) /* Max packet length for transmit in 1 desc */
 
 struct ast_udc_request {
 	struct usb_request	req;
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index ff7bee78bcc4..f759bfc2f243 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -80,7 +80,7 @@ module_param_named(num, mod_data.num, uint, S_IRUGO);
 MODULE_PARM_DESC(num, "number of emulated controllers");
 /*-------------------------------------------------------------------------*/
 
-/* gadget side driver data structres */
+/* gadget side driver data structures */
 struct dummy_ep {
 	struct list_head		queue;
 	unsigned long			last_io;	/* jiffies timestamp */
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 4e88681a79b6..55f49d01f9c5 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -511,7 +511,7 @@ static int qe_ep_register_init(struct qe_udc *udc, unsigned char pipe_num)
 	out_8(&epparam->tbmr, rtfcr);
 
 	tmp = (u16)(ep->ep.maxpacket + USB_CRC_SIZE);
-	/* MRBLR must be divisble by 4 */
+	/* MRBLR must be divisible by 4 */
 	tmp = (u16)(((tmp >> 2) << 2) + 4);
 	out_be16(&epparam->mrblr, tmp);
 
@@ -1413,7 +1413,7 @@ static int ep_txframe_handle(struct qe_ep *ep)
 	return 0;
 }
 
-/* confirm the already trainsmited bd */
+/* confirm the already transmitted bd */
 static int qe_ep_txconf(struct qe_ep *ep)
 {
 	struct qe_bd __iomem *bd;
@@ -2196,7 +2196,7 @@ static int tx_irq(struct qe_udc *udc)
 }
 
 
-/* setup packect's rx is handle in the function too */
+/* setup packet's rx is handle in the function too */
 static void rx_irq(struct qe_udc *udc)
 {
 	struct qe_ep *ep;
diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 873265634ccc..8558ba4b8a8b 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1297,7 +1297,7 @@ static void init_controller(struct fusb300 *fusb300)
 	reg |= val;
 	iowrite32(reg, fusb300->reg + FUSB300_OFFSET_HSCR);
 
-	/*set u1 u2 timmer*/
+	/*set u1 u2 timer*/
 	fusb300_set_u2_timeout(fusb300, 0xff);
 	fusb300_set_u1_timeout(fusb300, 0xff);
 
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 19bbc38f3d35..5e398180cded 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2097,7 +2097,7 @@ static irqreturn_t net2272_irq(int irq, void *_dev)
 	}
 	/* check dma interrupts */
 #endif
-	/* Platform/devcice interrupt handler */
+	/* Platform/device interrupt handler */
 #if !defined(PLX_PCI_RDK)
 	net2272_handle_stat1_irqs(dev, net2272_read(dev, IRQSTAT1));
 	net2272_handle_stat0_irqs(dev, net2272_read(dev, IRQSTAT0));
diff --git a/drivers/usb/gadget/udc/renesas_usbf.c b/drivers/usb/gadget/udc/renesas_usbf.c
index 657f265ac7cc..6de09ece8545 100644
--- a/drivers/usb/gadget/udc/renesas_usbf.c
+++ b/drivers/usb/gadget/udc/renesas_usbf.c
@@ -2482,7 +2482,7 @@ static int usbf_handle_ep0_setup(struct usbf_ep *ep0)
 	ep0->delayed_status = 0;
 
 	if ((crq.ctrlreq.bRequestType & USB_TYPE_MASK) != USB_TYPE_STANDARD) {
-		/* This is not a USB standard request -> delelate */
+		/* This is not a USB standard request -> delegate */
 		goto delegate;
 	}
 
diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 2fc5d4d277bc..25f418d2c232 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -2707,7 +2707,7 @@ static irqreturn_t udc_control_in_isr(struct udc *dev)
 					/* write fifo */
 					udc_txfifo_write(ep, &req->req);
 
-					/* lengh bytes transferred */
+					/* length bytes transferred */
 					len = req->req.length - req->req.actual;
 					if (len > ep->ep.maxpacket)
 						len = ep->ep.maxpacket;
-- 
2.34.1

