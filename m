From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Mon, 2 Mar 2020 18:07:44 +0000
Subject: [PATCH 00/23] mtd: spi-nor: Move manufacturer/SFDP code out of the
 core
Message-ID: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Hello,

This patch series is an attempt at getting all manufacturer specific
quirks/code out of the core to make the core logic more readable and
thus ease maintainance.

This is a respin of the last chunk of Boris's work from
https://patchwork.ozlabs.org/cover/1009290/.

Tested an erase-write-read-compare with a 1MB file on the following
flashes: mx25l25635e, w25q128, n25q256a, is25lp256, s25fl256s0,
gd25q256.

Boris Brezillon (21):
  mtd: spi-nor: Stop prefixing generic functions with a manufacturer
    name
  mtd: spi-nor: Prepare core / manufacturer code split
  mtd: spi-nor: Expose stuctures and functions to manufacturer drivers
  mtd: spi-nor: Add the concept of SPI NOR manufacturer driver
  mtd: spi-nor: Move Atmel bits out of core.c
  mtd: spi-nor: Move Eon bits out of core.c
  mtd: spi-nor: Move ESMT bits out of core.c
  mtd: spi-nor: Move Everspin bits out of core.c
  mtd: spi-nor: Move Fujitsu bits out of core.c
  mtd: spi-nor: Move GigaDevice bits out of core.c
  mtd: spi-nor: Move Intel bits out of core.c
  mtd: spi-nor: Move ISSI bits out of core.c
  mtd: spi-nor: Move Macronix bits out of core.c
  mtd: spi-nor: Move Micron/ST bits out of core.c
  mtd: spi-nor: Move Spansion bits out of core.c
  mtd: spi-nor: Move SST bits out of core.c
  mtd: spi-nor: Move Winbond bits out of core.c
  mtd: spi-nor: Move Catalyst bits out of core.c
  mtd: spi-nor: Move Xilinx bits out of core.c
  mtd: spi-nor: Move XMC bits out of core.c
  mtd: spi-nor: Get rid of the now empty spi_nor_ids[] table

Tudor Ambarus (2):
  mtd: spi-nor: Move SFDP logic out of the core
  mtd: spi-nor: Trim what is exposed in spi-nor.h

 drivers/mtd/spi-nor/Kconfig                   |   83 +-
 drivers/mtd/spi-nor/Makefile                  |   26 +-
 drivers/mtd/spi-nor/atmel.c                   |   46 +
 drivers/mtd/spi-nor/catalyst.c                |   29 +
 drivers/mtd/spi-nor/controllers/Kconfig       |   83 +
 drivers/mtd/spi-nor/controllers/Makefile      |    9 +
 .../spi-nor/{ => controllers}/aspeed-smc.c    |    0
 .../{ => controllers}/cadence-quadspi.c       |    0
 .../mtd/spi-nor/{ => controllers}/hisi-sfc.c  |    0
 .../spi-nor/{ => controllers}/intel-spi-pci.c |    0
 .../{ => controllers}/intel-spi-platform.c    |    0
 .../mtd/spi-nor/{ => controllers}/intel-spi.c |    0
 .../mtd/spi-nor/{ => controllers}/intel-spi.h |    0
 .../spi-nor/{ => controllers}/mtk-quadspi.c   |    0
 .../mtd/spi-nor/{ => controllers}/nxp-spifi.c |    0
 drivers/mtd/spi-nor/{spi-nor.c => core.c}     | 2503 ++---------------
 drivers/mtd/spi-nor/core.h                    |  432 +++
 drivers/mtd/spi-nor/eon.c                     |   34 +
 drivers/mtd/spi-nor/esmt.c                    |   25 +
 drivers/mtd/spi-nor/everspin.c                |   27 +
 drivers/mtd/spi-nor/fujitsu.c                 |   20 +
 drivers/mtd/spi-nor/gigadevice.c              |   59 +
 drivers/mtd/spi-nor/intel.c                   |   32 +
 drivers/mtd/spi-nor/issi.c                    |   83 +
 drivers/mtd/spi-nor/macronix.c                |   98 +
 drivers/mtd/spi-nor/micron-st.c               |  129 +
 drivers/mtd/spi-nor/sfdp.c                    | 1206 ++++++++
 drivers/mtd/spi-nor/sfdp.h                    |   98 +
 drivers/mtd/spi-nor/spansion.c                |   95 +
 drivers/mtd/spi-nor/sst.c                     |  151 +
 drivers/mtd/spi-nor/winbond.c                 |  113 +
 drivers/mtd/spi-nor/xilinx.c                  |   94 +
 drivers/mtd/spi-nor/xmc.c                     |   23 +
 include/linux/mtd/spi-nor.h                   |  257 +-
 34 files changed, 3121 insertions(+), 2634 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/atmel.c
 create mode 100644 drivers/mtd/spi-nor/catalyst.c
 create mode 100644 drivers/mtd/spi-nor/controllers/Kconfig
 create mode 100644 drivers/mtd/spi-nor/controllers/Makefile
 rename drivers/mtd/spi-nor/{ => controllers}/aspeed-smc.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/cadence-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/hisi-sfc.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-pci.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-platform.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.h (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/mtk-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/nxp-spifi.c (100%)
 rename drivers/mtd/spi-nor/{spi-nor.c => core.c} (52%)
 create mode 100644 drivers/mtd/spi-nor/core.h
 create mode 100644 drivers/mtd/spi-nor/eon.c
 create mode 100644 drivers/mtd/spi-nor/esmt.c
 create mode 100644 drivers/mtd/spi-nor/everspin.c
 create mode 100644 drivers/mtd/spi-nor/fujitsu.c
 create mode 100644 drivers/mtd/spi-nor/gigadevice.c
 create mode 100644 drivers/mtd/spi-nor/intel.c
 create mode 100644 drivers/mtd/spi-nor/issi.c
 create mode 100644 drivers/mtd/spi-nor/macronix.c
 create mode 100644 drivers/mtd/spi-nor/micron-st.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.h
 create mode 100644 drivers/mtd/spi-nor/spansion.c
 create mode 100644 drivers/mtd/spi-nor/sst.c
 create mode 100644 drivers/mtd/spi-nor/winbond.c
 create mode 100644 drivers/mtd/spi-nor/xilinx.c
 create mode 100644 drivers/mtd/spi-nor/xmc.c

-- 
2.23.0
