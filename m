From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 7 Nov 2022 17:15:05 +0800
Subject: [v2 1/2] iio: adc: aspeed: Remove the trim valid dts property.
Message-ID: <20221107091506.28630-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The dts property "aspeed,trim-data-valid" is currently used to determine
whether to read trimming data from the OTP register. If this is set on
a device without valid trimming data in the OTP the ADC will not function
correctly. This patch drops the use of this property and instead uses the
default (unprogrammed) OTP value of 0 to detect when a fallback value of
0x8 should be used rather then the value read from the OTP.

Fixes: d0a4c17b4073 ("iio: adc: aspeed: Get and set trimming data.")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 9341e0e0eb55..998e8bcc06e1 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -202,6 +202,8 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 				((scu_otp) &
 				 (data->model_data->trim_locate->field)) >>
 				__ffs(data->model_data->trim_locate->field);
+			if (!trimming_val)
+				trimming_val = 0x8;
 		}
 		dev_dbg(data->dev,
 			"trimming val = %d, offset = %08x, fields = %08x\n",
@@ -563,12 +565,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_find_property(data->dev->of_node, "aspeed,trim-data-valid",
-			     NULL)) {
-		ret = aspeed_adc_set_trim_data(indio_dev);
-		if (ret)
-			return ret;
-	}
+	ret = aspeed_adc_set_trim_data(indio_dev);
+	if (ret)
+		return ret;
 
 	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
 			     NULL)) {
-- 
2.25.1

