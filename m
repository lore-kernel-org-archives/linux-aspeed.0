From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:16 +0800
Subject: [PATCH -next v2 03/25] spi: aspeed: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-4-lizetao1@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: None

 drivers/spi/spi-aspeed-smc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 21b0fa646c7d..bbd417c55e7f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -748,7 +748,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	aspi->ahb_window_size = resource_size(res);
 	aspi->ahb_base_phy = res->start;
 
-	aspi->clk = devm_clk_get(&pdev->dev, NULL);
+	aspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(aspi->clk)) {
 		dev_err(dev, "missing clock\n");
 		return PTR_ERR(aspi->clk);
@@ -760,12 +760,6 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = clk_prepare_enable(aspi->clk);
-	if (ret) {
-		dev_err(dev, "can not enable the clock\n");
-		return ret;
-	}
-
 	/* IRQ is for DMA, which the driver doesn't support yet */
 
 	ctlr->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | data->mode_bits;
@@ -777,14 +771,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = dev->of_node;
 
 	ret = devm_spi_register_controller(dev, ctlr);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto disable_clk;
-	}
-	return 0;
 
-disable_clk:
-	clk_disable_unprepare(aspi->clk);
 	return ret;
 }
 
@@ -793,7 +782,6 @@ static void aspeed_spi_remove(struct platform_device *pdev)
 	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
 
 	aspeed_spi_enable(aspi, false);
-	clk_disable_unprepare(aspi->clk);
 }
 
 /*
-- 
2.34.1

