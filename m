From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 31 Aug 2021 15:14:48 +0800
Subject: [v5 05/15] iio: adc: aspeed: Refactory model data structure
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
Message-ID: <20210831071458.2334-6-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch refactors the model data structure to distinguish the
function form different versions of aspeed ADC.
- Rename the vref_voltage to vref_fixed_mv and add vref_mv driver data
When driver probe will check vref_fixed_mv value and store it to vref_mv
which isn't const value.
- Add num_channels
Make num_channles of iio device can be changed by different model_data
- Add need_prescaler flag and scaler_bit_width
The need_prescaler flag is used to tell the driver the clock divider needs
another Prescaler and the scaler_bit_width to set the clock divider
bitfield width.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 76ae1c3f584b..6ce2f676c54a 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -71,8 +71,11 @@ struct aspeed_adc_model_data {
 	const char *model_name;
 	unsigned int min_sampling_rate;	// Hz
 	unsigned int max_sampling_rate;	// Hz
-	unsigned int vref_voltage;	// mV
+	unsigned int vref_fixed_mv;
 	bool wait_init_sequence;
+	bool need_prescaler;
+	u8 scaler_bit_width;
+	unsigned int num_channels;
 };
 
 struct aspeed_adc_data {
@@ -83,6 +86,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
+	int			vref_mv;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -126,7 +130,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = data->model_data->vref_voltage;
+		*val = data->model_data->vref_fixed_mv;
 		*val2 = ASPEED_RESOLUTION_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -320,17 +324,23 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 
 static const struct aspeed_adc_model_data ast2400_model_data = {
 	.model_name = "ast2400-adc",
-	.vref_voltage = 2500, // mV
+	.vref_fixed_mv = 2500,
 	.min_sampling_rate = 10000,
 	.max_sampling_rate = 500000,
+	.need_prescaler = true,
+	.scaler_bit_width = 10,
+	.num_channels = 16,
 };
 
 static const struct aspeed_adc_model_data ast2500_model_data = {
 	.model_name = "ast2500-adc",
-	.vref_voltage = 1800, // mV
+	.vref_fixed_mv = 1800,
 	.min_sampling_rate = 1,
 	.max_sampling_rate = 1000000,
 	.wait_init_sequence = true,
+	.need_prescaler = true,
+	.scaler_bit_width = 10,
+	.num_channels = 16,
 };
 
 static const struct of_device_id aspeed_adc_matches[] = {
-- 
2.25.1

