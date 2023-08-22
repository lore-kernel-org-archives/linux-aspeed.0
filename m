From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:37 +0800
Subject: [PATCH -next 25/25] spi: rockchip: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-26-lizetao1@huawei.com>
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
 drivers/spi/spi-rockchip.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a37943847e81..cdbb86049d59 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -782,42 +782,30 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 	}
 
-	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	rs->apb_pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
 		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
 		ret = PTR_ERR(rs->apb_pclk);
 		goto err_put_ctlr;
 	}
 
-	rs->spiclk = devm_clk_get(&pdev->dev, "spiclk");
+	rs->spiclk = devm_clk_get_enabled(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
 		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
 		ret = PTR_ERR(rs->spiclk);
 		goto err_put_ctlr;
 	}
 
-	ret = clk_prepare_enable(rs->apb_pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
-		goto err_put_ctlr;
-	}
-
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
-		goto err_disable_apbclk;
-	}
-
 	spi_enable_chip(rs, false);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 
 	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
 			IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
 	if (ret)
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
@@ -843,7 +831,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
 		ret = -EINVAL;
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
@@ -937,10 +925,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_tx);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-err_disable_spiclk:
-	clk_disable_unprepare(rs->spiclk);
-err_disable_apbclk:
-	clk_disable_unprepare(rs->apb_pclk);
 err_put_ctlr:
 	spi_controller_put(ctlr);
 
@@ -950,13 +934,9 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 static void rockchip_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = spi_controller_get(platform_get_drvdata(pdev));
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.34.1

