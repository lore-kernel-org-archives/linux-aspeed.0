From: Colin King <colin.king@canonical.com>
Date: Fri,  1 Oct 2021 13:00:18 +0100
Subject: [PATCH][next] iio: adc: aspeed: Fix spelling mistake "battey" ->
 "battery"
Message-ID: <20211001120018.17570-1-colin.king@canonical.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/aspeed_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 3e9850a43372..a957cad1bfab 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -581,7 +581,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			}
 		} else
 			dev_warn(&pdev->dev,
-				 "Failed to enable battey-sensing mode\n");
+				 "Failed to enable battery-sensing mode\n");
 	}
 
 	ret = clk_prepare_enable(data->clk_scaler->clk);
-- 
2.32.0

