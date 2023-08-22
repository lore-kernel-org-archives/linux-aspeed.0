From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:24 +0800
Subject: [PATCH -next 12/25] spi: dw-mmio: Use helper function devm_clk_get_*()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-13-lizetao1@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly. Also,
devm_clk_get_optional() and clk_prepare_enable() can now be replaced by
devm_clk_get_optional_enabled(). Moreover, the lable "out_clk" no longer
makes sense, rename it to "out_reset".

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-dw-mmio.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 805264c9c65c..6d9f64ecbfd6 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -340,28 +340,22 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (dws->irq < 0)
 		return dws->irq; /* -ENXIO */
 
-	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
+	dwsmmio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
 		return PTR_ERR(dwsmmio->clk);
-	ret = clk_prepare_enable(dwsmmio->clk);
-	if (ret)
-		return ret;
 
 	/* Optional clock needed to access the registers */
-	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	dwsmmio->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(dwsmmio->pclk)) {
 		ret = PTR_ERR(dwsmmio->pclk);
-		goto out_clk;
+		goto out_reset;
 	}
-	ret = clk_prepare_enable(dwsmmio->pclk);
-	if (ret)
-		goto out_clk;
 
 	/* find an optional reset controller */
 	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(dwsmmio->rstc)) {
 		ret = PTR_ERR(dwsmmio->rstc);
-		goto out_clk;
+		goto out_reset;
 	}
 	reset_control_deassert(dwsmmio->rstc);
 
@@ -397,9 +391,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 out:
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(dwsmmio->pclk);
-out_clk:
-	clk_disable_unprepare(dwsmmio->clk);
+out_reset:
 	reset_control_assert(dwsmmio->rstc);
 
 	return ret;
@@ -411,8 +403,6 @@ static void dw_spi_mmio_remove(struct platform_device *pdev)
 
 	dw_spi_remove_host(&dwsmmio->dws);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(dwsmmio->pclk);
-	clk_disable_unprepare(dwsmmio->clk);
 	reset_control_assert(dwsmmio->rstc);
 }
 
-- 
2.34.1

