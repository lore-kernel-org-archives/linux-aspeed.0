From: Miaoqian Lin <linmq006@gmail.com>
Date: Fri,  3 Jun 2022 16:39:02 +0400
Subject: [PATCH v2] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
Message-ID: <20220603123904.30714-1-linmq006@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

platform_get_irq() returns negative error number instead 0 on failure.
And the doc of platform_get_irq() provides a usage example:

    int irq = platform_get_irq(pdev, 0);
    if (irq < 0)
        return irq;

Fix the check of return value to catch errors correctly.

Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
v1 Link: https://lore.kernel.org/r/20220114064357.18562-1-linmq006 at gmail.com
In previous v1 thread:
Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Patrick Venture <venture@google.com>

v2 Link: https://lore.kernel.org/r/20220603082336.3867-1-linmq006 at gmail.com
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..c4a03b3a5cf8 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
-		return -ENODEV;
+	if (lpc_snoop->irq < 0)
+		return lpc_snoop->irq;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
 			      aspeed_lpc_snoop_irq, IRQF_SHARED,
-- 
2.25.1

