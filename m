From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 31 Aug 2021 15:14:47 +0800
Subject: [v5 04/15] iio: adc: aspeed: Keep model data to driver data.
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
Message-ID: <20210831071458.2334-5-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Keep the model data pointer to driver data for reducing the usage of
of_device_get_match_data().

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index f055fe7b2c40..76ae1c3f584b 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -77,6 +77,7 @@ struct aspeed_adc_model_data {
 
 struct aspeed_adc_data {
 	struct device		*dev;
+	const struct aspeed_adc_model_data *model_data;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
 	struct clk_hw		*clk_prescaler;
@@ -118,8 +119,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       int *val, int *val2, long mask)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -127,7 +126,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = model_data->vref_voltage;
+		*val = data->model_data->vref_voltage;
 		*val2 = ASPEED_RESOLUTION_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -146,13 +145,11 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
 				int val, int val2, long mask)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val < model_data->min_sampling_rate ||
-			val > model_data->max_sampling_rate)
+		if (val < data->model_data->min_sampling_rate ||
+			val > data->model_data->max_sampling_rate)
 			return -EINVAL;
 
 		clk_set_rate(data->clk_scaler->clk,
@@ -198,7 +195,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
 	struct aspeed_adc_data *data;
-	const struct aspeed_adc_model_data *model_data;
 	const char *clk_parent_name;
 	int ret;
 	u32 adc_engine_control_reg_val;
@@ -209,6 +205,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 
 	data = iio_priv(indio_dev);
 	data->dev = &pdev->dev;
+	data->model_data = of_device_get_match_data(&pdev->dev);
 	platform_set_drvdata(pdev, indio_dev);
 
 	data->base = devm_platform_ioremap_resource(pdev, 0);
@@ -249,9 +246,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 	reset_control_deassert(data->rst);
 
-	model_data = of_device_get_match_data(&pdev->dev);
-
-	if (model_data->wait_init_sequence) {
+	if (data->model_data->wait_init_sequence) {
 		/* Enable engine in normal mode. */
 		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
 				  ASPEED_ADC_OP_MODE_NORMAL) |
@@ -281,8 +276,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
 
-	model_data = of_device_get_match_data(&pdev->dev);
-	indio_dev->name = model_data->model_name;
+	indio_dev->name = data->model_data->model_name;
 	indio_dev->info = &aspeed_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = aspeed_adc_iio_channels;
-- 
2.25.1

