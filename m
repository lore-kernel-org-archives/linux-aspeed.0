From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 Mar 2023 08:45:51 +0100
Subject: [PATCH v3 03/17] gpio: aspeed: Always register the irqchip
In-Reply-To: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org>
Message-ID: <20230215-immutable-chips-v3-3-972542092a77@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>

The driver was implemented in a way that made the irqchip optional, if a
irq was not present in the device tree. However, all of the device trees
have always had an irq, so the optional-ness has never been used.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 49 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index a94da80d3a95..129f6a6b4d1d 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1137,8 +1137,9 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
 static int __init aspeed_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *gpio_id;
+	struct gpio_irq_chip *girq;
 	struct aspeed_gpio *gpio;
-	int rc, i, banks, err;
+	int rc, irq, i, banks, err;
 	u32 ngpio;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
@@ -1201,31 +1202,27 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 		aspeed_gpio_change_cmd_source(gpio, bank, 3, GPIO_CMDSRC_ARM);
 	}
 
-	/* Optionally set up an irqchip if there is an IRQ */
-	rc = platform_get_irq(pdev, 0);
-	if (rc > 0) {
-		struct gpio_irq_chip *girq;
-
-		gpio->irq = rc;
-		girq = &gpio->chip.irq;
-		girq->chip = &gpio->irqc;
-		girq->chip->name = dev_name(&pdev->dev);
-		girq->chip->irq_ack = aspeed_gpio_irq_ack;
-		girq->chip->irq_mask = aspeed_gpio_irq_mask;
-		girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
-		girq->chip->irq_set_type = aspeed_gpio_set_type;
-		girq->parent_handler = aspeed_gpio_irq_handler;
-		girq->num_parents = 1;
-		girq->parents = devm_kcalloc(&pdev->dev, 1,
-					     sizeof(*girq->parents),
-					     GFP_KERNEL);
-		if (!girq->parents)
-			return -ENOMEM;
-		girq->parents[0] = gpio->irq;
-		girq->default_type = IRQ_TYPE_NONE;
-		girq->handler = handle_bad_irq;
-		girq->init_valid_mask = aspeed_init_irq_valid_mask;
-	}
+	/* Set up an irqchip */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	gpio->irq = irq;
+	girq = &gpio->chip.irq;
+	girq->chip = &gpio->irqc;
+	girq->chip->name = dev_name(&pdev->dev);
+	girq->chip->irq_ack = aspeed_gpio_irq_ack;
+	girq->chip->irq_mask = aspeed_gpio_irq_mask;
+	girq->chip->irq_unmask = aspeed_gpio_irq_unmask;
+	girq->chip->irq_set_type = aspeed_gpio_set_type;
+	girq->parent_handler = aspeed_gpio_irq_handler;
+	girq->num_parents = 1;
+	girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents), GFP_KERNEL);
+	if (!girq->parents)
+		return -ENOMEM;
+	girq->parents[0] = gpio->irq;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_bad_irq;
+	girq->init_valid_mask = aspeed_init_irq_valid_mask;
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);

-- 
2.34.1

