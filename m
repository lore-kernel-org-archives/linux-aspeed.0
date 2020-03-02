From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:51 +0000
Subject: [PATCH 11/23] mtd: spi-nor: Move GigaDevice bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-12-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for GigaDevice chips, and move the
GigaDevice definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile     |  1 +
 drivers/mtd/spi-nor/core.c       | 60 +-------------------------------
 drivers/mtd/spi-nor/core.h       |  1 +
 drivers/mtd/spi-nor/gigadevice.c | 59 +++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 59 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/gigadevice.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index ca6222d98b0f..38f704be4b03 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -6,4 +6,5 @@ spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
 spi-nor-objs			+= fujitsu.o
+spi-nor-objs			+= gigadevice.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3f3955bbbb70..8520423b1104 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2052,21 +2052,6 @@ static struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
-static void gd25q256_default_init(struct spi_nor *nor)
-{
-	/*
-	 * Some manufacturer like GigaDevice may use different
-	 * bit to set QE on different memories, so the MFR can't
-	 * indicate the quad_enable method for this case, we need
-	 * to set it in the default_init fixup hook.
-	 */
-	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
-}
-
-static struct spi_nor_fixups gd25q256_fixups = {
-	.default_init = gd25q256_default_init,
-};
-
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
@@ -2079,50 +2064,6 @@ static struct spi_nor_fixups gd25q256_fixups = {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* GigaDevice */
-	{
-		"gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25q32", INFO(0xc84016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25lq32", INFO(0xc86016, 0, 64 * 1024, 64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25q64", INFO(0xc84017, 0, 64 * 1024, 128,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25q128", INFO(0xc84018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
-			SPI_NOR_TB_SR_BIT6)
-			.fixups = &gd25q256_fixups,
-	},
-
 	/* Intel/Numonyx -- xxxs33b */
 	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
 	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
@@ -2428,6 +2369,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_esmt,
 	&spi_nor_everspin,
 	&spi_nor_fujitsu,
+	&spi_nor_gigadevice,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 1b9f7402e5ff..c44802a05532 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -172,6 +172,7 @@ extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
 extern const struct spi_nor_manufacturer spi_nor_fujitsu;
+extern const struct spi_nor_manufacturer spi_nor_gigadevice;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
new file mode 100644
index 000000000000..7930e4490dab
--- /dev/null
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -0,0 +1,59 @@
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
+static void gd25q256_default_init(struct spi_nor *nor)
+{
+	/*
+	 * Some manufacturer like GigaDevice may use different
+	 * bit to set QE on different memories, so the MFR can't
+	 * indicate the quad_enable method for this case, we need
+	 * to set it in the default_init fixup hook.
+	 */
+	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
+}
+
+static struct spi_nor_fixups gd25q256_fixups = {
+	.default_init = gd25q256_default_init,
+};
+
+static const struct flash_info gigadevice_parts[] = {
+	{ "gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25lq32", INFO(0xc86016, 0, 64 * 1024, 64,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128,
+			  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			  SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25lq64c", INFO(0xc86017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25lq128d", INFO(0xc86018, 0, 64 * 1024, 256,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
+			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			   SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
+			   SPI_NOR_HAS_TB | SPI_NOR_TB_SR_BIT6)
+		.fixups = &gd25q256_fixups },
+};
+
+const struct spi_nor_manufacturer spi_nor_gigadevice = {
+	.name = "gigadevice",
+	.parts = gigadevice_parts,
+	.nparts = ARRAY_SIZE(gigadevice_parts),
+};
-- 
2.23.0
