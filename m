From: Rashmica Gupta <rashmica.g@gmail.com>
Date: Fri,  6 Sep 2019 16:27:26 +1000
Subject: [PATCH v3 4/5] gpios: Use ngpio property from device tree if available
Message-ID: <20190906062727.13521-1-rashmica.g@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the ngpio property from the device tree if it exists. If it doesn't
then fallback to the hardcoded value in the config.

This is in preparation for adding ast2600 support. The ast2600 SoC has
two GPIO controllers and so requires two instances of the GPIO driver.
We use the ngpio property to different between them as they have
different numbers of GPIOs.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 drivers/gpio/gpio-aspeed.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 16c6eaf70857..c3d5ecba343b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -694,7 +694,7 @@ static void set_irq_valid_mask(struct aspeed_gpio *gpio)
 		for_each_clear_bit(offset, &input, 32) {
 			unsigned int i = props->bank * 32 + offset;
 
-			if (i >= gpio->config->nr_gpios)
+			if (i >= gpio->chip.ngpio)
 				break;
 
 			clear_bit(i, gpio->chip.irq.valid_mask);
@@ -1007,10 +1007,10 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	unsigned long flags;
 
 	if (!gpio->cf_copro_bankmap)
-		gpio->cf_copro_bankmap = kzalloc(gpio->config->nr_gpios >> 3, GFP_KERNEL);
+		gpio->cf_copro_bankmap = kzalloc(gpio->chip.ngpio >> 3, GFP_KERNEL);
 	if (!gpio->cf_copro_bankmap)
 		return -ENOMEM;
-	if (offset < 0 || offset > gpio->config->nr_gpios)
+	if (offset < 0 || offset > gpio->chip.ngpio)
 		return -EINVAL;
 	bindex = offset >> 3;
 
@@ -1055,7 +1055,7 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 	if (!gpio->cf_copro_bankmap)
 		return -ENXIO;
 
-	if (offset < 0 || offset > gpio->config->nr_gpios)
+	if (offset < 0 || offset > gpio->chip.ngpio)
 		return -EINVAL;
 	bindex = offset >> 3;
 
@@ -1119,7 +1119,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *gpio_id;
 	struct aspeed_gpio *gpio;
-	int rc, i, banks;
+	int rc, i, banks, err;
+	u32 ngpio;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
@@ -1145,7 +1146,10 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	gpio->config = gpio_id->data;
 
 	gpio->chip.parent = &pdev->dev;
-	gpio->chip.ngpio = gpio->config->nr_gpios;
+	err = of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio);
+	gpio->chip.ngpio = (u16) ngpio;
+	if (err)
+		gpio->chip.ngpio = gpio->config->nr_gpios;
 	gpio->chip.direction_input = aspeed_gpio_dir_in;
 	gpio->chip.direction_output = aspeed_gpio_dir_out;
 	gpio->chip.get_direction = aspeed_gpio_get_direction;
@@ -1158,7 +1162,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	gpio->chip.base = -1;
 
 	/* Allocate a cache of the output registers */
-	banks = DIV_ROUND_UP(gpio->config->nr_gpios, 32);
+	banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
 	gpio->dcache = devm_kcalloc(&pdev->dev,
 				    banks, sizeof(u32), GFP_KERNEL);
 	if (!gpio->dcache)
-- 
2.20.1

