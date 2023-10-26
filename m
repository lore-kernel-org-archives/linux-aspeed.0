From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 27 Oct 2023 00:17:02 +0200
Subject: [PATCH] usb: gadget: aspeed_udc: Convert to platform remove callback returning void
Message-ID: <20231026221701.2521483-2-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

ast_udc_remove() is one of these functions that return an error code
after doing only a partial cleanup. Replace the core's error message by
a more drastic one and still convert the driver to .remove_new().
Note the only semantic change here is the changed error message.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this driver is one of those that got the remove function wrong. This is
a general problem of the udc drivers and also affects

 drivers/usb/gadget/udc/at91_udc.c
 drivers/usb/gadget/udc/fsl_udc_core.c
 drivers/usb/gadget/udc/gr_udc.c
 drivers/usb/gadget/udc/lpc32xx_udc.c
 drivers/usb/gadget/udc/pxa25x_udc.c

. For now I only converted the aspeed driver, but once this patch is in
an acceptable state, I'd convert all these drivers in the same way.

Fixing the resource leak and the oops is something I'll not address.
This should be done by someone who cares for these drivers and has the
actual hardware.

Best regards
Uwe

 drivers/usb/gadget/udc/aspeed_udc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 2ef89a442f50..3916c8e2ba01 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1432,15 +1432,24 @@ static void ast_udc_init_hw(struct ast_udc_dev *udc)
 	ast_udc_write(udc, 0, AST_UDC_EP0_CTRL);
 }
 
-static int ast_udc_remove(struct platform_device *pdev)
+static void ast_udc_remove(struct platform_device *pdev)
 {
 	struct ast_udc_dev *udc = platform_get_drvdata(pdev);
 	unsigned long flags;
 	u32 ctrl;
 
 	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
+	if (udc->driver) {
+		/*
+		 * This is broken as only some cleanup is skipped, *udev is
+		 * freed and the register mapping goes away. Any further usage
+		 * probably crashes. Also the device is unbound, so the skipped
+		 * cleanup is never catched up later.
+		 */
+		dev_alert(&pdev->dev,
+			  "Driver is busy and still going away. Fasten your seat belts!\n");
+		return;
+	}
 
 	spin_lock_irqsave(&udc->lock, flags);
 
@@ -1459,8 +1468,6 @@ static int ast_udc_remove(struct platform_device *pdev)
 				  udc->ep0_buf_dma);
 
 	udc->ep0_buf = NULL;
-
-	return 0;
 }
 
 static int ast_udc_probe(struct platform_device *pdev)
@@ -1581,7 +1588,7 @@ MODULE_DEVICE_TABLE(of, ast_udc_of_dt_ids);
 
 static struct platform_driver ast_udc_driver = {
 	.probe			= ast_udc_probe,
-	.remove			= ast_udc_remove,
+	.remove_new		= ast_udc_remove,
 	.driver			= {
 		.name			= KBUILD_MODNAME,
 		.of_match_table		= ast_udc_of_dt_ids,

base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
-- 
2.42.0

