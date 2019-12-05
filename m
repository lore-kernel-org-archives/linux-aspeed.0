From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  5 Dec 2019 11:15:00 -0600
Subject: [PATCH v2 00/12] Aspeed: Add SCU interrupt controller and XDMA engine
 drivers
Message-ID: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series first adds a driver to control the interrupt controller provided by
the System Control Unit (SCU) on the AST2500 and AST2600 SOCs. The interrupts
made available are necessary for the control of the XDMA engine embedded in the
same Aspeed SOCs.
This series then adds a driver to control the XDMA engine. This driver was
previously sent to the list without support for the AST2600, and has been
refactored significantly to enable that support. The XDMA engine performs
automatic DMA operations between the Aspeed SOC (acting as a BMC) and a host
processor.

Changes since v1:
 - See individual patches
 - In summary, first the irqchip driver switched to use the parent SCU regmap
   rather than iomapping it's register. Secondly, the XDMA initialization
   switched to use properties from the device tree rather than dynamically
   calculate memory spaces, and system config.

Eddie James (12):
  dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
  irqchip: Add Aspeed SCU interrupt controller
  ARM: dts: aspeed: ast2500: Add SCU interrupt controller
  ARM: dts: aspeed: ast2600: Add SCU interrupt controllers
  dt-bindings: soc: Add Aspeed XDMA Engine
  drivers/soc: Add Aspeed XDMA Engine Driver
  drivers/soc: xdma: Add user interface
  ARM: dts: aspeed: ast2500: Add XDMA Engine
  ARM: dts: aspeed: ast2600: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine
  ARM: dts: aspeed: rainier: Enable XDMA engine
  ARM: dts: aspeed: tacoma: Enable XDMA engine

 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |   23 +
 .../devicetree/bindings/soc/aspeed/xdma.txt        |   43 +
 MAINTAINERS                                        |   16 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |    5 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |    5 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |    5 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   25 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   33 +
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |  239 +++++
 drivers/soc/aspeed/Kconfig                         |    8 +
 drivers/soc/aspeed/Makefile                        |    1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 1007 ++++++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h           |   23 +
 include/uapi/linux/aspeed-xdma.h                   |   41 +
 15 files changed, 1473 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

