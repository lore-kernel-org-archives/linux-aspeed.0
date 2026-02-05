Return-Path: <linux-aspeed+bounces-3481-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0E0E91261
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 06:07:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f66G16hwhz30BR;
	Thu, 05 Feb 2026 17:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770271673;
	cv=none; b=VJXJRFaGfOADgJJ+Q8jWdjVPOZ/ediIeGzoEOTaJ0qnL/UeDcudGUA80h9IyJOttFP6h/ZcTvU2IaqaBGpasy3/uUo865IyLvZC3ROltEC82b8gv1/P2gB009AJnUVCO8uT0IZLHGLW6/r2lvNTFEeTTJFdsi8pZDfBed9HQXGUMk/hHIzwKR9xCH8Q/gE5U+5p4bBEjuGgxLLqbqr4HMq9oxsolpE7Ph1XYKw0a8blAFdwuBCe7Am2CmtdRoDwWy+Yfb8dHVIiUwYjkKMW0nfHIvRWfHXxVWj4dKsWC8OvESrPECUBfZfL9qcf+oziVv/O64aKrow4y7EgW2+iNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770271673; c=relaxed/relaxed;
	bh=rZh6U2qhrG2V6p3VNLSrDhnu7T0cCn/g5lOj1kvvFZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X/INYN/RLSr4OYrRoUSTtpvFArgHrfzzEKJQX63GDpobhqBcvVhmLIJA5KeThLRKbEj6EK4ORj5RDBdqvtBhBuqoXqoZR+htdBKscaD8CD5yMwapDNpHw3indFJcNA4dPFGqEoiH9wufUVbWHm4SbgSiNqAAWTT3Ot7nppei15MFPRmorvEYb8k7yUGNmC68Tl+9dd3wnjzFH33Zztb+jslYlT99dwW3Co+4rsr7xWS5soiTWveKRRYar7vrZRlFwR1embFIMYqKsHKKnI5Ahm7XzJoInCvmQ9rpSmrEB/WkAPDrDGkeGskRbEQZ2B2rD4EaEl/ZkBVy4Odmo67OWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f66G123fVz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 17:07:53 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 5 Feb
 2026 14:07:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 5 Feb 2026 14:07:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 5 Feb 2026 14:07:21 +0800
Subject: [PATCH 3/4] irqchip/aspeed: Remove legacy AST2700 interrupt
 controller driver
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
Message-ID: <20260205-irqchip-v1-3-b0310e06c087@aspeedtech.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
In-Reply-To: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770271649; l=5554;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=/czyJlFUz+m3+HZmKZTbaU3DI1sOmd48ORlq8dtx26A=;
 b=aJadvqQVyHVtwWconhPq6ddtSwD01LZGhovAH0kIteVf2af1Re1ccgCw1Uthb3ijsZLlSwz/9
 NHRDXaSH5MFC+wATQXcP5WsnF0d3X5f8qH93gCvuMs672x0nTSo6NcY
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The legacy driver was designed around a PSP-centric interrupt model and
cannot describe the full routing and protection capabilities of the
AST2700 interrupt architecture.

This driver is superseded by the new AST2700 INTC0/INTC1 drivers, which
provide a unified, block-level description suitable for all integrated
processors.

There are no known upstream users of the legacy
aspeed,ast2700-intc-ic compatible.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/Makefile          |   1 -
 drivers/irqchip/irq-aspeed-intc.c | 139 --------------------------------------
 2 files changed, 140 deletions(-)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 51fdf269e436..ed547e90ae89 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -90,7 +90,6 @@ obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ASPEED_AST2700_INTC)	+= irq-ast2700.o irq-ast2700-intc0.o irq-ast2700-intc1.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
-obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
deleted file mode 100644
index 8330221799a0..000000000000
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ /dev/null
@@ -1,139 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Aspeed Interrupt Controller.
- *
- *  Copyright (C) 2023 ASPEED Technology Inc.
- */
-
-#include <linux/bitops.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#define INTC_INT_ENABLE_REG	0x00
-#define INTC_INT_STATUS_REG	0x04
-#define INTC_IRQS_PER_WORD	32
-
-struct aspeed_intc_ic {
-	void __iomem		*base;
-	raw_spinlock_t		gic_lock;
-	raw_spinlock_t		intc_lock;
-	struct irq_domain	*irq_domain;
-};
-
-static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
-{
-	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-
-	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
-		unsigned long bit, status;
-
-		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
-		for_each_set_bit(bit, &status, INTC_IRQS_PER_WORD) {
-			generic_handle_domain_irq(intc_ic->irq_domain, bit);
-			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void aspeed_intc_irq_mask(struct irq_data *data)
-{
-	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
-	unsigned int mask = readl(intc_ic->base + INTC_INT_ENABLE_REG) & ~BIT(data->hwirq);
-
-	guard(raw_spinlock)(&intc_ic->intc_lock);
-	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
-}
-
-static void aspeed_intc_irq_unmask(struct irq_data *data)
-{
-	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
-	unsigned int unmask = readl(intc_ic->base + INTC_INT_ENABLE_REG) | BIT(data->hwirq);
-
-	guard(raw_spinlock)(&intc_ic->intc_lock);
-	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
-}
-
-static struct irq_chip aspeed_intc_chip = {
-	.name			= "ASPEED INTC",
-	.irq_mask		= aspeed_intc_irq_mask,
-	.irq_unmask		= aspeed_intc_irq_unmask,
-};
-
-static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain, unsigned int irq,
-					 irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops = {
-	.map = aspeed_intc_ic_map_irq_domain,
-};
-
-static int __init aspeed_intc_ic_of_init(struct device_node *node,
-					 struct device_node *parent)
-{
-	struct aspeed_intc_ic *intc_ic;
-	int irq, i, ret = 0;
-
-	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
-	if (!intc_ic)
-		return -ENOMEM;
-
-	intc_ic->base = of_iomap(node, 0);
-	if (!intc_ic->base) {
-		pr_err("Failed to iomap intc_ic base\n");
-		ret = -ENOMEM;
-		goto err_free_ic;
-	}
-	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
-	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
-
-	intc_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), INTC_IRQS_PER_WORD,
-						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
-	if (!intc_ic->irq_domain) {
-		ret = -ENOMEM;
-		goto err_iounmap;
-	}
-
-	raw_spin_lock_init(&intc_ic->gic_lock);
-	raw_spin_lock_init(&intc_ic->intc_lock);
-
-	/* Check all the irq numbers valid. If not, unmaps all the base and frees the data. */
-	for (i = 0; i < of_irq_count(node); i++) {
-		irq = irq_of_parse_and_map(node, i);
-		if (!irq) {
-			pr_err("Failed to get irq number\n");
-			ret = -EINVAL;
-			goto err_iounmap;
-		}
-	}
-
-	for (i = 0; i < of_irq_count(node); i++) {
-		irq = irq_of_parse_and_map(node, i);
-		irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
-	}
-
-	return 0;
-
-err_iounmap:
-	iounmap(intc_ic->base);
-err_free_ic:
-	kfree(intc_ic);
-	return ret;
-}
-
-IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);

-- 
2.34.1


