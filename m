From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Jun 2024 22:12:11 -0000
Subject: [PATCH 06/10] iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-6-49e50cd0b99a@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/max1363.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 8b5bc96cb9fb..bf4b6dc53fd2 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1561,18 +1561,12 @@ static const struct of_device_id max1363_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max1363_of_match);
 
-static void max1363_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int max1363_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	struct max1363_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *vref;
 
 	indio_dev = devm_iio_device_alloc(&client->dev,
 					  sizeof(struct max1363_state));
@@ -1589,26 +1583,12 @@ static int max1363_probe(struct i2c_client *client)
 	st->chip_info = i2c_get_match_data(client);
 	st->client = client;
 
-	st->vref_uv = st->chip_info->int_vref_mv * 1000;
-	vref = devm_regulator_get_optional(&client->dev, "vref");
-	if (!IS_ERR(vref)) {
-		int vref_uv;
-
-		ret = regulator_enable(vref);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&client->dev, max1363_reg_disable, vref);
-		if (ret)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
 
-		st->vref = vref;
-		vref_uv = regulator_get_voltage(vref);
-		if (vref_uv <= 0)
-			return -EINVAL;
 
-		st->vref_uv = vref_uv;
-	}
+	st->vref_uv = ret == -ENODEV ? st->chip_info->int_vref_mv * 1000 : ret;
 
 	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		st->send = i2c_master_send;

-- 
2.45.2

