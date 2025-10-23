Return-Path: <linux-aspeed+bounces-2584-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6557ECCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 20:21:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csy946X65z3btM;
	Fri, 24 Oct 2025 07:21:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761250872;
	cv=none; b=m3vHZzmSqQqWUIHg0bqOFlwmmKlZ6lU5qajYooD8C5gteMbBfpmcP/BrCejYXKAfZSeLhCYgNXitgj1YaDh8tWMF6UUn/Q+NuO95XYf4J+EW5Jir176LhO36BQCJDpwJF2k6S9Dp+Qy+/yay1/bRpycQEmEa3r/WexCYSKPKyGWn9gYCfyHH4fdYinp3i37SiejlpTKK+ClkCN8B3g1F9fY9WfUXU9LXfsyFdulK+nBFM/BcJyNBbm46xrMa6r5i43kN1fW7gAhUzrb12FiypO9jXXaDLB/kKXMD/VAuf0UVW8rBryQcRi/D61eZJ1VC/O9OVkCyZCnw+81rMYtS/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761250872; c=relaxed/relaxed;
	bh=uOtdIBBvO4Ujse60vki69gfDQAEcTBuUnWSLTKLCpJ8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j5lBYbIZiMqLm3A8l7KQ0zsbxDzEfG+R5/AGvR8N3LQ342CcTibQjYCHM0vipPhvhtIh32hAiZT6WibX/OwrqsBJcBKUQR69Lb3OHEcbhKygrXLDHKZ1knk+cNW61QzTYf4iuZ3Ossto1a8LtSW92Kia7nHPC3NWt4IrONsDipWiwChNRD707Za0y0CanC1yK0fKuOeSTsiCgOxR8oV32wIPblYfRR4R1RrttZYuWzr1Rqbo9DGaY7lPkkG2BlGM+j++Xyn+lI4vAiXviSBgbwdxP7PhEMc9ZiOReoAqe8h48Z3RGFr/ifkXrCKa9kO54VTLARogFG+n+0F6XDnEjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VlWF0jqC; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kOqzGkGY; dkim-atps=neutral; spf=pass (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VlWF0jqC;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kOqzGkGY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.159; helo=fhigh-b8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 573 seconds by postgrey-1.37 at boromir; Fri, 24 Oct 2025 07:21:08 AEDT
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csy904Xtpz3bsN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 07:21:08 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45C167A003A;
	Thu, 23 Oct 2025 16:11:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 16:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761250291;
	 x=1761336691; bh=uOtdIBBvO4Ujse60vki69gfDQAEcTBuUnWSLTKLCpJ8=; b=
	VlWF0jqCIMQ6JHgD75hGpuWKuO2BWc/R8TVTYFsR894nKb+F4+YUs3FqsFGc7uQf
	Wzpd/oRWRo2QpHIYp0fAKO+nhXJrocVlEoAvaTYfCPLESY+aizrxZLD73ceERqm9
	T3ck8LXtCRF7+oy6+FdwY7alaJFGBYbCtQ5XxYMfMT9rD/vwn11t13e/YgZ+NEVK
	rF38LBNXT7g5Iz4y2r4Svd8+uQYgUk+CPbLv//SbDbn5x646KSkLDgYTomolc15k
	rUIzH4jxyphye65iNNA7mWzePskzrmw46C7rvW4oZeT2PdExvPxq576Oq+vh+GnX
	aXYPI5OqXwb25wPxrhsoFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761250291; x=1761336691; bh=u
	OtdIBBvO4Ujse60vki69gfDQAEcTBuUnWSLTKLCpJ8=; b=kOqzGkGYPMqjB4uHP
	zXcffmF54QCYlB53Bptup3D+wO9KLsgtmHyZa7/KJvAMMLuNxzWWtlZ83+7NJnuq
	8EFXp/hG/b4jHOwfmVP3C6OmbD1k+KNIRQ4mYxWBmC9X1lt6Aa8O/dWpc2rQd//d
	VKuWNs2hi2cckvBurbtlzQK7JdUyaBHzaz5cFxuY+JLtRPSe+GDDWaTk3ntTg6QP
	nE3C2nM9R3CS9RKdNkgp6I24hsAzrHFhWtUUpqUIHuVBE/8Rf9aoFcRBELezXK9t
	Fn/CvumnkUw92aNHiQsxUKCR0PG/4yRhOIyTfU5QW7INWNu3bOUlD1MMhKa1y1Vo
	rLh2Q==
X-ME-Sender: <xms:74v6aAbe_DwmhGMJG53C6jW140c11inxjy5RxYnYFvb5_QRaO2P_Ag>
    <xme:74v6aGPAOuTnDmbdIkMBttLRDcHfH24WNzAOJewXmAncY4L8c6d9pTMQDNHbB1f16
    gskQ5mxDHpunROpwNiiNMth3xhMqPsmfAKSpWxLfPdPyn5D-9AR-GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedutddtfffhfeehfeegvdfflefhgeegfefhvdeuhfeuffehjefhueeitddttdekleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlfihnrdhnvghtnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdgu
    vgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepsghmtgdq
    shifsegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehrhigrnhgptghhvghnse
    grshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehprhgrsghhrghkrghrrdhmrghh
    rgguvghvqdhlrggurdhrjhessghprdhrvghnvghsrghsrdgtohhmpdhrtghpthhtoheprg
    hnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehj
    khestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepnhhfrhgrph
    hrrgguohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehjohgvlhesjhhmshdr
    ihgurdgruhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:74v6aNz9Pv7pk8lbFJEkMAOTx4K8eA6k_u48jDljbJJNKwZ6n8T3tw>
    <xmx:74v6aJbtVwBmGAByqauon98-IvQkP7upRMQz3zhqgGiHcw_-jd4Urw>
    <xmx:74v6aDI5d2dDUWbqUYfz156HA-I5s1wavJEvP9WokWH2XbiPq0aPiQ>
    <xmx:74v6aI3hmtTp9iZM2_WYyKde4a63tzgl5bkTBhouA5a9JfdYRYdadg>
    <xmx:84v6aDknT2cJSxKMQoFrJUJ4d5-n5TaMrBQriloDjrQFpv3sTaieodpF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AFAB7700054; Thu, 23 Oct 2025 16:11:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: AMptcG-LwCSF
Date: Thu, 23 Oct 2025 22:11:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Jeremy Kerr" <jk@codeconstruct.com.au>, "Lee Jones" <lee@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Nishanth Menon" <nm@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Taniya Das" <quic_tdas@quicinc.com>, "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
In-Reply-To: 
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 23, 2025, at 09:37, Ryan Chen wrote:
>
>> > +	aliases {
>> > +		serial0 = &uart0;
>> > +		serial1 = &uart1;
>> > +		serial2 = &uart2;
>> > +		serial3 = &uart3;
>> > +		serial4 = &uart4;
>> > +		serial5 = &uart5;
>> > +		serial6 = &uart6;
>> > +		serial7 = &uart7;
>> > +		serial8 = &uart8;
>> > +		serial9 = &uart9;
>> > +		serial10 = &uart10;
>> > +		serial11 = &uart11;
>> > +		serial12 = &uart12;
>> > +		serial13 = &uart13;
>> > +		serial14 = &uart14;
>> > +	};
>> 
>> This looks like you just list all the uarts that are present on the chip, which is
>> not how the aliases are meant to be used. Move this block into the board
>> specific file and only list the ones that are actually enabled on that particular
>> board.
>> 
>> In particular, the alias names are meant to be local to the board and don't
>> usually correspond to the numbering inside of the chip. In the defconfig, we
>> currently set CONFIG_SERIAL_8250_NR_UARTS=8, which is enough for any
>> board we support so far, but that means only the first
>> 8 aliases in the list will actually work.
>
> Understood. I'll move the aliases block from the SoC dtsi into the
> EVB board dts. For the EVB, UART12 is used as the default console,
> and the board labels match the SoC numbering, so I plan to keep:
>
> Does that look acceptable?
> ast2700-evb.dts
> 	aliases {
> 		serial0 = &uart0;
> 		serial1 = &uart1;
> 		serial2 = &uart2;
> 		serial3 = &uart3;
> 		serial4 = &uart4;
> 		serial5 = &uart5;
> 		serial6 = &uart6;
> 		serial7 = &uart7;
> 		serial8 = &uart8;
> 		serial9 = &uart9;
> 		serial10 = &uart10;
> 		serial11 = &uart11;
> 		serial12 = &uart12;
> 		serial13 = &uart13;
> 		serial14 = &uart14;
> }

I think this would be broken for the defconfig if the consol is
on serial12. I would recommend using serial0 as the console, like

aliases {
       serial0 = &uart12;
}

in this case. If additional uarts are enabled, add those as
further aliases.

>> 
>> > +	soc1: soc@14000000 {
>> > +		compatible = "simple-bus";
>> > +		#address-cells = <2>;
>> > +		#size-cells = <2>;
>> > +		ranges = <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;
>> 
>> This probably needs some explanation: why are there two 'soc@...'
>> devices? Is this literally two chips in the system, or are you describing two
>> buses inside of the same SoC?
>
> The AST2700 is two soc connection with a property bus.
> Sharing some decode registers. Each have it own ahb bus.

I don't understand your explanation, 

>> 
>> > +
>> > +		mdio0: mdio@14040000 {
>> > +			compatible = "aspeed,ast2600-mdio";
>> > +			reg = <0 0x14040000 0 0x8>;
>> > +			resets = <&syscon1 SCU1_RESET_MII>;
>> > +			status = "disabled";
>> > +		};
>> 
>> I see that you use the old compatible="aspeed,ast2600-mdio" string exclusively
>> here. While this works, I would suggest you list both a more specific
>> "aspeed,ast2700-mdio" string to refer to the version in this chip as well as the
>> fallback "aspeed,ast2600-mdio" string as the generic identifier.
>> 
>> The binding obviously has to describe both in that case, but the driver does not
>> need to be modified as long as both behave the same way.
>
> Thanks, will submit ast2700-mdio. 
> Question, should I add in here patch series?
> Or go for another patch thread?

Since there is no corresponding driver change, I would keep the binding
change as a patch in this series.

>> > +
>> > +		syscon1: syscon@14c02000 {
>> > +			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
>> > +			reg = <0x0 0x14c02000 0x0 0x1000>;
>> > +			ranges = <0x0 0x0 0x14c02000 0x1000>;
>> > +			#address-cells = <1>;
>> > +			#size-cells = <1>;
>> > +			#clock-cells = <1>;
>> > +			#reset-cells = <1>;
>> > +
>> > +			scu_ic2: interrupt-controller@100 {
>> > +				compatible = "aspeed,ast2700-scu-ic2";
>> > +				reg = <0x100 0x8>;
>> > +				#interrupt-cells = <1>;
>> > +				interrupts-extended = <&intc1_5 0>;
>> > +				interrupt-controller;
>> > +			};
>> > +
>> > +			scu_ic3: interrupt-controller@108 {
>> > +				compatible = "aspeed,ast2700-scu-ic3";
>> > +				reg = <0x108 0x8>;
>> > +				#interrupt-cells = <1>;
>> > +				interrupts-extended = <&intc1_5 26>;
>> > +				interrupt-controller;
>> > +			};
>> 
>> This looks a bit silly to be honest: you have two separate devices that each have
>> a single register and a different compatible string?
>
> Yes, it have difference register define in each scu-ic#. That is 
> compatible with design.
> https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-aspeed-scu-ic.c#L45-L48

Right, if the driver already has this design, it does make sense to
not change it for the new generation. For a newly added driver I would
probably do it differently.

>> Also you claim to be compatible with "syscon" but nothing actually refers to the
>> syscon node in that form?
>
> There is another submit ongoing in pinctrl which will use syscon. 
> https://lwn.net/ml/all/20250829073030.2749482-2-billy_tsai@aspeedtech.com/
>
> Could I keep it? or I should remove it?

The version of the driver you are linking does not appear to use
syscon, maybe this is an artifact from a previous version?

If so, you can drop it. On the other hand, this does seem to
be a classic syscon device and keeping it marked that way is not
harmful, just redundant if you actually use the more specific
compatible string.


     Arnd

