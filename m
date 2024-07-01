From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:15:15 -0000
Subject: [PATCH 8/9] LoongArch: convert to MTD_EEPROM_AT24
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-8-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The EEPROM_AT24 Kconfig symbol is marked as deprecated. Make use of the
new Kconfig symbol to select the I2C EEPROM driver support.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/loongarch/configs/loongson3_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index b4252c357c8e..31daff75a01a 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -433,7 +433,7 @@ CONFIG_NVME_TARGET_LOOP=m
 CONFIG_NVME_TARGET_RDMA=m
 CONFIG_NVME_TARGET_FC=m
 CONFIG_NVME_TARGET_TCP=m
-CONFIG_EEPROM_AT24=m
+CONFIG_MTD_EEPROM_AT24=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y

-- 
2.39.2

