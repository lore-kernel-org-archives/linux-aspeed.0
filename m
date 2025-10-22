Return-Path: <linux-aspeed+bounces-2571-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3F2CCD1BB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 16:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csFYP2mt4z2yFJ;
	Thu, 23 Oct 2025 03:51:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761151881;
	cv=none; b=GM8wkd3+neIV9d3uB+hTEmR4w7COeIHGU91uSWVAfNoL4lb0A0bwpddtRHzBRIBGSSu1fXoLqJUg2crAgt9+DKKnjCNJIe/yGEo0f03FAyiIHpm0sjgm4gbNKUAV43JmOjs+8YSNg8YhDp0qk9TIZqVF2bgGf2RnmQYUBubxQUQnMB2hkqc+dl2hzqwoBcXIh1iO8Oiton9P69ggoGqYkYJZw6gvqni9bottd4LtOple+4b2l5LeWVUxR3aMTwDaSWH7703w1sTaxM8AUPpKK6RT2BlTW4cRY8M2mrMVAHpVvY5EQD805LY8EGnHm2zYuyIfybDTUyOBJdLO6tCmVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761151881; c=relaxed/relaxed;
	bh=lUA1o5WQQPVYysu6WcIr2xDXJWQfyRSq8an7IHzsYEE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZFzWS5cnfm4yvAZSwfxSuITowryS8NzO8ECPzXaXnE8T+iCVzX87zFABX8e9aD3cYJxLvyj8Iz1VZ5Y7FWdnhjYWRY9CqZKhSzMnCWE0/uCS9D3jXZEbgHoYdf6q7X9ZEoxKSkJjCsFsel5aAevHxdBm+ye+jMdKdpJrp4xfSBixnYp+H+gJR1Hig9ywcmcDS7135nD3BeAjh8uZuw1iDR9XFNH6WJjixdyPJ2pyD9sh+7zNIr5ngJdMQpOCzKj4PCZrZU5TyBp0HaT1DLpc61rqJ4gJABGEMRYYw7nrkoMP3m62diloujVe9KQGZUbNeRK2+o6+SoDjlvjMN0D/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Nqsays2h; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H8V01t+v; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Nqsays2h;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H8V01t+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csFYM6MTgz2xxS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 03:51:19 +1100 (AEDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761151875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUA1o5WQQPVYysu6WcIr2xDXJWQfyRSq8an7IHzsYEE=;
	b=Nqsays2hvm/reEWnIZrs8JhsUsg2zUkM/2uo8+YG41VXqxyQQ1CT3VgfvcY+b6AdwvQYhs
	HWKh2W/lUm9zJS8k5BRyooIyqgtDW+PU7nWRhla+3IT9N6jmAta78739L09hWPW3njYMtU
	538GG4UGTC7n19+Nii0VUo2omyMs2fHgQZ+DXhhdUIIAtlPrzlQiKSxhub64Zf0illoXrM
	w5TKi3Ju5ZVOhjkterp14xfUnq7j8Wlk8sn33R6zRf/9rqnjr+e6HBUo65qCRL08d8kreg
	ymYIQaHM55yYx3Zg3jY6HmOFUBRiPqbXmF0Y72w/ihlPxgr+hjodhdQF+lg4nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761151875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUA1o5WQQPVYysu6WcIr2xDXJWQfyRSq8an7IHzsYEE=;
	b=H8V01t+vilrR5cMR7J0tB7Xfvt2kU0XLpQcjAXHtBbLM2cMov/9lAM8oE4vvpZNROE9KpJ
	A1JLrIbDatJvefDQ==
To: Ryan Chen <ryan_chen@aspeedtech.com>, ryan_chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
In-Reply-To: <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
Date: Wed, 22 Oct 2025 18:51:14 +0200
Message-ID: <87ecquyj5p.ffs@tglx>
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

On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:

The subject prefix is: irqchip/aspeed-intc:

It's documented how to make them:

   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> The AST2700 SoC defines two parent interrupt controller blocks
> (INTC0 and INTC1), each containing multiple interrupt-controller
> child instances ("*-intc-ic"). The existing irqchip driver
> (irq-aspeed-intc.c) currently only registers a single compatible
> string: "aspeed,ast2700-intc-ic"
>
> To support device trees that describe the INTC0 and INTC1
> hierarchy more precisely, this patch adds two additional

s/this patch adds/add/

git grep 'This patch' Documentation/process/

> compatible strings:
>  - "aspeed,ast2700-intc0-ic"
>  - "aspeed,ast2700-intc1-ic"
>
> Both map to the same initialization function
> `aspeed_intc_ic_of_init()`.

The backticks are pointless. Just write aspeed...init()

Thanks,

        tglx

