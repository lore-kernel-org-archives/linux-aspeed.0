From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:26 +0800
Subject: [PATCH -next 14/25] spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-15-lizetao1@huawei.com>
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

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-lantiq-ssc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 938e9e577e4f..18a46569ba46 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -932,14 +932,11 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_host_put;
 
-	spi->spi_clk = devm_clk_get(dev, "gate");
+	spi->spi_clk = devm_clk_get_enabled(dev, "gate");
 	if (IS_ERR(spi->spi_clk)) {
 		err = PTR_ERR(spi->spi_clk);
 		goto err_host_put;
 	}
-	err = clk_prepare_enable(spi->spi_clk);
-	if (err)
-		goto err_host_put;
 
 	/*
 	 * Use the old clk_get_fpi() function on Lantiq platform, till it
@@ -952,7 +949,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 #endif
 	if (IS_ERR(spi->fpi_clk)) {
 		err = PTR_ERR(spi->fpi_clk);
-		goto err_clk_disable;
+		goto err_host_put;
 	}
 
 	num_cs = 8;
@@ -1010,8 +1007,6 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	destroy_workqueue(spi->wq);
 err_clk_put:
 	clk_put(spi->fpi_clk);
-err_clk_disable:
-	clk_disable_unprepare(spi->spi_clk);
 err_host_put:
 	spi_controller_put(host);
 
@@ -1029,7 +1024,6 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 	hw_enter_config_mode(spi);
 
 	destroy_workqueue(spi->wq);
-	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
 }
 
-- 
2.34.1

