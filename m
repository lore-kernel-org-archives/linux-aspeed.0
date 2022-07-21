From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Jul 2022 16:13:24 +0200
Subject: [PATCH 5/6] ARM: defconfig: remove broken CONFIG_THUMB disables
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
Message-ID: <20220721141325.2413920-6-arnd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

Since commit 1515b186c235 ("ARM: make configuration of userspace
Thumb support an expert option"), CONFIG_THUMB cannot be disabled
unless one turns on CONFIG_EXPERT first.

This is probably for the better, so remove the statements that
turn it off.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/eseries_pxa_defconfig | 1 -
 arch/arm/configs/iop32x_defconfig      | 1 -
 arch/arm/configs/ixp4xx_defconfig      | 1 -
 arch/arm/configs/lpd270_defconfig      | 1 -
 arch/arm/configs/lubbock_defconfig     | 1 -
 arch/arm/configs/mainstone_defconfig   | 1 -
 arch/arm/configs/omap1_defconfig       | 1 -
 arch/arm/configs/pxa255-idp_defconfig  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index b8994bff3f62..f76432fbc3af 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -6,7 +6,6 @@ CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_ESERIES=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_IWMMXT=y
 CONFIG_AEABI=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index e4c563182dea..3bc51fb4ebc9 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -9,7 +9,6 @@ CONFIG_MACH_GLANTANK=y
 CONFIG_ARCH_IQ80321=y
 CONFIG_ARCH_IQ31244=y
 CONFIG_MACH_N2100=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writealloc"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_AOUT=y
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 960978a23d16..6b65ac2a72e7 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -8,7 +8,6 @@ CONFIG_INITRAMFS_COMPRESSION_XZ=y
 CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_IXP4XX=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttyS0,115200"
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index b43938e30d77..fb74b0fc4761 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -3,7 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_LOGICPD_PXA270=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index 2b1aec0afba0..95e937379a62 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -3,7 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_LUBBOCK=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 6aac785c5696..f5c271631633 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -3,7 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_MAINSTONE=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index e7aab2d3dd55..e10febef3c43 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -40,7 +40,6 @@ CONFIG_MACH_SX1=y
 CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
 CONFIG_MACH_OMAP_GENERIC=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index b73ce035b20a..feb840102a05 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -3,7 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_IDP=y
-# CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
-- 
2.29.2

