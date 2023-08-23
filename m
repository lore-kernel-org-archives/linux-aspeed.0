From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:33 +0800
Subject: [PATCH -next v2 20/25] spi: npcm-fiu: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-21-lizetao1@huawei.com>
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

 drivers/spi/spi-npcm-fiu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 0ca21ff0e9cc..1a5277ff349f 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -699,7 +699,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	struct spi_controller *ctrl;
 	struct npcm_fiu_spi *fiu;
 	void __iomem *regbase;
-	int id, ret;
+	int id;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*fiu));
 	if (!ctrl)
@@ -737,7 +737,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 
 	fiu->res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						    "memory");
-	fiu->clk = devm_clk_get(dev, NULL);
+	fiu->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(fiu->clk))
 		return PTR_ERR(fiu->clk);
 
@@ -745,7 +745,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 					       "nuvoton,spix-mode");
 
 	platform_set_drvdata(pdev, fiu);
-	clk_prepare_enable(fiu->clk);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
 		| SPI_TX_DUAL | SPI_TX_QUAD;
@@ -755,18 +754,11 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = fiu->info->max_cs;
 	ctrl->dev.of_node = dev->of_node;
 
-	ret = devm_spi_register_controller(dev, ctrl);
-	if (ret)
-		clk_disable_unprepare(fiu->clk);
-
-	return ret;
+	return devm_spi_register_controller(dev, ctrl);
 }
 
 static void npcm_fiu_remove(struct platform_device *pdev)
 {
-	struct npcm_fiu_spi *fiu = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(fiu->clk);
 }
 
 MODULE_DEVICE_TABLE(of, npcm_fiu_dt_ids);
-- 
2.34.1

