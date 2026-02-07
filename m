Return-Path: <linux-aspeed+bounces-3494-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE1BEE0AE4
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Feb 2026 12:40:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f7VtW1TXXz2xm3;
	Sat, 07 Feb 2026 23:40:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770468051;
	cv=none; b=VliGOJG8vUFRb/drhRQ7wLjyejz512KPvwus5MsFyvgt4K2/9ADO+JAPiqY2KDwxtZknXEEY8rlLx+G4BxSMshbb6FGJnND/oRjuTltT+ZZMuAjiI563WRwAG/WYUwFnX5i0BEuIIP4B2jRXU0NQ0wxHO3/C4yUval2GBQULoMP5j3BVNXOt2LqrOCf/dcUeKHiLWYmfxnfBrJLPPLlpOYenJL1s9bQOy/djvLafqDs0FrNCvT4LSMw8AlHI1cVbC1maq4ezplkhJUAiqCXwuhOwsP3kx8DkJXRECjlokoev1YUiKKrM+91mUcp9dAtgPpkximvx19nNJGvDJOp1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770468051; c=relaxed/relaxed;
	bh=u7mw2REIi5YvReIN1++C/n4doj/HVhTauIRAe2doeMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iW5+9wd/WJ5xU8yndwY/waoC8NlgeIqvfKVCuLHaa9lWcR9NHhTDlxARvzMoqc1h2NpREnJs2x9NotYbjpGmY5ZuJDT8bQWmvrbOtiryIKDd2P0WMQvd+uJJOcHvyCPMSQmAQaGanAV/1rmrHhHLwzOozHxxk6TBWqVtnd8NFmIUGJ6dJF07yu4A+rOXmO5YFfWYELSzXEQfQImUCHI67pvymQf//rTBrZ83FTYtd8TN+SsxJGhZADruWDm6oYb5EVV6gnoSuBJsEzsoQPnJicwFEIK7nLGyUeV7YNbaKzx9nICE8I8yx9nqyA9fVtEuguQ5TBntCrrbXBOvyKKKOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IHUEfbEs; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QRPaRJuX; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=IHUEfbEs;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=QRPaRJuX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4f7VtS6PvHz2xWJ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Feb 2026 23:40:48 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770468039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u7mw2REIi5YvReIN1++C/n4doj/HVhTauIRAe2doeMY=;
	b=IHUEfbEs7jatAyG0QJUXYH7tn0JLEYfYurUxGzjGRBE5e/M9QAME/qZ7DMNVU5XfxXe65N
	f9JmkBPSVMEEpywPQHJlcAHkoea0xia8FeK1YwmlHfg5SM/Q69haYUN/oIIUq+Y8TIifmg
	O1e3UdPaw/6WwgB9BH2nDW+Vv8ZvdQ/NXAoAZ9GOBi1KpVg7uenYmJ+o77Dm4KJYRxK0a2
	hD3R0XP6AmRTUpJIa+Fer1KHRIazZqiquew3rMZdN9FUwaTMu4Zwy0B3g2rFqAi8JxlzDr
	YYYivOb1WjwDFuNz/lLzSxgeOyDgRBipZqqfA/B5NakR621s/EYifdFxOZzDZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770468039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u7mw2REIi5YvReIN1++C/n4doj/HVhTauIRAe2doeMY=;
	b=QRPaRJuX/plnEzL6PBt2E45uECSGwK6YLL3plNVB/bNviWky8Y5y7+9Uu94qN9CMnFSj6E
	XRbiA86rYYsGjXAA==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1 support
In-Reply-To: <TY2PPF5CB9A1BE6CC5EEC90EBF13B083D1EF267A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-2-b0310e06c087@aspeedtech.com> <87h5ru14xx.ffs@tglx>
 <TY2PPF5CB9A1BE6CC5EEC90EBF13B083D1EF267A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Date: Sat, 07 Feb 2026 13:40:38 +0100
Message-ID: <87sebczpyx.ffs@tglx>
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

On Sat, Feb 07 2026 at 03:50, Ryan Chen wrote:
>> -----Original Message-----
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Sent: Friday, February 6, 2026 7:34 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring <robh@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>> <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Paul Walmsley <pjw@kernel.org>; Palmer
>> Dabbelt <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>;
>> Alexandre Ghiti <alex@ghiti.fr>
>> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
>> linux-riscv@lists.infradead.org; Ryan Chen <ryan_chen@aspeedtech.com>
>> Subject: Re: [PATCH 2/4] irqchip/ast2700-intcx: Add AST2700 INTC0/INTC1
>> support

Please fix your email client to not copy all mail headers. If you can't
fix it, remove them manually and replace it with the usual:

On Fri, Feb 06 2026 at ...., Thomas Gleixner wrote:
>> > +	guard(raw_spinlock_irqsave)(&intc0->intc_lock);
>> 
>> s/_irqsave// Interrupts are disabled when this is invoked.
> Sorry, do you mean when this function been call.
> Ther have desc->lock to do the raw_spin_lock_irqsave.

The core always holds irq_desc::lock with interrupts disabled when it
invokes those irqchip callbacks. So trying to disable interrupts in them
again is a pointless exercise.



