From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 08/10] iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-8-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-ads8688.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 9440a268a78c..fca3032c59d9 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -65,7 +65,6 @@ struct ads8688_state {
 	struct mutex			lock;
 	const struct ads8688_chip_info	*chip_info;
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	unsigned int			vref_mv;
 	enum ads8688_range		range[8];
 	union {
@@ -423,21 +422,11 @@ static int ads8688_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			goto err_regulator_disable;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
 
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Use internal reference */
-		st->vref_mv = ADS8688_VREF_MV;
-	}
+	st->vref_mv = ret == -ENODEV ? ADS8688_VREF_MV : ret / 1000;
 
 	st->chip_info =	&ads8688_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -460,7 +449,7 @@ static int ads8688_probe(struct spi_device *spi)
 	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		goto err_regulator_disable;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -472,23 +461,15 @@ static int ads8688_probe(struct spi_device *spi)
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-err_regulator_disable:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
 	return ret;
 }
 
 static void ads8688_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ads8688_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 static const struct spi_device_id ads8688_id[] = {

-- 
2.45.2

