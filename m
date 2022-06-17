From: Liang He <windhl@126.com>
Date: Fri, 17 Jun 2022 22:41:06 +0800
Subject: [PATCH] iio: adc: Fix refcount leak bug in aspeed_adc
Message-ID: <20220617144106.4050677-1-windhl@126.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In aspeed_adc_set_trim_data(), of_find_node_by_name() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 0793d2474cdc..9341e0e0eb55 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -186,6 +186,7 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 		return -EOPNOTSUPP;
 	}
 	scu = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(scu)) {
 		dev_warn(data->dev, "Failed to get syscon regmap\n");
 		return -EOPNOTSUPP;
-- 
2.25.1

