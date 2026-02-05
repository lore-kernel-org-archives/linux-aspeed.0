Return-Path: <linux-aspeed+bounces-3486-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BDBE91290
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 08:58:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6B2n0HHwz2xrk;
	Thu, 05 Feb 2026 19:58:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770281904;
	cv=none; b=AvUopUIBs4YwXwWvTI97KRLU5wrYXDSXUoW4f2QRRMEKd4DzaRJzl951U6VKzT9LLoaAv3tXYansXX/oMrsmypirofmzmqBKg+sf66kCz28QbZ/dIsVCU5eg9b3SNo80DaqSpa9YLmMqQzx/aiepnAH4hXADXIm+Wg7SY5YzMNdcAZAAQ4y4Q+1lml3tf6pDS446/oQ2IOBZLyqYfQ0FXHUSX2U4cuty5xd4/vKGpPqjInYIyookzEhMjO3wU2kph4PtHwObHK8UukVC8wuU0xcLmzjTEUyfhKLN3PHeX1tzhlyQMI3dZn+vBDn9PCJmEWILxWSAFvYgWoX9vjUmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770281904; c=relaxed/relaxed;
	bh=+ZxEJxikMpWZELZXNMUhqu+ZPA8fmT6IbLMviGWKku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xop3FmZ6Lp1bDTO3TRwQ9bUzUXDyMFW2NSPO1ritj+x3P4PaYhNDefekei47vijrWc5MIoQ93N+qRMgVqCGk0ha5rRpsGGLwBaz9kkLAEFPYjvWTBo8omNoDa7E1iqidiuymT8nMWtilUBPGOWyPeTkR3HADyC2TtCNm7pTMzq874GjCZneNTjM8407MID8Pf2GqMSwyTRNAC8XNK6kk7CbjJbbXXgMq0jEDSYYAnf9Rm+kkktgZt6S9RJIJPYwGzUIX9B7p2jMTkzKxGe72Xf7UqX5IKXHxRdyK9vIIedRAPeYAsKBjp3ZsWSySGW0bxrPj8WDbCVW8FgXPRVw9kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZGrsfJD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RZGrsfJD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6B2m1HZ6z2xg9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 19:58:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 707FF43CF5;
	Thu,  5 Feb 2026 08:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EBAC4CEF7;
	Thu,  5 Feb 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770281902;
	bh=vEzXCJoRBGkhhZKBFWIH4fhYfwPKyl9r9lvIYdyhKiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZGrsfJDGPjlUvn2ynhz01H4syPE8Eq7ODg7Kmdm/Gbe0Ni/Xxpzf/JSUTvazBpTO
	 BvrFckaeowWBMv4PtddX9mUBUrcZwUSjQdAvNZ8+MrWx79QNHoUub6aTJFzA4JKm7H
	 eEiM622zW7+H/x7kXZU2HlwXFLAVdR4/h/GTZi9N8s0zR2IWV41ss5NFCprcZVcP5J
	 UGD7p6qMP9pQvepu/RVkQY99qjZvSEAGmXPH1HMzkxd2X/sG1CtPa42uSSxKOoWKap
	 56dEbqUHNCP3gZLwLq221QW9beRFj1Pe92hF+cXyhJuG5DOafFUeKxrgxmwWQBGMI+
	 Ln2vcvW9gv/yQ==
Date: Thu, 5 Feb 2026 09:58:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
Message-ID: <20260205-intrepid-vengeful-deer-14e2eb@quoll>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>

On Thu, Feb 05, 2026 at 02:07:18PM +0800, Ryan Chen wrote:
> This series replaces the existing AST2700 interrupt controller binding
> and driver. The original implementation was focused on a narrow,
> PSP-centric view and could not fully describe the complexity of the
> AST2700 interrupt fabric:
> 
> * It was focused primarily on the perspective of the Primary Service
>   Processor (PSP).
> * It could not handle interrupt route configuration.
> * It could not handle interrupt register protection.
> 
> By contrast, the new bindings and drivers describe the interrupt
> controllers at the block-function level and provide a unified binding
> design that can be used from the perspective of any of the four
> integrated processors (the Primary, Secondary and Tertiary Service
> Processors, and the Boot MCU):

Where and how did you address last feedback given to you here:

https://lore.kernel.org/all/20250814-auspicious-thundering-jaybird-b76f4f@kuoka/

"This binding is not improving. You are not responding to REAL problems
described to you. What's more, you send it in a way making our life
difficult, look:"

So how did you make our life easier now?

Best regards,
Krzysztof


