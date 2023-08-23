From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:28 +0800
Subject: [PATCH -next v2 15/25] spi: meson-spicc: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-16-lizetao1@huawei.com>
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
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: None

 drivers/spi/spi-meson-spicc.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 43d134f4b42b..1f2d26254e03 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -820,7 +820,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_master;
 	}
 
-	spicc->core = devm_clk_get(&pdev->dev, "core");
+	spicc->core = devm_clk_get_enabled(&pdev->dev, "core");
 	if (IS_ERR(spicc->core)) {
 		dev_err(&pdev->dev, "core clock request failed\n");
 		ret = PTR_ERR(spicc->core);
@@ -828,7 +828,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	}
 
 	if (spicc->data->has_pclk) {
-		spicc->pclk = devm_clk_get(&pdev->dev, "pclk");
+		spicc->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 		if (IS_ERR(spicc->pclk)) {
 			dev_err(&pdev->dev, "pclk clock request failed\n");
 			ret = PTR_ERR(spicc->pclk);
@@ -836,22 +836,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = clk_prepare_enable(spicc->core);
-	if (ret) {
-		dev_err(&pdev->dev, "core clock enable failed\n");
-		goto out_master;
-	}
-
-	ret = clk_prepare_enable(spicc->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "pclk clock enable failed\n");
-		goto out_core_clk;
-	}
-
 	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(spicc->pinctrl)) {
 		ret = PTR_ERR(spicc->pinctrl);
-		goto out_clk;
+		goto out_master;
 	}
 
 	device_reset_optional(&pdev->dev);
@@ -878,31 +866,25 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = meson_spicc_pow2_clk_init(spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "pow2 clock registration failed\n");
-		goto out_clk;
+		goto out_master;
 	}
 
 	if (spicc->data->has_enhance_clk_div) {
 		ret = meson_spicc_enh_clk_init(spicc);
 		if (ret) {
 			dev_err(&pdev->dev, "clock registration failed\n");
-			goto out_clk;
+			goto out_master;
 		}
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed\n");
-		goto out_clk;
+		goto out_master;
 	}
 
 	return 0;
 
-out_clk:
-	clk_disable_unprepare(spicc->pclk);
-
-out_core_clk:
-	clk_disable_unprepare(spicc->core);
-
 out_master:
 	spi_master_put(master);
 
@@ -916,9 +898,6 @@ static void meson_spicc_remove(struct platform_device *pdev)
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
 
-	clk_disable_unprepare(spicc->core);
-	clk_disable_unprepare(spicc->pclk);
-
 	spi_master_put(spicc->master);
 }
 
-- 
2.34.1

