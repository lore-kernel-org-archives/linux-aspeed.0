Return-Path: <linux-aspeed+bounces-771-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B548C021AA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 01:04:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyJ872BZBz2xCW;
	Wed, 19 Feb 2025 12:04:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739927079;
	cv=none; b=KrVGGd/J6kjdreOX+w3ri7q1nH2s/oWnGGhqGLjRsfzSE37yd3znIU4jna3DNwaYfcK9JoW4QaeoOBy50KGYobweiQEgg6mhXz2VzsIaUtONX4XngGTbCji5unjeEUKe+PQY/hSQ0ap5nn7Ud9cfFkqWnAD3O+k+vDFqGLpzviGnxGI/hNyjirvyYcTy2pRETDbX612478tBoZWCDb08jfRwOa4sYjrBr2jIydt7qCO+3XxD6txUNg7dvgpkkhAuLM+7ANBwPCDISGzvcjL6uZ7Po3w6JTMBQiPPv0X5hW6nkRkPXTLT5aP6SeiUTna3R8cxDKubBhYeOI6s6OSU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739927079; c=relaxed/relaxed;
	bh=exNED4G2Car6wsxXN9whsq4jxw9tN1sQJRhqHQV+x+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3waNhGPoUuAtZAGyYGUUAxX3cIYMXoNzPc3AHNB0VYmFd9/65FOSIXoUy2FHs/mLn9S13BFfNcKX5Ot6w6sospk2b24EocdfL+Bcg1d4FUVzMwulaFvXqQfBdjnVW/mmD89j+0Yh6jYqTcbyJFSqoZ1dj9tPgpCkPgCBQsPRrB22ezl9iFvQU7y2MoITQ1ExEUkr/yPs/79zNFgFObGdbV9/sw6/HHbzbwVV9KhBez98Kik8SsTrmWrcdjxVCyOIU2QzjzvnbjrHIfz2jNC4mieQu9thwg26xPJ2K4n4VLQ3m1J9fFXnF9mNxJU3bb4ZSq/XkGUHpnXfg9EjTBE5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ck4KNK93; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ck4KNK93;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyJ861C8wz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 12:04:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739927074;
	bh=exNED4G2Car6wsxXN9whsq4jxw9tN1sQJRhqHQV+x+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ck4KNK93oNFOKpL0t5ECzFTFAm6r2CgNMF/Tb2zwmGPh+HR2xnErZiTYVLNQdKXgL
	 b9boyAHmUkwvivRGZstj7UDqgmciRPlIeOtoimn3N5XRZQ6R9oBC/M0ly8Sc4ufX5l
	 iiiJ5a4lHOH+MruCaCiyuLeZVijM6HV5+Pg33m1vdW4PDBYkBQrD/Wo08jABrGmPCY
	 PWJg87ONt1ShjPxtzyysKYv9nhK5UScccXz6DNKMPRPZhquFavdn9I6NnhsNA3ixmE
	 1abdUpm6UGviduDtzScA7R5JClHHRENS8TC1ThX8eHK0db+PRcKwQ7Naofn8YS3cQ8
	 KFDL8tsJqlCCA==
Received: from [192.168.68.112] (203-173-1-6.dyn.iinet.net.au [203.173.1.6])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CF2B976191;
	Wed, 19 Feb 2025 09:04:31 +0800 (AWST)
Message-ID: <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>,  Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>
Cc: "tomer.maimon" <tomer.maimon@nuvoton.com>, Krzysztof Kozlowski
	 <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>, "robh@kernel.org"
	 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org"
	 <conor+dt@kernel.org>
Date: Wed, 19 Feb 2025 11:34:31 +1030
In-Reply-To: <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

On Tue, 2025-02-18 at 11:11 +0000, Kevin Chen wrote:
> > On Mon, 2025-02-17 at 13:00 +0100, Krzysztof Kozlowski wrote:
> > > On 17/02/2025 12:48, Kevin Chen wrote:
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.parent =3D dev=
;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.minor =3D MISC=
_DYNAMIC_MINOR;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.name =3D devm_=
kasprintf(dev, GFP_KERNEL,
> > > > "%s%d",
> > > > DEVICE_NAME,
> > > >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0pcc->mdev_id);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pcc->mdev.fops =3D &pcc_=
fops;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D misc_register(&pc=
c->mdev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "Couldn't register misc
> > > > device\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err_free_kfifo;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >=20
> > > You cannot expose user-space interfaces from SoC drivers. Use
> > > appropriate subsystem for this with proper ABI documentation.
> > >=20
> > > See:
> > > https://lore.kernel.org/all/bc5118f2-8982-46ff-bc75-d0c71475e909@app.=
f
> > > astmail.com/
> > > and more discussions on LKML
> >=20
> > Further, drivers/misc/aspeed-lpc-snoop.c already exists:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D
> > 9f4f9ae81d0affc182f54dd00285ddb90e0b3ae1
> >=20
> > Kevin: Did you consider reworking it?
> Andrew: No, I do not rework it but add the post code capture driver
> using the SNOOP registers. As a result, I add some code in
> aspeed_a2600_15 to check the SNOOP enable bit. PCC driver probe abort
> if snoop is enabled.

Hmm, I think OpenBMC's history regarding POST code support caused some
confusion on my part. For whatever reason, the snoop device was used as
a source of POST codes despite the existence of the dedicated POST code
hardware since at least the AST2400, but...

> PCC is used for port I/O byte snooping over eSPI.

... it seems that they're largely interchangeable, just with different
hardware features (PCC has DMA)? My impression is that the snoop device
could also be used over eSPI?

>=20
>=20
> >=20
> > Nuvoton have a similar capability in their NPCM BMC SoC(s) with the
> > "BPC"
> > ("BIOS POST Code" controller). There should be some consensus on
> > the binding
> > and userspace interface.

This is still the case.

Andrew

