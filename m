From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:34 +0800
Subject: [PATCH -next 22/25] spi: pic32-sqi: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-23-lizetao1@huawei.com>
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
 drivers/spi/spi-pic32-sqi.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5cbebcf26a2a..d894b99e4104 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -593,33 +593,20 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	}
 
 	/* clocks */
-	sqi->sys_clk = devm_clk_get(&pdev->dev, "reg_ck");
+	sqi->sys_clk = devm_clk_get_enabled(&pdev->dev, "reg_ck");
 	if (IS_ERR(sqi->sys_clk)) {
 		ret = PTR_ERR(sqi->sys_clk);
 		dev_err(&pdev->dev, "no sys_clk ?\n");
 		goto err_free_master;
 	}
 
-	sqi->base_clk = devm_clk_get(&pdev->dev, "spi_ck");
+	sqi->base_clk = devm_clk_get_enabled(&pdev->dev, "spi_ck");
 	if (IS_ERR(sqi->base_clk)) {
 		ret = PTR_ERR(sqi->base_clk);
 		dev_err(&pdev->dev, "no base clk ?\n");
 		goto err_free_master;
 	}
 
-	ret = clk_prepare_enable(sqi->sys_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "sys clk enable failed\n");
-		goto err_free_master;
-	}
-
-	ret = clk_prepare_enable(sqi->base_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "base clk enable failed\n");
-		clk_disable_unprepare(sqi->sys_clk);
-		goto err_free_master;
-	}
-
 	init_completion(&sqi->xfer_done);
 
 	/* initialize hardware */
@@ -629,7 +616,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	ret = ring_desc_ring_alloc(sqi);
 	if (ret) {
 		dev_err(&pdev->dev, "ring alloc failed\n");
-		goto err_disable_clk;
+		goto err_free_master;
 	}
 
 	/* install irq handlers */
@@ -669,10 +656,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 err_free_ring:
 	ring_desc_ring_free(sqi);
 
-err_disable_clk:
-	clk_disable_unprepare(sqi->base_clk);
-	clk_disable_unprepare(sqi->sys_clk);
-
 err_free_master:
 	spi_master_put(master);
 	return ret;
@@ -685,10 +668,6 @@ static void pic32_sqi_remove(struct platform_device *pdev)
 	/* release resources */
 	free_irq(sqi->irq, sqi);
 	ring_desc_ring_free(sqi);
-
-	/* disable clk */
-	clk_disable_unprepare(sqi->base_clk);
-	clk_disable_unprepare(sqi->sys_clk);
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {
-- 
2.34.1

