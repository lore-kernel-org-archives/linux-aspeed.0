From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:06 +0200
Subject: [PATCH 03/16] mtd: spi-nor: aspeed: Link controller with the ahb clock
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-4-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We will need the AHB frequency to set the HCLK settings in the SMC
controller to perform the read training.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index c775e0612613..facd8fc16ca3 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -109,6 +110,8 @@ struct aspeed_smc_controller {
 	void __iomem *ahb_base;			/* per-chip windows resource */
 	u32 ahb_window_size;			/* full mapping window size */
 
+	unsigned long	clk_frequency;
+
 	struct aspeed_smc_chip *chips[0];	/* pointers to attached chips */
 };
 
@@ -909,6 +912,7 @@ static int aspeed_smc_probe(struct platform_device *pdev)
 	struct aspeed_smc_controller *controller;
 	const struct of_device_id *match;
 	const struct aspeed_smc_info *info;
+	struct clk *clk;
 	struct resource *res;
 	int ret;
 
@@ -940,6 +944,12 @@ static int aspeed_smc_probe(struct platform_device *pdev)
 
 	controller->ahb_window_size = resource_size(res);
 
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	controller->clk_frequency = clk_get_rate(clk);
+	devm_clk_put(&pdev->dev, clk);
+
 	ret = aspeed_smc_setup_flash(controller, np, res);
 	if (ret)
 		dev_err(dev, "Aspeed SMC probe failed %d\n", ret);
-- 
2.21.0

