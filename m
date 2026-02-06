Return-Path: <linux-aspeed+bounces-3492-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0434EE2092
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Feb 2026 11:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6sSW5JFMz2xqk;
	Fri, 06 Feb 2026 22:34:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770377675;
	cv=none; b=jC/Q+P8egJSFi90weVa84wskzJlLOSflgWQYQNZFOq0EDodFk5CEo4Wm3VEwhFlc1Es3ec51pbScgy+7ptd8vfC5mD5AA44itTdMRWU7we3z/tmqXaZXlkfdbiIAv4j9OZ5nCjrrh1KBRG6AGDyiSYfPCno9TE2RbqP3w5a04RZoX5xxb+eT6dJFORnVWa9zMUeymgwDbGo95u+fn6xQflsTxmOPXJISUvYV8mGbAzdYot6Dez8FewWN4SkA1kHOWO20r2tHSfq8YC/R0x+bDfWAZQEToqvGKpouTgYzZyoFR0LWBM+vHFT9xq9CX1IXWSCRPGQvxv2gxYcHXHm5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770377675; c=relaxed/relaxed;
	bh=e88o2vkHKEQ7ct2edtyijEFQqfue9/krGUvH82zBYvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3vePrfX0VZHXlHIIzQzZ0nCkTwU6tyoUxlwmRhje18QqNVnFpek69J7yhm946pNYXnhtPDCg3q57rrno0fzJrK4sYaHZcknOTwP2sDG7OlFz+2IiJ4hPYMBCBtt8gnqMEoD8Zlp3d8ZvBiXLD6azFtwIZrhK7mrqriMSlvBH9DBUZMjzYf6cL/kYg6TNgPi6zkpZdp4kqpweCr1o7UwpPhFfHfH7uUqcHybwOd+0bXPpG+jEqsYiXaQy6vcp01I7XjSYVObUif5FYeG5NjySHvewBQjKhmTCWnV4EI2blSYhKszt4laPgBdhYN0kgp7eAYUvkRCvpN3CYiUMGyKiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GCxv/oCF; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RpSn/lhU; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GCxv/oCF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RpSn/lhU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4f6sSV2kjFz2xRv
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Feb 2026 22:34:34 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770377659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e88o2vkHKEQ7ct2edtyijEFQqfue9/krGUvH82zBYvA=;
	b=GCxv/oCFt+944O66V6ahoJel5fXljNGqn5VedO4GLzHrg3pYabGiunu+7F059Wu3I5SXwV
	zEdVj4FV0I5R0KYa1bRske29/qNpvMhozPQc3z73ZEUJw5IyMdiI2P0zKyB2lYg5rIzmuR
	u8CgDNwl4dsgEYfdfVBazzi6sw2VlMGLlLu3LzFOHvz7dpKLomJGI8c4pKpllqSHf/C/qM
	tSYGhSD2Gq6UnqyXjhnWm/gFgrss6z8pCN6xvZQP6Ev2Vj8VvpW7hqaZ1tOKE7p7lvBPIP
	IKH5Sdvy4coKo6MjJqujjtaJq6gVjhhcN8A89IuKM0eRtvca8Z+sk4L5Yquaxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770377659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e88o2vkHKEQ7ct2edtyijEFQqfue9/krGUvH82zBYvA=;
	b=RpSn/lhUuWmAbV1MUQJX3yCHQha5g4vDOU9oVTffdM/R68le4+t6oUetF554mlcFFGz50H
	d7GDic+AypymrhDw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1 support
In-Reply-To: <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com>
Date: Fri, 06 Feb 2026 12:34:18 +0100
Message-ID: <87h5ru14xx.ffs@tglx>
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

On Thu, Feb 05 2026 at 14:07, Ryan Chen wrote:
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
>  obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
> +obj-$(CONFIG_ASPEED_AST2700_INTC)	+= irq-ast2700.o irq-ast2700-intc0.o irq-ast2700-intc1.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
>  obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
> diff --git a/drivers/irqchip/irq-ast2700-intc0-test.c b/drivers/irqchip/irq-ast2700-intc0-test.c

How is this kunit test supposed to be built?

Also split this kunit thing out into a separate patch. It is not
relevant for the functional part.

> new file mode 100644
> index 000000000000..d6bc19676b2e
> --- /dev/null
> +++ b/drivers/irqchip/irq-ast2700-intc0-test.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Copyright (C) 2026 Code Construct
> + */
> +#include <kunit/test.h>
> +#include "irq-ast2700.h"
> +
> +static void aspeed_intc0_resolve_route_bad_args(struct kunit *test)
> +{
> +	static const struct aspeed_intc_interrupt_range c1ranges[] = { 0 };
> +	static const aspeed_intc_output_t c1outs[] = { 0 };
> +	struct aspeed_intc_interrupt_range resolved;
> +	const struct irq_domain c0domain = { 0 };
> +

Pointless newline

> +	int rc;
> +
> +	rc = aspeed_intc0_resolve_route(NULL, 0, c1outs, 0, c1ranges, NULL);
> +	KUNIT_EXPECT_EQ(test, rc, -EINVAL);
> +
> +	rc = aspeed_intc0_resolve_route(&c0domain, 0, c1outs,
> +					ARRAY_SIZE(c1ranges), c1ranges,
> +					&resolved);
> +	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
> +
> +	rc = aspeed_intc0_resolve_route(&c0domain, ARRAY_SIZE(c1outs), c1outs,
> +					0, c1ranges, &resolved);
> +	KUNIT_EXPECT_EQ(test, rc, -ENODEV);
> +}
> +
> +static int
> +arm_gicv3_fwnode_read_string_array(const struct fwnode_handle *fwnode_handle,
> +				   const char *propname, const char **val,
> +				   size_t nval)

Please use the full 100 character you have available and avoid extra
line breaks. It fits nicely into two lines:

static int arm_gicv3_fwnode_read_string_array(const struct fwnode_handle *fwnode_handle, 
			                      const char *propname, const char **val, size_t nval)

There is also no real point to have these overly long function and
argument names.

> +#include <asm-generic/errno.h>

That's wrong. Include <linux/errno.h>

> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "irq-ast2700.h"

Missing newline

> +#define INT_NUM 480
> +#define INTM_NUM 50
> +#define SWINT_NUM 16
> +
> +#define INTM_BASE (INT_NUM)
> +#define SWINT_BASE (INT_NUM + INTM_NUM)
> +#define INT0_NUM (INT_NUM + INTM_NUM + SWINT_NUM)
> +
> +#define GIC_P2P_SPI_END 128
> +
> +#define INTC0_SWINT_IER 0x10
> +#define INTC0_SWINT_ISR 0x14
> +#define INTC0_INTBANKX_IER 0x1000
> +#define INTC0_INTBANK_GROUPS 11
> +#define INTC0_INTBANKS_PER_GRP 3
> +#define INTC0_INTMX_IER 0x1b00
> +#define INTC0_INTMX_ISR 0x1b04
> +#define INTC0_INTM_BANK_NUM 3
> +#define INTM_IRQS_PER_BANK 10

If you make these defines tabular and they become readable:

#define INT_NUM			480
#define INTM_NUM		50
...
#define INTM_BASE 		(INT_NUM)
...
#define GIC_P2P_SPI_END		128
...
#define INTC0_SWINT_IER		0x10

See?

> +struct aspeed_intc0 {
> +	struct device *dev;
> +	void __iomem *base;
> +	raw_spinlock_t intc_lock;
> +	struct irq_domain *local;
> +	struct device_node *parent;
> +	struct aspeed_intc_interrupt_ranges ranges;
> +};

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

I pointed you to that documentation before. Do I really have to remind
you every couple of week?

> +
> +static void aspeed_swint_irq_mask(struct irq_data *data)
> +{
> +	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
> +	int bit = data->hwirq - SWINT_BASE;
> +	unsigned int mask;
> +
> +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);

s/_irqsave// Interrupts are disabled when this is invoked.

> +	mask = readl(intc0->base + INTC0_SWINT_IER) & ~BIT(bit);
> +	writel(mask, intc0->base + INTC0_SWINT_IER);
> +	irq_chip_mask_parent(data);
> +}
> +
> +static void aspeed_swint_irq_unmask(struct irq_data *data)
> +{
> +	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
> +	int bit = data->hwirq - SWINT_BASE;
> +	unsigned int unmask;
> +
> +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
> +	unmask = readl(intc0->base + INTC0_SWINT_IER) | BIT(bit);

These unmask/mask variable are simply not helpful. What's wrong with
naming them 'ier' because that's what this is about. And while at it the
data type for hardware related variables is u32 not unsigned int to make
it clear.

> +static struct irq_chip aspeed_swint_chip = {
> +	.name = "ast2700-swint",
> +	.irq_eoi = aspeed_swint_irq_eoi,
> +	.irq_mask = aspeed_swint_irq_mask,
> +	.irq_unmask = aspeed_swint_irq_unmask,
> +	.irq_set_affinity = irq_chip_set_affinity_parent,
> +	.flags = IRQCHIP_SET_TYPE_MASKED,

See above

> +
> +#define INTC0_IN_NUM 480
> +#define INTC0_ROUTE_NUM 5

Those should be at the top of the file next to the other constants.

> +static const aspeed_intc_output_t aspeed_intc0_routes[INTC0_IN_NUM / 32][INTC0_ROUTE_NUM] = {
> +	[0] = {
> +		[0b000] = 0,
> +		[0b001] = 256,
> +		[0b010] = 426,
> +		[0b011] = AST2700_INTC_INVALID_ROUTE,
> +		[0b100] = AST2700_INTC_INVALID_ROUTE,

Seriously? What's the point of this binary notation and the insane
amount of space this table occupies?

	[0] = {   0, 256, 426, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
	[1] = {  32, 288, 458, AST2700_INTC_INVALID_ROUTE, AST2700_INTC_INVALID_ROUTE },
	[4] = { 128, 384, 554, 160, 176 },
        ...


> +
> +#define INTC0_INTM_NUM 50
> +
> +static const aspeed_intc_output_t
> +	aspeed_intc0_intm_routes[INTC0_INTM_NUM / 10] = {

pointless line break

> +		[0] = 192, /* INTM00 ~ INTM09 */
> +		[1] = 416, /* INTM10 ~ INTM19 */
> +		[2] = 586, /* INTM20 ~ INTM29 */
> +		[3] = 208, /* INTM30 ~ INTM39 */
> +		[4] = 224, /* INTM40 ~ INTM49 */
> +	};
> +
> +static bool range_contains_element(u32 start, u32 count, u32 value)

in_range32() provides that already

> +{
> +	if (WARN_ON_ONCE((U32_MAX - count) < start))
> +		return false;
> +
> +	return value >= start && value < start + count;
> +}
> +
> +static int
> +resolve_input_from_child_ranges(const struct aspeed_intc0 *intc0,
> +				const struct aspeed_intc_interrupt_range *range,
> +				u32 outpin, u32 *input)
> +{
> +	u32 offset;
> +	u32 base;

One line

> +
> +	if (!range_contains_element(range->start, range->count, outpin))
> +		return -ENOENT;
> +
> +	if (range->upstream.param_count == 0)
> +		return -EINVAL;
> +
> +	base = range->upstream.param[0];
> +	offset = outpin - range->start;
> +	if ((U32_MAX - offset) < base) {

        if (!in_range32(...)


> +		dev_warn(intc0->dev,
> +			 "%s: Arithmetic overflow for input derivation: %u + %u\n",

Pointless line break. Please fix them all over the place.

> +			 __func__, base, offset);
> +		return -EINVAL;
> +	}
> +
> +	*input = base + offset;
> +	return 0;
> +static int resolve_parent_route_for_input(const struct aspeed_intc0 *intc0,
> +					  const struct fwnode_handle *parent, u32 input,
> +					  struct aspeed_intc_interrupt_range *resolved)
> +{
> +	aspeed_intc_output_t c0o;
> +	int rc = -ENOENT;
> +
> +	if (input < INT_NUM) {
> +		bool found;
> +
> +		dev_dbg(intc0->dev, "%s: Resolving parent route for linear input %u\n",
> +			__func__, input);

Do you really still need all those debug prints or are you trusting your
code by now?

If they still are considered valuable then shorten them in a sensible
way so they nicely hide in the code instead of cluttering it to the
point of making it unreadable.

> +{
> +	struct aspeed_intc0 *intc0;
> +	struct fwnode_handle *parent_fwnode;
> +	int ret;

See Documentation about variable declarations...

> +	for (size_t i = 0; i < nc1outs; i++) {
> +		aspeed_intc_output_t c1o = c1outs[i];
> +
> +		if (c1o == AST2700_INTC_INVALID_ROUTE) {
> +			dev_dbg(intc0->dev, "%s: Invalid output at route index %zu\n",
> +				__func__, i);
> +			continue;
> +		}
> +
> +		dev_dbg(intc0->dev, "%s: Have output %u for route index %zu\n",
> +			__func__, c1o, i);
> +
> +		for (size_t j = 0; j < nc1ranges; j++) {
> +			struct aspeed_intc_interrupt_range c1r = c1ranges[j];
> +			u32 input;
> +
> +			dev_dbg(intc0->dev,
> +				"%s: Inspecting candidate range %zu starting at %u for %u\n",
> +				__func__, j, c1r.start, c1r.count);
> +
> +			/*
> +			 * Range match for intc1 output pin
> +			 *
> +			 * Assume a failed match is still a match for the purpose of testing,
> +			 * saves a bunch of mess in the test fixtures
> +			 */
> +			if (!(c0domain == irq_find_matching_fwspec(&c1r.upstream,
> +								   c0domain->bus_token) ||
> +			      IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST))) {
> +				dev_dbg(intc0->dev, "%s: Parent mismatch for candidate range %zu\n",
> +					__func__, j);
> +				continue;
> +			}
> +
> +			ret = resolve_input_from_child_ranges(intc0, &c1r, c1o, &input);
> +			if (ret) {
> +				if (ret == -ENOENT)
> +					dev_dbg(intc0->dev,
> +						"%s: Output %u not in candidate range %zu starting at %u for %u\n",
> +						__func__, c1o, j, c1r.start, c1r.count);
> +				continue;

All of this is unreadable and I told you about the bracket rules before, no?

> +			}
> +			dev_dbg(intc0->dev,
> +				"%s: Resolved INTC0 input to %u using candidate range %zu: [%u, %u)\n",
> +				__func__, input, j, c1r.start, c1r.start + c1r.count);
> +
> +			/*
> +			 * INTC1 should never request routes for peripheral interrupt sources
> +			 * directly attached to INTC0.
> +			 */
> +			if (input < GIC_P2P_SPI_END) {
> +				dev_dbg(intc0->dev,
> +					"%s: Invalid range specification at index %zu routed INTC1 output to unreachable INTC0 input\n",
> +					__func__, j);
> +				continue;
> +			}
> +
> +			ret = resolve_parent_route_for_input(intc0, parent_fwnode, input, NULL);
> +			if (ret < 0)
> +				continue;
> +
> +			/* Route resolution succeeded */
> +			resolved->start = c1o;
> +			resolved->count = 1;
> +			resolved->upstream = c1r.upstream;
> +			resolved->upstream.param[0] = input;
> +			dev_dbg(intc0->dev,
> +				"%s: Route resolution selected INTC1 output %u via index %zu\n",
> +				__func__, c1o, i);
> +			/* Cast protected by prior test against nc1outs */
> +			return (int)i;
> +		}
> +	}
> +
> +	ret = -EHOSTUNREACH;
> +	return ret;

Impressive.

> +}
> +EXPORT_SYMBOL_GPL(aspeed_intc0_resolve_route);

What is this export for? All usage sites are built in, no?

> +static int aspeed_intc0_irq_domain_map(struct irq_domain *domain,
> +				       unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	if (hwirq < GIC_P2P_SPI_END)
> +		irq_set_chip_and_handler(irq, &linear_intr_irq_chip,
> +					 handle_level_irq);

Make this one line. Otherwise you need brackets.

> +	else if (hwirq < INTM_BASE)
> +		return -EINVAL;
> +	else if (hwirq < SWINT_BASE)
> +		irq_set_chip_and_handler(irq, &aspeed_intm_chip,
> +					 handle_level_irq);
> +	else if (hwirq < INT0_NUM)
> +		irq_set_chip_and_handler(irq, &aspeed_swint_chip,
> +					 handle_level_irq);
> +	else
> +		return -EINVAL;
> +
> +	irq_set_chip_data(irq, domain->host_data);
> +	return 0;
> +}

> +static int aspeed_intc0_irq_domain_activate(struct irq_domain *domain,
> +					    struct irq_data *data, bool reserve)
> +{
> +	struct aspeed_intc0 *intc0 = irq_data_get_irq_chip_data(data);
> +
> +	if (data->hwirq < INT_NUM) {
> +		int bank = data->hwirq / 32;
> +		int bit = data->hwirq % 32;
> +		u32 mask = BIT(bit);
> +		int route;
> +
> +		route = resolve_parent_route_for_input(intc0,
> +						       intc0->local->parent->fwnode,
> +						       data->hwirq, NULL);
> +		if (route < 0)
> +			return route;
> +
> +		guard(raw_spinlock_irqsave)(&intc0->intc_lock);
> +		for (int i = 0; i < 3; i++) {
> +			void __iomem *sel = intc0->base + 0x200 + bank * 4 + 0x100 * i;

Magic constants 0x200 4 and 0x100. Use proper defines and a macro/inline
to calculate the register address and not this incomprehensible garbage.

> +			u32 reg = readl(sel);
> +
> +			if (route & BIT(i))
> +				reg |= mask;
> +			else
> +				reg &= ~mask;
> +
> +			writel(reg, sel);
> +			if (readl(sel) != reg)
> +				return -EACCES;
> +		}
> +	} else if (data->hwirq < INT0_NUM) {
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}

If you rearrange those conditions you can avoid the indentation all
together

        if (in_range32(data->hwirq, INTM_BASE, INTM_NUM + SWINT_NUM))
        	return 0;
        if (data->hwirq >= INT_NUM)
        	return -EINVAL;

No?

> +
> +	return 0;
> +}
> +
> +static void aspeed_intc0_disable_intbank(struct aspeed_intc0 *intc0)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < INTC0_INTBANK_GROUPS; i++) {
> +		for (j = 0; j < INTC0_INTBANKS_PER_GRP; j++) {

Both i and j should be declared in the for () statement. Your coding
style is so inconsistent it's not even funny anymore. 

> +			u32 base = INTC0_INTBANKX_IER + (0x100 * i) + (0x10 * j);
> +
> +			writel(0, intc0->base + base);
> +		}
> +	}
> +}
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(ast2700_intc0)
> +IRQCHIP_MATCH("aspeed,ast2700-intc0-ic", aspeed_intc0_ic_probe)
> +IRQCHIP_PLATFORM_DRIVER_END(ast2700_intc0)
> +
> +#ifdef CONFIG_ASPEED_AST2700_INTC_TEST
> +#include "irq-ast2700-intc0-test.c"
> +#endif

Yikes. What's wrong with Makefile?

> diff --git a/drivers/irqchip/irq-ast2700-intc1.c b/drivers/irqchip/irq-ast2700-intc1.c
> +static void aspeed_intc1_ic_irq_handler(struct irq_desc *desc)
> +{
> +	struct aspeed_intc1 *intc1 = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long bit, status;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	for (int bank = 0; bank < INTC1_BANK_NUM; bank++) {
> +		status = readl(intc1->base + INTC1_ISR + (0x10 * bank));
> +		if (!status)
> +			continue;
> +
> +		for_each_set_bit(bit, &status, INTC1_IRQS_PER_BANK) {
> +			generic_handle_domain_irq(intc1->local,
> +						  (bank * INTC1_IRQS_PER_BANK) +
> +							  bit);
> +			writel(BIT(bit),
> +			       intc1->base + INTC1_ISR + (0x10 * bank));

My eyes bleed by now.

Thanks,

        tglx

