From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:11 -0000
Subject: [PATCH 03/10] iio: adc: hx711: remove hx711_remove()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-3-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

By using a few more devm_ functions, we can remove the hx711_remove()
function in the hx711 driver.

platform_set_drvdata() is also removed since there are no more
callers of platform_get_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 6efdc971689c..8461b1fe6bad 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -539,43 +539,27 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->data_ready_delay_ns =
 				1000000000 / hx711_data->clock_frequency;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	indio_dev->name = "hx711";
 	indio_dev->info = &hx711_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = hx711_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-							hx711_trigger, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      hx711_trigger, NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "Couldn't register the device\n");
-		goto error_buffer;
+		return ret;
 	}
 
 	return 0;
-
-error_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static void hx711_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev;
-
-	indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 }
 
 static const struct of_device_id of_hx711_match[] = {
@@ -587,7 +571,6 @@ MODULE_DEVICE_TABLE(of, of_hx711_match);
 
 static struct platform_driver hx711_driver = {
 	.probe		= hx711_probe,
-	.remove_new	= hx711_remove,
 	.driver		= {
 		.name		= "hx711-gpio",
 		.of_match_table	= of_hx711_match,

-- 
2.45.2

