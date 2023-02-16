From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Feb 2023 10:37:16 +0100
Subject: [PATCH 15/17] gpio: omap: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
Message-ID: <20230215-immutable-chips-v1-15-51a8f224a5d0@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the driver to immutable irq-chip with a bit of
intuition.

This driver require some special care: .irq_ack() was copied
from dummy_irq_chip where it was defined as noop. This only
makes sense if using handle_edge_irq() that will unconditionally
call .irq_ack() to avoid a crash, but this driver is not ever
using handle_edge_irq() so just avoid assigning .irq_ack().

A separate chip had to be created for the non-wakeup instance.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-omap.c | 68 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 292e62c06008..a5ee3ed31533 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <linux/syscore_ops.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -47,6 +48,7 @@ struct gpio_regs {
 struct gpio_bank {
 	void __iomem *base;
 	const struct omap_gpio_reg_offs *regs;
+	struct device *dev;
 
 	int irq;
 	u32 non_wakeup_gpios;
@@ -681,6 +683,7 @@ static void omap_gpio_mask_irq(struct irq_data *d)
 	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 	omap_set_gpio_irqenable(bank, offset, 0);
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
+	gpiochip_disable_irq(&bank->chip, offset);
 }
 
 static void omap_gpio_unmask_irq(struct irq_data *d)
@@ -690,6 +693,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
+	gpiochip_enable_irq(&bank->chip, offset);
 	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap_set_gpio_irqenable(bank, offset, 1);
 
@@ -708,6 +712,40 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void omap_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+
+	seq_printf(p, dev_name(bank->dev));
+}
+
+static const struct irq_chip omap_gpio_irq_chip = {
+	.irq_startup = omap_gpio_irq_startup,
+	.irq_shutdown = omap_gpio_irq_shutdown,
+	.irq_mask = omap_gpio_mask_irq,
+	.irq_unmask = omap_gpio_unmask_irq,
+	.irq_set_type = omap_gpio_irq_type,
+	.irq_set_wake = omap_gpio_wake_enable,
+	.irq_bus_lock = omap_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	.irq_print_chip = omap_gpio_irq_print_chip,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static const struct irq_chip omap_gpio_irq_chip_nowake = {
+	.irq_startup = omap_gpio_irq_startup,
+	.irq_shutdown = omap_gpio_irq_shutdown,
+	.irq_mask = omap_gpio_mask_irq,
+	.irq_unmask = omap_gpio_unmask_irq,
+	.irq_set_type = omap_gpio_irq_type,
+	.irq_bus_lock = omap_gpio_irq_bus_lock,
+	.irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	.irq_print_chip = omap_gpio_irq_print_chip,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	 GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -986,8 +1024,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		writel_relaxed(0, base + bank->regs->ctrl);
 }
 
-static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
-			       struct device *pm_dev)
+static int omap_gpio_chip_init(struct gpio_bank *bank, struct device *pm_dev)
 {
 	struct gpio_irq_chip *irq;
 	static int gpio;
@@ -1023,12 +1060,12 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 	}
 	bank->chip.ngpio = bank->width;
 
+	irq = &bank->chip.irq;
 	/* MPUIO is a bit different, reading IRQ status clears it */
 	if (bank->is_mpuio && !bank->regs->wkup_en)
-		irqc->irq_set_wake = NULL;
-
-	irq = &bank->chip.irq;
-	irq->chip = irqc;
+		gpio_irq_chip_set_chip(irq, &omap_gpio_irq_chip_nowake);
+	else
+		gpio_irq_chip_set_chip(irq, &omap_gpio_irq_chip);
 	irq->handler = handle_bad_irq;
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->num_parents = 1;
@@ -1361,7 +1398,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct omap_gpio_platform_data *pdata;
 	struct gpio_bank *bank;
-	struct irq_chip *irqc;
 	int ret;
 
 	pdata = device_get_match_data(dev);
@@ -1374,21 +1410,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
-	if (!irqc)
-		return -ENOMEM;
-
-	irqc->irq_startup = omap_gpio_irq_startup,
-	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = dummy_irq_chip.irq_ack,
-	irqc->irq_mask = omap_gpio_mask_irq,
-	irqc->irq_unmask = omap_gpio_unmask_irq,
-	irqc->irq_set_type = omap_gpio_irq_type,
-	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
-	irqc->name = dev_name(&pdev->dev);
-	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	bank->dev = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
@@ -1452,7 +1474,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_mod_init(bank);
 
-	ret = omap_gpio_chip_init(bank, irqc, dev);
+	ret = omap_gpio_chip_init(bank, dev);
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);

-- 
2.34.1

