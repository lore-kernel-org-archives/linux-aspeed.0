From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 14 Feb 2022 10:42:22 +0100
Subject: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
Message-ID: <20220214094231.3753686-2-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

To prepare transition to the new Aspeed SMC SPI controller driver using
the spi-mem interface, change the kernel CONFIG option of the current
driver to reflect that the implementation uses the MTD SPI-NOR interface.
Once the new driver is sufficiently exposed, we should remove the old one.

Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/configs/aspeed_g4_defconfig     | 2 +-
 arch/arm/configs/aspeed_g5_defconfig     | 2 +-
 arch/arm/configs/multi_v5_defconfig      | 2 +-
 arch/arm/configs/multi_v7_defconfig      | 2 +-
 drivers/mtd/spi-nor/controllers/Kconfig  | 2 +-
 drivers/mtd/spi-nor/controllers/Makefile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index b4a1b2ed1a17..964536444cd7 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -64,7 +64,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index ccc4240ee4b5..e809236ca88b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -103,7 +103,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 80a3ae02d759..49083ef05fb0 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -103,7 +103,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_ATMEL_SSC=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 33572998dbbe..fc1b69256b64 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -217,7 +217,7 @@ CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_NAND_STM32_FMC2=y
 CONFIG_MTD_NAND_PL35X=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=m
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..876a47042fec 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SPI_ASPEED_SMC
+config SPI_ASPEED_SMC_MTD_SPI_NOR
 	tristate "Aspeed flash controllers in SPI mode"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on HAS_IOMEM && OF
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index e7abba491d98..1e28297fb1e8 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
+obj-$(CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
 obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
-- 
2.34.1

