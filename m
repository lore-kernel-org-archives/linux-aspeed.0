From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 Mar 2023 08:46:04 +0100
Subject: [PATCH v3 16/17] gpio: pci-idio-16: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
Message-ID: <20230215-immutable-chips-v3-16-972542092a77@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: William Breathitt Gray <william.gray@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-pci-idio-16.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index a86ce748384b..6726c32e31e6 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -107,6 +107,8 @@ static void idio_16_irq_mask(struct irq_data *data)
 
 		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
 	}
+
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void idio_16_irq_unmask(struct irq_data *data)
@@ -117,6 +119,8 @@ static void idio_16_irq_unmask(struct irq_data *data)
 	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
 	unsigned long flags;
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
+
 	idio16gpio->irq_mask |= mask;
 
 	if (!prev_irq_mask) {
@@ -138,12 +142,14 @@ static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idio_16_irqchip = {
+static const struct irq_chip idio_16_irqchip = {
 	.name = "pci-idio-16",
 	.irq_ack = idio_16_irq_ack,
 	.irq_mask = idio_16_irq_mask,
 	.irq_unmask = idio_16_irq_unmask,
-	.irq_set_type = idio_16_irq_set_type
+	.irq_set_type = idio_16_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
@@ -242,7 +248,7 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio_16_state_init(&idio16gpio->state);
 
 	girq = &idio16gpio->chip.irq;
-	girq->chip = &idio_16_irqchip;
+	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;

-- 
2.34.1

