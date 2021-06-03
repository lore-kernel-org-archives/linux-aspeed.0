From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Jun 2021 13:39:06 +0930
Subject: [PATCH] ARM: config: aspeed: Add DEBUG_FS and EXT4
Message-ID: <20210603040906.125109-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DEBUG_FS was lost way back in v5.5, and EXT4 is used by ast2600 systems
that have MMC.

Fixes: 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g4_defconfig | 1 +
 arch/arm/configs/aspeed_g5_defconfig | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 58d293b63581..a3ee647b1ebb 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -254,6 +254,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
 CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 047975eccefb..2db48438c5d2 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -247,6 +247,7 @@ CONFIG_FSI_MASTER_ASPEED=y
 CONFIG_FSI_SCOM=y
 CONFIG_FSI_SBEFIFO=y
 CONFIG_FSI_OCC=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_OVERLAY_FS=y
 CONFIG_TMPFS=y
@@ -276,6 +277,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_FS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
 CONFIG_WQ_WATCHDOG=y
-- 
2.30.2

