From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 31 Aug 2021 15:14:54 +0800
Subject: [v5 11/15] iio: adc: aspeed: Fix the calculate error of clock.
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
Message-ID: <20210831071458.2334-12-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ADC clock formula is
ast2400/2500:
ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
ast2600:
ADC clock period = PCLK * 2 * (ADC0C[15:0] + 1)
They all have one fixed divided 2 and the legacy driver didn't handle it.
This patch register the fixed factory clock device as the parent of ADC
clock scaler to fix this issue.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 40b7ba58c1dc..349377b9fac0 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -4,6 +4,12 @@
  *
  * Copyright (C) 2017 Google, Inc.
  * Copyright (C) 2021 Aspeed Technology Inc.
+ *
+ * ADC clock formula:
+ * Ast2400/Ast2500:
+ * clock period = period of PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0] + 1)
+ * Ast2600:
+ * clock period = period of PCLK * 2 * (ADC0C[15:0] + 1)
  */
 
 #include <linux/clk.h>
@@ -85,6 +91,7 @@ struct aspeed_adc_data {
 	struct regulator	*regulator;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
+	struct clk_hw		*fixed_div_clk;
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
@@ -204,6 +211,13 @@ static void aspeed_adc_unregister_divider(void *data)
 	clk_hw_unregister_divider(clk);
 }
 
+static void aspeed_adc_unregister_fixed_divider(void *data)
+{
+	struct clk_hw *clk = data;
+
+	clk_hw_unregister_fixed_factor(clk);
+}
+
 static void aspeed_adc_reset_assert(void *data)
 {
 	struct reset_control *rst = data;
@@ -328,6 +342,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	spin_lock_init(&data->clk_lock);
 	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
 		 of_clk_get_parent_name(pdev->dev.of_node, 0));
+	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-fixed-div",
+		 data->model_data->model_name);
+	data->fixed_div_clk = clk_hw_register_fixed_factor(
+		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
+	if (IS_ERR(data->fixed_div_clk))
+		return PTR_ERR(data->fixed_div_clk);
+
+	ret = devm_add_action_or_reset(data->dev,
+				       aspeed_adc_unregister_fixed_divider,
+				       data->clk_prescaler);
+	if (ret)
+		return ret;
+	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), clk_name);
 
 	if (data->model_data->need_prescaler) {
 		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",
-- 
2.25.1

