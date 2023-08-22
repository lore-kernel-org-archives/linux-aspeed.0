From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:13 +0800
Subject: [PATCH -next 01/25] spi: ar934x: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-2-lizetao1@huawei.com>
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
 drivers/spi/spi-ar934x.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index 58b98cea31d9..5ba988720851 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -168,27 +168,21 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	struct ar934x_spi *sp;
 	void __iomem *base;
 	struct clk *clk;
-	int ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_info(&pdev->dev, "failed to allocate spi controller\n");
-		ret = -ENOMEM;
-		goto err_clk_disable;
+		return -ENOMEM;
 	}
 
 	/* disable flash mapping and expose spi controller registers */
@@ -212,25 +206,15 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	sp->clk_freq = clk_get_rate(clk);
 	sp->ctlr = ctlr;
 
-	ret = spi_register_controller(ctlr);
-	if (!ret)
-		return 0;
-
-err_clk_disable:
-	clk_disable_unprepare(clk);
-	return ret;
+	return spi_register_controller(ctlr);
 }
 
 static void ar934x_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
-	struct ar934x_spi *sp;
 
 	ctlr = dev_get_drvdata(&pdev->dev);
-	sp = spi_controller_get_devdata(ctlr);
-
 	spi_unregister_controller(ctlr);
-	clk_disable_unprepare(sp->clk);
 }
 
 static struct platform_driver ar934x_spi_driver = {
-- 
2.34.1

