From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:43:25 +0930
Subject: [PATCH 3/3] ARM: config: aspeed-g5: Enable EXT4, VFAT
In-Reply-To: <20190710141325.20888-1-andrew@aj.id.au>
References: <20190710141325.20888-1-andrew@aj.id.au>
Message-ID: <20190710141325.20888-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>

Popular filesystems now that we have eMMC support.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 9cb3cfd35a59..13db73e15539 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -217,8 +217,11 @@ CONFIG_FSI_MASTER_HUB=y
 CONFIG_FSI_MASTER_AST_CF=y
 CONFIG_FSI_SCOM=y
 CONFIG_FSI_SBEFIFO=y
+CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_OVERLAY_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_UTF8=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 # CONFIG_JFFS2_FS_WRITEBUFFER is not set
-- 
2.20.1

