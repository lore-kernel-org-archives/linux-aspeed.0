From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:30 +0800
Subject: [PATCH -next v2 17/25] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-18-lizetao1@huawei.com>
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

 drivers/spi/spi-microchip-core-qspi.c | 29 +++++++--------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 4f76ddf97b10..396dfc0fa278 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -518,30 +518,23 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->regs),
 				     "failed to map registers\n");
 
-	qspi->clk = devm_clk_get(&pdev->dev, NULL);
+	qspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->clk),
 				     "could not get clock\n");
 
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to enable clock\n");
-
 	init_completion(&qspi->data_completion);
 	mutex_init(&qspi->op_lock);
 
 	qspi->irq = platform_get_irq(pdev, 0);
-	if (qspi->irq < 0) {
-		ret = qspi->irq;
-		goto out;
-	}
+	if (qspi->irq < 0)
+		return qspi->irq;
 
 	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
 			       IRQF_SHARED, pdev->name, qspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -552,18 +545,11 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "spi_register_controller failed\n");
-		goto out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "spi_register_controller failed\n");
 
 	return 0;
-
-out:
-	clk_disable_unprepare(qspi->clk);
-
-	return ret;
 }
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
@@ -574,7 +560,6 @@ static void mchp_coreqspi_remove(struct platform_device *pdev)
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
-	clk_disable_unprepare(qspi->clk);
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {
-- 
2.34.1

