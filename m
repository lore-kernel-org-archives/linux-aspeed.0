From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 21 Sep 2021 14:09:35 +0930
Subject: [PATCH 1/2] leds: pca955x: Make the gpiochip always expose all pins
In-Reply-To: <20210921043936.468001-1-andrew@aj.id.au>
References: <20210921043936.468001-1-andrew@aj.id.au>
Message-ID: <20210921043936.468001-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The devicetree binding allows specifying which pins are GPIO vs LED.
Limiting the instantiated gpiochip to just these pins as the driver
currently does requires an arbitrary mapping between pins and GPIOs, but
such a mapping is not implemented by the driver. As a result,
specifying GPIOs in such a way that they don't map 1-to-1 to pin indexes
does not function as expected.

Establishing such a mapping is more complex than not and even if we did,
doing so leads to a slightly hairy userspace experience as the behaviour
of the PCA955x gpiochip would depend on how the pins are assigned in the
devicetree. Instead, always expose all pins via the gpiochip to provide
a stable interface and track which pins are in use.

Specifying a pin as `type = <PCA955X_TYPE_GPIO>;` in the devicetree
becomes a no-op.

I've assessed the impact of this change by looking through all of the
affected devicetrees as of the tag leds-5.15-rc1:

```
$ git grep -l 'pca955[0123]' $(find . -name dts -type d)
arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts
arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
```

These are all IBM-associated platforms. I've analysed both the
devicetrees and schematics where necessary to determine whether any
systems hit the hazard of the current broken behaviour. For the most
part, the systems specify the pins as either all LEDs or all GPIOs, or
at least do so in a way such that the broken behaviour isn't exposed.

The main counter-point to this observation is the Everest system whose
devicetree describes a large number of PCA955x devices and in some cases
has pin assignments that hit the hazard. However, there does not seem to
be any use of the affected GPIOs in the userspace associated with
Everest.

Regardless, any use of the hazardous GPIOs in Everest is already broken,
so let's fix the interface and then fix any already broken userspace
with it.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/leds/leds-pca955x.c | 63 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index a6b5699aeae4..77c0f461ab95 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -37,6 +37,7 @@
  *  bits the chip supports.
  */
 
+#include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -118,6 +119,7 @@ struct pca955x {
 	struct pca955x_led *leds;
 	struct pca955x_chipdef	*chipdef;
 	struct i2c_client	*client;
+	unsigned long active_pins;
 #ifdef CONFIG_LEDS_PCA955X_GPIO
 	struct gpio_chip gpio;
 #endif
@@ -360,12 +362,15 @@ static int pca955x_read_input(struct i2c_client *client, int n, u8 *val)
 static int pca955x_gpio_request_pin(struct gpio_chip *gc, unsigned int offset)
 {
 	struct pca955x *pca955x = gpiochip_get_data(gc);
-	struct pca955x_led *led = &pca955x->leds[offset];
 
-	if (led->type == PCA955X_TYPE_GPIO)
-		return 0;
+	return test_and_set_bit(offset, &pca955x->active_pins) ? -EBUSY : 0;
+}
 
-	return -EBUSY;
+static void pca955x_gpio_free_pin(struct gpio_chip *gc, unsigned int offset)
+{
+	struct pca955x *pca955x = gpiochip_get_data(gc);
+
+	clear_bit(offset, &pca955x->active_pins);
 }
 
 static int pca955x_set_value(struct gpio_chip *gc, unsigned int offset,
@@ -489,7 +494,6 @@ static int pca955x_probe(struct i2c_client *client)
 	struct i2c_adapter *adapter;
 	int i, err;
 	struct pca955x_platform_data *pdata;
-	int ngpios = 0;
 	bool set_default_label = false;
 	bool keep_pwm = false;
 	char default_label[8];
@@ -567,9 +571,7 @@ static int pca955x_probe(struct i2c_client *client)
 
 		switch (pca955x_led->type) {
 		case PCA955X_TYPE_NONE:
-			break;
 		case PCA955X_TYPE_GPIO:
-			ngpios++;
 			break;
 		case PCA955X_TYPE_LED:
 			led = &pca955x_led->led_cdev;
@@ -613,6 +615,8 @@ static int pca955x_probe(struct i2c_client *client)
 			if (err)
 				return err;
 
+			set_bit(i, &pca955x->active_pins);
+
 			/*
 			 * For default-state == "keep", let the core update the
 			 * brightness from the hardware, then check the
@@ -650,31 +654,30 @@ static int pca955x_probe(struct i2c_client *client)
 		return err;
 
 #ifdef CONFIG_LEDS_PCA955X_GPIO
-	if (ngpios) {
-		pca955x->gpio.label = "gpio-pca955x";
-		pca955x->gpio.direction_input = pca955x_gpio_direction_input;
-		pca955x->gpio.direction_output = pca955x_gpio_direction_output;
-		pca955x->gpio.set = pca955x_gpio_set_value;
-		pca955x->gpio.get = pca955x_gpio_get_value;
-		pca955x->gpio.request = pca955x_gpio_request_pin;
-		pca955x->gpio.can_sleep = 1;
-		pca955x->gpio.base = -1;
-		pca955x->gpio.ngpio = ngpios;
-		pca955x->gpio.parent = &client->dev;
-		pca955x->gpio.owner = THIS_MODULE;
+	pca955x->gpio.label = "gpio-pca955x";
+	pca955x->gpio.direction_input = pca955x_gpio_direction_input;
+	pca955x->gpio.direction_output = pca955x_gpio_direction_output;
+	pca955x->gpio.set = pca955x_gpio_set_value;
+	pca955x->gpio.get = pca955x_gpio_get_value;
+	pca955x->gpio.request = pca955x_gpio_request_pin;
+	pca955x->gpio.free = pca955x_gpio_free_pin;
+	pca955x->gpio.can_sleep = 1;
+	pca955x->gpio.base = -1;
+	pca955x->gpio.ngpio = chip->bits;
+	pca955x->gpio.parent = &client->dev;
+	pca955x->gpio.owner = THIS_MODULE;
 
-		err = devm_gpiochip_add_data(&client->dev, &pca955x->gpio,
-					     pca955x);
-		if (err) {
-			/* Use data->gpio.dev as a flag for freeing gpiochip */
-			pca955x->gpio.parent = NULL;
-			dev_warn(&client->dev, "could not add gpiochip\n");
-			return err;
-		}
-		dev_info(&client->dev, "gpios %i...%i\n",
-			 pca955x->gpio.base, pca955x->gpio.base +
-			 pca955x->gpio.ngpio - 1);
+	err = devm_gpiochip_add_data(&client->dev, &pca955x->gpio,
+				     pca955x);
+	if (err) {
+		/* Use data->gpio.dev as a flag for freeing gpiochip */
+		pca955x->gpio.parent = NULL;
+		dev_warn(&client->dev, "could not add gpiochip\n");
+		return err;
 	}
+	dev_info(&client->dev, "gpios %i...%i\n",
+		 pca955x->gpio.base, pca955x->gpio.base +
+		 pca955x->gpio.ngpio - 1);
 #endif
 
 	return 0;
-- 
2.30.2

