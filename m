Return-Path: <linux-aspeed+bounces-1899-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A109C87FDB
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Aug 2025 05:35:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwQHY55y0z3bV6;
	Mon,  4 Aug 2025 15:35:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754285705;
	cv=none; b=DFROLZRfQ02/KU5iU7oeH7POhY/wkoCv/q2BSeeWTcn8DSLmrXZhKNYMz/cT8VlzJKrswPnbSTedZNnTig81AJ2dQUsl9pAwjVtlrhSVBTomi0IwkPQJH2cYtQxQtmS74DnTJquLM2MsWSK8RK2acBAjeFMBVCU8JPRI5o+2T1UODROd4TIOtKT9N67SfNqeg4cY+6CDJAJY5uJU8cH7cI1AISAZUC0L5yehdvKQ6TIrFDP58iGz75lb/ZnS3SRtaAtANsu+Q7PTx86APGXo+PEmHTmQwLbngA0pIcbXZPx3O7UbPGVLg6o5vwqqeMeIY9E9k9ba/p/+JkaCRVx+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754285705; c=relaxed/relaxed;
	bh=2m/h+gYWVKV+F9jUKZysHFdMN7YACYhTrQvjD5NOm7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvzMcbW4z6hk4xzzCk053mRehxJrULhxJnoQOFIT0ZnD1pvyjXRNQhddRgTda4softicAOtSKvrp4h+YMFpEWOFhH+41/20wwHxC47xXNC1x3dUC4BDTPg5tZmuzSyvXPyGrb937by4X3SvW0GUwgOwahunpB01L29w8t+t/H1ngJoOqRkR7xVxT9jEnZ99t6NljrwzYBsKGfaPeNu6c9nhc2ZarQ2S+bo+pU32VYLahNlmiOqMUENswT3CmnD80HTEjq5RH2AiLG5ctaSBhZJqPj9J7eRGbrR/QiEjsSsVIC1ydoCgtT2IF560VkisMaZ85Y0KK0Y8mQM67aCwsZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwQHX68NLz30Wn
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 15:35:04 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 13:34:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 4 Aug 2025 13:34:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU interrupt controllers
Date: Mon, 4 Aug 2025 13:34:45 +0800
Message-ID: <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The AST2700 SoC follows the multi-instance interrupt controller architecture
introduced in the AST2600, where each SCU interrupt group (IC0–IC3) is treated
as an independent interrupt domain.

Unlike the AST2600, which uses a combined register for interrupt enable and
status bits, the AST2700 separates these into distinct registers: one for
interrupt enable (IER) and another for interrupt status (ISR). This architectural
change requires explicit handling of split registers for interrupt control.

- Register definitions and configuration for AST2700 SCU IC instances
  (compatible: aspeed,ast2700-scu-ic0/1/2/3)
- Initialization logic for handling split IER/ISR registers
- Chained IRQ handling and mask/unmask logic
- Table-driven registration using IRQCHIP_DECLARE per compatible

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 240 ++++++++++++++++++++++------
 1 file changed, 195 insertions(+), 45 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 1c7045467c48..b6f3ba269c5b 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Aspeed AST24XX, AST25XX, AST26XX, AST27XX SCU Interrupt Controller
  * Copyright 2019 IBM Corporation
  *
  * Eddie James <eajames@linux.ibm.com>
@@ -34,11 +34,42 @@
 	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
 #define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
 
+#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
+#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
+#define ASPEED_AST2700_SCU_IC0_SHIFT	0
+#define ASPEED_AST2700_SCU_IC0_ENABLE	\
+	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
+#define ASPEED_AST2700_SCU_IC0_NUM_IRQS	4
+
+#define ASPEED_AST2700_SCU_IC1_EN_REG	0x1e0
+#define ASPEED_AST2700_SCU_IC1_STS_REG	0x1e4
+#define ASPEED_AST2700_SCU_IC1_SHIFT	0
+#define ASPEED_AST2700_SCU_IC1_ENABLE	\
+	GENMASK(3, ASPEED_AST2700_SCU_IC1_SHIFT)
+#define ASPEED_AST2700_SCU_IC1_NUM_IRQS	4
+
+#define ASPEED_AST2700_SCU_IC2_EN_REG	0x104
+#define ASPEED_AST2700_SCU_IC2_STS_REG	0x100
+#define ASPEED_AST2700_SCU_IC2_SHIFT	0
+#define ASPEED_AST2700_SCU_IC2_ENABLE	\
+	GENMASK(3, ASPEED_AST2700_SCU_IC2_SHIFT)
+#define ASPEED_AST2700_SCU_IC2_NUM_IRQS	4
+
+#define ASPEED_AST2700_SCU_IC3_EN_REG	0x10c
+#define ASPEED_AST2700_SCU_IC3_STS_REG	0x108
+#define ASPEED_AST2700_SCU_IC3_SHIFT	0
+#define ASPEED_AST2700_SCU_IC3_ENABLE	\
+	GENMASK(1, ASPEED_AST2700_SCU_IC3_SHIFT)
+#define ASPEED_AST2700_SCU_IC3_NUM_IRQS	2
+
 struct aspeed_scu_ic {
 	unsigned long irq_enable;
 	unsigned long irq_shift;
 	unsigned int num_irqs;
 	unsigned int reg;
+	unsigned int en_reg;
+	unsigned int sts_reg;
+	bool split_ier_isr;
 	struct regmap *scu;
 	struct irq_domain *irq_domain;
 };
@@ -52,33 +83,51 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	unsigned long status;
 	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+	unsigned int mask;
 
 	chained_irq_enter(chip, desc);
 
-	/*
-	 * The SCU IC has just one register to control its operation and read
-	 * status. The interrupt enable bits occupy the lower 16 bits of the
-	 * register, while the interrupt status bits occupy the upper 16 bits.
-	 * The status bit for a given interrupt is always 16 bits shifted from
-	 * the enable bit for the same interrupt.
-	 * Therefore, perform the IRQ operations in the enable bit space by
-	 * shifting the status down to get the mapping and then back up to
-	 * clear the bit.
-	 */
-	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
-	enabled = sts & scu_ic->irq_enable;
-	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
-
-	bit = scu_ic->irq_shift;
-	max = scu_ic->num_irqs + bit;
-
-	for_each_set_bit_from(bit, &status, max) {
-		generic_handle_domain_irq(scu_ic->irq_domain,
-					  bit - scu_ic->irq_shift);
-
-		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
-				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+	if (scu_ic->split_ier_isr) {
+		mask = scu_ic->irq_enable;
+		regmap_read(scu_ic->scu, scu_ic->en_reg, &sts);
+		enabled = sts & scu_ic->irq_enable;
+		regmap_read(scu_ic->scu, scu_ic->sts_reg, &sts);
+		status = sts & enabled;
+
+		bit = scu_ic->irq_shift;
+		max = scu_ic->num_irqs + bit;
+
+		for_each_set_bit_from(bit, &status, max) {
+			generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+
+			regmap_write_bits(scu_ic->scu, scu_ic->sts_reg, mask, BIT(bit));
+		}
+	} else {
+		mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+		/*
+		 * The SCU IC has just one register to control its operation and read
+		 * status. The interrupt enable bits occupy the lower 16 bits of the
+		 * register, while the interrupt status bits occupy the upper 16 bits.
+		 * The status bit for a given interrupt is always 16 bits shifted from
+		 * the enable bit for the same interrupt.
+		 * Therefore, perform the IRQ operations in the enable bit space by
+		 * shifting the status down to get the mapping and then back up to
+		 * clear the bit.
+		 */
+		regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+		enabled = sts & scu_ic->irq_enable;
+		status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
+
+		bit = scu_ic->irq_shift;
+		max = scu_ic->num_irqs + bit;
+
+		for_each_set_bit_from(bit, &status, max) {
+			generic_handle_domain_irq(scu_ic->irq_domain,
+						  bit - scu_ic->irq_shift);
+
+			regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
+					  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		}
 	}
 
 	chained_irq_exit(chip, desc);
@@ -87,30 +136,42 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
-	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
-
-	/*
-	 * Status bits are cleared by writing 1. In order to prevent the mask
-	 * operation from clearing the status bits, they should be under the
-	 * mask and written with 0.
-	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	unsigned int mask;
+
+	if (scu_ic->split_ier_isr) {
+		mask = BIT(data->hwirq + scu_ic->irq_shift);
+		regmap_update_bits(scu_ic->scu, scu_ic->en_reg, mask, 0);
+	} else {
+		mask = BIT(data->hwirq + scu_ic->irq_shift) |
+		       (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+		/*
+		 * Status bits are cleared by writing 1. In order to prevent the mask
+		 * operation from clearing the status bits, they should be under the
+		 * mask and written with 0.
+		 */
+		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	}
 }
 
 static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
 	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
-	unsigned int mask = bit |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
-
-	/*
-	 * Status bits are cleared by writing 1. In order to prevent the unmask
-	 * operation from clearing the status bits, they should be under the
-	 * mask and written with 0.
-	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	unsigned int mask;
+
+	if (scu_ic->split_ier_isr) {
+		mask = bit;
+		regmap_update_bits(scu_ic->scu, scu_ic->en_reg, mask, bit);
+	} else {
+		mask = bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+		/*
+		 * Status bits are cleared by writing 1. In order to prevent the unmask
+		 * operation from clearing the status bits, they should be under the
+		 * mask and written with 0.
+		 */
+		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	}
 }
 
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -156,8 +217,17 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		rc = PTR_ERR(scu_ic->scu);
 		goto err;
 	}
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
+
+	if (scu_ic->split_ier_isr) {
+		regmap_write_bits(scu_ic->scu, scu_ic->sts_reg,
+				  scu_ic->irq_enable, scu_ic->irq_enable);
+		regmap_write_bits(scu_ic->scu, scu_ic->en_reg, scu_ic->irq_enable, 0);
+
+	} else {
+		regmap_write_bits(scu_ic->scu, scu_ic->reg,
+				  ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
+		regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
+	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -232,9 +302,89 @@ static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
 
+static int __init aspeed_ast2700_scu_ic0_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC0_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC0_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC0_NUM_IRQS;
+	scu_ic->split_ier_isr = true;
+	scu_ic->en_reg = ASPEED_AST2700_SCU_IC0_EN_REG;
+	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC0_STS_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2700_scu_ic1_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC1_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC1_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC1_NUM_IRQS;
+	scu_ic->split_ier_isr = true;
+	scu_ic->en_reg = ASPEED_AST2700_SCU_IC1_EN_REG;
+	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC1_STS_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2700_scu_ic2_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC2_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC2_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC2_NUM_IRQS;
+	scu_ic->split_ier_isr = true;
+	scu_ic->en_reg = ASPEED_AST2700_SCU_IC2_EN_REG;
+	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC2_STS_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2700_scu_ic3_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC3_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC3_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC3_NUM_IRQS;
+	scu_ic->split_ier_isr = true;
+	scu_ic->en_reg = ASPEED_AST2700_SCU_IC3_EN_REG;
+	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC3_STS_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
 IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
 		aspeed_ast2600_scu_ic0_of_init);
 IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
 		aspeed_ast2600_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic0, "aspeed,ast2700-scu-ic0",
+		aspeed_ast2700_scu_ic0_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic1, "aspeed,ast2700-scu-ic1",
+		aspeed_ast2700_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic2, "aspeed,ast2700-scu-ic2",
+		aspeed_ast2700_scu_ic2_of_init);
+IRQCHIP_DECLARE(ast2700_scu_ic3, "aspeed,ast2700-scu-ic3",
+		aspeed_ast2700_scu_ic3_of_init);
-- 
2.34.1


