Return-Path: <linux-aspeed+bounces-3927-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B1F436B7
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Apr 2026 16:07:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fy0Bj6DN5z2xc8;
	Sat, 18 Apr 2026 02:07:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776442029;
	cv=none; b=kDx/n0mE3C6SrFNoP0vLUSDoMzV10YzVhUA5kp2rLTJddWEuGjK13ZsMPRgYWwnLiVM6MM9n8n4a8oYa9kcAYex0q8VoX8KLfSNEOf5p8N9kdJJlNyT+ddRSAFngU3Fh62jrobDbgof2nJDpNDUhoO1rUReQeljZB9EI3H0Y7zWW4EQLOzu4r6ZghnC3lIXegCPr8kwM4fWHX4FMTKyY//3U3p2dA55X7vuwDEYGM9xd2KFa5eENIdUlX80xad1wa6evtoO+ewhbcF1hUO6B/hVoeSyGLxSlKZjdogi0Z2ycDKnWmUc7s7W9QUfr0LVlKetN1VLuGRAN5ueZh+ZIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776442029; c=relaxed/relaxed;
	bh=UvuIXZik6kpoAEXpZUcN/K8sqk11v8tCmvkFFZ0Cz8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGJoI28o6WjkynKn5+EAlx9uvwGTIT7acDtO9x5L775mvg/6OrIC/F8l0kLipHcdQB97imlnw4USE+/OGm26eMmEms0TjVy/X/oqiy0zLDxezr8ed+46SaJm8VBVGJ48VfQ5QYVgQnevy+xBk6TED+BF37mjwLIvhqPQdG0GBo5+TM/h5rhC6ATmBBMBR6G8DYnwArDLHzDJqrXIElAbtRr5MqlQegDOPUDLJy5DqFVUriSMdcUJfB64Z0hXobLzKyW5JkwfruhD0i7cZub+XylJ4CeGSzRwMAskOiNLVVocdnqqyxe9SqhgZM3RSGmxPo+vRha/MxHOOJAl60wv5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O+ZilaRD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O+ZilaRD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fy0Bh5G72z2xTh;
	Sat, 18 Apr 2026 02:07:08 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E7894035F;
	Fri, 17 Apr 2026 16:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29ACC19425;
	Fri, 17 Apr 2026 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776442025;
	bh=NQgku0XmKRU6rgKiAn/DW7pVK31ikSdLl/YitlLG/B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+ZilaRDHbIpuk+btUy0PJqf2nDXeW9zyi9F0lc1bgO07JLLXlhdnIAxV0pt3QMbJ
	 OZFjEc0Y4ag0wOuAXrdgkKVpb+Ivj0UkYvf9rieoR7CGQXx1W4NmEtWs+AuaMI/nrH
	 hugHPhq3slfvFe/Yk0er0AkKjCzK1BYcR9U0RlhZmJAaDri7QRdLTGRBBGRu6USD84
	 HnJe9ERiefV9hM7c0qA11VHA8ZpivyLxv/QjHa5cMtcfm2Aico6mlC+UUyCPz/RVI5
	 dVsYHkDOne5Z1zIpQyWFf4YLtAkzqyKyOyVcKiyGzyaaZkpHkgMGS9qB/orNZUrrGG
	 8yLX+nhkmwKeg==
Date: Fri, 17 Apr 2026 17:06:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: pinctrl: Add
 aspeed,ast2700-soc0-pinctrl
Message-ID: <20260417-anemia-borrower-fb90ac02b417@spud>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
 <20260416-upstream_pinctrl-v7-1-d72762253163@aspeedtech.com>
 <20260416-brutishly-saga-ba7168a4cd14@spud>
 <OSQPR06MB7252EB0C2A1A3313DE49406B8B202@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e075MT9JwuwmUji"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB7252EB0C2A1A3313DE49406B8B202@OSQPR06MB7252.apcprd06.prod.outlook.com>


--/e075MT9JwuwmUji
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 02:20:25AM +0000, Billy Tsai wrote:
> > > +=A0=A0=A0 properties:
> > > +=A0=A0=A0=A0=A0 function:
> > > +=A0=A0=A0=A0=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMC
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGDDR
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGM0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGPCIEA
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGPCIEB
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGPSP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGSSP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGTSP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGUSB3A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAGUSB3B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - PCIERC0PERST
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - PCIERC1PERST
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - TSPRSTN
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - UFSCLKI
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AD0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AHPD0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXH2B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXHD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXHP2B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AXHPD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BD0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BHPD0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXH2A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXHD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXHP2A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BXHPD1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXH2B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXHD
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXHP2B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AXHPD
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXH2A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXHD
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXHP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXHP2A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BXHPD
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - VB
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - VGADDC
> > > +
> > > +=A0=A0=A0=A0=A0 groups:
> > > +=A0=A0=A0=A0=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMCCDN
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMCG1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMCG4
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMCG8
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - EMMCWPN
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - JTAG0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - PCIERC0PERST
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - PCIERC1PERST
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - TSPRSTN
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - UFSCLKI
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2ABP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2ADAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2AHAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BBP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BDBP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BH
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB2BHBP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3A
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3AAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3ABP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3B
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BAP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - USB3BBP
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - VB0
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - VB1
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - VGADDC
> > > +=A0=A0=A0=A0=A0 pins:
> > > +=A0=A0=A0=A0=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AB13
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AB14
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AC13
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AC14
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AD13
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AD14
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AE13
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AE14
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AE15
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AF13
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AF14
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 - AF15
>=20
> > Why do you have groups and pins?
>=20
> > Is it valid in your device to have groups and pins in the same node?
>=20
> The intent is to support both group-based mux selection and
> configuration, as well as per-pin configuration.
>=20
> In our hardware:
>=20
> - `function` + `groups` are used for pinmux selection.
> - `pins` is used for per-pin configuration (e.g. drive strength,
>   bias settings).
> - `groups` may also be used for group-level configuration.
>=20
> As a result, both `groups` and `pins` may appear in the same node,
> but they serve different purposes and do not conflict:
>=20
> - `groups` selects the mux function and may apply configuration to
>   the entire group.
> - `pins` allows overriding or specifying configuration for individual
>   pins.
>=20
> In most cases, only one of them is needed, but both are allowed when
> both group-level and per-pin configuration are required.

To be honest, that sounds like your groups are not sufficiently
granular and should be reduced such that you can use them for pin
settings.=20

--/e075MT9JwuwmUji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJaoQAKCRB4tDGHoIJi
0oi8AQDp1gAb3AolAjABIl6fBvoBypslFDHqFAcNj6E2DlBE3QEA6Q6j2LCAIPOl
0A+dbl1IvfSrQZC4005IZCZMYdRgOgE=
=ZteU
-----END PGP SIGNATURE-----

--/e075MT9JwuwmUji--

