From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:22 +0800
Subject: [PATCH -next 10/25] spi: davinci: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-11-lizetao1@huawei.com>
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
 drivers/spi/spi-davinci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index c457b550d3ad..5688be245c68 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -915,14 +915,11 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.master = host;
 
-	dspi->clk = devm_clk_get(&pdev->dev, NULL);
+	dspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
 		ret = -ENODEV;
 		goto free_host;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto free_host;
 
 	host->use_gpio_descriptors = true;
 	host->dev.of_node = pdev->dev.of_node;
@@ -947,7 +944,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	ret = davinci_spi_request_dma(dspi);
 	if (ret == -EPROBE_DEFER) {
-		goto free_clk;
+		goto free_host;
 	} else if (ret) {
 		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
 		dspi->dma_rx = NULL;
@@ -991,8 +988,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
-free_clk:
-	clk_disable_unprepare(dspi->clk);
 free_host:
 	spi_controller_put(host);
 err:
@@ -1018,8 +1013,6 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
-	clk_disable_unprepare(dspi->clk);
-
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.34.1

