Return-Path: <linux-aspeed+bounces-2583-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8DFCCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 18:28:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csvgD0smxz3bf4;
	Fri, 24 Oct 2025 05:28:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761244120;
	cv=none; b=XTEbhhDWKAOk/I1zLAr0DeSEEHiCfzNpOp2X8VGZJc/95O+7B6Ph3GNlsA/4+inF7YHK7MeEL5tGlGW4lg9rqIhzTadIDZpR8yzoB2oH152PbSjuAnS3LCUCCesY575VwGZl/6FageZquKQBM+L3+oMWdse420zFfIM3pp4S3VLdDwbsZg3PH6Zgs4DEBjYglUP/CXVJhHaOqBeJ4hFi5rq+6BE/x0I09H3LXl/eUEgHuY5BE8mgWhsnI+rboLYRw9NifIOyGA63uQZE88AzJMWEkArbARJed26bx56/m0AAoT3iaTHkAskCRg1D1lTpO5XAIgYUivO4KsOpWpWVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761244120; c=relaxed/relaxed;
	bh=dF8Bsuxs1bOw/Vu4h6JauGctQLAvBIWDKoMFcT9IHNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgHSii/JT7QpeYhyJla7PfdwewSxDG4EiM1rSUXyekLrBFEWLTX6CH5hqiROXXKE8p4xqAGMQ096kXLgO8M6cq29Pjjw9kGmpvA8wO4+pvEKWq2qWhfZLLSTvNnBgATu9j3yd/NL0fS1o2OoK9IciCxOeE1p2bTnzDWP0DzMsB0SC3V0f3pTdKDRf6UJCjVH5b3xDeqfM5o4r4SqjJkQYar8q6dLXQTc6lfGv0LyK3hWFKgO9PvGEfj76ZqKibYG7cM5q5kKHuJGskbok5Nf9cGBpQWnV7xNqcVB8Fdh5nNAthOq7VO1Gzh51O97hywpjs9v+JcSncJcDa1lgwEudw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ycDkGYCD; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ycDkGYCD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csvgB1qFvz3bd0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 05:28:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dF8Bsuxs1bOw/Vu4h6JauGctQLAvBIWDKoMFcT9IHNI=; b=ycDkGYCDrUPhwkysgMTElO7lrA
	oERm9YjauhNyWsqRqlB3gXptN4R4DH72ymIRKKbzc1/7OkCcI2fZAh76tcJ2Ij/Vkj2XkTYfdvDR9
	kHTNA76wKvjT4ijztRf1xYtkrLcZ4kgnDBdN/KpoAk4GPM4ZX169WMM14ZnspA1FGLmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC02b-00BuNV-VB; Thu, 23 Oct 2025 20:28:01 +0200
Date: Thu, 23 Oct 2025 20:28:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, BMC-SW <BMC-SW@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC
 device tree
Message-ID: <b048afc1-a143-4fd0-94c9-3677339d7f56@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

> > > +		mdio0: mdio@14040000 {
> > > +			compatible = "aspeed,ast2600-mdio";
> > > +			reg = <0 0x14040000 0 0x8>;
> > > +			resets = <&syscon1 SCU1_RESET_MII>;
> > > +			status = "disabled";
> > > +		};
> > 
> > I see that you use the old compatible="aspeed,ast2600-mdio" string exclusively
> > here. While this works, I would suggest you list both a more specific
> > "aspeed,ast2700-mdio" string to refer to the version in this chip as well as the
> > fallback "aspeed,ast2600-mdio" string as the generic identifier.
> > 
> > The binding obviously has to describe both in that case, but the driver does not
> > need to be modified as long as both behave the same way.
> 
> Thanks, will submit ast2700-mdio. 
> Question, should I add in here patch series?
> Or go for another patch thread?

Please submit it to net-next. Since you will have aspeed,ast2600-mdio
as a fail back, it will work until everything meets up in linux-next.

	Andrew

