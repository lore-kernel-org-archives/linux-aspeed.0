From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 23 Jul 2021 16:16:20 +0800
Subject: [v2 7/8] iio: adc: aspeed: Fix the calculate error of clock.
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
Message-ID: <20210723081621.29477-8-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The adc clcok formula is
ast2400/2500:
ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
ast2600:
ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
They all have one fixed divided 2 and the legacy driver didn't handle it.
This patch register the fixed factory clock device as the parent of adc
clock scaler to fix this issue.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 0153b28b83b7..7e674b607e36 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -80,6 +80,7 @@ struct aspeed_adc_data {
 	struct device		*dev;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
+	struct clk_hw		*fixed_div_clk;
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
@@ -310,6 +311,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	int ret;
 	u32 adc_engine_control_reg_val;
 	char scaler_clk_name[32];
+	char fixed_div_clk_name[32];
 
 	model_data = of_device_get_match_data(&pdev->dev);
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
@@ -328,10 +330,15 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	spin_lock_init(&data->clk_lock);
 	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
 	if (model_data->version <= aspeed_adc_ast2500) {
+		/* ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1) */
+		data->fixed_div_clk = clk_hw_register_fixed_factor(
+			&pdev->dev, "fixed-div", clk_parent_name, 0, 1, 2);
+		if (IS_ERR(data->fixed_div_clk))
+			return PTR_ERR(data->fixed_div_clk);
 		data->clk_prescaler = clk_hw_register_divider(
-					&pdev->dev, "prescaler", clk_parent_name, 0,
-					data->base + ASPEED_REG_CLOCK_CONTROL,
-					17, 15, 0, &data->clk_lock);
+			&pdev->dev, "prescaler", "fixed-div", 0,
+			data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
+			&data->clk_lock);
 		if (IS_ERR(data->clk_prescaler))
 			return PTR_ERR(data->clk_prescaler);
 
@@ -349,14 +356,23 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			goto scaler_error;
 		}
 	} else {
+		/* ADC clock period = period of PCLK * 2 * (ADC0C[15:0] + 1) */
+		snprintf(fixed_div_clk_name, sizeof(fixed_div_clk_name), "fixed-div-%s",
+			 pdev->name);
+		data->fixed_div_clk = clk_hw_register_fixed_factor(
+			&pdev->dev, fixed_div_clk_name, clk_parent_name, 0, 1, 2);
+		if (IS_ERR(data->fixed_div_clk))
+			return PTR_ERR(data->fixed_div_clk);
 		snprintf(scaler_clk_name, sizeof(scaler_clk_name), "scaler-%s",
 			 pdev->name);
 		data->clk_scaler = clk_hw_register_divider(
 			&pdev->dev, scaler_clk_name, clk_parent_name, 0,
 			data->base + ASPEED_REG_CLOCK_CONTROL, 0, 16, 0,
 			&data->clk_lock);
-		if (IS_ERR(data->clk_scaler))
-			return PTR_ERR(data->clk_scaler);
+		if (IS_ERR(data->clk_scaler)) {
+			ret = PTR_ERR(data->clk_scaler);
+			goto scaler_error;
+		}
 	}
 
 	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
@@ -430,6 +446,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 scaler_error:
 	if (model_data->version <= aspeed_adc_ast2500)
 		clk_hw_unregister_divider(data->clk_prescaler);
+	clk_hw_unregister_fixed_factor(data->fixed_div_clk);
 	return ret;
 }
 
@@ -448,6 +465,7 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 	clk_hw_unregister_divider(data->clk_scaler);
 	if (model_data->version <= aspeed_adc_ast2500)
 		clk_hw_unregister_divider(data->clk_prescaler);
+	clk_hw_unregister_fixed_factor(data->fixed_div_clk);
 
 	return 0;
 }
-- 
2.25.1

