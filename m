From: Li Zetao <lizetao1@huawei.com>
Date: Tue, 22 Aug 2023 21:12:16 +0800
Subject: [PATCH -next 04/25] spi: ath79: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
Message-ID: <20230822131237.1022815-5-lizetao1@huawei.com>
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
 drivers/spi/spi-ath79.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 1b6d977d111c..c9f1d1e1dcf7 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -200,20 +200,16 @@ static int ath79_spi_probe(struct platform_device *pdev)
 		goto err_put_host;
 	}
 
-	sp->clk = devm_clk_get(&pdev->dev, "ahb");
+	sp->clk = devm_clk_get_enabled(&pdev->dev, "ahb");
 	if (IS_ERR(sp->clk)) {
 		ret = PTR_ERR(sp->clk);
 		goto err_put_host;
 	}
 
-	ret = clk_prepare_enable(sp->clk);
-	if (ret)
-		goto err_put_host;
-
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
 	if (!rate) {
 		ret = -EINVAL;
-		goto err_clk_disable;
+		goto err_put_host;
 	}
 
 	sp->rrw_delay = ATH79_SPI_RRW_DELAY_FACTOR / rate;
@@ -229,8 +225,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 
 err_disable:
 	ath79_spi_disable(sp);
-err_clk_disable:
-	clk_disable_unprepare(sp->clk);
 err_put_host:
 	spi_controller_put(host);
 
@@ -243,7 +237,6 @@ static void ath79_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
-	clk_disable_unprepare(sp->clk);
 	spi_controller_put(sp->bitbang.master);
 }
 
-- 
2.34.1

