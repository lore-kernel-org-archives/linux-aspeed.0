Return-Path: <linux-aspeed+bounces-2608-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBA5CCF9E0
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Oct 2025 23:12:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctdvh37J9z306d;
	Sat, 25 Oct 2025 10:12:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761347520;
	cv=none; b=GGdjZ8wAQKI6H+Y/E/lKNvi980WEwbd0L3XDZZ44jiEMNfhSqAnfGBuNwUJLM5arkp9TKKCleAOqJaQerzzmo6Nvjif1Jj8DLClh6+PhSLQzJhImHAASub4BweIGP/SQzR0rU8oLLKZHGm5gMs58WGzet+L6oA2bMUZpZ1xFHTJUf2S+nEAo4S0zMxe4YQhQHDtrjqPIwVpEDhjTWQbhWMO5U+qexyJxuqH7czM+drPwuVLPt0lRbSnjK6HDwECQa3x5/gDVRBXdr5+OnE3ZSo7QgBNKyCEG6gR7eO8yOaPtJmYsEgnjNQMp9J0upP9EEEUWEhMlYnhmHzaPvbnM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761347520; c=relaxed/relaxed;
	bh=v696+d7bEKIHP2KzhVvsY2xM2Oejqt840Bj3nBovTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfaalPtKUeoqcv8udXPwdF7sYVmXKbg/b7KU7/sj0Uq1Tg8yQSDyAWhuK79zSCmVt3zn1chb81xNkNq40uQl0tzOeij3ApzE0GJpL4VLxcdi6P4rwq1UMe9KCBDjEIhsi3j6KkOyvT14aTfDN+xKq1Ml/zjJ1V5f5m8NX34nF+aAjfAKtxIn3XRadhArmjLlaz77r+fjqAcr2IAITV7ZPqUUbQ0Xl1t3lORat+fbTkyOuulCDySXjW5XxTDV02IogLml5tHYYnd1MNZQkCSARcafe3m6idGTdsOQPfZfkyQm4qZ4HLpeROjV5/Ta/QHpy0HUq3xjxTu6MkXa9xzJnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vMc8uwQa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vMc8uwQa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctdvg31Phz304h
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Oct 2025 10:11:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 00E4A601A7;
	Fri, 24 Oct 2025 23:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E58C4CEF1;
	Fri, 24 Oct 2025 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761347516;
	bh=F1LhiwGp0x3wM8SAKbj7UnEIjjud2a8/8+rDH/aYbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMc8uwQa2ZrwjDbFF6Ktnl5l6b3YVFOifLfJacDlgvv45EyGN3Y6vPdMmdK2BrXsK
	 TiBckurBINKotx8ovqoOOPI0fnqJVuVhO8YOdPW8TSaySjdDMzuWxcuc7wNk/kVPsA
	 5N/yiuZvGf9TKL4dFHeNX0PtjsF+lZKSi+uU0JkK5LwpUGassFriVhIqO8Sp42MLdR
	 X03nJP9dqgLarDzc4Mh3tXRP3Eb7pU2YqiYW+ig73LkP9XGIhABgXfL9+6rWojAguE
	 OwAL6gnIeuecSfwRAT3vMeZjGTVJE5/x/RjVcBdJNTSV2vOjIDb8Xk7ILwlgo/qJdu
	 mbg0SpRIpe76w==
Date: Fri, 24 Oct 2025 18:11:54 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Kevin Chen <kevin_chen@aspeedtech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller:
 aspeed,ast2700: Add support for INTC hierarchy
Message-ID: <20251024231154.GA2962687-robh@kernel.org>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
 <20251022135101.GA3349934-robh@kernel.org>
 <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE674594566C13B8D8B2984F2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Thu, Oct 23, 2025 at 06:57:01AM +0000, Ryan Chen wrote:
> Hello Rob.
> 	Thank you for your detailed review and comments.
> 
> > Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast2700:
> > Add support for INTC hierarchy
> > 
> > On Wed, Oct 22, 2025 at 02:55:05PM +0800, Ryan Chen wrote:
> > > AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
> > > each with its own register space and handling different sets of
> > > peripherals.
> > 
> > This is a mess!
> > 
> > How does this relate to the existing "aspeed,ast2700-intc-ic"? Its schema has a
> > block diagram of connections which I can understand. This does not.
> > 
> > The use of child nodes here is questionable. A variable number of interrupt
> > banks is not a reason to have child nodes. I'm only guessing that's what's
> > happening here because you haven't explained it.
> 
> Let me clarify the hardware structure and the purpose of these bindings.
> 
> The AST2700 SoC includes two top-level interrupt controller modules,
> INTC0 and INTC1. (aspeed,ast2700-intc0, aspeed,ast2700-intc1)
> Each of them provides routing selection and register protection
> features.
> Within each INTCx block, there are multiple sub-blocks called
> intc-ic, each handling multi-interrupt sources.
> ("aspeed,ast2700-intc0-ic", "aspeed,ast2700-intc1-ic")
> 
> Cascading occurs between the child banks:
> Level 1 : intc0-ic have multi-interrupts connect to GIC (root)
> Level 2 : multi Intc1-ic# connect to intc0-ic
> The parent intc0/1 nodes expose register regions for routing and
> protection control, serving as containers for their intc-ic children.

Being a 2nd vs. 3rd level interrupt controller is not a reason for 
different compatibles. The programming model is obviously the same for 
both as you essentially have 0 driver changes. Having N banks of 32 
interrupts vs. 1 bank of 32 interrupts is not a reason to have multiple 
intcN-ic nodes. That is a very common difference between instances of 
the same interrupt controller such as the GIC.

What you need to do is simply extend your driver to support N banks of 
32 interrupts. That's what almost every other irqchip driver with more 
than 32 interrupts does. If you are lucky, then the offset to each 
bank's registers is just hwirq/32 * <bank stride> and the number of 
banks can be calculated from the length of 'reg'. If you are not 
lucky, then you could put 1 'reg' entry for each bank.

AFAICT, the existing binding in aspeed,ast2700-intc.yaml should work for 
you.

> 
> The following simplified diagram shows the hierarchy:
> 
> 
>                                  +----------+       +----------+
>                                  |  intc0   |       |  intc1   |
> - - - - - - - - - - - - - - - - -+---- -----+- -  - +------ - -+
>   +-----------------------+      |          |       |          |
>   | +-------+ +---------+ |      |          |       |          |
>   | |       | |         | |      |          |       |          |
>   | |  PSP  +-+ GIC     | |      |          |       |          |
>   | |       | |         | |      |          |       |          |
>   | +-------+ |         | |      |          |       |          |
>   |           |         | |      +----------+       |          |
>   |           | 192~201 <-|------+          <-------+ intc1-ic |
>   |           +---------+ |      |          |       |          |
>   +-----------------------+      | intc0-ic <-------+ intc1-ic |
>                                  |          |       |          |
>                                  | 			<-------+ intc1-ic |
>                                  +----------+		  .....

You already match on intc0 and handle 32 interrupts. Now you are adding 
intc0-ic to match on and handling the same 32 interrupts?

Rob

