Return-Path: <linux-aspeed+bounces-2703-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB55CCF9F0
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 09:20:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxz8w0kZTz2yvv;
	Thu, 30 Oct 2025 20:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761816000;
	cv=none; b=WjhjNW1xag45S9F/0k1xKg0v779VUr/Ow0sl56XyAJVpeAs5+KPo+l/KUqA4OFhe3MeWk91LDomh92sMf7EybLxl7E0ct5h30MGXylO1InLzlsTnyXYpVJx4EUhIE+2A2yHKMc+17dmLrM5SMmDEQDzqfSg8e0UqCrFariifvDcX/7aJDaigWuc0WYXYBgWxwsZcPkJPjT0sZFXPIBQKIwm3plG+x4AGjmd9UZZwr3omAeBum0smEMiOz81BpuVokhkWsTRk6BrGt3yN6l+urW5ikOGT2QYp2WVZPkIpaJK2tcyorrU0tjIoCDmzameSCMMjtxNFV+Ps0i7/wMZcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761816000; c=relaxed/relaxed;
	bh=Uh4NB+HSJVPCBBiBiBbt/42eb7P0NgKaMbg1S7YeUgE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gQUwzZnyrf5CPpsr46Ox6rF/OcRhYivKmxjyM70aba8q0G0LzlT8QxifONuIz9GPZwEEl7kIxb36Prw1QT3w3Gs3AVPExZgtmgbitfREQW9EfqdenSYCR5hAEejqVASGWjouEs6tdi987QWSnLz2DR+WGfyLapCR57upENW9RVYs/IFUYc9e9VN9vNGUwicDhvTbycr2EipzfkyJgxZ6lwD9YnoHF3pe+WXZEAyjVMv+C4NEbjVcPRHkgFZL0wV/5A6VsJ9mgTzxVv1RBobyvZg9F2OdkKFZxO7E9VmarEhLpOfe0FhWzjDR4fJ4GlnPzRoH594S0MksEw6J5iVWHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=A1tJr0FG; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=le9r6h20; dkim-atps=neutral; spf=pass (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=A1tJr0FG;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=le9r6h20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxz8n3H97z2yD5
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 20:19:52 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58B311400053;
	Thu, 30 Oct 2025 05:19:50 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 05:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761815990;
	 x=1761902390; bh=Uh4NB+HSJVPCBBiBiBbt/42eb7P0NgKaMbg1S7YeUgE=; b=
	A1tJr0FGfpT+KmteyW//kMW2zidPOy9N6MK8UwdeH9G1ob2S1h/C+tTMVI5vbs1A
	+Y9sf8W4H87k//ex0RjnDd53WyQds7gS5t4BXyTPiFF17+nuCgi+ayGjM041uIrX
	8dgGyRMvtw6JB86VUmT/SFVDI4roRViHPtXgC7UOAEnqb6hwDyqZ3MVYHuuf8OTL
	/vpSt8EwGYsVWliof3EAM8+th94kuFIT82K4c+NltOAkL0qKpl+LM+P9VfmYuKtg
	DbUGulT4QEp9njs7cnF8MKNaK6j4RGGoMA4t+14wC0dMfvCDKotxRG92trfVZ5N9
	1VK2OPB+o5e1q5e+mLT9fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761815990; x=
	1761902390; bh=Uh4NB+HSJVPCBBiBiBbt/42eb7P0NgKaMbg1S7YeUgE=; b=l
	e9r6h20JfPJuMtf+YWRuZuotD7GoYATTZK0VofffMwX+iiNRAHs4QfvO859ACsV5
	C8tnEUgD4RgAUhPhuVwxWt6DpxPZeEOQaQk3dAlMevEtTT+aBxfN5TtIY7o2Ds4q
	4yJYEiJ2m+uvuXEUzkCeuI+/6ZQF+H/xjSapOQzm+rNbn4zjj86KMovknoilnGyt
	4PzWQp51EP9iLua9rGvv0aUbq4wWDDZNmtjEJoQrhEddGLhFZ1NsyKiymU4453bV
	ZhprdwcNLFit7aJKqY8A97Ng7AfG1go2TBPQDs6QHwjL7Jl+c1COqR9o28RTfVro
	qZ5LUvwY55aC8Ip3XtcIQ==
X-ME-Sender: <xms:si0DaRrX5cYuLzX7twdK9rU0AVLVisa2isg9n3oBtKnyIeSIwsz2ew>
    <xme:si0DaefFpOIUhK-zVuC9GW-lD4K1owd9J32XB9ywQvDZc4AdhmWSGAkDHUYQkK1Gn
    2bL39JJhWIys530FqmhWLHRFRkzpWnDTsi8ZNhm3LzVXmzIYM0d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepteefudehvedutdeugfeuveffleduheehfeehffeujeduledvheeivdffleffjedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinh
    drmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopegsmhgtqdhsfiesrghsphgv
    vgguthgvtghhrdgtohhmpdhrtghpthhtoheprhihrghnpggthhgvnhesrghsphgvvgguth
    gvtghhrdgtohhmpdhrtghpthhtohepphhrrggshhgrkhgrrhdrmhgrhhgruggvvhdqlhgr
    ugdrrhhjsegsphdrrhgvnhgvshgrshdrtghomhdprhgtphhtthhopegrnhgurhgvfiestg
    houggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepjhhksegtohguvggt
    ohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehnfhhrrghprhgrughosegtoh
    hllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhr
    tghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:si0DaQa1jReZrdouddiXNT_gzDUZW4q2yvT-lhJogRueJkPC_Hp0sg>
    <xmx:si0DaW5-WcSf4fqmDeiP4dcJDGQf_x-CZESUKbFpNy6Mv9dVWcsf1A>
    <xmx:si0DaQ9gytoI1n2olJmnNXe9hDx-luLL7aJjq-_W84saiuW6LQi1PA>
    <xmx:si0DaYY11MBKdM2b9v8vPlIHfO130lzmuFSYnkzmlq8jV5V6z57RpA>
    <xmx:ti0DaYkAEc0OfepZSvvNm1L8UlPxSR9CldQXFiq5TDsCf_Ev2oQJCSJn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A59FC700054; Thu, 30 Oct 2025 05:19:46 -0400 (EDT)
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
Date: Thu, 30 Oct 2025 10:19:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, BMC-SW <BMC-SW@aspeedtech.com>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Jeremy Kerr" <jk@codeconstruct.com.au>, "Lee Jones" <lee@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
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
Message-Id: <80d0fb36-17d8-44c9-8941-0bac9f3b3ef2@app.fastmail.com>
In-Reply-To: 
 <TY2PPF5CB9A1BE68F47D7F3DBA2CDA2429EF2FBA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
 <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
 <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
 <TY2PPF5CB9A1BE68F47D7F3DBA2CDA2429EF2FBA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, at 03:30, Ryan Chen wrote:
>> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 S=
oC device
>> tree
>> On Wed, 29 Oct 2025 at 08:26, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wed, Oct 29, 2025, at 03:31, Ryan Chen wrote:
>> > >> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2=
700
>
> Thanks for pointing me in the right direction.
>
> After checking the TI K3 example
> (https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/=
k3-j784s4-j742s2-common.dtsi#L75),
> I see that all processing domains in that SoC share the same physical
> address decoding, which makes a System-DT-style structure possible.
>
> However, in the AST2700 design, the Cortex-A35 (64-bit) and Cortex-M4
> (32-bit) cores each run in a distinct address space with different mem=
ory
> maps, so they do not share the same decode view. =20
> Because of that, a single unified .dtsi cannot directly represent both=
 sides
> without additional translation or =E2=80=9Cranges=E2=80=9D mapping log=
ic.
> For example, in ca35 view uart0@14c33000, cm4 view uart0@74c33000
> From ca35 do have 0x7xxxxxxx is another peripheral decode address.

This still looks like the simplest case to me, where you'd have
a dtsi file describing the @soc0 and @soc1 devices using their
local addresses such as uart0@c33000, and a ranges property
to map it into the CPU specific physical address space, one of

	ranges =3D <0x0 0x0 0x0 0x14000000 0x0 0x1000000>;
	ranges =3D <0x0 0x0 0x0 0x74000000 0x0 0x1000000>;

to remap 0x1000000 bytes (16MB) of address space from local
bus addresses to one of the two clusters. This is almost
what you have, except you map an entire 256MB (0x10000000)
range. The exact size you want should be available in your
hardware documentation.

         Arnd

