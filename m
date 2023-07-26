From: Yangtao Li <frank.li@vivo.com>
Date: Wed, 26 Jul 2023 19:37:55 +0800
Subject: [PATCH 09/30] usb: gadget: aspeed_udc: Convert to devm_platform_ioremap_resource()
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Message-ID: <20230726113816.888-9-frank.li@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 01968e2167f9..2ef89a442f50 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1468,7 +1468,6 @@ static int ast_udc_probe(struct platform_device *pdev)
 	enum usb_device_speed max_speed;
 	struct device *dev = &pdev->dev;
 	struct ast_udc_dev *udc;
-	struct resource *res;
 	int rc;
 
 	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
@@ -1484,8 +1483,7 @@ static int ast_udc_probe(struct platform_device *pdev)
 	udc->gadget.name = "aspeed-udc";
 	udc->gadget.dev.init_name = "gadget";
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	udc->reg = devm_ioremap_resource(&pdev->dev, res);
+	udc->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(udc->reg)) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
 		return PTR_ERR(udc->reg);
-- 
2.39.0

