From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 31 Aug 2021 15:14:52 +0800
Subject: [v5 09/15] iio: adc: aspeed: Use devm_add_action_or_reset.
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
Message-ID: <20210831071458.2334-10-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch use devm_add_action_or_reset to handle the error in probe
phase.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 112 +++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index e53d1541ad1d..af00d9752c1e 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -195,6 +195,35 @@ static const struct iio_info aspeed_adc_iio_info = {
 	.debugfs_reg_access = aspeed_adc_reg_access,
 };
 
+static void aspeed_adc_unregister_divider(void *data)
+{
+	struct clk_hw *clk = data;
+
+	clk_hw_unregister_divider(clk);
+}
+
+static void aspeed_adc_reset_assert(void *data)
+{
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static void aspeed_adc_clk_disable_unprepare(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
+static void aspeed_adc_power_down(void *data)
+{
+	struct aspeed_adc_data *priv_data = data;
+
+	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
+	       priv_data->base + ASPEED_REG_ENGINE_CONTROL);
+}
+
 static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
@@ -242,6 +271,11 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			&data->clk_lock);
 		if (IS_ERR(data->clk_prescaler))
 			return PTR_ERR(data->clk_prescaler);
+		ret = devm_add_action_or_reset(data->dev,
+					       aspeed_adc_unregister_divider,
+					       data->clk_prescaler);
+		if (ret)
+			return ret;
 		snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name),
 			 clk_name);
 		scaler_flags = CLK_SET_RATE_PARENT;
@@ -256,23 +290,30 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
 		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
 		data->model_data->scaler_bit_width, 0, &data->clk_lock);
-	if (IS_ERR(data->clk_scaler)) {
-		ret = PTR_ERR(data->clk_scaler);
-		goto scaler_error;
-	}
+	if (IS_ERR(data->clk_scaler))
+		return PTR_ERR(data->clk_scaler);
+
+	ret = devm_add_action_or_reset(data->dev, aspeed_adc_unregister_divider,
+				       data->clk_scaler);
+	if (ret)
+		return ret;
 
 	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(data->rst)) {
 		dev_err(&pdev->dev,
 			"invalid or missing reset controller device tree entry");
-		ret = PTR_ERR(data->rst);
-		goto reset_error;
+		return PTR_ERR(data->rst);
 	}
 	reset_control_deassert(data->rst);
 
+	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
+				       data->rst);
+	if (ret)
+		return ret;
+
 	ret = aspeed_adc_vref_config(indio_dev);
 	if (ret)
-		goto vref_config_error;
+		return ret;
 
 	if (data->model_data->wait_init_sequence) {
 		/* Enable engine in normal mode. */
@@ -281,6 +322,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			       ASPEED_ADC_ENGINE_ENABLE,
 		       data->base + ASPEED_REG_ENGINE_CONTROL);
 
+		ret = devm_add_action_or_reset(data->dev, aspeed_adc_power_down,
+					       data);
+		if (ret)
+			return ret;
 		/* Wait for initial sequence complete. */
 		ret = readl_poll_timeout(data->base + ASPEED_REG_ENGINE_CONTROL,
 					 adc_engine_control_reg_val,
@@ -289,13 +334,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 					 ASPEED_ADC_INIT_POLLING_TIME,
 					 ASPEED_ADC_INIT_TIMEOUT);
 		if (ret)
-			goto poll_timeout_error;
+			return ret;
 	}
 
 	/* Start all channels in normal mode. */
 	ret = clk_prepare_enable(data->clk_scaler->clk);
 	if (ret)
-		goto clk_enable_error;
+		return ret;
+
+	ret = devm_add_action_or_reset(data->dev,
+				       aspeed_adc_clk_disable_unprepare,
+				       data->clk_scaler->clk);
+	if (ret)
+		return ret;
 
 	adc_engine_control_reg_val =
 		ASPEED_ADC_CTRL_CHANNEL |
@@ -303,6 +354,11 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		ASPEED_ADC_ENGINE_ENABLE;
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
+	ret = devm_add_action_or_reset(data->dev,
+				       aspeed_adc_power_down,
+				       data);
+	if (ret)
+		return ret;
 
 	indio_dev->name = data->model_data->model_name;
 	indio_dev->info = &aspeed_adc_iio_info;
@@ -310,45 +366,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = aspeed_adc_iio_channels;
 	indio_dev->num_channels = data->model_data->num_channels;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto iio_register_error;
-
-	return 0;
-
-iio_register_error:
-	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
-	       data->base + ASPEED_REG_ENGINE_CONTROL);
-	clk_disable_unprepare(data->clk_scaler->clk);
-clk_enable_error:
-poll_timeout_error:
-vref_config_error:
-	reset_control_assert(data->rst);
-reset_error:
-	clk_hw_unregister_divider(data->clk_scaler);
-scaler_error:
-	if (data->model_data->need_prescaler)
-		clk_hw_unregister_divider(data->clk_prescaler);
+	ret = devm_iio_device_register(data->dev, indio_dev);
 	return ret;
 }
 
-static int aspeed_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct aspeed_adc_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
-	       data->base + ASPEED_REG_ENGINE_CONTROL);
-	clk_disable_unprepare(data->clk_scaler->clk);
-	reset_control_assert(data->rst);
-	clk_hw_unregister_divider(data->clk_scaler);
-	if (data->model_data->need_prescaler)
-		clk_hw_unregister_divider(data->clk_prescaler);
-
-	return 0;
-}
-
 static const struct aspeed_adc_model_data ast2400_model_data = {
 	.model_name = "ast2400-adc",
 	.vref_fixed_mv = 2500,
@@ -379,7 +400,6 @@ MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
 
 static struct platform_driver aspeed_adc_driver = {
 	.probe = aspeed_adc_probe,
-	.remove = aspeed_adc_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = aspeed_adc_matches,
-- 
2.25.1

