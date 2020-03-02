From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:49 +0000
Subject: [PATCH 08/23] mtd: spi-nor: Move ESMT bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-9-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for ESMT chips, and move the
ESMT definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  6 +-----
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/esmt.c   | 25 +++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/esmt.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index e1bc8ccfe14d..4e5ef10e4fd7 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -3,4 +3,5 @@
 spi-nor-objs			:= core.o sfdp.o
 spi-nor-objs			+= atmel.o
 spi-nor-objs			+= eon.o
+spi-nor-objs			+= esmt.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 67a3493939f6..30a0ddc6de81 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,11 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups = {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* ESMT */
-	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
-
 	/* Everspin */
 	{ "mr25h128", CAT25_INFO( 16 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
 	{ "mr25h256", CAT25_INFO( 32 * 1024, 1, 256, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
@@ -2439,6 +2434,7 @@ static const struct flash_info spi_nor_ids[] = {
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
 	&spi_nor_eon,
+	&spi_nor_esmt,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 1ac226c456e1..23ce99fb8087 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -169,6 +169,7 @@ struct spi_nor_manufacturer {
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
 extern const struct spi_nor_manufacturer spi_nor_eon;
+extern const struct spi_nor_manufacturer spi_nor_esmt;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
new file mode 100644
index 000000000000..c93170008118
--- /dev/null
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -0,0 +1,25 @@
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
+static const struct flash_info esmt_parts[] = {
+	/* ESMT */
+	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128,
+			   SECT_4K | SPI_NOR_HAS_LOCK) },
+};
+
+const struct spi_nor_manufacturer spi_nor_esmt = {
+	.name = "esmt",
+	.parts = esmt_parts,
+	.nparts = ARRAY_SIZE(esmt_parts),
+};
-- 
2.23.0
