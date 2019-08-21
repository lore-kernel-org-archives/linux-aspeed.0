From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 15:25:30 +0930
Subject: [PATCH 7/7] ARM: configs: aspeed_g5: Enable AST2600
In-Reply-To: <20190821055530.8720-1-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
Message-ID: <20190821055530.8720-8-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

CONFIG_STRICT_KERNEL_RWX is enabled by default with ARMv7.

Turn on HIGHMEM as the EVB has 2GB of RAM, and not all is usable without
hihgmem.

The SoC contains Cortex A7 supporting VFP and has two CPUs.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 426d8e0c9890..597536cc9573 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -21,21 +21,26 @@ CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_SLAB_FREELIST_RANDOM=y
 CONFIG_ARCH_MULTI_V6=y
-# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G5=y
+CONFIG_MACH_ASPEED_G6=y
 # CONFIG_CACHE_L2X0 is not set
+CONFIG_SMP=y
+# CONFIG_ARM_CPU_TOPOLOGY is not set
 CONFIG_VMSPLIT_2G=y
+CONFIG_NR_CPUS=2
+CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_SECCOMP=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
-# CONFIG_SUSPEND is not set
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_KERNEL_MODE_NEON=y
 CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_JUMP_LABEL=y
-CONFIG_STRICT_KERNEL_RWX=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEBUG_FS is not set
 # CONFIG_MQ_IOSCHED_DEADLINE is not set
@@ -140,10 +145,12 @@ CONFIG_ASPEED_BT_IPMI_BMC=y
 CONFIG_HW_RANDOM_TIMERIOMEM=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_ASPEED=y
 CONFIG_I2C_FSI=y
+CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_ASPEED=y
@@ -194,6 +201,10 @@ CONFIG_USB_CONFIGFS_F_LB_SS=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_CONFIGFS_F_HID=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ASPEED=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_FLASH=y
-- 
2.23.0.rc1

