From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Mar 2023 14:04:49 +0100
Subject: [PATCH v2 07/16] gpio: hisi: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
Message-ID: <20230215-immutable-chips-v2-7-d6b0e3f2d991@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the driver to immutable irq-chip with a bit of
intuition.

The IRQ chip was unnamed which seems unwise, so we just
assign the name "HISI-GPIO".

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index 55bd69043bf4..29a03de37fd8 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -37,7 +37,6 @@ struct hisi_gpio {
 	struct device		*dev;
 	void __iomem		*reg_base;
 	unsigned int		line_num;
-	struct irq_chip		irq_chip;
 	int			irq;
 };
 
@@ -100,12 +99,14 @@ static void hisi_gpio_irq_set_mask(struct irq_data *d)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_SET_WX, BIT(irqd_to_hwirq(d)));
+	gpiochip_disable_irq(chip, irqd_to_hwirq(d));
 }
 
 static void hisi_gpio_irq_clr_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(d));
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_CLR_WX, BIT(irqd_to_hwirq(d)));
 }
 
@@ -191,20 +192,24 @@ static void hisi_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_c, desc);
 }
 
+static const struct irq_chip hisi_gpio_irq_chip = {
+	.name = "HISI-GPIO",
+	.irq_ack = hisi_gpio_set_ack,
+	.irq_mask = hisi_gpio_irq_set_mask,
+	.irq_unmask = hisi_gpio_irq_clr_mask,
+	.irq_set_type = hisi_gpio_irq_set_type,
+	.irq_enable = hisi_gpio_irq_enable,
+	.irq_disable = hisi_gpio_irq_disable,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void hisi_gpio_init_irq(struct hisi_gpio *hisi_gpio)
 {
 	struct gpio_chip *chip = &hisi_gpio->chip;
 	struct gpio_irq_chip *girq_chip = &chip->irq;
 
-	/* Set hooks for irq_chip */
-	hisi_gpio->irq_chip.irq_ack = hisi_gpio_set_ack;
-	hisi_gpio->irq_chip.irq_mask = hisi_gpio_irq_set_mask;
-	hisi_gpio->irq_chip.irq_unmask = hisi_gpio_irq_clr_mask;
-	hisi_gpio->irq_chip.irq_set_type = hisi_gpio_irq_set_type;
-	hisi_gpio->irq_chip.irq_enable = hisi_gpio_irq_enable;
-	hisi_gpio->irq_chip.irq_disable = hisi_gpio_irq_disable;
-
-	girq_chip->chip = &hisi_gpio->irq_chip;
+	gpio_irq_chip_set_chip(girq_chip, &hisi_gpio_irq_chip);
 	girq_chip->default_type = IRQ_TYPE_NONE;
 	girq_chip->num_parents = 1;
 	girq_chip->parents = &hisi_gpio->irq;

-- 
2.34.1

