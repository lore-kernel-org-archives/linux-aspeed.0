From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 01/10] iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-1-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This makes use of the devm_regulator_get_enable_read_voltage() helper
function to simplify the code.

The error return is moved closer to the function call to make it easier
to follow the logic. And a few blank lines are added for readability.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/aspeed_adc.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 998e8bcc06e1..090416c0d622 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -108,7 +108,6 @@ struct adc_gain {
 struct aspeed_adc_data {
 	struct device		*dev;
 	const struct aspeed_adc_model_data *model_data;
-	struct regulator	*regulator;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
 	struct clk_hw		*fixed_div_clk;
@@ -404,13 +403,6 @@ static void aspeed_adc_power_down(void *data)
 	       priv_data->base + ASPEED_REG_ENGINE_CONTROL);
 }
 
-static void aspeed_adc_reg_disable(void *data)
-{
-	struct regulator *reg = data;
-
-	regulator_disable(reg);
-}
-
 static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
@@ -423,18 +415,14 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 	}
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
-	data->regulator = devm_regulator_get_optional(data->dev, "vref");
-	if (!IS_ERR(data->regulator)) {
-		ret = regulator_enable(data->regulator);
-		if (ret)
-			return ret;
-		ret = devm_add_action_or_reset(
-			data->dev, aspeed_adc_reg_disable, data->regulator);
-		if (ret)
-			return ret;
-		data->vref_mv = regulator_get_voltage(data->regulator);
-		/* Conversion from uV to mV */
-		data->vref_mv /= 1000;
+
+	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	if (ret != -ENODEV) {
+		data->vref_mv = ret / 1000;
+
 		if ((data->vref_mv >= 1550) && (data->vref_mv <= 2700))
 			writel(adc_engine_control_reg_val |
 				FIELD_PREP(
@@ -453,8 +441,6 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 			return -EOPNOTSUPP;
 		}
 	} else {
-		if (PTR_ERR(data->regulator) != -ENODEV)
-			return PTR_ERR(data->regulator);
 		data->vref_mv = 2500000;
 		of_property_read_u32(data->dev->of_node,
 				     "aspeed,int-vref-microvolt",

-- 
2.45.2

