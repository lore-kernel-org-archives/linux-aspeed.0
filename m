From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Feb 2023 10:37:18 +0100
Subject: [PATCH 17/17] gpio: pcie-idio-24: Convert to immutable irq_chip
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
Message-ID: <20230215-immutable-chips-v1-17-51a8f224a5d0@linaro.org>
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
 drivers/gpio/gpio-pcie-idio-24.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 8a9b98fa418f..ac42150f4009 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -396,6 +396,8 @@ static void idio_24_irq_mask(struct irq_data *data)
 	}
 
 	raw_spin_unlock_irqrestore(&idio24gpio->lock, flags);
+
+	gpiochip_disable_irq(chip, irqd_to_hwirq(data));
 }
 
 static void idio_24_irq_unmask(struct irq_data *data)
@@ -408,6 +410,8 @@ static void idio_24_irq_unmask(struct irq_data *data)
 	const unsigned long bank_offset = bit_offset / 8;
 	unsigned char cos_enable_state;
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(data));
+
 	raw_spin_lock_irqsave(&idio24gpio->lock, flags);
 
 	prev_irq_mask = idio24gpio->irq_mask >> bank_offset * 8;
@@ -437,12 +441,14 @@ static int idio_24_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idio_24_irqchip = {
+static const struct irq_chip idio_24_irqchip = {
 	.name = "pcie-idio-24",
 	.irq_ack = idio_24_irq_ack,
 	.irq_mask = idio_24_irq_mask,
 	.irq_unmask = idio_24_irq_unmask,
-	.irq_set_type = idio_24_irq_set_type
+	.irq_set_type = idio_24_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idio_24_irq_handler(int irq, void *dev_id)
@@ -535,7 +541,7 @@ static int idio_24_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio24gpio->chip.set_multiple = idio_24_gpio_set_multiple;
 
 	girq = &idio24gpio->chip.irq;
-	girq->chip = &idio_24_irqchip;
+	gpio_irq_chip_set_chip(girq, &idio_24_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;

-- 
2.34.1

