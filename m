From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:15 +0800
Subject: [PATCH -next v2 02/25] spi: armada-3700: Use helper function devm_clk_get_prepared()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-3-lizetao1@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
by devm_clk_get_prepared() when driver prepares the clocks for the whole
lifetime of the device. Moreover, it is no longer necessary to unprepare
the clocks explicitly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Drop the empty remove function a3700_spi_remove().

 drivers/spi/spi-armada-3700.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 0103ac0158c0..3c9ed412932f 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -865,18 +865,12 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 	init_completion(&spi->done);
 
-	spi->clk = devm_clk_get(dev, NULL);
+	spi->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		dev_err(dev, "could not find clk: %ld\n", PTR_ERR(spi->clk));
 		goto error;
 	}
 
-	ret = clk_prepare(spi->clk);
-	if (ret) {
-		dev_err(dev, "could not prepare clk: %d\n", ret);
-		goto error;
-	}
-
 	host->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
 					clk_get_rate(spi->clk));
 	host->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
@@ -888,40 +882,29 @@ static int a3700_spi_probe(struct platform_device *pdev)
 			       dev_name(dev), host);
 	if (ret) {
 		dev_err(dev, "could not request IRQ: %d\n", ret);
-		goto error_clk;
+		goto error;
 	}
 
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "Failed to register host\n");
-		goto error_clk;
+		goto error;
 	}
 
 	return 0;
 
-error_clk:
-	clk_unprepare(spi->clk);
 error:
 	spi_controller_put(host);
 out:
 	return ret;
 }
 
-static void a3700_spi_remove(struct platform_device *pdev)
-{
-	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct a3700_spi *spi = spi_controller_get_devdata(host);
-
-	clk_unprepare(spi->clk);
-}
-
 static struct platform_driver a3700_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
 	},
 	.probe		= a3700_spi_probe,
-	.remove_new	= a3700_spi_remove,
 };
 
 module_platform_driver(a3700_spi_driver);
-- 
2.34.1

