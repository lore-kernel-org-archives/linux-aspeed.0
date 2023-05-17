From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 18 May 2023 01:01:27 +0200
Subject: [PATCH 25/97] usb: gadget: aspeed: Convert to platform remove callback returning void
In-Reply-To: <20230517230239.187727-1-u.kleine-koenig@pengutronix.de>
References: <20230517230239.187727-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230517230239.187727-26-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 86398a04a012..16f2db8c4a2b 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -253,14 +253,14 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	       vhub->regs + AST_VHUB_IER);
 }
 
-static int ast_vhub_remove(struct platform_device *pdev)
+static void ast_vhub_remove(struct platform_device *pdev)
 {
 	struct ast_vhub *vhub = platform_get_drvdata(pdev);
 	unsigned long flags;
 	int i;
 
 	if (!vhub || !vhub->regs)
-		return 0;
+		return;
 
 	/* Remove devices */
 	for (i = 0; i < vhub->max_ports; i++)
@@ -289,8 +289,6 @@ static int ast_vhub_remove(struct platform_device *pdev)
 				  vhub->ep0_bufs,
 				  vhub->ep0_bufs_dma);
 	vhub->ep0_bufs = NULL;
-
-	return 0;
 }
 
 static int ast_vhub_probe(struct platform_device *pdev)
@@ -431,7 +429,7 @@ MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);
 
 static struct platform_driver ast_vhub_driver = {
 	.probe		= ast_vhub_probe,
-	.remove		= ast_vhub_remove,
+	.remove_new	= ast_vhub_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.of_match_table	= ast_vhub_dt_ids,
-- 
2.39.2

