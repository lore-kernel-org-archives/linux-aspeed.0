Return-Path: <linux-aspeed+bounces-4519-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0501EC44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 06:57:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4lSM1XZKz2xJT;
	Wed, 22 Jul 2026 16:57:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784703459;
	cv=none; b=cP4OPV78R2oB11omVOJaP1NgJx3vB6Ns8UhVDzNqGf5k5roeVQ9dbF8Gn2rDbuV7U35gkqZhz3OcS3tOXuzUNzW1M2qqGeToBIWFNDFcGWM5l2j//FINGQCSMeeargnd2krZSzAvQSDJ8fCqy+WKAmcDDuM0EeklDy8PO3XlxsADzj8lkp9s/vOP6hkoByMvQ7liiz3oXtb+hq09gHRWCoDfMzBwTTLxaR031evgHpWHffS0NEiGHP1BCL2JSUTvdqIjwRk0TGBrwPfiP77eUqsIP7m96a3R3IxmKZoEd7XIHfZMJm86FaEpjtgr4JWBuIGg36g9p3KTMfDNOF7IXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784703459; c=relaxed/relaxed;
	bh=t69esuoTm8ZiigYmH0W9OwN5SLE48ProuPEFU1h70Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+9hrLcHcnuB+DuVsWNPGH3NifXNVaBoIMeBeTAGIU/RePsAHXo74vqh0L75K8kwKFkW+xO0LyymItF3MnzBMKntvpttQV+aR3fDYHw0ep4XRSrC/y2v8aN8mYLm60ORFY9c3uDMDKFhBbQPZr6SKiGP9137hFW6tQ4PQYWo40q/R6r02Vl20eW3nvIW62OtePW0dM82NJoXirRR+juuIWOXmEIZ8BZzdxwB99Ta+OT1sPTWuZoXqrBDbn3roIEcS4GLjgs9dA1szKTFwGzV+cmWQbhVxwfErCTLKFgpKA7HI20ymcLBUNwx1TNRpiYAHXEqUKckU5LGyeuk8Mzjtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VlKnkFNS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VlKnkFNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4lSL46fxz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 16:57:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784703456;
	bh=t69esuoTm8ZiigYmH0W9OwN5SLE48ProuPEFU1h70Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VlKnkFNSMzNwJ1NEw/5K6SZv0DJGDfuqo7QkE34qxjY0zwrVWXulDcxJtCpI5sl+b
	 cHFKeuj0U+6Kii8obQ4JOGcuD35NyZq/n9zQfXG9j/MWp0rYbKxYKmGhVefTvFWt+n
	 G2wfBzzA8/t7bcWy8EFSft/8sUCdqK+M9Vk1YbAjQa++Z+MWBpYqEZrOVxSGl1Q0mB
	 Mn/lFxx8OBUVOllYjouKzifXBXoDoUvYUYKJftQjY2m95rhH4n2nSEWy3lXCK9p2sN
	 9PBeh7Ggxcf0xaoj1K/KmFK8eX7P8n6ExypX6nZR2y+RkfkgBWuDJ1N8rUZU2H5y7B
	 ZIp2MIUo30cyw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 70C4465B37;
	Wed, 22 Jul 2026 14:57:35 +0800 (AWST)
Message-ID: <793ccb3b7af22f6f38ff6544ed633b7800ea68b6.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed-g6: add pcie-lpc and pcie-kcs4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>, Tan
 Siewert <tan.siewert@9elements.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 16:27:34 +0930
In-Reply-To: <CAFi2wKZrya6aHAN9Wtwk43gqQTMPp1BamM9VKKQ+iH1UPzr4HA@mail.gmail.com>
References: 
	<de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
	 <178412588365.243141.16731478852761544781.b4-review@b4>
	 <CAFi2wKZrya6aHAN9Wtwk43gqQTMPp1BamM9VKKQ+iH1UPzr4HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Mon, 2026-07-20 at 18:31 +0200, Gr=C3=A9goire Layet wrote:
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/=
dts/aspeed/aspeed-g6.dtsi
> > > index 56bb3b0444f7..ac351f01048f 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > > @@ -658,6 +658,21 @@ ibt: ibt@140 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_lpc: pcie-lpc@1=
e789800 {
> >=20
> > lpc@1e789000 already maps 0x1e789000-0x1e78a000 and 0x1e789914 falls in=
side it,
>=20
> I agree that there is an overlap in address space in my patch.
> I will fix this in a new revision.
>=20
> > so you're describing a second `ast2600-lpc-v2` node which is unnecessar=
y.
> >=20
> > Suggestion: Merge pcie_kcs4 into lpc@1e789000 and use 914 as offset. Th=
at way
> > you don't accidentally cause an overlap for the devices if you describe=
 more in
> > the future.
>=20
> The 'kcs_bmc_aspeed' driver has the kcs channels address hard-coded.
> If the 'reg' property does not contain the three addresses used by one
> of the four channels, the driver returns -EINVAL.
> So having a pcie-kcs4 with regs 0x914, 0x918 and 0x91c doesn't work.

It does work if you fix the driver to allow it.

>=20
> This is why a second LPC node was added, for the pcie-kcs4 to have
> regs 0x114, 0x118 and 0x11c;
>=20
> I know we should write device tree sources based on hardware rather
> than around driver limitations.
> Changing how the driver behaves seems excessive for supporting KCS over P=
CIe.

I don't think this is true.

> I think a point can be made that the LPC over PCIe is a different LPC bus=
.

In my opinion it's most helpful if Table 8 in the datasheet is used as
the reference for address ranges in the devicetree. With that in mind,
I don't intend to apply a patch adding a new node as you've proposed. I
suggest adjusting the driver to identify the X{{I,O}D,ST}R4 addresses
as channel 4, under the existing LPC node as Tan suggested.

Andrew

