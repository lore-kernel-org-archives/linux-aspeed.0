From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 6 Jan 2021 13:59:33 +0800
Subject: [PATCH 0/6] arm: aspeed: Add eSPI support
Message-ID: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series add the driver support for the eSPI controller
of Aspeed 6th generation SoCs. This controller is a slave device
communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire,
out-of-band, and flash, and operates at max frequency of 66MHz.

Chia-Wei, Wang (6):
  dt-bindings: aspeed: Add eSPI controller
  MAINTAINER: Add ASPEED eSPI driver entry
  clk: ast2600: Add eSPI reset bit
  irqchip/aspeed: Add Aspeed eSPI interrupt controller
  soc: aspeed: Add eSPI driver
  ARM: dts: aspeed: Add AST2600 eSPI nodes

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 252 +++++++
 MAINTAINERS                                   |  14 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  57 ++
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-aspeed-espi-ic.c          | 251 +++++++
 drivers/soc/aspeed/Kconfig                    |  49 ++
 drivers/soc/aspeed/Makefile                   |   5 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 197 +++++
 drivers/soc/aspeed/aspeed-espi-flash.c        | 490 ++++++++++++
 drivers/soc/aspeed/aspeed-espi-oob.c          | 706 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-peripheral.c   | 613 +++++++++++++++
 drivers/soc/aspeed/aspeed-espi-vw.c           | 211 ++++++
 include/dt-bindings/clock/ast2600-clock.h     |   1 +
 .../interrupt-controller/aspeed-espi-ic.h     |  15 +
 include/soc/aspeed/espi.h                     | 279 +++++++
 include/uapi/linux/aspeed-espi.h              | 160 ++++
 16 files changed, 3301 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-espi-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-espi-ic.h
 create mode 100644 include/soc/aspeed/espi.h
 create mode 100644 include/uapi/linux/aspeed-espi.h

-- 
2.17.1

