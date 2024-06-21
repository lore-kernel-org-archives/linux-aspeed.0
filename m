From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 05/10] iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-5-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.
Error message is changed since there is only one error return now.
LTC2309_INTERNAL_REF_MV macro is added to make the internal reference
voltage value self-documenting.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ltc2309.c | 43 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 8b3a89c1b840..888a71454070 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 
 #define LTC2309_ADC_RESOLUTION	12
+#define LTC2309_INTERNAL_REF_MV 4096
 
 #define LTC2309_DIN_CH_MASK	GENMASK(7, 4)
 #define LTC2309_DIN_SDN		BIT(7)
@@ -29,14 +30,12 @@
  * struct ltc2309 - internal device data structure
  * @dev:	Device reference
  * @client:	I2C reference
- * @vref:	External reference source
  * @lock:	Lock to serialize data access
  * @vref_mv:	Internal voltage reference
  */
 struct ltc2309 {
 	struct device		*dev;
 	struct i2c_client	*client;
-	struct regulator	*vref;
 	struct mutex		lock; /* serialize data access */
 	int			vref_mv;
 };
@@ -157,11 +156,6 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
-static void ltc2309_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -175,7 +169,6 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
-	ltc2309->vref_mv = 4096; /* Default to the internal ref */
 
 	indio_dev->name = "ltc2309";
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -183,36 +176,12 @@ static int ltc2309_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
 	indio_dev->info = &ltc2309_info;
 
-	ltc2309->vref = devm_regulator_get_optional(&client->dev, "vref");
-	if (IS_ERR(ltc2309->vref)) {
-		ret = PTR_ERR(ltc2309->vref);
-		if (ret == -ENODEV)
-			ltc2309->vref = NULL;
-		else
-			return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(ltc2309->dev, ret,
+				     "failed to get vref voltage\n");
 
-	if (ltc2309->vref) {
-		ret = regulator_enable(ltc2309->vref);
-		if (ret)
-			return dev_err_probe(ltc2309->dev, ret,
-					     "failed to enable vref\n");
-
-		ret = devm_add_action_or_reset(ltc2309->dev,
-					       ltc2309_regulator_disable,
-					       ltc2309->vref);
-		if (ret) {
-			return dev_err_probe(ltc2309->dev, ret,
-					     "failed to add regulator_disable action: %d\n",
-					     ret);
-		}
-
-		ret = regulator_get_voltage(ltc2309->vref);
-		if (ret < 0)
-			return ret;
-
-		ltc2309->vref_mv = ret / 1000;
-	}
+	ltc2309->vref_mv = ret == -ENODEV ? LTC2309_INTERNAL_REF_MV : ret / 1000;
 
 	mutex_init(&ltc2309->lock);
 

-- 
2.45.2

