From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 16 May 2022 08:54:08 +0800
Subject: [PATCH v5 0/4] arm: aspeed: Add eSPI support
Message-ID: <20220516005412.4844-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series add the driver support for the eSPI controller of Aspeed 5/6th generation SoCs. This controller is a slave device communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire, out-of-band, and flash, and operates at max frequency of 66MHz.

v5:
 - unconditionally set VW GPIO to software mode as suggested by Jeremy
 - add missing DTS node for Aspeed G5 SoCs

v4:
 - fix dt-bindgins error with patternProperties
 - fix data type warning for ARM64 compilation
 - replace header based implementation with .c files
 - add more description for the ioctl interface

v3:
 - remove the redundant patch "clk: aspeed: Add eSPI reset bit"
 - fix missing header inclusion reported by test bot
 - fix dt-bindings error reported by yamllint

v2:
 - remove irqchip implementation
 - merge per-channel drivers into single one to avoid the racing issue
   among eSPI handshake process and driver probing.

Chia-Wei Wang (4):
  dt-bindings: aspeed: Add eSPI controller
  MAINTAINER: Add ASPEED eSPI driver entry
  soc: aspeed: Add eSPI driver
  ARM: dts: aspeed: Add eSPI node

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 +++++
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  17 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  17 +
 drivers/soc/aspeed/Kconfig                    |  11 +
 drivers/soc/aspeed/Makefile                   |   5 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 214 +++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 309 ++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.c        | 352 +++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-ioc.h          | 195 ++++++
 drivers/soc/aspeed/aspeed-espi-oob.c          | 558 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-oob.h          |  70 +++
 drivers/soc/aspeed/aspeed-espi-perif.c        | 511 ++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-perif.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-vw.c           | 142 +++++
 drivers/soc/aspeed/aspeed-espi-vw.h           |  21 +
 17 files changed, 2683 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ioc.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.h

-- 
2.25.1

