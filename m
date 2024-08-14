From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 14 Aug 2024 19:41:04 +0800
Subject: [PATCH v2 0/2] Add support for AST2700 INTC
In-Reply-To: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
Message-ID: <20240814114106.2809876-2-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Support for the Aspeed Interrupt Controller found on Aspeed 7th Geration Silicon
SoCs.

ASPEED interrupt controller(INTC) maps the internal interrupt sources of
the AST27XX devices to an parent interrupt controller.

Changes since v2:
Combine the aspeed_intc_ic_of_init and aspeed_intc_ic_of_init_v2.
Switch raw_spin_lock_irqsave to scoped_guard and guard.
Fix the error of make dt_binding_check.
Refine the aspeed,ast2700-intc.yaml.


Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add support for AST27XX INTC

 .../aspeed,ast2700-intc.yaml                  |  71 +++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 137 ++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1

