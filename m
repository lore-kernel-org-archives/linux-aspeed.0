From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:13 -0000
Subject: [PATCH 10/10] iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-10-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.
Error message is slightly changed since there is only one error return
now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index ddc6c262f801..bd37d304ca70 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -857,15 +857,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 	return 0;
 }
 
-static void ad3552r_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	struct regulator *vref;
 	int err, cnt = 0, voltage, delta = 100000;
 	u32 vals[2], val, ch;
 
@@ -874,30 +868,16 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
 				     "Error getting gpio ldac");
 
-	vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(vref)) {
-		if (PTR_ERR(vref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(vref),
-					     "Error getting vref");
+	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (voltage < 0 && voltage != -ENODEV)
+		return dev_err_probe(dev, voltage, "Error getting vref voltage\n");
 
+	if (voltage == -ENODEV) {
 		if (device_property_read_bool(dev, "adi,vref-out-en"))
 			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
 		else
 			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
 	} else {
-		err = regulator_enable(vref);
-		if (err) {
-			dev_err(dev, "Failed to enable external vref supply\n");
-			return err;
-		}
-
-		err = devm_add_action_or_reset(dev, ad3552r_reg_disable, vref);
-		if (err) {
-			regulator_disable(vref);
-			return err;
-		}
-
-		voltage = regulator_get_voltage(vref);
 		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
 			dev_warn(dev, "vref-supply must be 2.5V");
 			return -EINVAL;

-- 
2.45.2

