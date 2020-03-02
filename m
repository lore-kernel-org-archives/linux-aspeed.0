From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:56 +0000
Subject: [PATCH 21/23] mtd: spi-nor: Move XMC bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-22-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for XMC chips, and move the
XMC definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  4 +---
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/xmc.c    | 23 +++++++++++++++++++++++
 4 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/xmc.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index fa03513dd160..7ddb742de1fe 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -16,4 +16,5 @@ spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
+spi-nor-objs			+= xmc.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e9f6bafa01b..f4178cd65c45 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1965,9 +1965,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ },
 };
 
@@ -1988,6 +1985,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_sst,
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
+	&spi_nor_xmc,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index abd5332afaf5..3541a84c03d8 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -173,6 +173,7 @@ extern const struct spi_nor_manufacturer spi_nor_spansion;
 extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
+extern const struct spi_nor_manufacturer spi_nor_xmc;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
new file mode 100644
index 000000000000..2c7773b68993
--- /dev/null
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -0,0 +1,23 @@
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
+static const struct flash_info xmc_parts[] = {
+	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
+	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+};
+
+const struct spi_nor_manufacturer spi_nor_xmc = {
+	.name = "xmc",
+	.parts = xmc_parts,
+	.nparts = ARRAY_SIZE(xmc_parts),
+};
-- 
2.23.0
