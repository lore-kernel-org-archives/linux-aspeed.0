Return-Path: <linux-aspeed+bounces-2601-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E901CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Oct 2025 12:29:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctMdl5sydz2yjm;
	Fri, 24 Oct 2025 23:28:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761308939;
	cv=none; b=LgygPw2GfbLdvj8OxRiBqOGMn47Ib7RPw7uBwXdS2LGFpfCoPdy6EvM9t9r9WVwEUWlhlcuhj6olshOKaHo5OMv4P25oQ7xsTxvQ5o+mCXGmy0eRKS6ZqigyNQJkgwck1O0Vz+ELuFoAIqTLtBXULWhLUMXZer39FG3qtciX4hjSRdWjsnlOotc1rsPA9/m5sMpiPlxEg7krrU8KZtHZGfGty5gPWoDMe8GlA4Xm4qzeEQhV/2NW5NCL8W/Cp8ag7+gCbA5EJ4JtQOxxfaC4e4xrt5B1oYl7yIErDiA59CxAu1cVGglSIYJKTRmNDejGMcar9UR2tgfDh0uWe84Ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761308939; c=relaxed/relaxed;
	bh=bLpiuHTkVYJeeQyf1nxnU5c82uk7vYrn+Np6jyjJloc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THh4QYMLXlNE9iV1VHzHHvjSsGbhDDdQ+1IdScGPJbVRLR/kBzjXXXYm0D2wNPWHS5wstpsB+BY4DtScXenVFlpUB+BrCSlRFn4OlUhOFyqeYABE3t+VylfESTTRNQNuo3CKCRERs8lbcBgo/fAdD5BfKYRaVKKBBf3VyiXmgPOQY4pPOCak58CQl/BtH9XErqK0bsMEvPh0NYN0WEKzxUnYE8LOfsP/NxQD97/JxrfeusdbFTZ9iKPH+NJCiMv3+ZLZdg6+IJy8q2XxBbwswqLy8MsljE4BO7WttRvb1lkfXW+9QAu5f4P1oIG1JsKvwHg9HdUPftl7uTBrjhskRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uogF3IuR; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=uogF3IuR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctMdk6rpXz2yN1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 23:28:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bLpiuHTkVYJeeQyf1nxnU5c82uk7vYrn+Np6jyjJloc=; b=uogF3IuRHG65F4F/hUsAqYa5bv
	5bsEVw1N/nJ5cZ5HPwcZYOW/3aWpoNIZAMC/mgFUSrbwJIbB9xWFXoHv5GOUgsHFBY4vIbbu8qtEO
	Mv3EUx/1xB9l12UKduwnjXRhTIt7Dt2X8IJzQcM/ctu9HTVb2THqkYrI3S3QCdwG/jdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vCGuA-00Bzil-7X; Fri, 24 Oct 2025 14:28:26 +0200
Date: Fri, 24 Oct 2025 14:28:26 +0200
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
Message-ID: <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

> > >> This probably needs some explanation: why are there two 'soc@...'
> > >> devices? Is this literally two chips in the system, or are you
> > >> describing two buses inside of the same SoC?
> > >
> > > The AST2700 is two soc connection with a property bus.
> > > Sharing some decode registers. Each have it own ahb bus.
> > 
> > I don't understand your explanation,
> 
> Let me clarify more clearly:
> The AST2700 is a dual-SoC architecture, consisting of two interconnected SoCs,
> referred to as SoC0 and SoC1. Each SoC has its own clock/reset domains. 
> They are connected through an internal "property bus", 
> which is Aspeed's internal interconnect providing shared
> address decoding and communication between the two SoCs.

By SoC are you just referring to peripherals? Or are there two sets of
CPUs as well?

If it is just peripherals, this has been done before by Marvell.

See armada-cp11x.dtsi. Marvell calls it a CP, they are identical, so
there is one description of it, which then gets included twice.

	Andrew

