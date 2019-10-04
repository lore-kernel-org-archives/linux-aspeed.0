From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:12 +0200
Subject: [PATCH 09/16] mtd: spi-nor: aspeed: Introduce a field for the AHB
 physical address
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-10-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On the AST2600, we will use this field to compute the address of the
chip AHB window from the Segment Register value. It also removes the
need of aspeed_smc_ahb_base_phy() helper.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index add95a9aca76..c5a0c8d94371 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -121,7 +121,8 @@ struct aspeed_smc_controller {
 	struct mutex mutex;			/* controller access mutex */
 	const struct aspeed_smc_info *info;	/* type info of controller */
 	void __iomem *regs;			/* controller registers */
-	void __iomem *ahb_base;			/* per-chip windows resource */
+	void __iomem *ahb_base;			/* per-chip window resource */
+	u32 ahb_base_phy;			/* phys addr of AHB window  */
 	u32 ahb_window_size;			/* full mapping window size */
 
 	unsigned long	clk_frequency;
@@ -533,21 +534,13 @@ static void __iomem *aspeed_smc_chip_base(struct aspeed_smc_chip *chip,
 	return controller->ahb_base + offset;
 }
 
-static u32 aspeed_smc_ahb_base_phy(struct aspeed_smc_controller *controller)
-{
-	u32 seg0_val = readl(SEGMENT_ADDR_REG(controller, 0));
-
-	return SEGMENT_ADDR_START(seg0_val);
-}
-
 static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 			    u32 size)
 {
 	struct aspeed_smc_controller *controller = chip->controller;
 	void __iomem *seg_reg;
-	u32 seg_oldval, seg_newval, ahb_base_phy, end;
-
-	ahb_base_phy = aspeed_smc_ahb_base_phy(controller);
+	u32 seg_oldval, seg_newval, end;
+	u32 ahb_base_phy = controller->ahb_base_phy;
 
 	seg_reg = SEGMENT_ADDR_REG(controller, cs);
 	seg_oldval = readl(seg_reg);
@@ -636,7 +629,7 @@ static u32 aspeed_smc_chip_set_segment(struct aspeed_smc_chip *chip)
 			 chip->cs, size >> 20);
 	}
 
-	ahb_base_phy = aspeed_smc_ahb_base_phy(controller);
+	ahb_base_phy = controller->ahb_base_phy;
 
 	/*
 	 * As a start address for the current segment, use the default
@@ -1158,6 +1151,7 @@ static int aspeed_smc_probe(struct platform_device *pdev)
 		return PTR_ERR(controller->regs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	controller->ahb_base_phy = res->start;
 	controller->ahb_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(controller->ahb_base))
 		return PTR_ERR(controller->ahb_base);
-- 
2.21.0

