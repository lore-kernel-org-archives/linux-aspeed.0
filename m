Return-Path: <linux-aspeed+bounces-317-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F03BE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 05:14:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRzjz2r0tz30gL;
	Tue,  7 Jan 2025 16:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736226855;
	cv=none; b=a8Q9d0RLY70AQZHHqp1HNl2Be/YtVditwGgtxQa/nSRAaY8UZyhj3ZwIwpzPk2pCzyZgww4qNyn1w6WY52Xak1w28vrNY2zDbEDvc12W6CCzVanfhLBPWpRa0JylJX7GDre7YWffJUm5WJxmPJ5QPrO7MyRcO2IkHpFbaEHiDC7JqOnUlULVNCKegNwGSr9E84Agc0lrWUuUM2vx6HHc4U4XwKbXzNDObVyLtf17uufLMEZMq1ELTep/NcW2qkhvSx9lsewhgf/I+r6MId1S4qn16o5jb6tGjkA5Fpcs9FYzi0Lhsr0zvXP38cCuFwUHnQ9pj+L9MT7vTO0vJg2VDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736226855; c=relaxed/relaxed;
	bh=hzRoupXZ4+IZGUpiLX6vdlDEZbnyuwWKW3dVF+1lsIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orDZ+KC1Z1DcS5CRzy8c73+jsAOKrXGKJUmTN7CaYZP+GyAaJ5lzF7gwoOQD0PPwiyGRfQ2DPAlS+/DuA/QSAvgI3TV+j25wwXKBF956e5h7QcIw82NsgpnStgxVTi78BHYqJZtV5fnXQQxREhQ23F+j6d66XQPWIobx/3I75qTbhGDt5VQRbmZXjJWZGgtWgcKl1gE1YGFm4CVPNKPFnqdvdmIcodXj+kkv10nhKgDMFVOznZ0gq5s8YAUnBMb0dxwRhZ5AX2RxqzDh3Toeq+XoZaORTUA8fx7EjsfWZckE6rJ1bwmdt03GORmvEiL499r2mIdraMBKsfhcf2e0LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=g0uRxe3o; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=g0uRxe3o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YRzjx5xj3z30Wq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 16:14:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736226850;
	bh=hzRoupXZ4+IZGUpiLX6vdlDEZbnyuwWKW3dVF+1lsIQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g0uRxe3oZ9kVG6R97JEPeWJAD6EBQtw4XMiPFxloHNjHix8mmHyCEN+hG/1Oztt/r
	 g24R8bAD2QNK83Xg/SMS4Ziu7xAbihbQSyYemEtBc8y2qBhPIwr5nwXp2lUtNVUsu5
	 2rMrinfdDzJJs9pzk2x0vhKV0eqAuCm+A/PWt4xdCfQWVCWc1exK37goYEB8BikR+h
	 C/DttU+dg3ytvAVWw18oG65pvhvc9dvXTlgx2HVyRwZReiBNpZLeZCdUQeJaqFObf/
	 s38E5/mSVm2DZr+6vCGgWjF58o9pw4tdlsuAp+eeH+0pdNOyzHmeE6fuppva3timWW
	 j0Il4p+5/mneg==
Received: from [10.200.97.88] (203-173-1-122.dyn.iinet.net.au [203.173.1.122])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1ACBC706BE;
	Tue,  7 Jan 2025 13:14:06 +0800 (AWST)
Message-ID: <e3279e0c41259f165a0cde0195b196f416ac566a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite4: adjust secondary flash name
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Tue, 07 Jan 2025 15:44:04 +1030
In-Reply-To: <20241218212458.3050775-1-patrick@stwcx.xyz>
References: <20241218212458.3050775-1-patrick@stwcx.xyz>
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

Hi Patrick,

On Wed, 2024-12-18 at 16:24 -0500, Patrick Williams wrote:
> Meta (Facebook) has a preference for all of our secondary flash
> chips to be labelled "alt-bmc" for consistency of userspace tools
> deal with updates.=C2=A0 Bletchley, Harma, Minerva, and Catalina all
> follow this convention but for some reason Yosemite4 is different.
>=20
> Adjust the label in the dts to match the other platforms.
>=20
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts
> index 98477792aa00..e20816d9e077 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -112,7 +112,7 @@ flash@0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0m25p,fast-read;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0label =3D "bmc2";
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0label =3D "alt-bmc";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spi-rx-bus-width =3D <4>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spi-max-frequency =3D <50000000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};

I'm hitting conflicts (?) when I apply this on top of[1]. Do you mind
rebasing it?

[1]: https://github.com/amboar/linux/tree/for/bmc/aspeed/dt

Andrew

