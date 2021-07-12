From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 12 Jul 2021 18:03:14 +0800
Subject: [PATCH v6 7/9] gpio: gpio-aspeed-sgpio: Move irq_chip to aspeed-sgpio
 struct
In-Reply-To: <20210712100317.23298-1-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
Message-ID: <20210712100317.23298-8-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The current design initializes irq->chip from a global irqchip struct,
which causes multiple sgpio devices use the same irq_chip.
The patch moves irq_chip to aspeed_sgpio struct for initializing
irq_chip from their private gpio struct.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 9b809c28f842..6b3695197c97 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -29,6 +29,7 @@ struct aspeed_sgpio_pdata {
 
 struct aspeed_sgpio {
 	struct gpio_chip chip;
+	struct irq_chip intc;
 	struct clk *pclk;
 	spinlock_t lock;
 	void __iomem *base;
@@ -403,14 +404,6 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
-static struct irq_chip aspeed_sgpio_irqchip = {
-	.name       = "aspeed-sgpio",
-	.irq_ack    = aspeed_sgpio_irq_ack,
-	.irq_mask   = aspeed_sgpio_irq_mask,
-	.irq_unmask = aspeed_sgpio_irq_unmask,
-	.irq_set_type   = aspeed_sgpio_set_type,
-};
-
 static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 				   struct platform_device *pdev)
 {
@@ -433,8 +426,14 @@ static int aspeed_sgpio_setup_irqs(struct aspeed_sgpio *gpio,
 		iowrite32(0xffffffff, bank_reg(gpio, bank, reg_irq_status));
 	}
 
+	gpio->intc.name = dev_name(&pdev->dev);
+	gpio->intc.irq_ack = aspeed_sgpio_irq_ack;
+	gpio->intc.irq_mask = aspeed_sgpio_irq_mask;
+	gpio->intc.irq_unmask = aspeed_sgpio_irq_unmask;
+	gpio->intc.irq_set_type = aspeed_sgpio_set_type;
+
 	irq = &gpio->chip.irq;
-	irq->chip = &aspeed_sgpio_irqchip;
+	irq->chip = &gpio->intc;
 	irq->init_valid_mask = aspeed_sgpio_irq_init_valid_mask;
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
-- 
2.17.1

