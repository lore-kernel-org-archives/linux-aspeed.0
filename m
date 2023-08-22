From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:18 +0800
Subject: [PATCH -next 06/25] spi: bcm2835: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-7-lizetao1@huawei.com>
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
 drivers/spi/spi-bcm2835.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e7bb2714678a..a457ad2f7db1 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1352,7 +1352,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
-	bs->clk = devm_clk_get(&pdev->dev, NULL);
+	bs->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(bs->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(bs->clk),
 				     "could not get clk\n");
@@ -1363,14 +1363,11 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	if (bs->irq < 0)
 		return bs->irq;
 
-	err = clk_prepare_enable(bs->clk);
-	if (err)
-		return err;
 	bs->clk_hz = clk_get_rate(bs->clk);
 
 	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
 	if (err)
-		goto out_clk_disable;
+		return err;
 
 	/* initialise the hardware with the default polarities */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
@@ -1396,8 +1393,6 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 out_dma_release:
 	bcm2835_dma_release(ctlr, bs);
-out_clk_disable:
-	clk_disable_unprepare(bs->clk);
 	return err;
 }
 
@@ -1415,8 +1410,6 @@ static void bcm2835_spi_remove(struct platform_device *pdev)
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-
-	clk_disable_unprepare(bs->clk);
 }
 
 static const struct of_device_id bcm2835_spi_match[] = {
-- 
2.34.1

