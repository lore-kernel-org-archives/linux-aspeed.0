From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:15:38 -0000
Subject: [PATCH 0/9] AT24 EEPROM MTD Support
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds the intial support to handle EEPROMs via the MTD layer
as well. This allow the user-space to have separate paritions since
EEPROMs can become quite large nowadays.

With this patchset applied EEPROMs can be accessed via:
  - legacy 'eeprom' device
  - nvmem device
  - mtd device(s)

The patchset targets only the AT24 (I2C) EEPROMs since I have no access
to AT25 (SPI) EEPROMs nor to one of the other misc/eeprom/* devices.

Note: I'm not familiar with Kconfig symbol migration so I don't know if
the last patch is required at the moment. Please be notified that the
list of recipients is quite large due to the defconfig changes.

Regards,
  Marco

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Marco Felsch (9):
      mtd: core: add nvmem_write support
      mtd: add mtd_is_master helper
      mtd: add support to handle EEPROM devices
      mtd: devices: add AT24 eeprom support
      ARM: defconfig: convert to MTD_EEPROM_AT24
      powerpc: convert to MTD_EEPROM_AT24
      MIPS: configs: convert to MTD_EEPROM_AT24
      LoongArch: convert to MTD_EEPROM_AT24
      eeprom: at24: remove deprecated Kconfig symbol

 MAINTAINERS                                 |   2 +-
 arch/arm/configs/aspeed_g4_defconfig        |   2 +-
 arch/arm/configs/aspeed_g5_defconfig        |   2 +-
 arch/arm/configs/at91_dt_defconfig          |   2 +-
 arch/arm/configs/axm55xx_defconfig          |   2 +-
 arch/arm/configs/davinci_all_defconfig      |   2 +-
 arch/arm/configs/imx_v4_v5_defconfig        |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig        |   2 +-
 arch/arm/configs/ixp4xx_defconfig           |   2 +-
 arch/arm/configs/keystone_defconfig         |   2 +-
 arch/arm/configs/lpc18xx_defconfig          |   2 +-
 arch/arm/configs/lpc32xx_defconfig          |   2 +-
 arch/arm/configs/multi_v5_defconfig         |   2 +-
 arch/arm/configs/multi_v7_defconfig         |   2 +-
 arch/arm/configs/mvebu_v5_defconfig         |   2 +-
 arch/arm/configs/mvebu_v7_defconfig         |   2 +-
 arch/arm/configs/mxs_defconfig              |   2 +-
 arch/arm/configs/omap2plus_defconfig        |   2 +-
 arch/arm/configs/pxa_defconfig              |   2 +-
 arch/arm/configs/s3c6400_defconfig          |   2 +-
 arch/arm/configs/sama5_defconfig            |   2 +-
 arch/arm/configs/sama7_defconfig            |   2 +-
 arch/arm/configs/shmobile_defconfig         |   2 +-
 arch/arm/configs/socfpga_defconfig          |   2 +-
 arch/arm/configs/tegra_defconfig            |   2 +-
 arch/arm/configs/wpcm450_defconfig          |   2 +-
 arch/loongarch/configs/loongson3_defconfig  |   2 +-
 arch/mips/configs/cavium_octeon_defconfig   |   2 +-
 arch/mips/configs/db1xxx_defconfig          |   2 +-
 arch/powerpc/configs/44x/warp_defconfig     |   2 +-
 arch/powerpc/configs/mpc512x_defconfig      |   2 +-
 arch/powerpc/configs/mpc5200_defconfig      |   2 +-
 arch/powerpc/configs/ppc6xx_defconfig       |   2 +-
 arch/powerpc/configs/skiroot_defconfig      |   2 +-
 drivers/misc/eeprom/Kconfig                 |  31 -------
 drivers/misc/eeprom/Makefile                |   1 -
 drivers/mtd/devices/Kconfig                 |  31 +++++++
 drivers/mtd/devices/Makefile                |   1 +
 drivers/{misc/eeprom => mtd/devices}/at24.c | 122 +++++++++++++++-------------
 drivers/mtd/mtdcore.c                       |  49 ++++++++++-
 include/linux/mtd/mtd.h                     |   5 ++
 include/uapi/mtd/mtd-abi.h                  |   2 +
 42 files changed, 187 insertions(+), 123 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240701-b4-v6-10-topic-usbc-tcpci-c4bc9bcce604

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

