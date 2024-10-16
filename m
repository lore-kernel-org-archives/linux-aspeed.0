From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 16 Oct 2024 10:24:10 +0800
Subject: [PATCH v4 2/2] irqchip/aspeed-intc: Add AST27XX INTC support
In-Reply-To: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
Message-ID: <20241016022410.1154574-3-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Support Aspeed Interrupt Controller on Aspeed Silicon SoCs.

ASPEED interrupt controller(INTC) maps the internal interrupt
sources to a parent interrupt controller, which can be GIC or INTC.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-aspeed-intc.c | 140 ++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec2b9f7..086911bf4db6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
new file mode 100644
index 000000000000..faf18a675395
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#define INTC_INT_ENABLE_REG	0x00
+#define INTC_INT_STATUS_REG	0x04
+#define INTC_IRQS_PER_WORD	32
+
+struct aspeed_intc_ic {
+	void __iomem		*base;
+	raw_spinlock_t		gic_lock;
+	raw_spinlock_t		intc_lock;
+	struct irq_domain	*irq_domain;
+};
+
+static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
+		unsigned long bit, status;
+
+		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
+		for_each_set_bit(bit, &status, INTC_IRQS_PER_WORD) {
+			generic_handle_domain_irq(intc_ic->irq_domain, bit);
+			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int mask = readl(intc_ic->base + INTC_INT_ENABLE_REG) & ~BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static void aspeed_intc_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int unmask = readl(intc_ic->base + INTC_INT_ENABLE_REG) | BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static struct irq_chip aspeed_intc_chip = {
+	.name			= "ASPEED INTC",
+	.irq_mask		= aspeed_intc_irq_mask,
+	.irq_unmask		= aspeed_intc_irq_unmask,
+};
+
+static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain, unsigned int irq,
+					 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops = {
+	.map = aspeed_intc_ic_map_irq_domain,
+};
+
+static int __init aspeed_intc_ic_of_init(struct device_node *node,
+					 struct device_node *parent)
+{
+	struct aspeed_intc_ic *intc_ic;
+	int ret = 0;
+	int irq, i;
+
+	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
+	if (!intc_ic)
+		return -ENOMEM;
+
+	intc_ic->base = of_iomap(node, 0);
+	if (!intc_ic->base) {
+		pr_err("Failed to iomap intc_ic base\n");
+		ret = -ENOMEM;
+		goto err_free_ic;
+	}
+	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
+	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
+
+	intc_ic->irq_domain = irq_domain_add_linear(node, INTC_IRQS_PER_WORD,
+						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
+	if (!intc_ic->irq_domain) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	raw_spin_lock_init(&intc_ic->gic_lock);
+	raw_spin_lock_init(&intc_ic->intc_lock);
+
+	/* Check all the irq numbers valid. If not, unmaps all the base and frees the data. */
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+		if (!irq) {
+			pr_err("Failed to get irq number\n");
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+	}
+
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+		irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
+	}
+
+	return 0;
+
+err_iounmap:
+	iounmap(intc_ic->base);
+err_free_ic:
+	kfree(intc_ic);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);
-- 
2.34.1

