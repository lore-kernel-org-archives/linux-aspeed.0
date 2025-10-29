Return-Path: <linux-aspeed+bounces-2680-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C638CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 07:51:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxKF30Nc2z3bfF;
	Wed, 29 Oct 2025 18:51:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761724278;
	cv=none; b=PagREn8GBjO0yPG3a5rn2bpumtmYVMAK95k7/AefdakrVlfsDHbJ0AKE3FGYzIWCdWMVLtFHkLpkCM74iUvOTmVZmHas9yYboiuQBLcYyEWml/YAVMpQ0hh52qvPEFTvyBw1OJsH3JOnCf3hxaWDhA38M8C34NiKNQsXHx8XzNR7xuwEVBBQ10yWdVEi6uNGrseRGsTX7YT3PUlDPvoY/CqMOVflPe2yW4GI7a+OC2Bu3VhsbZiREfcZHmZwrVgHdC/gARAUQdrhmvBrFbpgadHbrJiHjySgkn1Y43AEwUGbSkiQ9fAyIjjsAo8kTT0l517HfoqkPw4I5JiMVZ4Y5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761724278; c=relaxed/relaxed;
	bh=HL4fT/7Pst+EfkWdbuJ+fjqkNVyr3cJdgOgkyt71Afs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dyoB1EXEfzMhjK5jvvzdk60SxB+bnCMQ9KF07V+OQ5fwlxXJnuTEBY2OeAwwPGmuiCCVOUttssd6GNBQbCqowmq7D6qteCqiZhWInVeZja9bqb5jeUegOE3wZvuErDor6VALsHEzI216QzpXYclNRfwJrRR5zp7S12DKDFDzRpz+HBuYqzb+YNk5t9K86OFg1uqZpRxACiHPm+Ag9CC/piKFxCrGQLpDrzDWFBxLwudf1U269mD6cMCuLU2J2IIbNglo8hvchJ7J3SO/i0ApaI1kCQWu5MbhJ/uMCwV6FzjAfA9LoamDlG+Og2zREu8o5+rTuXzx6jOU+I+JljFI0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=TsE+egRA; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=buCsAW9t; dkim-atps=neutral; spf=pass (client-ip=103.168.172.151; helo=fout-a8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=TsE+egRA;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=buCsAW9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.151; helo=fout-a8-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1477 seconds by postgrey-1.37 at boromir; Wed, 29 Oct 2025 18:51:14 AEDT
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxKDy2whsz30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 18:51:14 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F356EC02AE;
	Wed, 29 Oct 2025 03:26:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 03:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761722794;
	 x=1761809194; bh=HL4fT/7Pst+EfkWdbuJ+fjqkNVyr3cJdgOgkyt71Afs=; b=
	TsE+egRAXaQBIxVtjjN73Rj3ClHl9oxqOMclN2UuaUPOqICef3WlHjzVkoPkP26i
	6S07NpewUn14LKjz/knOQA4IPC3FO9rFGLEro/u7EWHATZtuA09YT/SGCAlHkSmh
	PzpoJsW2sGQYsFlZ4ikrMDJR+7LqxKoJ/v1aPpI1EHzLgbkfPTMB6O39qBz1KHv+
	ptxWi0kbx+eWKenyJCOlM0cKKv4WPYcIpHQc9gFL+rhOmKrs4ORfGsXzZTjL9Dkj
	RIl4Is/trtRxorXiQp3PGObelWQXNcib1tdW883YrDPH1DCvKchp/A+TxYuaIrvZ
	6wjM5j5Wwg7CnZNPTZbTvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761722794; x=
	1761809194; bh=HL4fT/7Pst+EfkWdbuJ+fjqkNVyr3cJdgOgkyt71Afs=; b=b
	uCsAW9t/9gdk3Zy52sXZvDD7pXH2XsqFW99aqUm2QzoL+VJUvhQHyzSRJwwSTX0w
	dQ3iHNFx/MYMni8nuiOEG39me/i7EU6sNa7ai7hRXVRVxtA5ZYKL3ydiYkM/Dc8E
	Orfqd49nh50reQicPAFJBs1lIkOyvO5lHut1Z1M0qJDp3Rxag2JtgcKGqNGh4rDR
	12eUjydkKhvn//KTEobrB796qaJO+KlstPDOuLPte3iS7bbidy5wRJZ+Aq5hCPhj
	6FF6eyixu4I3uEtOZM2nc3/lDj+lX2lYjOvq9DTj1NFsdxSUDUOEy3Rx28eDe+YP
	PZ/wHj70FV2tjyhGXVO0Q==
X-ME-Sender: <xms:p8EBaavqJ0QQ4LJo-rhQsWncvD6kEVTVV4rmvyBorYbJi2ZZA_WoBg>
    <xme:p8EBaaRgB11oP8RMGDqRz83ry0S21PwUM7rCozkf1UFLjQeQYeu4wz8WJAWiTRJve
    k9Jk8da1H7YYXAMXwecEt-kENWouf2s7N24_5Is_v-LY_sgVze9MXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtg
    hpthhtohepsghmtgdqshifsegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehr
    higrnhgptghhvghnsegrshhpvggvughtvggthhdrtghomhdprhgtphhtthhopehprhgrsg
    hhrghkrghrrdhmrghhrgguvghvqdhlrggurdhrjhessghprdhrvghnvghsrghsrdgtohhm
    pdhrtghpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruh
    dprhgtphhtthhopehjkhestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghp
    thhtohepnhhfrhgrphhrrgguohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhope
    hjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:p8EBaYFzyY_GprhtuwuqqyoQGyXV2LxZTR_c6AbyWPVI9ohsqpYnXA>
    <xmx:p8EBaROTWrCGhVE_WWzbSpg7rrjo7od7fRzKFUsvlIBN9LhKPMpGTw>
    <xmx:p8EBafe3D93GA74moCEijH_lAR59ecXpZKMWzZFAUSpvEgFT8KDxAA>
    <xmx:p8EBaWT1XfDyaIxoSFMXQslzpL37DWn7iZpL0U4ZpMTutgT1TyZBiA>
    <xmx:qsEBadd_JnlZak_WFppPr5HmGeD3gT7u-9W5pyEPYgCtBu2nPWMjPsTC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 81F87700063; Wed, 29 Oct 2025 03:26:31 -0400 (EDT)
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
Date: Wed, 29 Oct 2025 08:26:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>, "Andrew Lunn" <andrew@lunn.ch>
Cc: BMC-SW <BMC-SW@aspeedtech.com>, "Rob Herring" <robh@kernel.org>,
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
Message-Id: <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
In-Reply-To: 
 <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com>
 <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
 <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch>
 <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch>
 <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
 <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 03:31, Ryan Chen wrote:
>> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
>> tree
>> 
>> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
>> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700
>> > > SoC device tree
>> > >
>> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
>> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
>> > > > domains and high-speed peripheral set.
>> > >
>> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
>> > > > own clock/reset domains and low-speed peripheral set, and is
>> > > > responsible for system boot and control functions.
>> > >
>> > > So is the same .dtsi file shared by both systems?
>> >
>> > This .dtsi represents the Cortex-A35 view only and is not shared with
>> > the Cortex-M4 or the Boot MCU side, since they are separate 32-bit and
>> > 64-bit systems running independent firmware.
>> 
>> DT describes the hardware. The .dtsi file could be shared, you just need
>> different status = <>; lines in the dtb blob.
>
> Could you please share an example of a .dtsi that is shared between
> different CPU architectures?

I can think of three that are shared between arm and riscv, with both
able to boot Linux using a variation of the same device tree, with
the .dtsi file being included from the respective other side:

arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
arch/arm64/boot/dts/sophgo/sg2000.dtsi

All of these however use the same basic physical address layout
as seen from the two CPUs, with only the set of on-chip devices
being slightly different, such as using the native irqchip
instance per CPU.

> In the AST2700 design, even though we have both Cortex-A35 (64-bit)
> and Cortex-M4 (32-bit) cores, each runs in a distinct address space
> and sees a different memory map.

This is similar to the Cortex-M4 on i.MX7D. This is supported by
the Linux code, but I don't see the corresponding dts file for it now,
it may have never been merged.

If you want to share the devicetree source files but have different
physical addresses, you'll need to set up 'ranges' properties in
the top-level .dtsi files that map the child buses into the CPU space
as needed. arch/arm64/boot/dts/apple/t6002.dtsi has a rather
sophisticated way of doing this where &die0 and &die1 set up the
ranges for including the same child die multiple times at different
addresses. You should be able to use similar method but make it
a lot simpler for your case.

      Arnd

