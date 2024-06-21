From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 02/10] iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-2-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the devm_regulator_get_enable_read_voltage() helper to simplify the
code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index fef97c1d226a..6efdc971689c 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -80,7 +80,6 @@ struct hx711_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_pd_sck;
 	struct gpio_desc	*gpiod_dout;
-	struct regulator	*reg_avdd;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	struct mutex		lock;
@@ -497,11 +496,7 @@ static int hx711_probe(struct platform_device *pdev)
 		return PTR_ERR(hx711_data->gpiod_dout);
 	}
 
-	hx711_data->reg_avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(hx711_data->reg_avdd))
-		return PTR_ERR(hx711_data->reg_avdd);
-
-	ret = regulator_enable(hx711_data->reg_avdd);
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
 	if (ret < 0)
 		return ret;
 
@@ -517,9 +512,6 @@ static int hx711_probe(struct platform_device *pdev)
 	 * approximately to fit into a 32 bit number:
 	 * 1 LSB = (AVDD * 100) / GAIN / 1678 [10^-9 mV]
 	 */
-	ret = regulator_get_voltage(hx711_data->reg_avdd);
-	if (ret < 0)
-		goto error_regulator;
 
 	/* we need 10^-9 mV */
 	ret *= 100;
@@ -559,7 +551,7 @@ static int hx711_probe(struct platform_device *pdev)
 							hx711_trigger, NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
-		goto error_regulator;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -573,25 +565,17 @@ static int hx711_probe(struct platform_device *pdev)
 error_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-error_regulator:
-	regulator_disable(hx711_data->reg_avdd);
-
 	return ret;
 }
 
 static void hx711_remove(struct platform_device *pdev)
 {
-	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 
 	indio_dev = platform_get_drvdata(pdev);
-	hx711_data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
 	iio_triggered_buffer_cleanup(indio_dev);
-
-	regulator_disable(hx711_data->reg_avdd);
 }
 
 static const struct of_device_id of_hx711_match[] = {

-- 
2.45.2

