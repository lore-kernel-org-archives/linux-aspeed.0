From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  2 Jan 2020 13:27:44 -0600
Subject: [PATCH v4 00/12] aspeed: Add SCU interrupt controller and XDMA engine
 drivers
Message-ID: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
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

Changes since v3:
 - See individual patches; just clean-up items

Changes since v2:
 - See individual patches
 - Drop rainier dts patch
 - In summary, remove references to VGA memory as the XDMA driver doesn't care
   where it is. Remove SDRAM controller reference. Move user reset
   functionality to a separate patch and make it an ioctl.

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
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: aspeed: ast2500: Add XDMA Engine
  ARM: dts: aspeed: ast2600: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine
  ARM: dts: aspeed: tacoma: Enable XDMA engine

 .../aspeed,ast2xxx-scu-ic.txt                 |   23 +
 .../devicetree/bindings/soc/aspeed/xdma.txt   |   40 +
 MAINTAINERS                                   |   16 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |    5 +
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |    5 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   19 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   27 +
 drivers/irqchip/Makefile                      |    2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c           |  239 ++++
 drivers/soc/aspeed/Kconfig                    |    8 +
 drivers/soc/aspeed/Makefile                   |    1 +
 drivers/soc/aspeed/aspeed-xdma.c              | 1031 +++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h      |   23 +
 include/uapi/linux/aspeed-xdma.h              |   42 +
 14 files changed, 1480 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
2.24.0

