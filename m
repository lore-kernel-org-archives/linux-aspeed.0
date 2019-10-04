From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:16 +0200
Subject: [PATCH 13/16] mtd: spi-nor: aspeed: Check for disabled segments on
 the AST2600
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-14-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On the AST2600, the segment of a flash SPI device can be disabled with
zero register value. By default, the CS0 AHB window is open but the
other CS are not. This is closing the access to the flash device in
user mode and also forbids scanning. For multiple CS, we will need
firmware or a DT property to reopen the flash AHB window.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index c977f8f28aef..fad08738e534 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -307,12 +307,20 @@ static u32 aspeed_smc_segment_end_ast2600(struct aspeed_smc_controller *ctlr,
 {
 	u32 end_offset = reg & AST2600_SEG_ADDR_MASK;
 
+	/* segment is disabled */
+	if (!end_offset)
+		return ctlr->ahb_base_phy;
+
 	return ctlr->ahb_base_phy + end_offset + 0x100000;
 }
 
 static u32 aspeed_smc_segment_reg_ast2600(struct aspeed_smc_controller *ctlr,
 					  u32 start, u32 end)
 {
+	/* disable zero size segments */
+	if (start == end)
+		return 0;
+
 	return ((start & AST2600_SEG_ADDR_MASK) >> 16) |
 		((end - 1) & AST2600_SEG_ADDR_MASK);
 }
@@ -656,8 +664,15 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 	 * size, but take into account the possible overlap with the
 	 * previous segment
 	 */
-	if (!size)
-		size = info->segment_end(controller, seg_oldval) - start;
+	if (!size) {
+		end = info->segment_end(controller, seg_oldval);
+
+		/*
+		 * Check for disabled segment (AST2600).
+		 */
+		if (end != ahb_base_phy)
+			size = end - start;
+	}
 
 	/*
 	 * The segment cannot exceed the maximum window size of the
@@ -686,8 +701,8 @@ static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
 		size = end - start;
 	}
 
-	dev_info(chip->nor.dev, "CE%d window [ 0x%.8x - 0x%.8x ] %dMB",
-		 cs, start, end, size >> 20);
+	dev_info(chip->nor.dev, "CE%d window [ 0x%.8x - 0x%.8x ] %dMB%s",
+		 cs, start, end, size >> 20, size ? "" : " (disabled)");
 
 	return size;
 }
-- 
2.21.0

