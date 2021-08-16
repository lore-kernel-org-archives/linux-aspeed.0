From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 16 Aug 2021 18:48:38 +0800
Subject: [v3 07/15] iio: adc: aspeed: Set num_channels with model data
In-Reply-To: <20210816104846.13155-1-billy_tsai@aspeedtech.com>
References: <20210816104846.13155-1-billy_tsai@aspeedtech.com>
Message-ID: <20210816104846.13155-8-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the model_data member num_channels to set the num_channels of iio
device.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index f260e40ab9b2..2d6215a91f99 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -291,7 +291,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	indio_dev->info = &aspeed_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = aspeed_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
+	indio_dev->num_channels = data->model_data->num_channels;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
2.25.1

