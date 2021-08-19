From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 16:22:03 +0930
Subject: [PATCH 4/4] ARM: config: aspeed: Regenerate defconfigs
In-Reply-To: <20210819065203.2620911-1-joel@jms.id.au>
References: <20210819065203.2620911-1-joel@jms.id.au>
Message-ID: <20210819065203.2620911-5-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A make defconfig && make savedefconfig was performed for each
configuration.

Most changes are due to options moving around, except for the following
which are due to changing defaults:

 - SECCOMP is enabled by default as of commit 282a181b1a0d ("seccomp:
   Move config option SECCOMP to arch/Kconfig") in v5.9

 - The soc drivers ASPEED_LPC_CTRL, ASPEED_LPC_SNOOP and ASPEED_P2A_CTRL
   are enabled by default when the aspeed platform is enabled, as of
   commit 592693a1f881 ("soc: aspeed: Improve kconfig") in v5.9

 - The ZBOOT_ROM_TEXT/BSS values fall out of the defconfig as of
   commit 39c3e304567a ("ARM: 8984/1: Kconfig: set default
   ZBOOT_ROM_TEXT/BSS value to 0x0") in v5.8

- I2C_MUX is selected by MEDIA_SUBDRV_AUTOSELECT, probably as of about
  v5.8. It was in the config as it is required bt the PCA I2C muxes that
  enabled it

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g4_defconfig | 12 ++----------
 arch/arm/configs/aspeed_g5_defconfig | 20 ++++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index a578865c2d96..acaafa351d08 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -3,6 +3,7 @@ CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
@@ -14,7 +15,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_AIO is not set
-CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
@@ -26,10 +26,7 @@ CONFIG_MACH_ASPEED_G4=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_SECCOMP=y
 # CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
@@ -76,7 +73,6 @@ CONFIG_NETCONSOLE=y
 # CONFIG_NET_VENDOR_AMAZON is not set
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
@@ -132,7 +128,6 @@ CONFIG_ASPEED_BT_IPMI_BMC=y
 CONFIG_HW_RANDOM_TIMERIOMEM=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_ASPEED=y
@@ -214,9 +209,6 @@ CONFIG_RTC_DRV_RV8803=y
 CONFIG_RTC_DRV_ASPEED=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_ASPEED_LPC_CTRL=y
-CONFIG_ASPEED_LPC_SNOOP=y
-CONFIG_ASPEED_P2A_CTRL=y
 CONFIG_IIO=y
 CONFIG_ASPEED_ADC=y
 CONFIG_MAX1363=y
@@ -257,6 +249,7 @@ CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_WX=y
 CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
@@ -265,6 +258,5 @@ CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_WQ_WATCHDOG=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_FUNCTION_TRACER=y
-CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_USER=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 6ba30b212bda..480dbbb4ff91 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -3,6 +3,7 @@ CONFIG_KERNEL_XZ=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
@@ -14,7 +15,6 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_AIO is not set
-CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
@@ -31,10 +31,7 @@ CONFIG_VMSPLIT_2G=y
 CONFIG_NR_CPUS=2
 CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-CONFIG_SECCOMP=y
 # CONFIG_ATAGS is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
@@ -89,7 +86,6 @@ CONFIG_NETCONSOLE=y
 # CONFIG_NET_VENDOR_AMAZON is not set
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
@@ -149,7 +145,6 @@ CONFIG_ASPEED_BT_IPMI_BMC=y
 CONFIG_HW_RANDOM_TIMERIOMEM=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_GPIO=y
 CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
@@ -232,9 +227,6 @@ CONFIG_RTC_DRV_RV8803=y
 CONFIG_RTC_DRV_ASPEED=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
-CONFIG_ASPEED_LPC_CTRL=y
-CONFIG_ASPEED_LPC_SNOOP=y
-CONFIG_ASPEED_P2A_CTRL=y
 CONFIG_IIO=y
 CONFIG_ASPEED_ADC=y
 CONFIG_MAX1363=y
@@ -279,14 +271,14 @@ CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_WX=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_PANIC_TIMEOUT=-1
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
 CONFIG_WQ_WATCHDOG=y
-CONFIG_PANIC_ON_OOPS=y
-CONFIG_PANIC_TIMEOUT=-1
 # CONFIG_SCHED_DEBUG is not set
-CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_FUNCTION_TRACER=y
-# CONFIG_RUNTIME_TESTING_MENU is not set
-CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_USER=y
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.32.0

