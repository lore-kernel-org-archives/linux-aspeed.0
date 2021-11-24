From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 24 Nov 2021 17:43:48 +0800
Subject: [PATCH] irqchip: Replace update_bits with write_bits.
Message-ID: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The interrupt status bits are cleared by writing 1, we should force a
write to clear the interrupt without checking if the value has changed.

Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index f3c6855a4cef..18b77c3e6db4 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -76,8 +76,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 		generic_handle_domain_irq(scu_ic->irq_domain,
 					  bit - scu_ic->irq_shift);
 
-		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
-				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
+				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.25.1

