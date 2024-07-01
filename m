From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:15:09 -0000
Subject: [PATCH 9/9] eeprom: at24: remove deprecated Kconfig symbol
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-9-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

All kernel users are shifted to the new MTD_EEPROM_AT24 Kconfig symbol
so we can drop the old one.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/misc/eeprom/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 3a9aaec2f2c7..9e071cfdc6c6 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "EEPROM support"
 
-config EEPROM_AT24
-	tristate "I2C EEPROMs / RAMs / ROMs from most vendors"
-	select MTD_EEPROM_AT24
-	help
-	  Deprecated config option to get read/write support to most I2C
-	  EEPROMs. Please use MTD_EEPROM_AT24 instead.
-
 config EEPROM_AT25
 	tristate "SPI EEPROMs (FRAMs) from most vendors"
 	depends on SPI && SYSFS

-- 
2.39.2

