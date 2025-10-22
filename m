Return-Path: <linux-aspeed+bounces-2572-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81A1CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 21:29:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4csMkq6RmSz2xnM;
	Thu, 23 Oct 2025 08:29:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761168595;
	cv=none; b=oejbghoVhFOTaEPesyuHcTwf5C7BAtnpPVwBSWsXF0Sz9wRA3inL1jzmh39M0vMbgxMsNtIhbcFd3fE99zIcYh8LVHQxlBST6UhTQ1sDmZwrmHFn8KzF0yy6Pzqys1Y9o8+1KYASTkV3Nrjfyqpe4Yw9sqCYutYo432LQbQbaKfBpNNX9nGJKX+e7xN3w1o+eE0KG5WYkHWNI3pNpLGmBorSSBdsgsj4QeO6/NtJEp4UiLis1bCeg7YDBecZfZrunk4jM0QunzgkXpe8ycKhAwgt3DXeTvxr8CKEOfeF8P3OwaTvwE1a2nrsE5f5xkBNWpKf/R5fZCPtuKEf4Xkyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761168595; c=relaxed/relaxed;
	bh=GQtbnX2T9Se/lRsU3DTM/JRK0hTqgNTrDEYIiVzPzXg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DvGyYX4a6BwyuH+xd4cUtKsuoMOh25yl9HqWXfHRy79hvu7eGPooMZh0xodxqcKkfAkVjUtnSX/qW7/VuIEszYnxB8COhlpo06XWf5LenWCaRH2wWgVPLR4Flodn9hzYD6nG4D0B0n+xxGCQ5QpssqMo+LpMsVKTELzl4k+rn2crjIxkPGAK4jEVbevLAsM4OQ3z2uiTyUL3TsCMW+IG2Mmh3h8y8Cc+GWn08IXDNu6PRUKn5Ud9sFb0iFMIQE54InYdZoN0VvdctW7BPKY6G/94EeFfuyRV93oXikQI8QLZ0Iv9TNHH+qtAq1epv7Ql+4DMDFd+B8SPdcfadgaIXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=T4SxPkLU; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ou7TvU9M; dkim-atps=neutral; spf=pass (client-ip=103.168.172.156; helo=fhigh-a5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=T4SxPkLU;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ou7TvU9M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.156; helo=fhigh-a5-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csMkl3Qydz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 08:29:49 +1100 (AEDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69F2A1400179;
	Wed, 22 Oct 2025 17:29:47 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 22 Oct 2025 17:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761168587;
	 x=1761254987; bh=GQtbnX2T9Se/lRsU3DTM/JRK0hTqgNTrDEYIiVzPzXg=; b=
	T4SxPkLUshLDsetVBJ/s2ahutHPxk6IqoV+3ZBCY+l4iauAYnJ/8o9qmbjmF0eRw
	mexndk3pN1GKfjpyD5+f4r0Ano0Y67E4i6i5PaitMVzE+bH57pkqHBwEoeE7DC9s
	uYNjCwbi3q7k80u1lVwmxSLZG/lB3In5RV2j00XHFXxLABpjZvox4gQ9Th7Rz/EP
	RdVFhTb3ajfBDy5oX5gp2sT1vSrxtkRiRuBAcfxp1VO99VmVHm0BSwOWHYt347i1
	0KkNuBys49d0awdBntg5T2xggf8bLBK4EbANO5v1gjG8VZKMbfty2tgu8pzfKEH0
	ZS+P3omLJyTji1BpFyRHlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761168587; x=1761254987; bh=G
	QtbnX2T9Se/lRsU3DTM/JRK0hTqgNTrDEYIiVzPzXg=; b=ou7TvU9MaD2Cj4WhJ
	wOTWISBACxdnX15j5M4WKzscNO++lNUOAKPCH7xBngsbMGESZ4+b9uEpkfPc9MF9
	DGws/OiXR4bAJUdISheICQxaeZI4IbrOvK4I8XGDh6de+MUpxrABwrWVPirq4OcC
	+6q5LfPjKEewEWAknp2sWb9AXmCCBAKMWpLAsD45Xp0MyP3doa2fSySNycZKPB70
	kO1vcgneA/r3gBuGm76FOlHkFtmC6Gp5UK9s8w8M4hoIM8DjO/N0s7tJhiI+gaBY
	p9Z8O30XCHqzDtp8Qft99oN2Dat7bEw2ymqTjPph3c0XVhvMVDhRLmO2G5R5upvA
	B6qtg==
X-ME-Sender: <xms:yEz5aKImCldmUCX7U54vfZ05-AAJkUTKq0uoJf6mdWtflsoSPepewA>
    <xme:yEz5aM_S7iI1RIDFDQTfI7YimnTORMkee7PKxsqkX2yhx-e7J207kucp3qpjMok4T
    NKBbukKr_eeTH-sIa7cTzYDk8K8Wg4TfWDVLX2r73Qi5bRGnb5R3UM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhkeeltdfffefhgffhteetheeuhffgteeghfdtueefudeuleetgfehtdejieffhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopegsmhgtqdhsfiesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtoheprhih
    rghnpggthhgvnhesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohepphhrrggshh
    grkhgrrhdrmhgrhhgruggvvhdqlhgrugdrrhhjsegsphdrrhgvnhgvshgrshdrtghomhdp
    rhgtphhtthhopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupd
    hrtghpthhtohepjhhksegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphht
    thhopehnfhhrrghprhgrughosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjh
    hovghlsehjmhhsrdhiugdrrghupdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:yEz5aBgcDioDWIc_8DeRivTfNZakPd6HTRia4nf1zN4O_SfLO07Cdg>
    <xmx:yEz5aCK1AaQJfDOoAgORQdIeliTmQ3NPfdtRVgKBdVRFS0YJ6Oalrg>
    <xmx:yEz5aM73GP141dHMlJLTmDcXUZ-EAH4r4Q0r60x7HxdKnFsywnXkAw>
    <xmx:yEz5aPkxidvDJAgTXW0uPyJUFc2llHsYHCy-TekCsqgTUSGKii4d1A>
    <xmx:y0z5aOXvPySuzPpWft2Y2TVfuArpGU7LHWS857_t35R_1ukaAPoVibc6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB151700054; Wed, 22 Oct 2025 17:29:43 -0400 (EDT)
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
Date: Wed, 22 Oct 2025 23:29:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>, bmc-sw@aspeedtech.com,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Jeremy Kerr" <jk@codeconstruct.com.au>, "Lee Jones" <lee@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Nishanth Menon" <nm@ti.com>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 "Taniya Das" <quic_tdas@quicinc.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Eric Biggers" <ebiggers@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
In-Reply-To: <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 22, 2025, at 09:05, Ryan Chen wrote:
> Add initial device tree for the ASPEED 8th BMC SoC family.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I think this is the place where you'd want to put some information
about the chip itself. I know what it is, but others may not
know anything about it.
 
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +		serial8 = &uart8;
> +		serial9 = &uart9;
> +		serial10 = &uart10;
> +		serial11 = &uart11;
> +		serial12 = &uart12;
> +		serial13 = &uart13;
> +		serial14 = &uart14;
> +	};

This looks like you just list all the uarts that are present
on the chip, which is not how the aliases are meant to be
used. Move this block into the board specific file and
only list the ones that are actually enabled on that particular
board.

In particular, the alias names are meant to be local to the
board and don't usually correspond to the numbering inside
of the chip. In the defconfig, we currently set
CONFIG_SERIAL_8250_NR_UARTS=8, which is enough for any
board we support so far, but that means only the first
8 aliases in the list will actually work.

> +	soc0: soc@10000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x10000000 0x0 0x4000000>;
> +
> +		intc0: interrupt-controller@12100000 {
> +			compatible = "aspeed,ast2700-intc0";
> +			reg = <0 0x12100000 0 0x4000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x0 0x12100000 0x4000>;

This doesn't seem to add up: you define a local register
space for the soc from 0x0 to 0x4000000, but the registers of
the child devices are above 0x4000000.

I suspect that you forgot to adjust all the addresses in
the child devices to be inside of that range.

> +	soc1: soc@14000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x14000000 0x0 0x10000000>;

This probably needs some explanation: why are there two 'soc@...'
devices? Is this literally two chips in the system, or are you
describing two buses inside of the same SoC?

> +
> +		mdio0: mdio@14040000 {
> +			compatible = "aspeed,ast2600-mdio";
> +			reg = <0 0x14040000 0 0x8>;
> +			resets = <&syscon1 SCU1_RESET_MII>;
> +			status = "disabled";
> +		};

I see that you use the old compatible="aspeed,ast2600-mdio" string
exclusively here. While this works, I would suggest you list both
a more specific "aspeed,ast2700-mdio" string to refer to the version
in this chip as well as the fallback "aspeed,ast2600-mdio" string
as the generic identifier.

The binding obviously has to describe both in that case, but the
driver does not need to be modified as long as both behave the
same way.

> +
> +		syscon1: syscon@14c02000 {
> +			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
> +			reg = <0x0 0x14c02000 0x0 0x1000>;
> +			ranges = <0x0 0x0 0x14c02000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			scu_ic2: interrupt-controller@100 {
> +				compatible = "aspeed,ast2700-scu-ic2";
> +				reg = <0x100 0x8>;
> +				#interrupt-cells = <1>;
> +				interrupts-extended = <&intc1_5 0>;
> +				interrupt-controller;
> +			};
> +
> +			scu_ic3: interrupt-controller@108 {
> +				compatible = "aspeed,ast2700-scu-ic3";
> +				reg = <0x108 0x8>;
> +				#interrupt-cells = <1>;
> +				interrupts-extended = <&intc1_5 26>;
> +				interrupt-controller;
> +			};

This looks a bit silly to be honest: you have two separate devices
that each have a single register and a different compatible string?

Also you claim to be compatible with "syscon" but nothing actually
refers to the syscon node in that form?

       Arnd

