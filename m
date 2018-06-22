From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 22 Jun 2018 14:14:16 +0200
Subject: [PATCH 3/4] mtd: spi-nor: aspeed: retrieve the ABH clock frequency
In-Reply-To: <20180622121417.6762-1-clg@kaod.org>
References: <20180622121417.6762-1-clg@kaod.org>
Message-ID: <20180622121417.6762-4-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

We will need the AHB frequency to set the SPI clock frequency to
perform the SPI calibration sequence and optimize the controller
settings for the fast reads.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-=
smc.c
index 054614f34698..0251724eeecb 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -10,6 +10,7 @@
  */
=20
 #include <linux/bug.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -113,6 +114,8 @@ struct aspeed_smc_controller {
 	void __iomem *ahb_base;			/* per-chip windows resource */
 	u32 ahb_window_size;			/* full mapping window size */
=20
+	unsigned long	clk_frequency;
+
 	struct aspeed_smc_chip *chips[0];	/* pointers to attached chips */
 };
=20
@@ -911,6 +914,7 @@ static int aspeed_smc_probe(struct platform_device *pde=
v)
 	struct aspeed_smc_controller *controller;
 	const struct of_device_id *match;
 	const struct aspeed_smc_info *info;
+	struct clk *clk;
 	struct resource *res;
 	int ret;
=20
@@ -942,6 +946,12 @@ static int aspeed_smc_probe(struct platform_device *pd=
ev)
=20
 	controller->ahb_window_size =3D resource_size(res);
=20
+	clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	controller->clk_frequency =3D clk_get_rate(clk);
+	devm_clk_put(&pdev->dev, clk);
+
 	ret =3D aspeed_smc_setup_flash(controller, np, res);
 	if (ret)
 		dev_err(dev, "Aspeed SMC probe failed %d\n", ret);
--=20
2.13.6

