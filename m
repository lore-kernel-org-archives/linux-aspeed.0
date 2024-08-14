From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 14 Aug 2024 19:41:03 +0800
Subject: [PATCH v1 0/2] Add support for AST2700 INTC driver
Message-ID: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce to the AST27XX INTC modules, which contain two conponents in
CPU die(12nm) and IO die(40mm) comunicating by SLI or LTPI protocol.

There are lots of device in IO die, which need to be serviced in
requested interrupt handler. As two die ICs, combine 32 interrupt source
in IO die into 1 interrupt in CPU die.

soc0_intc11 represent CPU die INTC, which each bit mapping to soc1_intcX.
soc1_intcX represent IO die INTC, which combines 32 interrupt sources.

Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add support for 10 INTC interrupts on AST27XX
    platforms

 .../aspeed,ast2700-intc.yaml                  | 120 +++++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 198 ++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1

