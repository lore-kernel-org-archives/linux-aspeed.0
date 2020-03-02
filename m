From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:51 +0000
Subject: [PATCH 12/23] mtd: spi-nor: Move Intel bits out of core.c
In-Reply-To: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
Message-ID: <20200302180730.1886678-13-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Boris Brezillon <bbrezillon@kernel.org>

Create a SPI NOR manufacturer driver for Intel chips, and move the
Intel definitions outside of core.c.

Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   | 15 +--------------
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/intel.c  | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 14 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/intel.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 38f704be4b03..8eb741a27fa7 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -7,4 +7,5 @@ spi-nor-objs			+= esmt.o
 spi-nor-objs			+= everspin.o
 spi-nor-objs			+= fujitsu.o
 spi-nor-objs			+= gigadevice.o
+spi-nor-objs			+= intel.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8520423b1104..2f47852a3a01 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2064,11 +2064,6 @@ static struct spi_nor_fixups mx25l25635_fixups = {
  * old entries may be missing 4K flag.
  */
 static const struct flash_info spi_nor_ids[] = {
-	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-
 	/* ISSI */
 	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
 	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8,
@@ -2370,6 +2365,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_everspin,
 	&spi_nor_fujitsu,
 	&spi_nor_gigadevice,
+	&spi_nor_intel,
 };
 
 static const struct flash_info *
@@ -3149,11 +3145,6 @@ static int spi_nor_setup(struct spi_nor *nor,
 	return nor->params.setup(nor, hwcaps);
 }
 
-static void intel_set_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
 static void issi_set_default_init(struct spi_nor *nor)
 {
 	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
@@ -3192,10 +3183,6 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 {
 	/* Init flash parameters based on MFR */
 	switch (JEDEC_MFR(nor->info)) {
-	case SNOR_MFR_INTEL:
-		intel_set_default_init(nor);
-		break;
-
 	case SNOR_MFR_ISSI:
 		issi_set_default_init(nor);
 		break;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index c44802a05532..c4c23efaa68b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -173,6 +173,7 @@ extern const struct spi_nor_manufacturer spi_nor_esmt;
 extern const struct spi_nor_manufacturer spi_nor_everspin;
 extern const struct spi_nor_manufacturer spi_nor_fujitsu;
 extern const struct spi_nor_manufacturer spi_nor_gigadevice;
+extern const struct spi_nor_manufacturer spi_nor_intel;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
new file mode 100644
index 000000000000..d8196f101368
--- /dev/null
+++ b/drivers/mtd/spi-nor/intel.c
@@ -0,0 +1,32 @@
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
+static const struct flash_info intel_parts[] = {
+	/* Intel/Numonyx -- xxxs33b */
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
+};
+
+static void intel_default_init(struct spi_nor *nor)
+{
+	nor->flags |= SNOR_F_HAS_LOCK;
+}
+
+static const struct spi_nor_fixups intel_fixups = {
+	.default_init = intel_default_init,
+};
+
+const struct spi_nor_manufacturer spi_nor_intel = {
+	.name = "intel",
+	.parts = intel_parts,
+	.nparts = ARRAY_SIZE(intel_parts),
+	.fixups = &intel_fixups,
+};
-- 
2.23.0
