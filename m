From: tangbin <tangbin@cmss.chinamobile.com>
Date: Tue,  3 Sep 2024 20:31:52 +0800
Subject: [PATCH] usb: gadget: aspeed_udc: use the defined variable to simplify code
Message-ID: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the defined variable 'dev' to make the code cleaner.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611..702d4806c 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1479,7 +1479,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	struct ast_udc_dev *udc;
 	int rc;
 
-	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
+	udc = devm_kzalloc(dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
 	if (!udc)
 		return -ENOMEM;
 
@@ -1494,32 +1494,32 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	udc->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(udc->reg)) {
-		dev_err(&pdev->dev, "Failed to map resources\n");
+		dev_err(dev, "Failed to map resources\n");
 		return PTR_ERR(udc->reg);
 	}
 
 	platform_set_drvdata(pdev, udc);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		rc = PTR_ERR(udc->clk);
 		goto err;
 	}
 	rc = clk_prepare_enable(udc->clk);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
+		dev_err(dev, "Failed to enable clock (0x%x)\n", rc);
 		goto err;
 	}
 
 	/* Check if we need to limit the HW to USB1 */
-	max_speed = usb_get_maximum_speed(&pdev->dev);
+	max_speed = usb_get_maximum_speed(dev);
 	if (max_speed != USB_SPEED_UNKNOWN && max_speed < USB_SPEED_HIGH)
 		udc->force_usb1 = true;
 
 	/*
 	 * Allocate DMA buffers for all EPs in one chunk
 	 */
-	udc->ep0_buf = dma_alloc_coherent(&pdev->dev,
+	udc->ep0_buf = dma_alloc_coherent(dev,
 					  AST_UDC_EP_DMA_SIZE *
 					  AST_UDC_NUM_ENDPOINTS,
 					  &udc->ep0_buf_dma, GFP_KERNEL);
@@ -1534,7 +1534,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	 */
 	udc->desc_mode = AST_UDC_DESC_MODE;
 
-	dev_info(&pdev->dev, "DMA %s\n", udc->desc_mode ?
+	dev_info(dev, "DMA %s\n", udc->desc_mode ?
 		 "descriptor mode" : "single mode");
 
 	INIT_LIST_HEAD(&udc->gadget.ep_list);
@@ -1556,26 +1556,26 @@ static int ast_udc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	rc = devm_request_irq(&pdev->dev, udc->irq, ast_udc_isr, 0,
+	rc = devm_request_irq(dev, udc->irq, ast_udc_isr, 0,
 			      KBUILD_MODNAME, udc);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to request interrupt\n");
+		dev_err(dev, "Failed to request interrupt\n");
 		goto err;
 	}
 
-	rc = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
+	rc = usb_add_gadget_udc(dev, &udc->gadget);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to add gadget udc\n");
+		dev_err(dev, "Failed to add gadget udc\n");
 		goto err;
 	}
 
-	dev_info(&pdev->dev, "Initialized udc in USB%s mode\n",
+	dev_info(dev, "Initialized udc in USB%s mode\n",
 		 udc->force_usb1 ? "1" : "2");
 
 	return 0;
 
 err:
-	dev_err(&pdev->dev, "Failed to udc probe, rc:0x%x\n", rc);
+	dev_err(dev, "Failed to udc probe, rc:0x%x\n", rc);
 	ast_udc_remove(pdev);
 
 	return rc;
-- 
2.33.0



