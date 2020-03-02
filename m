From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:53 +0000
Subject: [PATCH 15/23] mtd: spi-nor: Move Micron/ST bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-16-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Micron/ST chips, and move the
Micron/ST definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile    |   1 +
 drivers/mtd/spi-nor/core.c      |  98 +-----------------------
 drivers/mtd/spi-nor/core.h      |   2 +
 drivers/mtd/spi-nor/micron-st.c | 129 ++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 96 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/micron-st.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index c94798987801..c7e5fb908bec 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -10,4 +10,5 @@ spi-nor-objs			+= gigadevice.o
 spi-nor-objs			+= intel.o
 spi-nor-objs			+= issi.o
 spi-nor-objs			+= macronix.o
+spi-nor-objs			+= micron-st.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9d0e0fc5af45..8d54dfe33cdc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2017,53 +2017,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* Micron <--> ST Micro */
-	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
-	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
-	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K |
-			      USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K |
-			      USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
-			      USE_FSR | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
-			      USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
-			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
-			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K |
-			      USE_FSR | SPI_NOR_QUAD_READ) },
-	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
-			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
-			      NO_CHIP_ERASE) },
-	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
-
-	/* Micron */
-	{
-		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
-			SPI_NOR_4B_OPCODES)
-	},
-	{ "mt35xu02g",  INFO(0x2c5b1c, 0, 128 * 1024, 2048,
-			     SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
-			     SPI_NOR_4B_OPCODES) },
-
 	/* Spansion/Cypress -- single (large) sector size only, at least
 	 * for the chips listed here (without boot sectors).
 	 */
@@ -2121,42 +2074,6 @@ static const struct flash_info spi_nor_ids[] = {
 			      SPI_NOR_DUAL_READ) },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
-	/* ST Microelectronics -- newer production may have feature updates */
-	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
-	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
-	{ "m25p20",  INFO(0x202012,  0,  64 * 1024,   4, 0) },
-	{ "m25p40",  INFO(0x202013,  0,  64 * 1024,   8, 0) },
-	{ "m25p80",  INFO(0x202014,  0,  64 * 1024,  16, 0) },
-	{ "m25p16",  INFO(0x202015,  0,  64 * 1024,  32, 0) },
-	{ "m25p32",  INFO(0x202016,  0,  64 * 1024,  64, 0) },
-	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128, 0) },
-	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64, 0) },
-
-	{ "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2, 0) },
-	{ "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4, 0) },
-	{ "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4, 0) },
-	{ "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8, 0) },
-	{ "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16, 0) },
-	{ "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32, 0) },
-	{ "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64, 0) },
-	{ "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128, 0) },
-	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
-
-	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
-	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
-	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
-
-	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
-	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
-	{ "m25pe16", INFO(0x208015,  0, 64 * 1024, 32, SECT_4K) },
-
-	{ "m25px16",    INFO(0x207115,  0, 64 * 1024, 32, SECT_4K) },
-	{ "m25px32",    INFO(0x207116,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px32-s0", INFO(0x207316,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px32-s1", INFO(0x206316,  0, 64 * 1024, 64, SECT_4K) },
-	{ "m25px64",    INFO(0x207117,  0, 64 * 1024, 128, 0) },
-	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16, 0) },
-
 	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
 	{ "w25x05", INFO(0xef3010, 0, 64 * 1024,  1,  SECT_4K) },
 	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
@@ -2254,6 +2171,8 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_intel,
 	&spi_nor_issi,
 	&spi_nor_macronix,
+	&spi_nor_micron,
+	&spi_nor_st,
 };
 
 static const struct flash_info *
@@ -3038,14 +2957,6 @@ static void sst_set_default_init(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_LOCK;
 }
 
-static void st_micron_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
-	nor->params.quad_enable = NULL;
-	nor->params.set_4byte = spi_nor_en4_ex4_wen_set_4byte;
-}
-
 static void winbond_set_default_init(struct spi_nor *nor)
 {
 	nor->params.set_4byte = winbond_set_4byte;
@@ -3060,11 +2971,6 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_ST:
-	case SNOR_MFR_MICRON:
-		st_micron_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_SST:
 		sst_set_default_init(nor);
 		break;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 9af3a701de95..7e3ec8e4ef34 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -176,6 +176,8 @@ extern const struct spi_nor_manufacturer spi_nor_gigadevice;
 extern const struct spi_nor_manufacturer spi_nor_intel;
 extern const struct spi_nor_manufacturer spi_nor_issi;
 extern const struct spi_nor_manufacturer spi_nor_macronix;
+extern const struct spi_nor_manufacturer spi_nor_micron;
+extern const struct spi_nor_manufacturer spi_nor_st;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
new file mode 100644
index 000000000000..8017ca58b3a5
--- /dev/null
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info micron_parts[] = {
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
+			       SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			       SPI_NOR_4B_OPCODES) },
+	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
+			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			    SPI_NOR_4B_OPCODES) },
+};
+
+static const struct flash_info st_parts[] = {
+	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32,
+			      SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64,
+			      SPI_NOR_QUAD_READ) },
+	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64,
+			      SPI_NOR_QUAD_READ) },
+	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128,
+			      SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128,
+			      SECT_4K | SPI_NOR_QUAD_READ) },
+	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
+			      USE_FSR | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
+	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			      NO_CHIP_ERASE) },
+	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			      NO_CHIP_ERASE) },
+	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			      NO_CHIP_ERASE) },
+	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
+			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
+			      NO_CHIP_ERASE) },
+
+	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
+	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
+	{ "m25p20",  INFO(0x202012,  0,  64 * 1024,   4, 0) },
+	{ "m25p40",  INFO(0x202013,  0,  64 * 1024,   8, 0) },
+	{ "m25p80",  INFO(0x202014,  0,  64 * 1024,  16, 0) },
+	{ "m25p16",  INFO(0x202015,  0,  64 * 1024,  32, 0) },
+	{ "m25p32",  INFO(0x202016,  0,  64 * 1024,  64, 0) },
+	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128, 0) },
+	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64, 0) },
+
+	{ "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2, 0) },
+	{ "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4, 0) },
+	{ "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4, 0) },
+	{ "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8, 0) },
+	{ "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16, 0) },
+	{ "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32, 0) },
+	{ "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64, 0) },
+	{ "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128, 0) },
+	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
+
+	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
+	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
+	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
+
+	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
+	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
+	{ "m25pe16", INFO(0x208015,  0, 64 * 1024, 32, SECT_4K) },
+
+	{ "m25px16",    INFO(0x207115,  0, 64 * 1024, 32, SECT_4K) },
+	{ "m25px32",    INFO(0x207116,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px32-s0", INFO(0x207316,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px32-s1", INFO(0x206316,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px64",    INFO(0x207117,  0, 64 * 1024, 128, 0) },
+	{ "m25px80",    INFO(0x207114,  0, 64 * 1024, 16, 0) },
+};
+
+static void micron_st_default_init(struct spi_nor *nor)
+{
+	nor->flags |= SNOR_F_HAS_LOCK;
+	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
+	nor->params.quad_enable = NULL;
+	nor->params.set_4byte = spi_nor_en4_ex4_wen_set_4byte;
+}
+
+static const struct spi_nor_fixups micron_st_fixups = {
+	.default_init = micron_st_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_micron = {
+	.name = "micron",
+	.parts = micron_parts,
+	.nparts = ARRAY_SIZE(micron_parts),
+	.fixups = &micron_st_fixups,
+};
+
+const struct spi_nor_manufacturer spi_nor_st = {
+	.name = "st",
+	.parts = st_parts,
+	.nparts = ARRAY_SIZE(st_parts),
+	.fixups = &micron_st_fixups,
+};
-- 
2.23.0
