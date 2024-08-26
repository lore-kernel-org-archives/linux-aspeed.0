From: Lei Liu <liulei.rjpt@vivo.com>
Date: Mon, 26 Aug 2024 16:21:39 +0800
Subject: [PATCH v3 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Message-ID: <20240826082140.2311-1-liulei.rjpt@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611aaa..a362e31f7550 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1459,8 +1459,6 @@ static void ast_udc_remove(struct platform_device *pdev)
 	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
 	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
 
-	clk_disable_unprepare(udc->clk);
-
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	if (udc->ep0_buf)
@@ -1500,16 +1498,11 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, udc);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		rc = PTR_ERR(udc->clk);
 		goto err;
 	}
-	rc = clk_prepare_enable(udc->clk);
-	if (rc) {
-		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
-		goto err;
-	}
 
 	/* Check if we need to limit the HW to USB1 */
 	max_speed = usb_get_maximum_speed(&pdev->dev);
-- 
2.34.1

