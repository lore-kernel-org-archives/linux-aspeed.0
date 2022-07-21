From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Jul 2022 16:13:25 +0200
Subject: [PATCH 6/6] ARM: defconfig: kill remnants of CONFIG_LEDS
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
Message-ID: <20220721141325.2413920-7-arnd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_LEDS was replaced by CONFIG_NEW_LEDS over ten years ago with commit
fa8bbb13ab49 ("ARM: use new LEDS CPU trigger stub to replace old one"),
but some defconfig files still reference it.

Replace it and its sub-options with the corresponding new versions.

Some of these machines may not actually have a new-style LED driver,
and I did not check them individually as most of the machines are
going away soon anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/assabet_defconfig    | 6 ++++--
 arch/arm/configs/cerfcube_defconfig   | 6 ++++--
 arch/arm/configs/footbridge_defconfig | 6 ++++--
 arch/arm/configs/hackkit_defconfig    | 6 ++++--
 arch/arm/configs/lart_defconfig       | 6 ++++--
 arch/arm/configs/lubbock_defconfig    | 6 ++++--
 arch/arm/configs/mainstone_defconfig  | 6 ++++--
 arch/arm/configs/neponset_defconfig   | 6 ++++--
 arch/arm/configs/netwinder_defconfig  | 6 ++++--
 arch/arm/configs/omap1_defconfig      | 1 -
 arch/arm/configs/pxa255-idp_defconfig | 6 ++++--
 arch/arm/configs/simpad_defconfig     | 3 ++-
 12 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index da5284a8f374..801383e4135d 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
@@ -42,6 +40,10 @@ CONFIG_FB=y
 CONFIG_FB_SA1100=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_TMPFS=y
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index c42e39b011df..d4f3f9a8cd97 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -4,8 +4,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_CERF=y
 CONFIG_SA1100_CERF_FLASH_16MB=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="console=ttySA0,38400 root=/dev/mtdblock3 rootfstype=jffs2 rw mem=32M init=/linuxrc"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
@@ -46,6 +44,10 @@ CONFIG_SERIAL_SA1100_CONSOLE=y
 CONFIG_WATCHDOG=y
 CONFIG_SA1100_WATCHDOG=m
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 CONFIG_MSDOS_FS=m
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index af7d3120cc9c..5c0c88ce9bc5 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -8,8 +8,6 @@ CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_CATS=y
 CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
-CONFIG_LEDS=y
-CONFIG_LEDS_TIMER=y
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_BINFMT_AOUT=y
@@ -91,6 +89,10 @@ CONFIG_SOUND=m
 CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_PRINTER=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_EXT2_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_ISO9660_FS=m
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index e0ea332a4cf4..19bc294c2767 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_HACKKIT=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="console=ttySA0,115200 root=/dev/ram0 initrd=0xc0400000,8M init=/rootshell"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
@@ -31,6 +29,10 @@ CONFIG_DUMMY=y
 CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 76ea89716184..3dad6adabb43 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_LART=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="console=ttySA0,9600 root=/dev/ram"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
@@ -37,6 +35,10 @@ CONFIG_SERIAL_SA1100=y
 CONFIG_SERIAL_SA1100_CONSOLE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=m
 CONFIG_REISERFS_FS=m
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index 95e937379a62..ca226bce5025 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_LUBBOCK=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
@@ -37,6 +35,10 @@ CONFIG_SERIAL_PXA_CONSOLE=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_G_SERIAL=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index f5c271631633..dc1a88ed4de4 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_MAINSTONE=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=bootp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
@@ -35,6 +33,10 @@ CONFIG_FB_PXA=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index bc70ca29a166..907403529e30 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -4,8 +4,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_ASSABET_NEPONSET=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
@@ -70,6 +68,10 @@ CONFIG_USB=m
 CONFIG_USB_MON=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_STORAGE=m
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index d870524e87bf..cf7bbcf9d98a 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -2,8 +2,6 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_NETWINDER=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_DEPRECATED_PARAM_STRUCT=y
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
@@ -58,6 +56,10 @@ CONFIG_SOUND_TRACEINIT=y
 CONFIG_SOUND_DMAP=y
 CONFIG_SOUND_YM3812=y
 CONFIG_SOUND_WAVEARTIST=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index e10febef3c43..3f72d2ff7644 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -41,7 +41,6 @@ CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
 CONFIG_MACH_OMAP_GENERIC=y
 CONFIG_AEABI=y
-CONFIG_LEDS=y
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
 # CONFIG_SUSPEND is not set
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index feb840102a05..d141cc786145 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -3,8 +3,6 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_PXA_IDP=y
-CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_CMDLINE="root=/dev/nfs ip=dhcp console=ttyS0,115200 mem=64M"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
@@ -36,6 +34,10 @@ CONFIG_FB_PXA=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
 CONFIG_JFFS2_FS=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index b81e5decd147..7956f0da0bf9 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -7,7 +7,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_SIMPAD=y
-CONFIG_LEDS=y
 CONFIG_CMDLINE="mtdparts=sa1100:512k(boot),1m(kernel),-(root) console=ttySA0 root=1f02 noinitrd mem=64M jffs2_orphaned_inodes=delete rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
@@ -75,6 +74,8 @@ CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 CONFIG_SOUND=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 CONFIG_REISERFS_FS=m
-- 
2.29.2

