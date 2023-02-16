From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Feb 2023 10:37:10 +0100
Subject: [PATCH 09/17] gpio: hlwd: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
Message-ID: <20230215-immutable-chips-v1-9-51a8f224a5d0@linaro.org>
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
 drivers/gpio/gpio-hlwd.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index 4e13e937f832..c208ac1c54a6 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 /*
@@ -48,7 +49,7 @@
 
 struct hlwd_gpio {
 	struct gpio_chip gpioc;
-	struct irq_chip irqc;
+	struct device *dev;
 	void __iomem *regs;
 	int irq;
 	u32 edge_emulation;
@@ -123,6 +124,7 @@ static void hlwd_gpio_irq_mask(struct irq_data *data)
 	mask &= ~BIT(data->hwirq);
 	iowrite32be(mask, hlwd->regs + HW_GPIOB_INTMASK);
 	raw_spin_unlock_irqrestore(&hlwd->gpioc.bgpio_lock, flags);
+	gpiochip_disable_irq(&hlwd->gpioc, irqd_to_hwirq(data));
 }
 
 static void hlwd_gpio_irq_unmask(struct irq_data *data)
@@ -132,6 +134,7 @@ static void hlwd_gpio_irq_unmask(struct irq_data *data)
 	unsigned long flags;
 	u32 mask;
 
+	gpiochip_enable_irq(&hlwd->gpioc, irqd_to_hwirq(data));
 	raw_spin_lock_irqsave(&hlwd->gpioc.bgpio_lock, flags);
 	mask = ioread32be(hlwd->regs + HW_GPIOB_INTMASK);
 	mask |= BIT(data->hwirq);
@@ -202,6 +205,24 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
+static void hlwd_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct hlwd_gpio *hlwd =
+		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+
+	seq_printf(p, dev_name(hlwd->dev));
+}
+
+static const struct irq_chip hlwd_gpio_irq_chip = {
+	.irq_mask = hlwd_gpio_irq_mask,
+	.irq_unmask = hlwd_gpio_irq_unmask,
+	.irq_enable = hlwd_gpio_irq_enable,
+	.irq_set_type = hlwd_gpio_irq_set_type,
+	.irq_print_chip = hlwd_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int hlwd_gpio_probe(struct platform_device *pdev)
 {
 	struct hlwd_gpio *hlwd;
@@ -216,6 +237,8 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(hlwd->regs))
 		return PTR_ERR(hlwd->regs);
 
+	hlwd->dev = &pdev->dev;
+
 	/*
 	 * Claim all GPIOs using the OWNER register. This will not work on
 	 * systems where the AHBPROT memory firewall hasn't been configured to
@@ -259,14 +282,8 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 			return hlwd->irq;
 		}
 
-		hlwd->irqc.name = dev_name(&pdev->dev);
-		hlwd->irqc.irq_mask = hlwd_gpio_irq_mask;
-		hlwd->irqc.irq_unmask = hlwd_gpio_irq_unmask;
-		hlwd->irqc.irq_enable = hlwd_gpio_irq_enable;
-		hlwd->irqc.irq_set_type = hlwd_gpio_irq_set_type;
-
 		girq = &hlwd->gpioc.irq;
-		girq->chip = &hlwd->irqc;
+		gpio_irq_chip_set_chip(girq, &hlwd_gpio_irq_chip);
 		girq->parent_handler = hlwd_gpio_irqhandler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(&pdev->dev, 1,

-- 
2.34.1

