Return-Path: <linux-aspeed+bounces-3780-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D0F109E559
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:20:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDCf3QvZz2yRl;
	Thu, 26 Mar 2026 17:20:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506014;
	cv=none; b=K2JyGea/HGTvM/19mqdi206tfY5OSjJ2kGRip8pjuHW9IStqc8zCZ2lLkiWn641XcI5RfmuNCElbtAzRURovYVVyBV5aPaQp/HVIElk8K6xMl7Ua0EUIv7UmgnnkjokkBBa7uk1EHpXsPeoAsSKBN85mNPYXnTClnyocRZ253QGZM2DRjfkssdqfNj8MgC0hQiXhfFXU0wqlaHfhJV1iStlszDehDwUgqPBcNPY+UE4GqM8aOrT/Gd2tBcDH8rIjwUN9fverPABOYnkP38j82zM2mO6M/wpQv8ZyLtP5fJ/Vq7qK4vU0UujA0R939XUyqyAdwFr0xi4ZEBfaRf4BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506014; c=relaxed/relaxed;
	bh=Zam0YgTGG5oL17OH82tXcc4i3mucDsyz06TDj1JGpfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KoK0gQl5vEZ6HPUsk8H64KMxFKE/Lhl2GAlnstXX47yY42LtTXLsPphxsEEY1V1t24tz216ioVXqk7WlwuJiAFkkQUe9Z566FN4Po9cMeWB544eEbCSo19Qz+CY5bcSXFb+vLy3IjO8U7Uqac2HuR5VEufNmtuqvt005xIXV3nkQ5Vzkhb/CHR+jKWgBMwO28ZGtsxmF2nqB34U2c/H5f5MDg/d2K4d/mOe14RO+KDtVqlEHVGEsKPfiAW9AP6svkJ/fsNriHgpF691+ZxXGwsklXmJvahG0AZ3I3R4e0iJqAjDKJhfZvTSUDACHfC+Aqobc8Pvq9EX78ij8biWXdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDCc4Psgz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:20:12 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Mar
 2026 14:19:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Mar 2026 14:19:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 26 Mar 2026 14:19:51 +0800
Subject: [PATCH v3 2/4] irqchip/ast2700-intc: Add AST2700-A2 support
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260326-irqchip-v3-2-366739f57acf@aspeedtech.com>
References: <20260326-irqchip-v3-0-366739f57acf@aspeedtech.com>
In-Reply-To: <20260326-irqchip-v3-0-366739f57acf@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774505990; l=34895;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=i6Tc0HPlSQ37VLfqIrBKNmzPPeiMl9bG5qF5c4NSnmA=;
 b=fxTLlUcjU6dpO4ErVeYLxobnySpBHvGV1N8dPm/JJWwcvfm8PauUmRoEKPwFovSrIme6xrrUP
 EVzRWLaHYWaAoC9iKxVNMl8LzPpUiIjnRTc3BvOm6dJk7BVPENHCsdn
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The AST2700 interrupt fabric is shared by multiple integrated processors
(PSP/SSP/TSP/BootMCU), each with its own interrupt controller and its own
devicetree view of the system. As a result, interrupt routing cannot be
treated as fixed: the valid route for a peripheral interrupt depends on
which processor is consuming it.

The INTC0 driver models this by creating a hierarchical irqdomain under
the upstream interrupt controller selected by the interrupt-parent
property in the devicetree. Information derived from this relationship
is incorporated into the route resolution logic for the controller.

The INTC1 driver implements the banked INTM-fed controller and forwards
interrupts toward INTC0, without embedding assumptions about the final
destination processor.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- remove typedef u32 aspeed_intc_output_t
- modify #include <asm-generic/errno.h> to <linux/err.h>
- add newline after include "irq-ast2700.h"
- make defines tabular
- Struct declarations should align the struct member names in a table
- modify raw_spinlock_irqsave() to raw_spin_lock()
- use u32 ier replace mask/unmask
- remove pointless line break
- refine aspeed_intc0_routes, aspeed_intc1_routes array
- remove range_contains_element(), use in_range32()
- remove dev_dbg()
- remove EXPORT_SYMBOL_GPL(aspeed_intc0_resolve_route);
- make irq_set_chip_and_handler() with one line
- replace magic constants to macro define
- move struct aspeed_intc0 to irq-ast2700.h
- add mcro define for upstream param
---
 drivers/irqchip/Kconfig             |  12 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-ast2700-intc0.c | 584 ++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-ast2700-intc1.c | 282 +++++++++++++++++
 drivers/irqchip/irq-ast2700.c       | 106 +++++++
 drivers/irqchip/irq-ast2700.h       |  47 +++
 6 files changed, 1032 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f07b00d7fef9..0156fee89b2c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -110,6 +110,18 @@ config AL_FIC
 	help
 	  Support Amazon's Annapurna Labs Fabric Interrupt Controller.
 
+config ASPEED_AST2700_INTC
+	bool "ASPEED AST2700 Interrupt Controller support"
+	depends on OF
+	depends on ARCH_ASPEED || COMPILE_TEST
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the ASPEED AST2700 interrupt controller.
+	  This driver handles interrupt, routing and merged interrupt
+	  sources to upstream parent interrupt controllers.
+
+	  If unsure, say N.
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 26aa3b6ec99f..62790663f982 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
+obj-$(CONFIG_ASPEED_AST2700_INTC)	+= irq-ast2700.o irq-ast2700-intc0.o irq-ast2700-intc1.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
diff --git a/drivers/irqchip/irq-ast2700-intc0.c b/drivers/irqchip/irq-ast2700-intc0.c
new file mode 100644
index 000000000000..66e2fb108281
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc0.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fwnode.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kconfig.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/overflow.h>
+#include <linux/property.h>
+#include <linux/spinlock.h>
+
+#include "irq-ast2700.h"
+
+#define INT_NUM		480
+#define INTM_NUM	50
+#define SWINT_NUM	16
+
+#define INTM_BASE	(INT_NUM)
+#define SWINT_BASE	(INT_NUM + INTM_NUM)
+#define INT0_NUM	(INT_NUM + INTM_NUM + SWINT_NUM)
+
+#define INTC0_IN_NUM		480
+#define INTC0_ROUTE_NUM		5
+#define INTC0_INTM_NUM		50
+#define INTC0_ROUTE_BITS	3
+
+#define GIC_P2P_SPI_END		128
+#define INTC0_SWINT_OUT_BASE	144
+
+#define INTC0_SWINT_IER		0x10
+#define INTC0_SWINT_ISR		0x14
+#define INTC0_INTBANKX_IER	0x1000
+#define INTC0_INTBANK_SIZE	0x100
+#define INTC0_INTBANK_GROUPS	11
+#define INTC0_INTBANKS_PER_GRP	3
+#define INTC0_INTMX_IER		0x1b00
+#define INTC0_INTMX_ISR		0x1b04
+#define INTC0_INTMX_BANK_SIZE	0x10
+#define INTC0_INTM_BANK_NUM	3
+#define INTC0_IRQS_PER_BANK	32
+#define INTM_IRQS_PER_BANK	10
+#define INTC0_SEL_BASE			0x200
+#define INTC0_SEL_BANK_SIZE		0x4
+#define INTC0_SEL_ROUTE_SIZE	0x100
+
+static void aspeed_swint_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc0->intc_lock);
+	ier = readl(intc0->base + INTC0_SWINT_IER) & ~BIT(bit);
+	writel(ier, intc0->base + INTC0_SWINT_IER);
+	irq_chip_mask_parent(data);
+}
+
+static void aspeed_swint_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc0->intc_lock);
+	ier = readl(intc0->base + INTC0_SWINT_IER) | BIT(bit);
+	writel(ier, intc0->base + INTC0_SWINT_IER);
+	irq_chip_unmask_parent(data);
+}
+
+static void aspeed_swint_irq_eoi(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bit = data->hwirq - SWINT_BASE;
+
+	writel(BIT(bit), intc0->base + INTC0_SWINT_ISR);
+	irq_chip_eoi_parent(data);
+}
+
+static struct irq_chip aspeed_swint_chip = {
+	.name			= "ast2700-swint",
+	.irq_eoi		= aspeed_swint_irq_eoi,
+	.irq_mask		= aspeed_swint_irq_mask,
+	.irq_unmask		= aspeed_swint_irq_unmask,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static void aspeed_intc0_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc0->intc_lock);
+	ier = readl(intc0->base + INTC0_INTMX_IER + bank * INTC0_INTMX_BANK_SIZE) & ~BIT(bit);
+	writel(ier, intc0->base + INTC0_INTMX_IER + bank * INTC0_INTMX_BANK_SIZE);
+	irq_chip_mask_parent(data);
+}
+
+static void aspeed_intc0_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc0->intc_lock);
+	ier = readl(intc0->base + INTC0_INTMX_IER + bank * INTC0_INTMX_BANK_SIZE) | BIT(bit);
+	writel(ier, intc0->base + INTC0_INTMX_IER + bank * INTC0_INTMX_BANK_SIZE);
+	irq_chip_unmask_parent(data);
+}
+
+static void aspeed_intc0_irq_eoi(struct irq_data *data)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	int bank = (data->hwirq - INTM_BASE) / INTM_IRQS_PER_BANK;
+	int bit = (data->hwirq - INTM_BASE) % INTM_IRQS_PER_BANK;
+
+	writel(BIT(bit), intc0->base + INTC0_INTMX_ISR + bank * INTC0_INTMX_BANK_SIZE);
+	irq_chip_eoi_parent(data);
+}
+
+static struct irq_chip aspeed_intm_chip = {
+	.name			= "ast2700-intmerge",
+	.irq_eoi		= aspeed_intc0_irq_eoi,
+	.irq_mask		= aspeed_intc0_irq_mask,
+	.irq_unmask		= aspeed_intc0_irq_unmask,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip linear_intr_irq_chip = {
+	.name			= "ast2700-int",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static const u32 aspeed_intc0_routes[INTC0_IN_NUM / INTC0_IRQS_PER_BANK][INTC0_ROUTE_NUM] = {
+	{ 0, 256, 426, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
+	{ 32, 288, 458, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
+	{ 64, 320, 490, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
+	{ 96, 352, 522, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
+	{ 128, 384, 554, 160, 176 },
+	{ 129, 385, 555, 161, 177 },
+	{ 130, 386, 556, 162, 178 },
+	{ 131, 387, 557, 163, 179 },
+	{ 132, 388, 558, 164, 180 },
+	{ 133, 544, 714, 165, 181 },
+	{ 134, 545, 715, 166, 182 },
+	{ 135, 546, 706, 167, 183 },
+	{ 136, 547, 707, 168, 184 },
+	{ 137, 548, 708, 169, 185 },
+	{ 138, 549, 709, 170, 186 },
+};
+
+static const u32 aspeed_intc0_intm_routes[INTC0_INTM_NUM / INTM_IRQS_PER_BANK] = {
+	192, 416, 586, 208, 224
+};
+
+static int resolve_input_from_child_ranges(const struct aspeed_intc0 *intc0,
+					   const struct aspeed_intc_interrupt_range *range,
+					   u32 outpin, u32 *input)
+{
+	u32 offset, base;
+
+	if (!in_range32(outpin, range->start, range->count))
+		return -ENOENT;
+
+	if (range->upstream.param_count == 0)
+		return -EINVAL;
+
+	base = range->upstream.param[ASPEED_INTC_RANGES_BASE];
+	offset = outpin - range->start;
+	if (check_add_overflow(base, offset, input)) {
+		dev_warn(intc0->dev, "%s: Arithmetic overflow for input derivation: %u + %u\n",
+			 __func__, base, offset);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int resolve_parent_range_for_output(const struct aspeed_intc0 *intc0,
+					   const struct fwnode_handle *parent,
+					   u32 output,
+					   struct aspeed_intc_interrupt_range *resolved)
+{
+	for (size_t i = 0; i < intc0->ranges.nranges; i++) {
+		struct aspeed_intc_interrupt_range range =
+			intc0->ranges.ranges[i];
+
+		if (!in_range32(output, range.start, range.count))
+			continue;
+
+		if (range.upstream.fwnode != parent)
+			continue;
+
+		if (resolved) {
+			resolved->start = output;
+			resolved->count = 1;
+			resolved->upstream = range.upstream;
+			resolved->upstream.param[ASPEED_INTC_RANGES_COUNT] +=
+				output - range.start;
+		}
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int resolve_parent_route_for_input(const struct aspeed_intc0 *intc0,
+					  const struct fwnode_handle *parent, u32 input,
+					  struct aspeed_intc_interrupt_range *resolved)
+{
+	int rc = -ENOENT;
+	u32 c0o;
+
+	if (input < INT_NUM) {
+		static_assert(INTC0_ROUTE_NUM < INT_MAX, "Broken cast");
+		for (size_t i = 0; rc == -ENOENT && i < INTC0_ROUTE_NUM; i++) {
+			c0o = aspeed_intc0_routes[input / INTC0_IRQS_PER_BANK][i];
+			if (c0o == AST2700_INTC_INVALID_ROUTE)
+				continue;
+
+			if (input < GIC_P2P_SPI_END)
+				c0o += input % INTC0_IRQS_PER_BANK;
+
+			rc = resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+			if (!rc)
+				return (int)i;
+		}
+	} else if (input < (INT_NUM + INTM_NUM)) {
+		c0o = aspeed_intc0_intm_routes[(input - INT_NUM) / INTM_IRQS_PER_BANK];
+		c0o += ((input - INT_NUM) % INTM_IRQS_PER_BANK);
+		return resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+	} else if (input < (INT_NUM + INTM_NUM + SWINT_NUM)) {
+		c0o = input - SWINT_BASE + INTC0_SWINT_OUT_BASE;
+		return resolve_parent_range_for_output(intc0, parent, c0o, resolved);
+	} else {
+		return -ENOENT;
+	}
+
+	return rc;
+}
+
+/**
+ * aspeed_intc0_resolve_route - Determine the necessary interrupt output at intc1
+ * @c0domain: The pointer to intc0's irq_domain
+ * @nc1outs: The number of valid intc1 outputs available for the input
+ * @c1outs: The array of available intc1 output indices for the input
+ * @nc1ranges: The number of interrupt range entries for intc1
+ * @c1ranges: The array of configured intc1 interrupt ranges
+ * @resolved: The fully resolved range entry after applying the resolution
+ *            algorithm
+ *
+ * Returns: The intc1 route index associated with the intc1 output identified in
+ * @resolved on success. Otherwise, a negative errno value.
+ *
+ * The AST2700 interrupt architecture allows any peripheral interrupt source
+ * to be routed to one of up to four processors running in the SoC. A processor
+ * binding a driver for a peripheral that requests an interrupt is (without
+ * further design and effort) the destination for the requested interrupt.
+ *
+ * Routing a peripheral interrupt to its destination processor requires
+ * coordination between INTC0 on the CPU die and one or more INTC1 instances.
+ * At least one INTC1 instance exists in the SoC on the IO-die, however up
+ * to two more instances may be integrated via LTPI (LVDS Tunneling Protocol
+ * & Interface).
+ *
+ * Between the multiple destinations, various route constraints, and the
+ * devicetree binding design, some information that's needed at INTC1 instances
+ * to route inbound interrupts correctly to the destination processor is only
+ * available at INTC0.
+ *
+ * aspeed_intc0_resolve_route() is to be invoked by INTC1 driver instances to
+ * perform the route resolution. The implementation in INTC0 allows INTC0 to
+ * encapsulate the information used to perform route selection, and provides it
+ * with an opportunity to apply policy as part of the selection process. Such
+ * policy may, for instance, choose to de-prioritise some interrupts destined
+ * for the PSP (Primary Service Processor) GIC.
+ */
+int aspeed_intc0_resolve_route(const struct irq_domain *c0domain, size_t nc1outs,
+			       const u32 *c1outs, size_t nc1ranges,
+			       const struct aspeed_intc_interrupt_range *c1ranges,
+			       struct aspeed_intc_interrupt_range *resolved)
+{
+	struct fwnode_handle *parent_fwnode;
+	struct aspeed_intc0 *intc0;
+	int ret;
+
+	if (!c0domain || !resolved)
+		return -EINVAL;
+
+	if (nc1outs > INT_MAX)
+		return -EINVAL;
+
+	if (nc1outs == 0 || nc1ranges == 0)
+		return -ENOENT;
+
+	if (!fwnode_device_is_compatible(c0domain->fwnode, "aspeed,ast2700-intc0"))
+		return -ENODEV;
+
+	intc0 = c0domain->host_data;
+	if (!intc0)
+		return -EINVAL;
+
+	parent_fwnode = of_fwnode_handle(intc0->parent);
+
+	for (size_t i = 0; i < nc1outs; i++) {
+		u32 c1o = c1outs[i];
+
+		if (c1o == AST2700_INTC_INVALID_ROUTE)
+			continue;
+
+		for (size_t j = 0; j < nc1ranges; j++) {
+			struct aspeed_intc_interrupt_range c1r = c1ranges[j];
+			u32 input;
+
+			/*
+			 * Range match for intc1 output pin
+			 *
+			 * Assume a failed match is still a match for the purpose of testing,
+			 * saves a bunch of mess in the test fixtures
+			 */
+			if (!(c0domain == irq_find_matching_fwspec(&c1r.upstream,
+								   c0domain->bus_token) ||
+			      IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST)))
+				continue;
+
+			ret = resolve_input_from_child_ranges(intc0, &c1r, c1o, &input);
+			if (ret)
+				continue;
+
+			/*
+			 * INTC1 should never request routes for peripheral interrupt sources
+			 * directly attached to INTC0.
+			 */
+			if (input < GIC_P2P_SPI_END)
+				continue;
+
+			ret = resolve_parent_route_for_input(intc0, parent_fwnode, input, NULL);
+			if (ret < 0)
+				continue;
+
+			/* Route resolution succeeded */
+			resolved->start = c1o;
+			resolved->count = 1;
+			resolved->upstream = c1r.upstream;
+			resolved->upstream.param[ASPEED_INTC_RANGES_BASE] = input;
+			/* Cast protected by prior test against nc1outs */
+			return (int)i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static int aspeed_intc0_irq_domain_map(struct irq_domain *domain,
+				       unsigned int irq, irq_hw_number_t hwirq)
+{
+	if (hwirq < GIC_P2P_SPI_END)
+		irq_set_chip_and_handler(irq, &linear_intr_irq_chip, handle_level_irq);
+	else if (hwirq < INTM_BASE)
+		return -EINVAL;
+	else if (hwirq < SWINT_BASE)
+		irq_set_chip_and_handler(irq, &aspeed_intm_chip, handle_level_irq);
+	else if (hwirq < INT0_NUM)
+		irq_set_chip_and_handler(irq, &aspeed_swint_chip, handle_level_irq);
+	else
+		return -EINVAL;
+
+	irq_set_chip_data(irq, domain->host_data);
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_translate(struct irq_domain *domain,
+					     struct irq_fwspec *fwspec,
+					     unsigned long *hwirq,
+					     unsigned int *type)
+{
+	if (fwspec->param_count != 1)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_alloc(struct irq_domain *domain,
+					 unsigned int virq,
+					 unsigned int nr_irqs, void *data)
+{
+	struct aspeed_intc0 *intc0 = domain->host_data;
+	struct aspeed_intc_interrupt_range resolved;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	struct irq_chip *chip;
+	unsigned long hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = aspeed_intc0_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (hwirq >= GIC_P2P_SPI_END && hwirq < INT_NUM)
+		return -EINVAL;
+
+	if (hwirq < INTM_BASE)
+		chip = &linear_intr_irq_chip;
+	else if (hwirq < SWINT_BASE)
+		chip = &aspeed_intm_chip;
+	else
+		chip = &aspeed_swint_chip;
+
+	ret = resolve_parent_route_for_input(intc0, domain->parent->fwnode,
+					     (u32)hwirq, &resolved);
+	if (ret)
+		return ret;
+
+	parent_fwspec = resolved.upstream;
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					   &parent_fwspec);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
+		ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip,
+						    domain->host_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aspeed_intc0_irq_domain_activate(struct irq_domain *domain,
+					    struct irq_data *data, bool reserve)
+{
+	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
+	unsigned long hwirq = data->hwirq;
+	int route, bank, bit;
+	u32 mask;
+
+	if (hwirq >= INT0_NUM)
+		return -EINVAL;
+
+	if (in_range32(hwirq, INTM_BASE, INTM_NUM + SWINT_NUM))
+		return 0;
+
+	bank = hwirq / INTC0_IRQS_PER_BANK;
+	bit = hwirq % INTC0_IRQS_PER_BANK;
+	mask = BIT(bit);
+
+	route = resolve_parent_route_for_input(intc0, intc0->local->parent->fwnode,
+					       hwirq, NULL);
+	if (route < 0)
+		return route;
+
+	guard(raw_spinlock)(&intc0->intc_lock);
+	for (int i = 0; i < INTC0_ROUTE_BITS; i++) {
+		void __iomem *sel = intc0->base + INTC0_SEL_BASE +
+				    (bank * INTC0_SEL_BANK_SIZE) +
+				    (INTC0_SEL_ROUTE_SIZE * i);
+		u32 reg = readl(sel);
+
+		if (route & BIT(i))
+			reg |= mask;
+		else
+			reg &= ~mask;
+
+		writel(reg, sel);
+		if (readl(sel) != reg)
+			return -EACCES;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc0_irq_domain_ops = {
+	.translate	= aspeed_intc0_irq_domain_translate,
+	.activate	= aspeed_intc0_irq_domain_activate,
+	.alloc		= aspeed_intc0_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+	.map		= aspeed_intc0_irq_domain_map,
+};
+
+static void aspeed_intc0_disable_swint(struct aspeed_intc0 *intc0)
+{
+	writel(0, intc0->base + INTC0_SWINT_IER);
+}
+
+static void aspeed_intc0_disable_intbank(struct aspeed_intc0 *intc0)
+{
+	for (int i = 0; i < INTC0_INTBANK_GROUPS; i++) {
+		for (int j = 0; j < INTC0_INTBANKS_PER_GRP; j++) {
+			u32 base = INTC0_INTBANKX_IER +
+				   (INTC0_INTBANK_SIZE * i) +
+				   (INTC0_INTMX_BANK_SIZE * j);
+
+			writel(0, intc0->base + base);
+		}
+	}
+}
+
+static void aspeed_intc0_disable_intm(struct aspeed_intc0 *intc0)
+{
+	for (int i = 0; i < INTC0_INTM_BANK_NUM; i++)
+		writel(0, intc0->base + INTC0_INTMX_IER + (INTC0_INTMX_BANK_SIZE * i));
+}
+
+static int aspeed_intc0_probe(struct platform_device *pdev,
+			      struct device_node *parent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct irq_domain *parent_domain;
+	struct aspeed_intc0 *intc0;
+	int ret;
+
+	if (!parent) {
+		pr_err("missing parent interrupt node\n");
+		return -ENODEV;
+	}
+
+	intc0 = devm_kzalloc(&pdev->dev, sizeof(*intc0), GFP_KERNEL);
+	if (!intc0)
+		return -ENOMEM;
+
+	intc0->dev = &pdev->dev;
+	intc0->parent = parent;
+	intc0->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intc0->base))
+		return PTR_ERR(intc0->base);
+
+	aspeed_intc0_disable_swint(intc0);
+	aspeed_intc0_disable_intbank(intc0);
+	aspeed_intc0_disable_intm(intc0);
+
+	raw_spin_lock_init(&intc0->intc_lock);
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("unable to obtain parent domain\n");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_compatible(parent, "arm,gic-v3"))
+		return -ENODEV;
+
+	intc0->local = irq_domain_create_hierarchy(parent_domain, 0, INT0_NUM,
+						   of_fwnode_handle(node),
+						   &aspeed_intc0_irq_domain_ops,
+						   intc0);
+	if (!intc0->local)
+		return -ENOMEM;
+
+	ret = aspeed_intc_populate_ranges(&pdev->dev, &intc0->ranges);
+	if (ret < 0) {
+		irq_domain_remove(intc0->local);
+		return ret;
+	}
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc0)
+IRQCHIP_MATCH("aspeed,ast2700-intc0", aspeed_intc0_probe)
+IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc0)
diff --git a/drivers/irqchip/irq-ast2700-intc1.c b/drivers/irqchip/irq-ast2700-intc1.c
new file mode 100644
index 000000000000..09b9d5d743e6
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700-intc1.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+
+#include "irq-ast2700.h"
+
+#define INTC1_IER			0x100
+#define INTC1_ISR			0x104
+#define INTC1_BANK_SIZE		0x10
+#define INTC1_SEL_BASE			0x80
+#define INTC1_SEL_BANK_SIZE		0x4
+#define INTC1_SEL_ROUTE_SIZE	0x20
+#define INTC1_IRQS_PER_BANK		32
+#define INTC1_BANK_NUM			6
+#define INTC1_ROUTE_NUM			7
+#define INTC1_IN_NUM			192
+#define INTC1_BOOTMCU_ROUTE		6
+#define INTC1_ROUTE_SELECTOR_BITS	3
+#define INTC1_ROUTE_IRQS_PER_GROUP	32
+#define INTC1_ROUTE_SHIFT		5
+
+struct aspeed_intc1 {
+	struct device				*dev;
+	void __iomem				*base;
+	raw_spinlock_t				intc_lock;
+	struct irq_domain			*local;
+	struct irq_domain			*upstream;
+	struct aspeed_intc_interrupt_ranges	ranges;
+};
+
+static void aspeed_intc1_disable_int(struct aspeed_intc1 *intc1)
+{
+	for (int i = 0; i < INTC1_BANK_NUM; i++)
+		writel(0, intc1->base + INTC1_IER + (INTC1_BANK_SIZE * i));
+}
+
+static void aspeed_intc1_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc1 *intc1 = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long bit, status;
+
+	chained_irq_enter(chip, desc);
+
+	for (int bank = 0; bank < INTC1_BANK_NUM; bank++) {
+		status = readl(intc1->base + INTC1_ISR + (INTC1_BANK_SIZE * bank));
+		if (!status)
+			continue;
+
+		for_each_set_bit(bit, &status, INTC1_IRQS_PER_BANK) {
+			generic_handle_domain_irq(intc1->local, (bank * INTC1_IRQS_PER_BANK) + bit);
+			writel(BIT(bit), intc1->base + INTC1_ISR + (INTC1_BANK_SIZE * bank));
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc1_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	int bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	int bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc1->intc_lock);
+	ier = readl(intc1->base + INTC1_IER + (INTC1_BANK_SIZE * bank)) & ~BIT(bit);
+	writel(ier, intc1->base + INTC1_IER + (INTC1_BANK_SIZE * bank));
+}
+
+static void aspeed_intc1_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	int bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	int bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	u32 ier;
+
+	guard(raw_spinlock)(&intc1->intc_lock);
+	ier = readl(intc1->base + INTC1_IER + (INTC1_BANK_SIZE * bank)) | BIT(bit);
+	writel(ier, intc1->base + INTC1_IER + (INTC1_BANK_SIZE * bank));
+}
+
+static struct irq_chip aspeed_intc_chip = {
+	.name		= "ASPEED INTC1",
+	.irq_mask	= aspeed_intc1_irq_mask,
+	.irq_unmask	= aspeed_intc1_irq_unmask,
+};
+
+static int aspeed_intc1_irq_domain_translate(struct irq_domain *domain,
+					     struct irq_fwspec *fwspec,
+					     unsigned long *hwirq,
+					     unsigned int *type)
+{
+	if (fwspec->param_count != 1)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_LEVEL_HIGH;
+	return 0;
+}
+
+static int aspeed_intc1_map_irq_domain(struct irq_domain *domain,
+				       unsigned int irq,
+				       irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(domain, irq, hwirq, &aspeed_intc_chip,
+			    domain->host_data, handle_level_irq, NULL, NULL);
+	return 0;
+}
+
+/*
+ * In-bound interrupts are progressively merged into one out-bound interrupt in
+ * groups of 32. Apply this fact to compress the route table in corresponding
+ * groups of 32.
+ */
+static const u32
+aspeed_intc1_routes[INTC1_IN_NUM / INTC1_ROUTE_IRQS_PER_GROUP][INTC1_ROUTE_NUM] = {
+	{ 0, AST2700_INTC_INVALID_ROUTE, 10, 20, 30, 40, 50 },
+	{ 1, AST2700_INTC_INVALID_ROUTE, 11, 21, 31, 41, 50 },
+	{ 2, AST2700_INTC_INVALID_ROUTE, 12, 22, 32, 42, 50 },
+	{ 3, AST2700_INTC_INVALID_ROUTE, 13, 23, 33, 43, 50 },
+	{ 4, AST2700_INTC_INVALID_ROUTE, 14, 24, 34, 44, 50 },
+	{ 5, AST2700_INTC_INVALID_ROUTE, 15, 25, 35, 45, 50 },
+};
+
+static int aspeed_intc1_irq_domain_activate(struct irq_domain *domain,
+					    struct irq_data *data, bool reserve)
+{
+	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
+	struct aspeed_intc_interrupt_range resolved;
+	int rc, bank, bit;
+	u32 mask;
+
+	if (WARN_ON_ONCE((data->hwirq >> INTC1_ROUTE_SHIFT) >= ARRAY_SIZE(aspeed_intc1_routes)))
+		return -EINVAL;
+
+	/*
+	 * outpin may be an error if the upstream is the BootMCU APLIC node, or
+	 * anything except a valid intc0 driver instance
+	 */
+	rc = aspeed_intc0_resolve_route(intc1->upstream, INTC1_ROUTE_NUM,
+					aspeed_intc1_routes[data->hwirq >> INTC1_ROUTE_SHIFT],
+					intc1->ranges.nranges,
+					intc1->ranges.ranges, &resolved);
+	if (rc < 0) {
+		if (!fwnode_device_is_compatible(intc1->upstream->fwnode, "riscv,aplic")) {
+			dev_warn(intc1->dev,
+				 "Failed to resolve interrupt route for hwirq %lu in domain %s\n",
+				 data->hwirq, domain->name);
+			return rc;
+		}
+		rc = INTC1_BOOTMCU_ROUTE;
+	}
+
+	bank = data->hwirq / INTC1_IRQS_PER_BANK;
+	bit = data->hwirq % INTC1_IRQS_PER_BANK;
+	mask = BIT(bit);
+
+	guard(raw_spinlock)(&intc1->intc_lock);
+	for (int i = 0; i < INTC1_ROUTE_SELECTOR_BITS; i++) {
+		void __iomem *sel = intc1->base + INTC1_SEL_BASE +
+				    (bank * INTC1_SEL_BANK_SIZE) +
+				    (INTC1_SEL_ROUTE_SIZE * i);
+		u32 reg = readl(sel);
+
+		if (rc & BIT(i))
+			reg |= mask;
+		else
+			reg &= ~mask;
+
+		writel(reg, sel);
+		if (readl(sel) != reg)
+			return -EACCES;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc1_irq_domain_ops = {
+	.map		= aspeed_intc1_map_irq_domain,
+	.translate	= aspeed_intc1_irq_domain_translate,
+	.activate	= aspeed_intc1_irq_domain_activate,
+};
+
+static void aspeed_intc1_request_interrupts(struct aspeed_intc1 *intc1)
+{
+	for (unsigned int i = 0; i < intc1->ranges.nranges; i++) {
+		struct aspeed_intc_interrupt_range *r =
+			&intc1->ranges.ranges[i];
+
+		if (intc1->upstream !=
+		    irq_find_matching_fwspec(&r->upstream,
+					     intc1->upstream->bus_token))
+			continue;
+
+		for (u32 k = 0; k < r->count; k++) {
+			struct of_phandle_args parent_irq;
+			int irq;
+
+			parent_irq.np = to_of_node(r->upstream.fwnode);
+			parent_irq.args_count = 1;
+			parent_irq.args[0] =
+				intc1->ranges.ranges[i].upstream.param[ASPEED_INTC_RANGES_BASE] + k;
+
+			irq = irq_create_of_mapping(&parent_irq);
+			if (!irq)
+				continue;
+
+			irq_set_chained_handler_and_data(irq,
+							 aspeed_intc1_irq_handler, intc1);
+		}
+	}
+}
+
+static int aspeed_intc1_probe(struct platform_device *pdev,
+			      struct device_node *parent)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct aspeed_intc1 *intc1;
+	struct irq_domain *host;
+	int ret;
+
+	if (!parent) {
+		dev_err(&pdev->dev, "missing parent interrupt node\n");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_compatible(parent, "aspeed,ast2700-intc0"))
+		return -ENODEV;
+
+	host = irq_find_host(parent);
+	if (!host)
+		return -ENODEV;
+
+	intc1 = devm_kzalloc(&pdev->dev, sizeof(*intc1), GFP_KERNEL);
+	if (!intc1)
+		return -ENOMEM;
+
+	intc1->dev = &pdev->dev;
+	intc1->upstream = host;
+	intc1->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intc1->base))
+		return PTR_ERR(intc1->base);
+
+	aspeed_intc1_disable_int(intc1);
+
+	raw_spin_lock_init(&intc1->intc_lock);
+
+	intc1->local = irq_domain_create_linear(of_fwnode_handle(node),
+						INTC1_BANK_NUM * INTC1_IRQS_PER_BANK,
+						&aspeed_intc1_irq_domain_ops, intc1);
+	if (!intc1->local)
+		return -ENOMEM;
+
+	ret = aspeed_intc_populate_ranges(&pdev->dev, &intc1->ranges);
+	if (ret < 0) {
+		irq_domain_remove(intc1->local);
+		return ret;
+	}
+
+	aspeed_intc1_request_interrupts(intc1);
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc1)
+IRQCHIP_MATCH("aspeed,ast2700-intc1", aspeed_intc1_probe)
+IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc1)
diff --git a/drivers/irqchip/irq-ast2700.c b/drivers/irqchip/irq-ast2700.c
new file mode 100644
index 000000000000..280657480d5f
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2026 ASPEED Technology Inc.
+ */
+#include "irq-ast2700.h"
+
+#define ASPEED_INTC_RANGE_FIXED_CELLS	3U
+#define ASPEED_INTC_RANGE_OFF_START	0U
+#define ASPEED_INTC_RANGE_OFF_COUNT	1U
+#define ASPEED_INTC_RANGE_OFF_PHANDLE	2U
+
+/**
+ * aspeed_intc_populate_ranges
+ * @dev: Device owning the interrupt controller node.
+ * @ranges: Destination for parsed range descriptors.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int aspeed_intc_populate_ranges(struct device *dev,
+				struct aspeed_intc_interrupt_ranges *ranges)
+{
+	struct aspeed_intc_interrupt_range *arr;
+	const __be32 *pvs, *pve;
+	struct device_node *dn;
+	int len;
+
+	if (!dev || !ranges)
+		return -EINVAL;
+
+	dn = dev->of_node;
+
+	pvs = of_get_property(dn, "aspeed,interrupt-ranges", &len);
+	if (!pvs)
+		return -EINVAL;
+
+	if (len % sizeof(__be32))
+		return -EINVAL;
+
+	/* Over-estimate the range entry count for now */
+	ranges->ranges = devm_kmalloc_array(dev,
+					    len / (ASPEED_INTC_RANGE_FIXED_CELLS * sizeof(__be32)),
+					    sizeof(*ranges->ranges),
+					    GFP_KERNEL);
+	if (!ranges->ranges)
+		return -ENOMEM;
+
+	pve = pvs + (len / sizeof(__be32));
+	for (unsigned int i = 0; pve - pvs >= ASPEED_INTC_RANGE_FIXED_CELLS; i++) {
+		struct aspeed_intc_interrupt_range *r;
+		struct device_node *target;
+		u32 target_cells;
+
+		target = of_find_node_by_phandle(be32_to_cpu(pvs[ASPEED_INTC_RANGE_OFF_PHANDLE]));
+		if (!target)
+			return -EINVAL;
+
+		if (of_property_read_u32(target, "#interrupt-cells",
+					 &target_cells)) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		if (!target_cells || target_cells > IRQ_DOMAIN_IRQ_SPEC_PARAMS) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		if (pve - pvs < ASPEED_INTC_RANGE_FIXED_CELLS + target_cells) {
+			of_node_put(target);
+			return -EINVAL;
+		}
+
+		r = &ranges->ranges[i];
+		r->start = be32_to_cpu(pvs[ASPEED_INTC_RANGE_OFF_START]);
+		r->count = be32_to_cpu(pvs[ASPEED_INTC_RANGE_OFF_COUNT]);
+
+		{
+			struct of_phandle_args args = {
+				.np = target,
+				.args_count = target_cells,
+			};
+
+			for (u32 j = 0; j < target_cells; j++)
+				args.args[j] = be32_to_cpu(pvs[ASPEED_INTC_RANGE_FIXED_CELLS + j]);
+
+			of_phandle_args_to_fwspec(target, args.args,
+						  args.args_count,
+						  &r->upstream);
+		}
+
+		of_node_put(target);
+		pvs += ASPEED_INTC_RANGE_FIXED_CELLS + target_cells;
+		ranges->nranges++;
+	}
+
+	/* Re-fit the range array now we know the entry count */
+	arr = devm_krealloc_array(dev, ranges->ranges, ranges->nranges,
+				  sizeof(*ranges->ranges), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+	ranges->ranges = arr;
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-ast2700.h b/drivers/irqchip/irq-ast2700.h
new file mode 100644
index 000000000000..544f1af4c8ab
--- /dev/null
+++ b/drivers/irqchip/irq-ast2700.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Aspeed AST2700 Interrupt Controller.
+ *
+ *  Copyright (C) 2026 ASPEED Technology Inc.
+ */
+#ifndef DRIVERS_IRQCHIP_AST2700
+#define DRIVERS_IRQCHIP_AST2700
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+
+#define AST2700_INTC_INVALID_ROUTE (~0U)
+#define ASPEED_INTC_RANGES_BASE		0U
+#define ASPEED_INTC_RANGES_COUNT	1U
+
+struct aspeed_intc_interrupt_range {
+	u32               start;
+	u32               count;
+	struct irq_fwspec upstream;
+};
+
+struct aspeed_intc_interrupt_ranges {
+	struct aspeed_intc_interrupt_range *ranges;
+	unsigned int                       nranges;
+};
+
+struct aspeed_intc0 {
+	struct device				*dev;
+	void __iomem				*base;
+	raw_spinlock_t				intc_lock;
+	struct irq_domain			*local;
+	struct device_node			*parent;
+	struct aspeed_intc_interrupt_ranges	ranges;
+};
+
+int aspeed_intc_populate_ranges(struct device *dev,
+				struct aspeed_intc_interrupt_ranges *ranges);
+
+int aspeed_intc0_resolve_route(const struct irq_domain *c0domain,
+			       size_t nc1outs,
+			       const u32 *c1outs,
+			       size_t nc1ranges,
+			       const struct aspeed_intc_interrupt_range *c1ranges,
+			       struct aspeed_intc_interrupt_range *resolved);
+
+#endif

-- 
2.34.1


