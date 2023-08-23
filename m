From: Li Zetao <lizetao1@huawei.com>
Date: Wed, 23 Aug 2023 21:39:22 +0800
Subject: [PATCH -next v2 09/25] spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
Message-ID: <20230823133938.1359106-10-lizetao1@huawei.com>
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

 drivers/spi/spi-cavium-thunderx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index f7c378a5f1bc..337aef12abcc 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -49,16 +49,12 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	p->regs.tx = 0x1010;
 	p->regs.data = 0x1080;
 
-	p->clk = devm_clk_get(dev, NULL);
+	p->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(p->clk)) {
 		ret = PTR_ERR(p->clk);
 		goto error;
 	}
 
-	ret = clk_prepare_enable(p->clk);
-	if (ret)
-		goto error;
-
 	p->sys_freq = clk_get_rate(p->clk);
 	if (!p->sys_freq)
 		p->sys_freq = SYS_FREQ_DEFAULT;
@@ -82,7 +78,6 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 	return 0;
 
 error:
-	clk_disable_unprepare(p->clk);
 	pci_release_regions(pdev);
 	spi_controller_put(host);
 	return ret;
@@ -97,7 +92,6 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
-	clk_disable_unprepare(p->clk);
 	pci_release_regions(pdev);
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-- 
2.34.1

