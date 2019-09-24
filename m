From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 24 Sep 2019 11:14:28 -0500
Subject: [PATCH 0/4] irqchip: Add Aspeed SCU Interrupt Controller
Message-ID: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed SOCs provide some interrupts through the System Control
Unit registers. Add an interrupt controller that provides these
interrupts to the system. Add the interrupt controller to the AST25XX
and AST26XX devicetrees.

Eddie James (4):
  dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
  irqchip: Add Aspeed SCU interrupt controller
  ARM: dts: aspeed: ast2500: Add SCU interrupt controller
  ARM: dts: aspeed: ast2600: Add SCU interrupt controllers

 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |  26 +++
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  11 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  18 ++
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                | 199 +++++++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h           |  23 +++
 7 files changed, 285 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

-- 
1.8.3.1

