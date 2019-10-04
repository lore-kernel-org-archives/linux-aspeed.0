From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:10 +0200
Subject: [PATCH 07/16] mtd: spi-nor: aspeed: Add support for the 4B opcodes
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-8-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Switch the default controller value to use the read mode in order to
customize the command and use SPINOR_OP_READ_4B (0x13) when the chip
supports 4B opcodes.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 1c1822a13407..add95a9aca76 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -888,14 +888,21 @@ static u32 aspeed_smc_default_read(struct aspeed_smc_chip *chip)
 	 */
 	u32 ctl_mask = chip->controller->info == &spi_2400_info ?
 		 CONTROL_IO_ADDRESS_4B : 0;
+	u8 cmd = chip->nor.flags & SNOR_F_4B_OPCODES ? SPINOR_OP_READ_4B :
+		SPINOR_OP_READ;
 
+	/*
+	 * Use the "read command" mode to customize the opcode. In
+	 * normal command mode, the value is necessarily READ (0x3) on
+	 * the AST2400/2500 SoCs.
+	 */
 	return (chip->ctl_val[smc_read] & ctl_mask) |
 		(0x00 << 28) | /* Single bit */
 		(0x00 << 24) | /* CE# max */
-		(0x03 << 16) | /* use normal reads */
+		(cmd  << 16) | /* use read mode to support 4B opcode */
 		(0x00 <<  8) | /* HCLK/16 */
 		(0x00 <<  6) | /* no dummy cycle */
-		(0x00);        /* normal mode */
+		(0x01);        /* read mode */
 }
 
 static int aspeed_smc_optimize_read(struct aspeed_smc_chip *chip,
-- 
2.21.0

