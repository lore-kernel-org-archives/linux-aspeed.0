From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 09/10] iio: adc: ti-ads8688: drop ads8688_remove()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-9-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

By using a few devm_ functions, we can simplify the driver and remove
the ads8688_remove() function.

spi_set_drvdata() is removed since there are no more callers of
spi_get_drvdata().

Also use dev_err_probe() to simplify error return.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads8688.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index fca3032c59d9..7a79f0cebfbf 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -432,8 +432,6 @@ static int ads8688_probe(struct spi_device *spi)
 
 	spi->mode = SPI_MODE_1;
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st->spi = spi;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
@@ -446,30 +444,13 @@ static int ads8688_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto err_buffer_cleanup;
-
-	return 0;
-
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static void ads8688_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      ads8688_trigger_handler, NULL);
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "iio triggered buffer setup failed\n");
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ads8688_id[] = {
@@ -492,7 +473,6 @@ static struct spi_driver ads8688_driver = {
 		.of_match_table = ads8688_of_match,
 	},
 	.probe		= ads8688_probe,
-	.remove		= ads8688_remove,
 	.id_table	= ads8688_id,
 };
 module_spi_driver(ads8688_driver);

-- 
2.45.2

