Return-Path: <linux-aspeed+bounces-4570-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32931C53209
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 01:03:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7gMJ54fjz2yRl;
	Mon, 27 Jul 2026 11:03:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785114204;
	cv=none; b=UCumtF9h25L91Z5PAWiyd65/51kBR+0tBOcl0UJioP6jvW7Rso4K9wA/cdSmMOzdA1s9NnTqkm5Wmg6xRMi2w5AGTCS1KtCmEumKW9hXZwj+d+TnxtUgfBBsJ0zkbIYlrpAn71C0O5TyYBPBnt2RgkVmMhqXHU45W6WMT5ZDIJ+TZ7w5l4S3YrY05bX/Mt45wRRfKMavXpEAxB5noZr5hW0EgWPIdDXpl6jpNntc+eiwS1E64mVxfzGlMAi0dWkcJU+PemyiIvC5Butp8EedIaiBNFUkWObZHN87Vngg+DX7fu9/3lz6P3YjHbZTAYT93mK2LcvPj7xeTmGyx0JZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785114204; c=relaxed/relaxed;
	bh=B7xwk8bkofSoOCbb/Y0lzrdZi6QnX81MLwC2X54AVCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2WNeDaPb0ntUsdH5Ifyp6Xu24uAoI1a5LtkYpZqatW85YE0jcTf3eLU2F3MBB2sIiuBWiZyOBUDvTnWm4tOmQE5Z2O0QmokjtfL7JDTWfDVHgCK6uyAH9QRrD/qzofRIdc6TomGznCCt0qJWJvlq2WY645iBZWd4F2XTxQ4sC9WXgtJ3mC76TZM5aAgn+w36tjjsVUxGG6XcJAo7iTJF4kRvRWjGxjuQ9lsgpR2KlPL2jtAu1aytD0ZwQj1SoWZwRrFrTiXSxRV+BDbBPXc1oSW0Vmd9CRUKpIG2cJ7E9OlOxyV/i8Rx+V/8lSO+PS+qzSLuBv1nyDJKrnLbRixqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Gpcv1fUx; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Gpcv1fUx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7gMJ1VJHz2yH4
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 11:03:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785114203;
	bh=B7xwk8bkofSoOCbb/Y0lzrdZi6QnX81MLwC2X54AVCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gpcv1fUx1dQpgaLv2/ylGmzL11KKwB8+aZj1UVHoHzsW12u7dyBTA0zwniMV3chHs
	 wx+79Fo2H2ZEmvsxikEiZgOMbzNVhVnr0SapZI1oR1ntxsNvM7LtMxLk2kfdxanrtQ
	 Nm0DUJI2vMxQoy2B2ex0ATbPiIrSGWP1GiqD+/aubMAfBOKoSLs29VF06l536xKq/l
	 J/A9/16HKUrq105km+eyBNTHX4kxY6HZ2d7PVGHBVBQ2bO1uKcORTn8Wc+xhJpHrNE
	 g4stI0JzeaNimAQX5CfZUrNXF53LIVc/lE91MP+2m3HEM3A6oSyVZrVMZc5WHqfQ19
	 rstIY9+NTO5Mw==
Received: from [192.168.68.117] (unknown [180.150.113.112])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1C18A608E3;
	Mon, 27 Jul 2026 09:03:22 +0800 (AWST)
Message-ID: <ad836298ba3d0cf78d8b2a89692d81ad1caaba33.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed-g6: add pcie-kcs4
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	corey@minyard.net, devicetree@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Jul 2026 10:33:22 +0930
In-Reply-To: <CAFi2wKbNCVqZzApbG_xcDzyrN6yt_Wc01PVVqtPROcjVnp8hRg@mail.gmail.com>
References: <cover.1784732161.git.gregoire.layet@9elements.com>
	 <0b97a66762efc05c9073c14112cc489624871947.1784732161.git.gregoire.layet@9elements.com>
	 <afa321db51d5e6cc8e0c15badc7204faa0925251.camel@codeconstruct.com.au>
	 <CAFi2wKbNCVqZzApbG_xcDzyrN6yt_Wc01PVVqtPROcjVnp8hRg@mail.gmail.com>
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

Hi Gr=C3=A9goire,

On Thu, 2026-07-23 at 09:56 +0200, Gr=C3=A9goire Layet wrote:
> Hi Andrew,
>=20
> > > =C2=A0arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
> > > =C2=A01 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/=
dts/aspeed/aspeed-g6.dtsi
> > > index 56bb3b0444f7..a93fa4cf5d8f 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > > @@ -617,6 +617,13 @@ kcs4: kcs@114 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 status =3D "disabled";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 pcie_kcs4: kcs@914 {
> >=20
> > Nodes need to be ordered by ascending address:
>=20
> The existing kcs4 node is already not in ascending order of address.
>=20
> 'kcs4: kcs@114' is before 'lpc_ctrl: lpc-ctrl@80'
>=20
> pcie_kcs4 has been placed here to have ascending addresses locally on
> the kcs nodes and still
> having all the kcs nodes next to each other. This matches the kcs4
> node ordering.

Understood, however:

>=20
> If ascending address is still preferred, I'll change pcie_kcs4 order of c=
ourse.

My preference is that we don't add further style problems on top of
those we already have :)

Thanks,

Andrew

