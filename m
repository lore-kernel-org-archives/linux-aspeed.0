From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Feb 2023 10:37:08 +0100
Subject: [PATCH 07/17] gpio: eic_sprd: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
Message-ID: <20230215-immutable-chips-v1-7-51a8f224a5d0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-eic-sprd.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 8d722e026e9c..695d74ba55f0 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
 /* EIC registers definition */
@@ -91,7 +92,7 @@ enum sprd_eic_type {
 
 struct sprd_eic {
 	struct gpio_chip chip;
-	struct irq_chip intc;
+	struct device *dev;
 	void __iomem *base[SPRD_EIC_MAX_BANK];
 	enum sprd_eic_type type;
 	spinlock_t lock;
@@ -255,6 +256,7 @@ static void sprd_eic_irq_mask(struct irq_data *data)
 	default:
 		dev_err(chip->parent, "Unsupported EIC type.\n");
 	}
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void sprd_eic_irq_unmask(struct irq_data *data)
@@ -263,6 +265,7 @@ static void sprd_eic_irq_unmask(struct irq_data *data)
 	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
 	u32 offset = irqd_to_hwirq(data);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
 	switch (sprd_eic->type) {
 	case SPRD_EIC_DEBOUNCE:
 		sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IE, 1);
@@ -564,6 +567,24 @@ static void sprd_eic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(ic, desc);
 }
 
+static void sprd_eic_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+
+	seq_printf(p, dev_name(sprd_eic->dev));
+}
+
+static const struct irq_chip sprd_eic_irq_chip = {
+	.irq_ack = sprd_eic_irq_ack,
+	.irq_mask = sprd_eic_irq_mask,
+	.irq_unmask = sprd_eic_irq_unmask,
+	.irq_set_type = sprd_eic_irq_set_type,
+	.irq_print_chip = sprd_eic_irq_print_chip,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int sprd_eic_probe(struct platform_device *pdev)
 {
 	const struct sprd_eic_variant_data *pdata;
@@ -584,6 +605,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sprd_eic->lock);
 	sprd_eic->type = pdata->type;
+	sprd_eic->dev = &pdev->dev;
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
 	if (sprd_eic->irq < 0)
@@ -626,15 +648,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		break;
 	}
 
-	sprd_eic->intc.name = dev_name(&pdev->dev);
-	sprd_eic->intc.irq_ack = sprd_eic_irq_ack;
-	sprd_eic->intc.irq_mask = sprd_eic_irq_mask;
-	sprd_eic->intc.irq_unmask = sprd_eic_irq_unmask;
-	sprd_eic->intc.irq_set_type = sprd_eic_irq_set_type;
-	sprd_eic->intc.flags = IRQCHIP_SKIP_SET_WAKE;
-
 	irq = &sprd_eic->chip.irq;
-	irq->chip = &sprd_eic->intc;
+	gpio_irq_chip_set_chip(irq, &sprd_eic_irq_chip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->parent_handler = sprd_eic_irq_handler;

-- 
2.34.1

