Return-Path: <linux-aspeed+bounces-2169-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCDCAC581
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Sep 2025 01:18:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cKpxQ37RLz2yw7;
	Mon,  8 Sep 2025 11:18:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757294314;
	cv=none; b=h5SvMgi/1iYaqJw7PuRhvB40CWEL2mAR3IfAqqKg1BnEoBwGNfjvQAkzi/kdeKVOD+vWIdM1A7Cb9PbCqrTujiDWcZHDAWC5cXqb/j2QkHGc3HxrUW9zzrYpVX8A5HJaonHUkLm9ia1FUYyBML7pyIlKe9xxGBc/I/DG1BCKOv+q3aq6UONzUc43eXgPpSn14Iw6KSI+Ktd0X2zANsni3r6zblbpv07YmAOFbadzIgXqbqKyAtY1DZjZmTySWbRNkS6NmCxhv7Cgx5B+qLYdDcSSnSBYfN1ZBaz5q5widyhjHLyZ3ipNlutj1ua5+Kef9SEeMOmY90vZnXzUOiyqng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757294314; c=relaxed/relaxed;
	bh=nJj+gdMFQTnDrSku8GM82wDUd6sOh7BmiM8YB+U1MzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT21fJO0sJIcJlb/A+sA7gBsoY+NfLbin/6amhWEgBLXxDsg1Mgl++582Xg/CAQ1jwkoU5oWApO2aMbPd1J3F/rrbnLVeCehGjrG+NSIFqio7ksipbcwx3eqtlyu8BTFpo15Spt5iq7sPPp+hljwYaUtcoXzLUcZU9APyzIz5Li8UpkyTh21Zb9KofYgXwjf4QJ7WiHHDYeSZf6x7YJz/LQe8q9FLRwWkNIlfDIRVpxEkLaotNXtMRfwdTlR0Qzs5rFHndiyNRPbB1q7/dQqSnSnbvY67MZTrzh5Vj5kxXAUT1CEk+DRfB4FwrzRs1I+vH0lnLWNvDQnBtNCWLMSlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKpxP2kNQz2ytg
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 11:18:33 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 09:18:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 09:18:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/4] irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization
Date: Mon, 8 Sep 2025 09:18:09 +0800
Message-ID: <20250908011812.1033858-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The original SCU IC driver handled each AST2600 instance with separate
initialization functions and hardcoded register definitions. This patch
consolidates the implementation by introducing a variant-based structure,
selected via compatible string.

The driver now uses a unified init path and MMIO access via of_iomap().
This simplifies the code and prepares for upcoming SoCs like AST2700,
which require split register handling.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 144 ++++++++++++----------------
 1 file changed, 60 insertions(+), 84 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 1c7045467c48..54d2f187e081 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -7,55 +7,56 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/regmap.h>
 
-#define ASPEED_SCU_IC_REG		0x018
-#define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
-#define ASPEED_SCU_IC_NUM_IRQS		7
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
 
-#define ASPEED_AST2600_SCU_IC0_REG	0x560
-#define ASPEED_AST2600_SCU_IC0_SHIFT	0
-#define ASPEED_AST2600_SCU_IC0_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
-#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+struct aspeed_scu_ic_variant {
+	const char		*compatible;
+	unsigned long	irq_enable;
+	unsigned long	irq_shift;
+	unsigned int	num_irqs;
+};
+
+#define SCU_VARIANT(_compat, _shift, _enable, _num) { \
+	.compatible		=	_compat,	\
+	.irq_shift		=	_shift,		\
+	.irq_enable		=	_enable,	\
+	.num_irqs		=	_num,		\
+}
 
-#define ASPEED_AST2600_SCU_IC1_REG	0x570
-#define ASPEED_AST2600_SCU_IC1_SHIFT	4
-#define ASPEED_AST2600_SCU_IC1_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
-#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0,	GENMASK(15, 0),	7),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0,	GENMASK(15, 0), 7),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0,	GENMASK(5, 0),	6),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4,	GENMASK(5, 4),	2),
+};
 
 struct aspeed_scu_ic {
-	unsigned long irq_enable;
-	unsigned long irq_shift;
-	unsigned int num_irqs;
-	unsigned int reg;
-	struct regmap *scu;
-	struct irq_domain *irq_domain;
+	unsigned long		irq_enable;
+	unsigned long		irq_shift;
+	unsigned int		num_irqs;
+	void __iomem		*base;
+	struct irq_domain	*irq_domain;
 };
 
 static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 {
-	unsigned int sts;
-	unsigned long bit;
-	unsigned long enabled;
-	unsigned long max;
-	unsigned long status;
 	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
 
 	chained_irq_enter(chip, desc);
 
+	mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
 	/*
 	 * The SCU IC has just one register to control its operation and read
 	 * status. The interrupt enable bits occupy the lower 16 bits of the
@@ -66,7 +67,7 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	 * shifting the status down to get the mapping and then back up to
 	 * clear the bit.
 	 */
-	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	sts = readl(scu_ic->base);
 	enabled = sts & scu_ic->irq_enable;
 	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
 
@@ -76,9 +77,9 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	for_each_set_bit_from(bit, &status, max) {
 		generic_handle_domain_irq(scu_ic->irq_domain,
 					  bit - scu_ic->irq_shift);
-
-		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
-				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		writel((readl(scu_ic->base) & ~mask) |
+		       BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
+		       scu_ic->base);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -95,7 +96,7 @@ static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
 
 static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
@@ -110,7 +111,7 @@ static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
 }
 
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -146,18 +147,13 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	int irq;
 	int rc = 0;
 
-	if (!node->parent) {
-		rc = -ENODEV;
+	scu_ic->base = of_iomap(node, 0);
+	if (IS_ERR(scu_ic->base)) {
+		rc = PTR_ERR(scu_ic->base);
 		goto err;
 	}
-
-	scu_ic->scu = syscon_node_to_regmap(node->parent);
-	if (IS_ERR(scu_ic->scu)) {
-		rc = PTR_ERR(scu_ic->scu);
-		goto err;
-	}
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
+	writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+	writel(0, scu_ic->base);
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -166,8 +162,7 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	}
 
 	scu_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), scu_ic->num_irqs,
-						   &aspeed_scu_ic_domain_ops,
-						   scu_ic);
+						      &aspeed_scu_ic_domain_ops, scu_ic);
 	if (!scu_ic->irq_domain) {
 		rc = -ENOMEM;
 		goto err;
@@ -184,57 +179,38 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	return rc;
 }
 
-static int __init aspeed_scu_ic_of_init(struct device_node *node,
-					struct device_node *parent)
+static const struct aspeed_scu_ic_variant *
+aspeed_scu_ic_find_variant(struct device_node *np)
 {
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable = ASPEED_SCU_IC_ENABLE;
-	scu_ic->irq_shift = ASPEED_SCU_IC_SHIFT;
-	scu_ic->num_irqs = ASPEED_SCU_IC_NUM_IRQS;
-	scu_ic->reg = ASPEED_SCU_IC_REG;
+	for (int i = 0; i < ARRAY_SIZE(scu_ic_variants); i++) {
+		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
+			return &scu_ic_variants[i];
+	}
 
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
+	return NULL;
 }
 
-static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
-						 struct device_node *parent)
+static int __init aspeed_scu_ic_of_init(struct device_node *node, struct device_node *parent)
 {
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
+	const struct aspeed_scu_ic_variant *variant;
+	struct aspeed_scu_ic *scu_ic;
 
-	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC0_ENABLE;
-	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC0_SHIFT;
-	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC0_NUM_IRQS;
-	scu_ic->reg = ASPEED_AST2600_SCU_IC0_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
-}
-
-static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
-						 struct device_node *parent)
-{
-	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+	variant = aspeed_scu_ic_find_variant(node);
+	if (!variant)
+		return -ENODEV;
 
+	scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
 	if (!scu_ic)
 		return -ENOMEM;
 
-	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC1_ENABLE;
-	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC1_SHIFT;
-	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC1_NUM_IRQS;
-	scu_ic->reg = ASPEED_AST2600_SCU_IC1_REG;
+	scu_ic->irq_enable	= variant->irq_enable;
+	scu_ic->irq_shift	= variant->irq_shift;
+	scu_ic->num_irqs	= variant->num_irqs;
 
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
 
 IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
-		aspeed_ast2600_scu_ic0_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
-		aspeed_ast2600_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_init);
-- 
2.34.1


