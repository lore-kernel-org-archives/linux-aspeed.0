From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 Mar 2023 08:45:49 +0100
Subject: [PATCH v3 01/17] gpio: altera: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
Message-ID: <20230215-immutable-chips-v3-1-972542092a77@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-altera.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index b59fae993626..c1599edb3453 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -24,14 +24,12 @@
 * @interrupt_trigger	: specifies the hardware configured IRQ trigger type
 *			  (rising, falling, both, high)
 * @mapped_irq		: kernel mapped irq number.
-* @irq_chip		: IRQ chip configuration
 */
 struct altera_gpio_chip {
 	struct of_mm_gpio_chip mmchip;
 	raw_spinlock_t gpio_lock;
 	int interrupt_trigger;
 	int mapped_irq;
-	struct irq_chip irq_chip;
 };
 
 static void altera_gpio_irq_unmask(struct irq_data *d)
@@ -43,6 +41,7 @@ static void altera_gpio_irq_unmask(struct irq_data *d)
 
 	altera_gc = gpiochip_get_data(irq_data_get_irq_chip_data(d));
 	mm_gc = &altera_gc->mmchip;
+	gpiochip_enable_irq(&mm_gc->gc, irqd_to_hwirq(d));
 
 	raw_spin_lock_irqsave(&altera_gc->gpio_lock, flags);
 	intmask = readl(mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
@@ -68,6 +67,7 @@ static void altera_gpio_irq_mask(struct irq_data *d)
 	intmask &= ~BIT(irqd_to_hwirq(d));
 	writel(intmask, mm_gc->regs + ALTERA_GPIO_IRQ_MASK);
 	raw_spin_unlock_irqrestore(&altera_gc->gpio_lock, flags);
+	gpiochip_disable_irq(&mm_gc->gc, irqd_to_hwirq(d));
 }
 
 /*
@@ -233,6 +233,17 @@ static void altera_gpio_irq_leveL_high_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static const struct irq_chip altera_gpio_irq_chip = {
+	.name = "altera-gpio",
+	.irq_mask = altera_gpio_irq_mask,
+	.irq_unmask = altera_gpio_irq_unmask,
+	.irq_set_type = altera_gpio_irq_set_type,
+	.irq_startup  = altera_gpio_irq_startup,
+	.irq_shutdown = altera_gpio_irq_mask,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int altera_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -278,15 +289,9 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	}
 	altera_gc->interrupt_trigger = reg;
 
-	altera_gc->irq_chip.name = "altera-gpio";
-	altera_gc->irq_chip.irq_mask     = altera_gpio_irq_mask;
-	altera_gc->irq_chip.irq_unmask   = altera_gpio_irq_unmask;
-	altera_gc->irq_chip.irq_set_type = altera_gpio_irq_set_type;
-	altera_gc->irq_chip.irq_startup  = altera_gpio_irq_startup;
-	altera_gc->irq_chip.irq_shutdown = altera_gpio_irq_mask;
-
 	girq = &altera_gc->mmchip.gc.irq;
-	girq->chip = &altera_gc->irq_chip;
+	gpio_irq_chip_set_chip(girq, &altera_gpio_irq_chip);
+
 	if (altera_gc->interrupt_trigger == IRQ_TYPE_LEVEL_HIGH)
 		girq->parent_handler = altera_gpio_irq_leveL_high_handler;
 	else

-- 
2.34.1

