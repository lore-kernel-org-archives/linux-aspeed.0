From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Nov 2019 16:58:54 +1030
Subject: [PATCH 2/5] ARM: config: aspeed-g5: Add SGPIO and FSI drivers
In-Reply-To: <20191112062857.32638-1-joel@jms.id.au>
References: <20191112062857.32638-1-joel@jms.id.au>
Message-ID: <20191112062857.32638-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These are recently merged drivers for ASPEED systems.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index b87508c7056c..b0d056d49abe 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -155,6 +155,7 @@ CONFIG_SPI=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_ASPEED=y
+CONFIG_GPIO_ASPEED_SGPIO=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_GPIO=y
 CONFIG_W1_SLAVE_THERM=y
@@ -237,8 +238,10 @@ CONFIG_FSI=y
 CONFIG_FSI_MASTER_GPIO=y
 CONFIG_FSI_MASTER_HUB=y
 CONFIG_FSI_MASTER_AST_CF=y
+CONFIG_FSI_MASTER_ASPEED=y
 CONFIG_FSI_SCOM=y
 CONFIG_FSI_SBEFIFO=y
+CONFIG_FSI_OCC=y
 CONFIG_FANOTIFY=y
 CONFIG_OVERLAY_FS=y
 CONFIG_TMPFS=y
-- 
2.24.0

