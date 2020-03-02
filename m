From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:55 +0000
Subject: [PATCH 19/23] mtd: spi-nor: Move Catalyst bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-20-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Catalyst chips, and move the
Catalyst definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile   |  1 +
 drivers/mtd/spi-nor/catalyst.c | 29 +++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c     |  8 +-------
 drivers/mtd/spi-nor/core.h     |  1 +
 4 files changed, 32 insertions(+), 7 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/catalyst.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 33b6f834a14f..cd8d95b727c9 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -2,6 +2,7 @@
 
 spi-nor-objs			:= core.o sfdp.o
 spi-nor-objs			+= atmel.o
+spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
diff --git a/drivers/mtd/spi-nor/catalyst.c b/drivers/mtd/spi-nor/catalyst.c
new file mode 100644
index 000000000000..011b83e99e95
--- /dev/null
+++ b/drivers/mtd/spi-nor/catalyst.c
@@ -0,0 +1,29 @@
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
+static const struct flash_info catalyst_parts[] = {
+	/* Catalyst / On Semiconductor -- non-JEDEC */
+	{ "cat25c11", CAT25_INFO(16, 8, 16, 1,
+				 SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	{ "cat25c03", CAT25_INFO(32, 8, 16, 2,
+				 SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	{ "cat25c09", CAT25_INFO(128, 8, 32, 2,
+				 SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	{ "cat25c17", CAT25_INFO(256, 8, 32, 2,
+				 SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+	{ "cat25128", CAT25_INFO(2048, 8, 64, 2,
+				 SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
+};
+
+const struct spi_nor_manufacturer spi_nor_catalyst = {
+	.name = "catalyst",
+	.parts = catalyst_parts,
+	.nparts = ARRAY_SIZE(catalyst_parts),
+};
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c99f063b0781..1776fb8eb66b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1985,13 +1985,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* Catalyst / On Semiconductor -- non-JEDEC */
-	{ "cat25c11", CAT25_INFO(  16, 8, 16, 1, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c03", CAT25_INFO(  32, 8, 16, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c09", CAT25_INFO( 128, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25c17", CAT25_INFO( 256, 8, 32, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-	{ "cat25128", CAT25_INFO(2048, 8, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
-
 	/* Xilinx S3AN Internal Flash */
 	{ "3S50AN", S3AN_INFO(0x1f2200, 64, 264) },
 	{ "3S200AN", S3AN_INFO(0x1f2400, 256, 264) },
@@ -2007,6 +2000,7 @@ static const struct flash_info spi_nor_ids[] = {
 
 static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_atmel,
+	&spi_nor_catalyst,
 	&spi_nor_eon,
 	&spi_nor_esmt,
 	&spi_nor_everspin,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 01e0b8e2b191..9eb46900bc72 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -168,6 +168,7 @@ struct spi_nor_manufacturer {
 
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
+extern const struct spi_nor_manufacturer spi_nor_catalyst;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
-- 
2.23.0
