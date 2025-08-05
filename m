Return-Path: <linux-aspeed+bounces-1903-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD4C87FCB
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Aug 2025 07:51:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx5G2034Lz3bh6;
	Tue,  5 Aug 2025 17:51:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754380265;
	cv=none; b=WMBQKDvUR0eQniuNYKAsOLSEYF8MjSM9tLnTEMHldl7LH2NvkD67Uynl8DxyKffQl5yvRM17a1An1K5kQ56Aig/yoXYfHZExF5/mXeSO6uuPr6eitt5oBsXPOxbi7xs2VrdaFgKswc4rCMh2mVpiRjP7bvg+esD8Xkt9bS5diBaVccCMNveGwhrzARzO47W7LJ9wc8sK4EkxsO3w7uPexvA0AAG6fC+Q2oPSf/IAvmw4q+xZtAM2gHqFRy4/gO0Q8nloaYgQ1cqrzGrhvpO+xvHqIeFMDPgHvkc3igny16C3BfLhoxG921xH/YFra+dml/Q2CfssZgYrzLU7VX8DNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754380265; c=relaxed/relaxed;
	bh=+So4wv8Zly3BtM63OQvZFyoVi+SRY/LO7UXsrqv6fcM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFElqrUp63UeRg3J7k5VveFBRHy7YXW9XU+c2UflR2kQDse+XZeGV0tdQWzlVAWkh5sNDT+iKtibo8HJ/gMu4hk7Xb9OJSBPFBAy6EjBaNTxrgs9D32O4N4pG7W5E45++up5e+k76hJfgmSmlF+hhLCN9EGfL/3Is+m40Yj5QU6m1+hqF9HSmDmYwVX78HsOSIh4mOdHxY2Sk2iZyi5v1/5PjPI8JQV1hy1XZGTrFVluGPMKWpRzF+L/rejDialGRBAw4j/Xt5PrBeIXhHXTZEfaPYkDYdDo4Ife6IOzkt8ee/FqgUk34NZc8783KNrUeBpDK91OVXE291NA5BXvQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ENkdKStn; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kDsAWd4d; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ENkdKStn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kDsAWd4d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx5Fx3RWtz2xnM
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Aug 2025 17:51:01 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754380253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+So4wv8Zly3BtM63OQvZFyoVi+SRY/LO7UXsrqv6fcM=;
	b=ENkdKStnJoAkA7rx4rCYyNvtfAObVJucm1RTLx0dCnp6fLEhYmmtees1scz01sZcNuGQ72
	LYetv4m5hNv8baU3Hoc+i4/m/gX775ghEjIpGKHkW02GP5mlcQw7Qq4dATqHCRJefyXSnC
	PfbtP8lYlQEexNFMGYPbRabIjdcm9C1SAbbRQe040we8pcNLcDqbgP+PoKaOLXO8QlCPsH
	PeLl7os0fgf1FbKd6FRrZyfo0OdKXKHCPx2zVjQDR4PvOPkB39R9GrRj3YXuQtTFCR7r4k
	80RVHm0udF+/eLGnmh0+49AKNmGEeu5PfqINf7a8XQe8MVejCN43T47tjXLQwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754380253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+So4wv8Zly3BtM63OQvZFyoVi+SRY/LO7UXsrqv6fcM=;
	b=kDsAWd4dy48cmoYwpT8I4eiUq6h6MDpAhKchcYikjsGh9zQmB8lOuDP9cO66j1qoC3gMqQ
	MnNkyv4iYe2pTqBA==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
In-Reply-To: <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
Date: Tue, 05 Aug 2025 09:50:52 +0200
Message-ID: <874iumgqar.ffs@tglx>
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
Content-Type: text/plain

On Mon, Aug 04 2025 at 13:34, Ryan Chen wrote:
> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)

Let it stick out, you have 100 characters

>  struct aspeed_scu_ic {
>  	unsigned long irq_enable;
>  	unsigned long irq_shift;
>  	unsigned int num_irqs;
>  	unsigned int reg;
> +	unsigned int en_reg;
> +	unsigned int sts_reg;
> +	bool split_ier_isr;

Please reformat this struct declaration according to:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

>  	struct regmap *scu;
>  	struct irq_domain *irq_domain;
>  };
> @@ -52,33 +83,51 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>  	unsigned long status;
>  	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
> +	unsigned int mask;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

>  	chained_irq_enter(chip, desc);
>  
> -	/*
> -	 * The SCU IC has just one register to control its operation and read
> -	 * status. The interrupt enable bits occupy the lower 16 bits of the
> -	 * register, while the interrupt status bits occupy the upper 16 bits.
> -	 * The status bit for a given interrupt is always 16 bits shifted from
> -	 * the enable bit for the same interrupt.
> -	 * Therefore, perform the IRQ operations in the enable bit space by
> -	 * shifting the status down to get the mapping and then back up to
> -	 * clear the bit.
> -	 */
> -	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> -	enabled = sts & scu_ic->irq_enable;
> -	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> -
> -	bit = scu_ic->irq_shift;
> -	max = scu_ic->num_irqs + bit;
> -
> -	for_each_set_bit_from(bit, &status, max) {
> -		generic_handle_domain_irq(scu_ic->irq_domain,
> -					  bit - scu_ic->irq_shift);
> -
> -		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> -				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +	if (scu_ic->split_ier_isr) {
> +		mask = scu_ic->irq_enable;
> +		regmap_read(scu_ic->scu, scu_ic->en_reg, &sts);
> +		enabled = sts & scu_ic->irq_enable;
> +		regmap_read(scu_ic->scu, scu_ic->sts_reg, &sts);
> +		status = sts & enabled;
> +
> +		bit = scu_ic->irq_shift;
> +		max = scu_ic->num_irqs + bit;
> +
> +		for_each_set_bit_from(bit, &status, max) {
> +			generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
> +
> +			regmap_write_bits(scu_ic->scu, scu_ic->sts_reg, mask, BIT(bit));
> +		}
> +	} else {
> +		mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
> +		/*
> +		 * The SCU IC has just one register to control its operation and read
> +		 * status. The interrupt enable bits occupy the lower 16 bits of the
> +		 * register, while the interrupt status bits occupy the upper 16 bits.
> +		 * The status bit for a given interrupt is always 16 bits shifted from
> +		 * the enable bit for the same interrupt.
> +		 * Therefore, perform the IRQ operations in the enable bit space by
> +		 * shifting the status down to get the mapping and then back up to
> +		 * clear the bit.
> +		 */
> +		regmap_read(scu_ic->scu, scu_ic->reg, &sts);
> +		enabled = sts & scu_ic->irq_enable;
> +		status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
> +
> +		bit = scu_ic->irq_shift;
> +		max = scu_ic->num_irqs + bit;
> +
> +		for_each_set_bit_from(bit, &status, max) {
> +			generic_handle_domain_irq(scu_ic->irq_domain,
> +						  bit - scu_ic->irq_shift);
> +
> +			regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
> +					  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
> +		}

This is horrible, really. Either rework the code so that both chips can
share it with minimal conditionals or provide seperate handlers. It's
not rocket science.
  
>  	chained_irq_exit(chip, desc);
> @@ -87,30 +136,42 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)

>  static void aspeed_scu_ic_irq_mask(struct irq_data *data)
>  static void aspeed_scu_ic_irq_unmask(struct irq_data *data)

>  {
>  	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
>  	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
> -	unsigned int mask = bit |
> -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> -
> -	/*
> -	 * Status bits are cleared by writing 1. In order to prevent the unmask
> -	 * operation from clearing the status bits, they should be under the
> -	 * mask and written with 0.
> -	 */
> -	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> +	unsigned int mask;
> +
> +	if (scu_ic->split_ier_isr) {
> +		mask = bit;
> +		regmap_update_bits(scu_ic->scu, scu_ic->en_reg, mask, bit);
> +	} else {
> +		mask = bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> +
> +		/*
> +		 * Status bits are cleared by writing 1. In order to prevent the unmask
> +		 * operation from clearing the status bits, they should be under the
> +		 * mask and written with 0.
> +		 */
> +		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
> +	}

This also wants to be consolidated or seperated.

>  }
>  
> +static int __init aspeed_ast2700_scu_ic0_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC0_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC0_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC0_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC0_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC0_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic1_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC1_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC1_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC1_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC1_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC1_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic2_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC2_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC2_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC2_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC2_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC2_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}
> +
> +static int __init aspeed_ast2700_scu_ic3_of_init(struct device_node *node,
> +						 struct device_node *parent)
> +{
> +	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> +
> +	if (!scu_ic)
> +		return -ENOMEM;
> +
> +	scu_ic->irq_enable = ASPEED_AST2700_SCU_IC3_ENABLE;
> +	scu_ic->irq_shift = ASPEED_AST2700_SCU_IC3_SHIFT;
> +	scu_ic->num_irqs = ASPEED_AST2700_SCU_IC3_NUM_IRQS;
> +	scu_ic->split_ier_isr = true;
> +	scu_ic->en_reg = ASPEED_AST2700_SCU_IC3_EN_REG;
> +	scu_ic->sts_reg = ASPEED_AST2700_SCU_IC3_STS_REG;
> +
> +	return aspeed_scu_ic_of_init_common(scu_ic, node);
> +}

You seriously have no better idea than this copy & pasta orgy?

static struct scu_variant variants = {
	SCU("aspeed,ast2400-scu-ic", ......, whatever...),
        ...
	SCU("aspeed,ast2700-scu-ic0", 0x1D0, 0x1D4, 0, GENMASK(3, 0),
            4, whatever...),
        ...
	SCU("aspeed,ast2700-scu-ic3", 0x10C, 0x108, 0, GENMASK(1, 0),
            2, ......),
} __initdata;

static struct scu_variant *find_variant(struct device_node *node)
{
        for (int i = 0; i < ARRAY_SIZE(variant); i++) {
        	if (!strcmp(variant[i].name, node->name))
                	return &variant[i];
	}                               
        return NULL;
}

static int __init ast_scu_of_init(struct device_node *node, struct device_node *parent)
{
        struct variant *v = find_variant(node);

        if (!v)
          	...

        scu_ic = kzalloc(...);
        *scu_ic = v->scu;
        ...

You get the idea.

This rework needs to come first and then you can add your new 2700 muck
on top.

Thanks,

        tglx

