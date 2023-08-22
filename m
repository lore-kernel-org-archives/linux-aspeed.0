From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:28 +0800
Subject: [PATCH -next 16/25] spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-17-lizetao1@huawei.com>
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
Moreover, the lable "out_clk" no longer makes sense, rename it to "out_pm".

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-meson-spifc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..d70a18885b49 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -312,19 +312,13 @@ static int meson_spifc_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	spifc->clk = devm_clk_get(spifc->dev, NULL);
+	spifc->clk = devm_clk_get_enabled(spifc->dev, NULL);
 	if (IS_ERR(spifc->clk)) {
 		dev_err(spifc->dev, "missing clock\n");
 		ret = PTR_ERR(spifc->clk);
 		goto out_err;
 	}
 
-	ret = clk_prepare_enable(spifc->clk);
-	if (ret) {
-		dev_err(spifc->dev, "can't prepare clock\n");
-		goto out_err;
-	}
-
 	rate = clk_get_rate(spifc->clk);
 
 	master->num_chipselect = 1;
@@ -343,12 +337,11 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(spifc->dev, master);
 	if (ret) {
 		dev_err(spifc->dev, "failed to register spi master\n");
-		goto out_clk;
+		goto out_pm;
 	}
 
 	return 0;
-out_clk:
-	clk_disable_unprepare(spifc->clk);
+out_pm:
 	pm_runtime_disable(spifc->dev);
 out_err:
 	spi_master_put(master);
@@ -357,11 +350,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 
 static void meson_spifc_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
-
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spifc->clk);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1

