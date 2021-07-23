From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jul 2021 16:16:18 +0800
Subject: [v2 5/8] iio: adc: aspeed: Add func to set sampling rate.
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
Message-ID: <20210723081621.29477-6-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the function to set the sampling rate and keep the sampling period
for a driver used to wait the lastest value.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 48 +++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 84f079195375..bb6100228cae 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -55,6 +55,12 @@
 
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
+/*
+ * When the sampling rate is too high, the ADC may not have enough charging
+ * time, resulting in a low voltage value. Thus, default use slow sampling
+ * rate for most user case.
+ */
+#define ASPEED_ADC_DEF_SAMPLING_RATE	65000
 
 enum aspeed_adc_version {
 	aspeed_adc_ast2400,
@@ -77,6 +83,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
 	int			vref;
+	u32			sample_period_ns;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -108,6 +115,26 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
 	ASPEED_CHAN(15, 0x2E),
 };
 
+static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
+{
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	const struct aspeed_adc_model_data *model_data =
+		of_device_get_match_data(data->dev);
+
+	if (rate < model_data->min_sampling_rate ||
+	    rate > model_data->max_sampling_rate)
+		return -EINVAL;
+	/* Each sampling needs 12 clocks to covert.*/
+	clk_set_rate(data->clk_scaler->clk, rate * ASPEED_CLOCKS_PER_SAMPLE);
+
+	rate = clk_get_rate(data->clk_scaler->clk);
+	data->sample_period_ns = DIV_ROUND_UP_ULL(
+		(u64)NSEC_PER_SEC * ASPEED_CLOCKS_PER_SAMPLE, rate);
+	dev_dbg(data->dev, "Adc clock = %d sample period = %d ns", rate,
+		data->sample_period_ns);
+	return 0;
+}
+
 static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val, int *val2, long mask)
@@ -138,19 +165,9 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
-	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val < model_data->min_sampling_rate ||
-			val > model_data->max_sampling_rate)
-			return -EINVAL;
-
-		clk_set_rate(data->clk_scaler->clk,
-				val * ASPEED_CLOCKS_PER_SAMPLE);
-		return 0;
+		return aspeed_adc_set_sampling_rate(indio_dev, val);
 
 	case IIO_CHAN_INFO_SCALE:
 	case IIO_CHAN_INFO_RAW:
@@ -302,6 +319,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		goto reset_error;
 	}
 	reset_control_deassert(data->rst);
+	ret = clk_prepare_enable(data->clk_scaler->clk);
+	if (ret)
+		goto clk_enable_error;
+	aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
 
 	ret = aspeed_adc_vref_config(pdev);
 	if (ret)
@@ -327,9 +348,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			goto poll_timeout_error;
 	}
 
-	ret = clk_prepare_enable(data->clk_scaler->clk);
-	if (ret)
-		goto clk_enable_error;
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 	/* Start all channels in normal mode. */
@@ -354,8 +372,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 iio_register_error:
 	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
-	clk_disable_unprepare(data->clk_scaler->clk);
 vref_config_error:
+	clk_disable_unprepare(data->clk_scaler->clk);
 clk_enable_error:
 poll_timeout_error:
 	reset_control_assert(data->rst);
-- 
2.25.1

