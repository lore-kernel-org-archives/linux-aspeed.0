From: Yuan Can <yuancan@huawei.com>
Date: Fri, 25 Nov 2022 09:28:33 +0000
Subject: [PATCH] usb: gadget: aspeed_udc: Add checks for dma_alloc_coherent()
Message-ID: <20221125092833.74822-1-yuancan@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

As the dma_alloc_coherent() may return NULL, the return value needs to be
checked to avoid NULL poineter dereference.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 01968e2167f9..7dc2457c7460 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1516,6 +1516,10 @@ static int ast_udc_probe(struct platform_device *pdev)
 					  AST_UDC_EP_DMA_SIZE *
 					  AST_UDC_NUM_ENDPOINTS,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
+	if (!udc->ep0_buf) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	udc->gadget.max_speed = USB_SPEED_HIGH;
-- 
2.17.1

