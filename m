From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:50 +0000
Subject: [PATCH 10/23] mtd: spi-nor: Move Fujitsu bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-11-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Fujitsu chips, and move the
Fujitsu definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile  |  1 +
 drivers/mtd/spi-nor/core.c    |  4 +---
 drivers/mtd/spi-nor/core.h    |  1 +
 drivers/mtd/spi-nor/fujitsu.c | 20 ++++++++++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/fujitsu.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 384c520689d8..ca6222d98b0f 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -5,4 +5,5 @@ spi-nor-objs			+= atmel.o
 spi-nor-objs			+= eon.o
 spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
+spi-nor-objs			+= fujitsu.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 07eec3476053..3f3955bbbb70 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2079,9 +2079,6 @@ static struct spi_nor_fixups gd25q256_fixups = {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* Fujitsu */
-	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1, SPI_NOR_NO_ERASE) },
-
 	/* GigaDevice */
 	{
 		"gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,
@@ -2430,6 +2427,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_eon,
 	&spi_nor_esmt,
 	&spi_nor_everspin,
+	&spi_nor_fujitsu,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d36e7f93dbcf..1b9f7402e5ff 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -171,6 +171,7 @@ extern const struct spi_nor_manufacturer spi_nor_atmel;
 extern const struct spi_nor_manufacturer spi_nor_eon;
 extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
+extern const struct spi_nor_manufacturer spi_nor_fujitsu;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/fujitsu.c b/drivers/mtd/spi-nor/fujitsu.c
new file mode 100644
index 000000000000..e385d93e756c
--- /dev/null
+++ b/drivers/mtd/spi-nor/fujitsu.c
@@ -0,0 +1,20 @@
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
+static const struct flash_info fujitsu_parts[] = {
+	/* Fujitsu */
+	{ "mb85rs1mt", INFO(0x047f27, 0, 128 * 1024, 1, SPI_NOR_NO_ERASE) },
+};
+
+const struct spi_nor_manufacturer spi_nor_fujitsu = {
+	.name = "fujitsu",
+	.parts = fujitsu_parts,
+	.nparts = ARRAY_SIZE(fujitsu_parts),
+};
-- 
2.23.0
