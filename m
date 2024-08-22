From: Lei Liu <liulei.rjpt@vivo.com>
Date: Thu, 22 Aug 2024 12:07:27 +0800
Subject: [PATCH v1 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
In-Reply-To: <20240822040734.29412-1-liulei.rjpt@vivo.com>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
Message-ID: <20240822040734.29412-3-liulei.rjpt@vivo.com>
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

---
v0 -> v1
Incorrect usage of clk_prepare_enable() should be 
corrected to devm_clk_get_enabled().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 1a6317e4b2a3..6e99e75f1acb 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
 	if (udc->gpiod)
 		gpiod_direction_output(udc->gpiod, 0);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk))
 		return PTR_ERR(udc->clk);
 
-	retval = clk_prepare(udc->clk);
-	if (retval)
-		return retval;
-
 	udc->vbus_sensed = 0;
 
 	the_controller = udc;
-- 
2.34.1

