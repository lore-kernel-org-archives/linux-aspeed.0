From: Yangtao Li <frank.li@vivo.com>
Date: Wed, 26 Jul 2023 19:37:52 +0800
Subject: [PATCH 06/30] usb: gadget: aspeed: Use devm_platform_get_and_ioremap_resource()
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Message-ID: <20230726113816.888-6-frank.li@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 16f2db8c4a2b..f60a019bb173 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -328,8 +328,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
 				      VHUB_IRQ_DEV1_BIT);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
+	vhub->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(vhub->regs)) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
 		return PTR_ERR(vhub->regs);
-- 
2.39.0

