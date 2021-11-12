From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Fri, 12 Nov 2021 20:29:31 +0000
Subject: [PATCH] ARM: configs: aspeed: Add support for USB flash drives
Message-ID: <20211112202931.2379145-1-anoo@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Adriana Kobylak <anoo@us.ibm.com>

Add support to detect USB flash drives and create the /dev/sd* devices.
Also add support for vfat to support USB drives formatted as FAT32.
This support will be used to enable firmware updates via USB flash
drives where the firmware image is stored in the USB drive and it's
plugged into the BMC USB port.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
Tested-by: Adriana Kobylak <anoo@us.ibm.com>
---
 arch/arm/configs/aspeed_g5_defconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index bee9422919aa..1b0d82c64ad4 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -37,11 +37,9 @@ CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEBUG_FS is not set
 # CONFIG_MQ_IOSCHED_DEADLINE is not set
 # CONFIG_MQ_IOSCHED_KYBER is not set
@@ -98,6 +96,7 @@ CONFIG_NET_NCSI=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
@@ -111,6 +110,8 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
 # CONFIG_NET_VENDOR_ALACRITECH is not set
@@ -230,6 +231,7 @@ CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ASPEED_VHUB=y
 CONFIG_USB_CONFIGFS=y
@@ -277,6 +279,7 @@ CONFIG_FSI_OCC=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_OVERLAY_FS=y
+CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 # CONFIG_JFFS2_FS_WRITEBUFFER is not set
@@ -292,6 +295,8 @@ CONFIG_PSTORE_PMSG=y
 CONFIG_PSTORE_FTRACE=y
 CONFIG_PSTORE_RAM=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_CRYPTO_HMAC=y
-- 
2.25.1

