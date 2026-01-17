Return-Path: <linux-aspeed+bounces-3372-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190C6C98327
	for <linux-aspeed@archiver.kernel.org>; Sat, 17 Jan 2026 15:47:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dth1135yZz2xqG;
	Sun, 18 Jan 2026 02:47:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768664821;
	cv=none; b=hnG69vJAjQfh+RHajTdr6OUKpOA4oMRg9T/AAAURtSMZ7V65ki9iZ8bDeL8MvtsXuMu2FjG/v18HxPnwwfBVaicAVPF7HM9iSghGz6Ifmgi9vRCXQbu2Lr2Jiyqrr3njDDJ4QFfUXijq5LkNplRDDxtSkFsMZvaF4iwKDx9dbUHc2QRNfaXnNTcZfhAsmSab15LtCij/ipf9QbTJmlRO3uc4fzX0s2454WG58qGRd7LQZTfcBjxqm7AkjYHk+POxZwaczalsJERnsHvVmtZMLX30mknuo0WGhm6eXwhcGTUv083vQYMAOXy1yYuCum1WD8k/Xhrj2H/0PUSwgPfF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768664821; c=relaxed/relaxed;
	bh=gF8+Zq1qK4nUISuq8ZYKam6dKSKTtWo9A81RsKUSatk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPmavUdWY6O0R2jmNjxGzkpWoiTDI/+g0fnXTn/5OAnPJI9VF9UWCR/8q/fUjYTT4/KPVO6ktL/GzI9K9HDIKlcpGbo4y/Ev7OYk5TIIQ9Ag+aINmg+gH7gdobo6DGJ4LHOBLcuzpCQEaHCEbhYYkko6zCOEy9nOD9JDQ64zXP4O0JayR/NE5/Rwd/sx5TcjORwaWiS6f1U89A055rA8cI3/Bdlk5U7tyPC3YEJIiJvBH4lZr6Xt1dmBpnAFbhNswuLWw/qAT0E6e0P9LC3r1Tb1TbNF3O0osXJ3WpVF8GBOUlEbkJsQtrQYXT+43XjIupa+165LeJZjB5nPOiXoxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fFxoiG5o; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fFxoiG5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dth0y5PdCz2xQC
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 02:46:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gF8+Zq1qK4nUISuq8ZYKam6dKSKTtWo9A81RsKUSatk=; b=fFxoiG5ouamEjvJWtIjJJqiZmZ
	ETa+cz75RUWA6SQbZuAAIwaD6U7YvThjuoYnJld2ETo7MDh6SNe9ENtr/+MUgD8W/Uslb4wpbD/cS
	W2Lsc2ZEzRzEUtD2Uv1FZ22e+IlEGXE28W+koektM/uK/4g4nlGqQni5usy4HXoir3zA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vh8VU-003DhI-R8; Sat, 17 Jan 2026 16:46:32 +0100
Date: Sat, 17 Jan 2026 16:46:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org, bmc-sw@aspeedtech.com
Subject: Re: [PATCH 3/5] gpio: aspeed-sgpio: Create llops to handle hardware
 access
Message-ID: <55fbb766-12b5-441a-b06c-d807097e5476@lunn.ch>
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
 <20260117-upstream_sgpio-v1-3-850ef3ffb680@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117-upstream_sgpio-v1-3-850ef3ffb680@aspeedtech.com>

On Sat, Jan 17, 2026 at 07:17:10PM +0800, Billy Tsai wrote:
> Add low-level operations (llops) to abstract the register access for SGPIO
> registers. With this abstraction layer, the driver can separate the
> hardware and software logic, making it easier to extend the driver to
> support different hardware register layouts.

With a quick look at the code, it appears the register numbers stay
the same? Is that true?

I think you have reinvented regmap.

> @@ -318,30 +278,25 @@ static int aspeed_sgpio_set_type(struct irq_data *d, unsigned int type)
>  	u32 type0 = 0;
>  	u32 type1 = 0;
>  	u32 type2 = 0;
> -	u32 bit, reg;
> -	const struct aspeed_sgpio_bank *bank;
>  	irq_flow_handler_t handler;
> -	struct aspeed_sgpio *gpio;
> -	void __iomem *addr;
> -	int offset;
> -
> -	irqd_to_aspeed_sgpio_data(d, &gpio, &bank, &bit, &offset);
> +	struct aspeed_sgpio *gpio = irq_data_get_irq_chip_data(d);
> +	int offset = irqd_to_hwirq(d);
>  
>  	switch (type & IRQ_TYPE_SENSE_MASK) {
>  	case IRQ_TYPE_EDGE_BOTH:
> -		type2 |= bit;
> +		type2 = 1;
>  		fallthrough;
>  	case IRQ_TYPE_EDGE_RISING:
> -		type0 |= bit;
> +		type0 = 1;
>  		fallthrough;
>  	case IRQ_TYPE_EDGE_FALLING:
>  		handler = handle_edge_irq;
>  		break;
>  	case IRQ_TYPE_LEVEL_HIGH:
> -		type0 |= bit;
> +		type0 = 1;
>  		fallthrough;
>  	case IRQ_TYPE_LEVEL_LOW:
> -		type1 |= bit;
> +		type1 = 1;
>  		handler = handle_level_irq;
>  		break;

This change is not obviously correct to me. It is not about
abstracting register accesses, what you actually write to the
registers appears to of changed. Maybe you could add a refactoring
patch first which does this change, with a commit message explaining
it, and then insert the register abstraction?


> @@ -374,16 +318,14 @@ static void aspeed_sgpio_irq_handler(struct irq_desc *desc)
>  {
>  	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
>  	struct irq_chip *ic = irq_desc_get_chip(desc);
> -	struct aspeed_sgpio *data = gpiochip_get_data(gc);
> +	struct aspeed_sgpio *gpio = gpiochip_get_data(gc);

This rename does not belong in this patch. You want lots of small
patches, each doing one logical thing, with a good commit message, and
obviously correct. Changes like this make it a lot less obviously
correct.

>  	/* Disable IRQ and clear Interrupt status registers for all SGPIO Pins. */
> -	for (i = 0; i < ARRAY_SIZE(aspeed_sgpio_banks); i++) {
> -		bank =  &aspeed_sgpio_banks[i];
> +	for (i = 0; i < gpio->chip.ngpio; i += 2) {

Why are ARRAY_SIZE() gone? There probably is a good reason, so doing
this in a patch of its own, with a commit message explaining "Why?"
would make this easier to review.

      Andrew

