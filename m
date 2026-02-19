Return-Path: <linux-aspeed+bounces-3527-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B035C531E1
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Feb 2026 22:55:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fH7yY69XXz2yrl;
	Fri, 20 Feb 2026 09:55:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771541749;
	cv=none; b=SFuwnxENHGSn3EV/FaX0KmL+rZV9D//jRqTIbQ68IjrkqPMTrU2be0t5lPzr7Y+wMt4AXHI6d5BcXIwlMxG9DWL0P/ErlA7u6IuS3Tbx/GeQhVbWFRiKJXEqGpAdF70pPZ4mdN//gvqH2Awn8EabDtye/Th+LbPJCt9Sgpey46xt2oLeKqjpCOT7XYQh2fvBgxuLiCJj1RfDAt1Qfv1VVUH9ZlQP1o8TMdNlMJqcimXgaO21v1dioXOswDC2sCl3kVp4yelsq6q0Ebkt9nt8BWSQdbak46NdJ4yOD6OIg6r6x5evlBq+nL+w8NtP7qn+sqXIJ4XgeeX6mKfMh9N0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771541749; c=relaxed/relaxed;
	bh=SsuYpqBzhHCrA5NOoErB6qWr93G3ME/F8oMqLaTn5dw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uzmo1LgKCRYa8iAmpaRBF/qET4ykbx2qeNy3cBZsO7Nl1mpcgrRBAhNOOrNt5Rr1ofWtyEtKh2cUr/rpm0JKlW/wg9hZmN6ZEziuPdFU786HJdVoh3muzTWnWNIOgAzshfUmhKAbLIzoOWwIJuMi/ib+4wua8L8Qusk1zaozzZOzPwe/LwMNQc1BHq4J5dzIkGnEFve0ufLWru+BVzzbEazVqUBSi9IrnraiuVURjV7hoddus4CGqXC6GWIAqWwvB25QdP5ud9f2X2UytkjaeMBWjs9vjRuYz4y4G5Wur48fGqCN+WlBB7uH1fQSG7yrvCRWwOXQPa8SCm8VNK/Kgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=UJ8Qx9VO; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=UJ8Qx9VO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fH7yX3Yzvz2xls
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Feb 2026 09:55:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771541742;
	bh=SsuYpqBzhHCrA5NOoErB6qWr93G3ME/F8oMqLaTn5dw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UJ8Qx9VOxZXNGx2/KPPqarJ91onDtc/c91tR9XStg93O0F1PqgJ+gMaRUYKw8KAG+
	 JdhtuaUIov9nn66tpAvtBOIVvSjTaj+LKGdUseStOl1nbaRROrZt+7HtHWzMmhwA2A
	 XNGS4Ynv4pnpbB03RKhnj3n4C0U1FVQ68TvFvkgKyYlDSn+eKuufiN9va4TuahBbUm
	 cC4wg9fuXIARy+r/3i0NWLUeLEBgqmWx20em5jd2a3xnIP4GJsh973uEurQUmSUEfp
	 v/N05EpZ+l4VNk/PtqsKQGzOhhAe11vAFRUAk/Id4QHlykWQyZ+vlGIAGC1Q1/VwmF
	 qHIPlrhpXS5eQ==
Received: from [192.168.68.114] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 08C16600E1;
	Fri, 20 Feb 2026 06:55:41 +0800 (AWST)
Message-ID: <7fb15c01c586fb7d4a3ee506b17d87151d50bfe6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Chen, Dirk" <Dirk.Chen@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 20 Feb 2026 09:25:41 +1030
In-Reply-To: <MN2PR12MB403103EC90C803E3FA6CE6B9E76BA@MN2PR12MB4031.namprd12.prod.outlook.com>
References: <20260209-b4-anacapa-dts-fix-v2-1-fe446a7038bf@amd.com>
	 <6192440acc150d216de5e074299e579e891fc845.camel@codeconstruct.com.au>
	 <MN2PR12MB403103EC90C803E3FA6CE6B9E76BA@MN2PR12MB4031.namprd12.prod.outlook.com>
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

Hi Dirk,

On Thu, 2026-02-19 at 15:54 +0000, Chen, Dirk wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

Please have a read through [1], in particular:

[1]: https://subspace.kernel.org/etiquette.html

   Do not include =E2=80=9Cconfidentiality disclaimers=E2=80=9D

   When posting to public mailing lists the boilerplate confidentiality
   disclaimers are not only meaningless, they are absolutely wrong for
   obvious reasons.
  =20
   If that disclaimer is automatically inserted by your corporate e-mail
   infrastructure, talk to your manager, IT department or consider using a
   different e-mail address which is not affected by this policy. Many IT
   companies have dedicated e-mail infrastructure for kernel developers to
   specifically avoid this situation.

>=20
> Hi Andrew,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 eeprom@50 {
> > Please order these nodes by ascending address. The node currently above=
 this one is i2c-mux@70 - eeprom@50 should go before it.
> > https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order=
-of-nodes
>=20
> Thanks for the reminder.
> I've reordered the nodes by ascending address in v3.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible =3D "atmel,24c2048";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D <0x50>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pagesize =3D <128>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0};
> > +=C2=A0=C2=A0=C2=A0=C2=A0 eeprom@50 {
> > Same for this one.
>=20
> Fixed in v3 as well.
>=20

Thanks,

Andrew

