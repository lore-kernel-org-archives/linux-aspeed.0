From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 16 Oct 2024 10:24:08 +0800
Subject: [PATCH v4 0/2] Add support for AST2700 INTC driver
Message-ID: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

---
v4:
aspeed,ast2700-intc.yaml:
  - Add |' to preserve formatting.
  - Remove the interrupt nubmer accroding to maxItems of interrupts.

drivers/irqchip/irq-aspeed-intc.c
  - Reduce scope of variables, which are bit and status.
  - Replace 32 with INTC_IRQS_PER_WORD define.
  - Remove reduendant tab.

v3:
aspeed,ast2700-intc.yaml:
  - Change reg with maxIntems:10 only.
  - Change interrupt with maxIntems:10 only.
  - Add description of INT0 and INTC1.
  - Fix the indentation.

drivers/irqchip/irq-aspeed-intc.c:
  - Change to use CONFIG_ARCH_ASPEED.
  - Fix indentation.
  - Remove irq_domain name assignment.
  - Check all irq numbers first, and set chained.

Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add AST27XX INTC support

 .../aspeed,ast2700-intc.yaml                  |  86 +++++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 140 ++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1

