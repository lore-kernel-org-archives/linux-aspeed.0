From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:12 -0000
Subject: [PATCH 07/10] iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-7-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc108s102.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 69fcbbc7e418..9758ac801310 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -58,7 +58,6 @@
 
 struct adc108s102_state {
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	u32				va_millivolt;
 	/* SPI transfer used by triggered buffer handler*/
 	struct spi_transfer		ring_xfer;
@@ -216,11 +215,6 @@ static const struct iio_info adc108s102_info = {
 	.update_scan_mode	= &adc108s102_update_scan_mode,
 };
 
-static void adc108s102_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int adc108s102_probe(struct spi_device *spi)
 {
 	struct adc108s102_state *st;
@@ -236,25 +230,9 @@ static int adc108s102_probe(struct spi_device *spi)
 	if (ACPI_COMPANION(&spi->dev)) {
 		st->va_millivolt = ADC108S102_VA_MV_ACPI_DEFAULT;
 	} else {
-		st->reg = devm_regulator_get(&spi->dev, "vref");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret < 0) {
-			dev_err(&spi->dev, "Cannot enable vref regulator\n");
-			return ret;
-		}
-		ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
-					       st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0) {
-			dev_err(&spi->dev, "vref get voltage failed\n");
-			return ret;
-		}
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret, "failed get vref voltage\n");
 
 		st->va_millivolt = ret / 1000;
 	}

-- 
2.45.2

