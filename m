From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:19 +0800
Subject: [PATCH -next 07/25] spi: bcm2835aux: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-8-lizetao1@huawei.com>
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
 drivers/spi/spi-bcm2835aux.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 6d2a5d9f2498..06fe155a70c9 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -512,7 +512,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
-	bs->clk = devm_clk_get(&pdev->dev, NULL);
+	bs->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
@@ -523,19 +523,11 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	if (bs->irq < 0)
 		return bs->irq;
 
-	/* this also enables the HW block */
-	err = clk_prepare_enable(bs->clk);
-	if (err) {
-		dev_err(&pdev->dev, "could not prepare clock: %d\n", err);
-		return err;
-	}
-
 	/* just checking if the clock returns a sane value */
 	clk_hz = clk_get_rate(bs->clk);
 	if (!clk_hz) {
 		dev_err(&pdev->dev, "clock returns 0 Hz\n");
-		err = -ENODEV;
-		goto out_clk_disable;
+		return -ENODEV;
 	}
 
 	/* reset SPI-HW block */
@@ -547,22 +539,18 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), host);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
-		goto out_clk_disable;
+		return err;
 	}
 
 	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI host: %d\n", err);
-		goto out_clk_disable;
+		return err;
 	}
 
 	bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
 
 	return 0;
-
-out_clk_disable:
-	clk_disable_unprepare(bs->clk);
-	return err;
 }
 
 static void bcm2835aux_spi_remove(struct platform_device *pdev)
@@ -575,9 +563,6 @@ static void bcm2835aux_spi_remove(struct platform_device *pdev)
 	spi_unregister_controller(host);
 
 	bcm2835aux_spi_reset_hw(bs);
-
-	/* disable the HW block by releasing the clock */
-	clk_disable_unprepare(bs->clk);
 }
 
 static const struct of_device_id bcm2835aux_spi_match[] = {
-- 
2.34.1

