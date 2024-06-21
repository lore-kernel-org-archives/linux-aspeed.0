From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 04/10] iio: adc: hx711: use dev_err_probe()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-4-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use dev_err_probe() to simplify error returns in the probe function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8461b1fe6bad..b3372ccff7d5 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -464,10 +464,8 @@ static int hx711_probe(struct platform_device *pdev)
 	int i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
-	if (!indio_dev) {
-		dev_err(dev, "failed to allocate IIO device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate IIO device\n");
 
 	hx711_data = iio_priv(indio_dev);
 	hx711_data->dev = dev;
@@ -479,22 +477,18 @@ static int hx711_probe(struct platform_device *pdev)
 	 * in the driver it is an output
 	 */
 	hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(hx711_data->gpiod_pd_sck)) {
-		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_pd_sck));
-		return PTR_ERR(hx711_data->gpiod_pd_sck);
-	}
+	if (IS_ERR(hx711_data->gpiod_pd_sck))
+		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_pd_sck),
+				     "failed to get sck-gpiod\n");
 
 	/*
 	 * DOUT stands for serial data output of HX711
 	 * for the driver it is an input
 	 */
 	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_IN);
-	if (IS_ERR(hx711_data->gpiod_dout)) {
-		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_dout));
-		return PTR_ERR(hx711_data->gpiod_dout);
-	}
+	if (IS_ERR(hx711_data->gpiod_dout))
+		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_dout),
+				     "failed to get dout-gpiod\n");
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
 	if (ret < 0)
@@ -548,16 +542,13 @@ static int hx711_probe(struct platform_device *pdev)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      hx711_trigger, NULL);
-	if (ret < 0) {
-		dev_err(dev, "setup of iio triggered buffer failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "setup of iio triggered buffer failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "Couldn't register the device\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't register the device\n");
 
 	return 0;
 }

-- 
2.45.2

