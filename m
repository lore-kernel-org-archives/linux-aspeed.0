From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:25 +0800
Subject: [PATCH -next 13/25] spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-14-lizetao1@huawei.com>
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
 drivers/spi/spi-fsl-dspi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8318249f8a1f..c9eae046f66c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1372,19 +1372,16 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
+	dspi->clk = devm_clk_get_enabled(&pdev->dev, "dspi");
 	if (IS_ERR(dspi->clk)) {
 		ret = PTR_ERR(dspi->clk);
 		dev_err(&pdev->dev, "unable to get clock\n");
 		goto out_ctlr_put;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto out_ctlr_put;
 
 	ret = dspi_init(dspi);
 	if (ret)
-		goto out_clk_put;
+		goto out_ctlr_put;
 
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
@@ -1400,7 +1397,7 @@ static int dspi_probe(struct platform_device *pdev)
 				   IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
-		goto out_clk_put;
+		goto out_ctlr_put;
 	}
 
 poll_mode:
@@ -1432,8 +1429,6 @@ static int dspi_probe(struct platform_device *pdev)
 out_free_irq:
 	if (dspi->irq)
 		free_irq(dspi->irq, dspi);
-out_clk_put:
-	clk_disable_unprepare(dspi->clk);
 out_ctlr_put:
 	spi_controller_put(ctlr);
 
@@ -1458,7 +1453,6 @@ static void dspi_remove(struct platform_device *pdev)
 	dspi_release_dma(dspi);
 	if (dspi->irq)
 		free_irq(dspi->irq, dspi);
-	clk_disable_unprepare(dspi->clk);
 }
 
 static void dspi_shutdown(struct platform_device *pdev)
-- 
2.34.1

