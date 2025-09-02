Return-Path: <linux-aspeed+bounces-2113-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DD9CA1005
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Sep 2025 12:56:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGQjJ2rMNz2yN1;
	Tue,  2 Sep 2025 22:56:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756817780;
	cv=none; b=llBXzuwi2LpDQRatsEXgthH3WhZE17IY5GveARKM546Lo8rSk6kPMT/RS188XnUKF8p2d2k3RmIPi/JHaT5VrvtaG370EEc9hPDA5OlGONn3qiyag/QfVKe7EcsFAjurAFIi+9KmP7YCa3LT1irf7UYHVSShp5bkxUn2Z0c85I+Oxbh1J5zvkx4nnDhfFmkON+TVTANPVGn7BHY2uO/LmzfidkcPDE5R9XVt81+SGkjpu0DWMyzPC9rc91mZKTdzkG+C7Yr+mZ/5SFiFcxvkXIa0bd/6cGytlE3lqSgAmwIH8opIOGqSJyMHlyqKI7pnaQ55fGl6M+P1sjuhCj3iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756817780; c=relaxed/relaxed;
	bh=fqaO+SeV+juuMOmuDP+CCM9/ezm8a+cuzkEOZBsIzaY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/x6RtmKbp1q3s8MyR2UzUZ65Dnv7QENvrx28p0QsLCBxJ01xVMZRW7YKOKI6+k9ZQDoLWJU6MNSQA57dHXGRrZnadVGmy2NjWhrofRV68HZQaGdUykjzuYiF5HccDgr6sVniZ08/c6Wb5w2O5/1ngiaqZVum24Svpj3YPxasndtfhlXy2TmzvMBpdqLnXok85e270X8FdQfiXYbt5478Fd//CDwAmAEv/mKhBij84egG2hf3r3TGeut9eFvE+sSkYjttFyKE6qO7S+9eXTXvOekC9ld9nBMWoff9vNWbcG/k1DEofWMKjFxVNVseUYgtCtFzQuq6UuL1qxDpibNrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Jl3Ir6pn; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cSY2/Zxw; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Jl3Ir6pn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cSY2/Zxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGQjH2cMtz2y06
	for <linux-aspeed@lists.ozlabs.org>; Tue,  2 Sep 2025 22:56:19 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756817773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqaO+SeV+juuMOmuDP+CCM9/ezm8a+cuzkEOZBsIzaY=;
	b=Jl3Ir6pnSxJZNrlzEafpDbybEzAsScYMj2qFx4iAZKmr8ZcHniinwHLqQDkswxZdZVwrkH
	5TJRXTmcz57EvPHj07PBTrvCJaCEGuftAp+3rgQ14QaoTSXSxu2pyf09OnP9PC7+LX4MbZ
	pQwN9gposebgqqLa4aLFRNqXgYFOdRtp+CKIn30FTYyvvsgQq6NUwVdqkgqYE+m4/8Rmu1
	iihZDcz5qzDmpdQgKJMCMh9pVlcg9XvBKwujlRU3ep7YCsASiKAChlRfP3sWpCnFoGkof0
	ZtDCtMl5DH4mL9cvIsD3CD7GndYOqN9OBv0vEvmDqSizBOTr4ViVXZ3rzoqu4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756817773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqaO+SeV+juuMOmuDP+CCM9/ezm8a+cuzkEOZBsIzaY=;
	b=cSY2/ZxwSkTcM3n6h5dg0DWREVEm4aceh5FyNagu4bT+lojglO0U9ENF3AeFej8rv30yCv
	HhNHiyDBYRxVUcBg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] irqchip/aspeed-scu-ic: Refactor driver to
 support variant-based initialization
In-Reply-To: <20250831021438.976893-2-ryan_chen@aspeedtech.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-2-ryan_chen@aspeedtech.com>
Date: Tue, 02 Sep 2025 14:56:12 +0200
Message-ID: <871pop2etv.ffs@tglx>
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
>  	scu_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), scu_ic->num_irqs,
> -						   &aspeed_scu_ic_domain_ops,
> -						   scu_ic);
> +						      &aspeed_scu_ic_domain_ops,
> +						      scu_ic);

Please move scu_ic to the previous line.

> +aspeed_scu_ic_find_variant(struct device_node *np)
>  {
> -	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
> -
> -	if (!scu_ic)
> -		return -ENOMEM;
> +	for (int i = 0; i < ARRAY_SIZE(scu_ic_variants); i++)
> +		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
> +			return &scu_ic_variants[i];

the for loop wants curly brackets.

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

> +	scu_ic->irq_enable    = variant->irq_enable;
> +	scu_ic->irq_shift     = variant->irq_shift;
> +	scu_ic->num_irqs      = variant->num_irqs;

Please use a TAB not spaces when you want to align things.

> +IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_init);
> +IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",     aspeed_scu_ic_of_init);

Stray TAB in the last line.

Thanks,

        tglx

