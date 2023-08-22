From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:33 +0800
Subject: [PATCH -next 21/25] spi: orion: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-22-lizetao1@huawei.com>
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
 drivers/spi/spi-orion.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index faf2764b91a8..d22bb67fee00 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -688,21 +688,17 @@ static int orion_spi_probe(struct platform_device *pdev)
 	devdata = devdata ? devdata : &orion_spi_dev_data;
 	spi->devdata = devdata;
 
-	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		status = PTR_ERR(spi->clk);
 		goto out;
 	}
 
-	status = clk_prepare_enable(spi->clk);
-	if (status)
-		goto out;
-
 	/* The following clock is only used by some SoCs */
 	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
 	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
 		status = -EPROBE_DEFER;
-		goto out_rel_clk;
+		goto out;
 	}
 	if (!IS_ERR(spi->axi_clk))
 		clk_prepare_enable(spi->axi_clk);
@@ -795,8 +791,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
-out_rel_clk:
-	clk_disable_unprepare(spi->clk);
 out:
 	spi_master_put(master);
 	return status;
@@ -810,7 +804,6 @@ static void orion_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
-	clk_disable_unprepare(spi->clk);
 
 	spi_unregister_master(master);
 	pm_runtime_disable(&pdev->dev);
-- 
2.34.1

