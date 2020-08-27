From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 27 Aug 2020 09:07:42 +0200
Subject: [PATCH 1/2] EDAC/aspeed: Fix handling of platform_get_irq() error
Message-ID: <20200827070743.26628-1-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/edac/aspeed_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index b194658b8b5c..fbec28dc661d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -209,8 +209,8 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 	/* register interrupt handler */
 	irq = platform_get_irq(pdev, 0);
 	dev_dbg(&pdev->dev, "got irq %d\n", irq);
-	if (!irq)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
 			      DRV_NAME, ctx);
-- 
2.17.1

