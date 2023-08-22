From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:35 +0800
Subject: [PATCH -next 23/25] spi: pic32: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-24-lizetao1@huawei.com>
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
 drivers/spi/spi-pic32.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index e9b4c9cb97fb..2b0680974cba 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -730,17 +730,13 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 		return pic32s->tx_irq;
 
 	/* get clock */
-	pic32s->clk = devm_clk_get(&pdev->dev, "mck0");
+	pic32s->clk = devm_clk_get_enabled(&pdev->dev, "mck0");
 	if (IS_ERR(pic32s->clk)) {
 		dev_err(&pdev->dev, "clk not found\n");
 		ret = PTR_ERR(pic32s->clk);
 		goto err_unmap_mem;
 	}
 
-	ret = clk_prepare_enable(pic32s->clk);
-	if (ret)
-		goto err_unmap_mem;
-
 	pic32_spi_hw_init(pic32s);
 
 	return 0;
@@ -837,7 +833,6 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 err_bailout:
 	pic32_spi_dma_unprep(pic32s);
-	clk_disable_unprepare(pic32s->clk);
 err_master:
 	spi_master_put(master);
 	return ret;
@@ -849,7 +844,6 @@ static void pic32_spi_remove(struct platform_device *pdev)
 
 	pic32s = platform_get_drvdata(pdev);
 	pic32_spi_disable(pic32s);
-	clk_disable_unprepare(pic32s->clk);
 	pic32_spi_dma_unprep(pic32s);
 }
 
-- 
2.34.1

