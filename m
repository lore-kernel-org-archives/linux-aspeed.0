Return-Path: <linux-aspeed+bounces-3823-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9152810F9308
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:21:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flkdw4L1Mz2yYY;
	Wed, 01 Apr 2026 10:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774973416;
	cv=none; b=HrUwRxZlUiauDHI0/w0CMT7qqyMDM5HhvlW5G5iXeJpg5lVQz/A3W1yC7O15uVpDNuaH9RklyLFlKk+Dqp4SoCNEvfhUyQYjzdlhEbGzjq5jSI7k0AkuhvHehGA6m0ste3H2OiRig9+l6GE8s3Kuebe8V0UgorcUhtC6fHGdQJEaPG+P54qrFkg3RmgFq95wpksdXK9P0U3JORhyrmY3PrBcqLks8qSz6RU0ZQLqA1Rjjz8/2WG/kiMKh1CxmWhD2rylMbH6QPy5Y7FI2YGjPEQMVnFxEllJ51SPG7Opr2URCf+Ou0SDwZS1icb6KgW4mL2CVu/bXOuQaP+aATIIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774973416; c=relaxed/relaxed;
	bh=lDMDu+KQNPl9LVsfF1SGzQusDF9mr9eDLdnCQE4KcXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m+ERBfszulOQ54b9WwQ+pF4SqdOUZsPI2wtFLPEigHLMapx6zcpFT9W5CBsalzN2qdOXdJztrLLOsw2dLJSZSJpd74360cZjYa4Vz/8PmmA7+zue2DDyYWgz5ECuEq7WUtlAIBI+b0tVOpUUgDmm8ZrXsdsaH7uBU3SIK6LFYx4IMrymLA6Cj6zUdClGapG0VHBmjeD9P7N4QszFOYp66P7Aw1GcxXWbQo1Tp1+MDKqsb2bsak7cOBnMMbM77KG7zYO/zdtIUesRzlbDonHUI69SpWNLzJeD/tkJkElZEBoM8TMiaDgCuCIdJ9AC2j2K436G2J0sAFqDZZpFNGGV/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rQI73jqX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rQI73jqX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flY47277kz2ygf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Apr 2026 03:10:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03EA1417F5;
	Tue, 31 Mar 2026 16:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336A5C19423;
	Tue, 31 Mar 2026 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774973412;
	bh=ijpDo/7JDayOQ1D9eDJjCZ11/E2WfbQpZeWsZEqb6ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rQI73jqXU6YI2gkO3mK+iz8h5EIxdGh44HXO3c1FtbeD3FDDwWl7IWu8703NDHEob
	 LhJNtt5HQRbebcFdvfX7gid3ym3Lf6UOsPdBPBVRpAucPdSpc69l/qDMWpKsyM9mlS
	 xIiF+1IR3jKxi+b81z9psAZGWpPT6XRQXSP5B1hp3/naLfjosz/ze3RkgiK9Nieqo6
	 fK0LLxoihbzuVGdXoZKVMzuHLXfaJWHjMi+RHa2dELqC1QNjZlahKUDiOkTLoyFo6W
	 BA7vhj+kPd7x1OWadIzRBTH3YyxIXIMcNu2LcDwA0r5V3p9SlxKB12q28gL8bgqjx9
	 CKBur4Mj/yn5w==
From: Thomas Gleixner <tglx@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v4 2/4] irqchip/ast2700-intc: Add AST2700-A2 support
In-Reply-To: <20260330-irqchip-v4-2-3c0f1620cc06@aspeedtech.com>
References: <20260330-irqchip-v4-0-3c0f1620cc06@aspeedtech.com>
 <20260330-irqchip-v4-2-3c0f1620cc06@aspeedtech.com>
Date: Tue, 31 Mar 2026 18:10:08 +0200
Message-ID: <87tstw7zfj.ffs@tglx>
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

On Mon, Mar 30 2026 at 14:32, Ryan Chen wrote:
> +static int resolve_parent_range_for_output(const struct aspeed_intc0 *intc0,
> +					   const struct fwnode_handle *parent,
> +					   u32 output,
> +					   struct aspeed_intc_interrupt_range *resolved)

Please reduce the number of line breaks. You still have 100 characters.

> +{
> +	for (size_t i = 0; i < intc0->ranges.nranges; i++) {
> +		struct aspeed_intc_interrupt_range range =
> +			intc0->ranges.ranges[i];

No line break required.

> +static int aspeed_intc1_irq_domain_activate(struct irq_domain *domain,
> +					    struct irq_data *data, bool reserve)
> +{
> +	struct aspeed_intc1 *intc1 = irq_data_get_irq_chip_data(data);
> +	struct aspeed_intc_interrupt_range resolved;
> +	int rc, bank, bit;
> +	u32 mask;
> +
> +	if (WARN_ON_ONCE((data->hwirq >> INTC1_ROUTE_SHIFT) >= ARRAY_SIZE(aspeed_intc1_routes)))
> +		return -EINVAL;
> +
> +	/*
> +	 * outpin may be an error if the upstream is the BootMCU APLIC node, or
> +	 * anything except a valid intc0 driver instance
> +	 */
> +	rc = aspeed_intc0_resolve_route(intc1->upstream, INTC1_ROUTE_NUM,
> +					aspeed_intc1_routes[data->hwirq >> INTC1_ROUTE_SHIFT],
> +					intc1->ranges.nranges,
> +					intc1->ranges.ranges, &resolved);

Please test your code with CONFIG_PROVE_LOCKING=y, which is mandatory
for submission according to documentation.

This is invoked with the interrupt descriptor lock held and interrupts
disabled.

       aspeed_intc0_resolve_route()
                ....
                irq_find_matching_fwspec()
                	mutex_lock(&irq_domain_mutex); <---- FAIL

Thanks,

        tglx

        

