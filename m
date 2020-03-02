From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:48 +0000
Subject: [PATCH 06/23] mtd: spi-nor: Move Atmel bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-7-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Atmel chips, and move the
Atmel definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/atmel.c  | 46 ++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c   | 32 +++----------------------
 drivers/mtd/spi-nor/core.h   |  3 +++
 4 files changed, 53 insertions(+), 29 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/atmel.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 6bcdb6f1615a..0a243592e416 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 spi-nor-objs			:= core.o sfdp.o
+spi-nor-objs			+= atmel.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
new file mode 100644
index 000000000000..3f5f21a473a6
--- /dev/null
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -0,0 +1,46 @@
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
+static const struct flash_info atmel_parts[] = {
+	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
+	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
+	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
+
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
+	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+
+	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+
+	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+
+	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
+};
+
+static void atmel_default_init(struct spi_nor *nor)
+{
+	nor->flags |= SNOR_F_HAS_LOCK;
+}
+
+static const struct spi_nor_fixups atmel_fixups = {
+	.default_init = atmel_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_atmel = {
+	.name = "atmel",
+	.parts = atmel_parts,
+	.nparts = ARRAY_SIZE(atmel_parts),
+	.fixups = &atmel_fixups,
+};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d41ef1795707..45d370229e0a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,25 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups = {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
-
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
-
-	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-
-	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
-
-	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
-
 	/* EON -- en25xxx */
 	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
 	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
@@ -2472,7 +2453,9 @@ static const struct flash_info spi_nor_ids[] = {
 	{ },
 };
 
-static const struct spi_nor_manufacturer *manufacturers[0];
+static const struct spi_nor_manufacturer *manufacturers[] = {
+	&spi_nor_atmel,
+};
 
 static const struct flash_info *
 spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int nparts,
@@ -3251,11 +3234,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
 
-static void atmel_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
 static void intel_set_default_init(struct spi_nor *nor)
 {
 	nor->flags |= SNOR_F_HAS_LOCK;
@@ -3299,10 +3277,6 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_ATMEL:
-		atmel_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_INTEL:
 		intel_set_default_init(nor);
 		break;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 89b8dd1c8213..505e580add68 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -166,6 +166,9 @@ struct spi_nor_manufacturer {
 	const struct spi_nor_fixups *fixups;
 };
 
+/* Manufacturer drivers. */
+extern const struct spi_nor_manufacturer spi_nor_atmel;
+
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_en4_ex4_set_4byte(struct spi_nor *nor, bool enable);
-- 
2.23.0
