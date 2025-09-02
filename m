Return-Path: <linux-aspeed+bounces-2114-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C881CA0FFE
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Sep 2025 13:07:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGQy96yqYz2yN1;
	Tue,  2 Sep 2025 23:07:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756818449;
	cv=none; b=UnE+nkjyARfq+bz3SVh9UjQsNyreHogOyjG8K1mfpT4rxEKTWkm+3zYq5116ojZ7dXU9Ib2diA5RnNAeZ9G0VPE5G2JckN0Bqw8QLWan64tk5cQDq3ZmV/D5l2CtnSqYh/eA61o7a8QXnHpd43eUx1S765O0H7rhx8Xza3mYm1gClYyITiYyXElJLDM/JHlmOibe4vSXvfAKsRov804ukhyaamhH90b/kmfTQqcCmVNjlB27IArhyjxRzzgv04bgyXLgfydXBOav6OAxTVPFn+A4ipaCUWildesDHracPwquC0zZDw5sKgJ8+bJXgCufb2h2OYAKXnL+1ZtC4BHrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756818449; c=relaxed/relaxed;
	bh=+IOP6KQgl7sg4RNv1HB15N9tnpQImYkfB9yocklRZDY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0j6p7sK+Ey5BtDcHwq9KtsohaUbJEngwHTZxHgfyQl2mjebKS+sNmVZ1u3g0YOz6HKbuDBZ8fsthR+678RZCfESJttw240SYnN77vZy6e/4P1FjSLlSViIbIEVNwaLZbr8dewB3Lesmt2Urd5w5h5jxBYN/+CxE7epLNYv82zovc53Ai9FzlVvDlBIh3rPgKpRVFG6JT446lU06wsJ18vJ9TWAzDpO22daCcGzALQoeXM8FhCd2aToqZx2HVgdvGcZSYWLWrfylEq1Jxcsn7i1NzcsscPLSwiVULkvhPuvhbyRmzBEo7TFkFL+0YaQeCDVGEgNbGDZEWg1LEcQHMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0MpqbOb0; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=AKhUPcae; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0MpqbOb0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=AKhUPcae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGQy90NT0z2xnq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  2 Sep 2025 23:07:28 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756818444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IOP6KQgl7sg4RNv1HB15N9tnpQImYkfB9yocklRZDY=;
	b=0MpqbOb0MmctHgGLQpEoK7RvCrWqhe11k7zTcy8rW2Qfo7mEGcPn5YRQkw8nA/4UE4khMk
	qVglqTWaaErQgvpR6lBTxWvoGi008hP0GLsPHU7H/pp+UX2aUaLx1+7feoS6miXFyPEg9Z
	iqBXxrZmrXN+K4gbv0NKs1+w3YlIfGOPH2Uk/IWlXPSXd83ArVwnQB3A+coNOQYY0xi91a
	EQqlpauvguqFqYMV0d3U09qWOkil3jRoUezBM+Ji7uhtq2xn8/ZdOw0STltaDV+3yXvIiL
	w+eONQLePF81UOj2KAyLncrk+TWHd7+J8U4A22FRez4iuwC+eMkgWjBEaJfnHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756818444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IOP6KQgl7sg4RNv1HB15N9tnpQImYkfB9yocklRZDY=;
	b=AKhUPcaeUUqBybjPoJeHUXRY72ygfIw8wlfOfdrh1iP5zgu2ytXtU3whmTaefPi79pOvkS
	oV/Hg036JfwXYfDg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
In-Reply-To: <20250831021438.976893-5-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com>
Date: Tue, 02 Sep 2025 15:07:21 +0200
Message-ID: <87y0qx0zqu.ffs@tglx>
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

On Sun, Aug 31 2025 at 10:14, Ryan Chen wrote:

> The AST2700 continues the multi-instance SCU interrupt controller model
> introduced in the AST2600, with four independent interrupt domains
> (scu-ic0 to 3).
>
> Unlike earlier generations that combine interrupt enable and status bits
> into a single register, the AST2700 separates these into distinct IER and
> ISR registers. Support for this layout is implemented by using register
> offsets and separate chained IRQ handlers.
>
> The variant table is extended to cover AST2700 IC instances, enabling
> shared initialization logic while preserving support for previous SoCs.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 123 +++++++++++++++++++++-------
>  1 file changed, 95 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index cbfc35919281..ffdd9b4e44c1 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -17,12 +17,16 @@
>  
>  #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
>  #define ASPEED_SCU_IC_STATUS_SHIFT	16
> +#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
>  
>  struct aspeed_scu_ic_variant {
>  	const char		*compatible;
>  	unsigned long	irq_enable;
>  	unsigned long	irq_shift;
>  	unsigned int	num_irqs;
> +	bool			split_ier_isr;

How does that end up aligned?

> +	unsigned long	ier;
> +	unsigned long	isr;
>  };
>  
>  #define SCU_VARIANT(_compat, _shift, _enable, _num) { \
> @@ -30,13 +34,20 @@ struct aspeed_scu_ic_variant {
>  	.irq_shift		=	_shift,		\
>  	.irq_enable		=	_enable,	\
>  	.num_irqs		=	_num,		\
> +	.split_ier_isr	=	_split,		\

Ditto.

> +	.ier			=	_ier,		\
> +	.isr			=	_isr,		\

But what's worse is that '_split, _ier and _isr' come out of thin air as
SCU_VARIANT does not have corresponding arguments. So how is that
supposed to work?

>  }
>  
>  struct aspeed_scu_ic {
> @@ -45,9 +56,12 @@ struct aspeed_scu_ic {
>  	unsigned int		num_irqs;
>  	void __iomem		*base;
>  	struct irq_domain	*irq_domain;
> +	bool				split_ier_isr;

Sigh...

> +	unsigned long		ier;
> +	unsigned long		isr;
>  };
>  
> -static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
> +static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
>  {
>  	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> @@ -84,33 +98,69 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
> +{

...

>  static void aspeed_scu_ic_irq_mask(struct irq_data *data)
>  {
>  	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
> -	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
> -		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
>  
> -	/*
> -	 * Status bits are cleared by writing 1. In order to prevent the mask
> -	 * operation from clearing the status bits, they should be under the
> -	 * mask and written with 0.
> -	 */
> -	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> +	if (scu_ic->split_ier_isr) {
> +		writel(readl(scu_ic->base) & ~BIT(data->hwirq + scu_ic->irq_shift),
> +		       scu_ic->base + scu_ic->ier);
> +	} else {
> +		unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
> +			(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
> +
> +		/*
> +		 * Status bits are cleared by writing 1. In order to prevent the mask
> +		 * operation from clearing the status bits, they should be under the
> +		 * mask and written with 0.
> +		 */
> +		writel(readl(scu_ic->base) & ~mask, scu_ic->base);
> +	}

So you have two different handlers. Why can't you provide two different
mask/unmask/ functions along with a seperate irq chip instead of
cluttering the code with conditionals. Thes two variants share no code
at all.

> -	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
> -					 scu_ic);
> +	if (scu_ic->split_ier_isr)
> +		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_split,
> +						 scu_ic);
> +	else
> +		irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler_combined,
> +						 scu_ic);
>

Please get rid of the line break. You have 100 characters....

Thanks,

        tglx

