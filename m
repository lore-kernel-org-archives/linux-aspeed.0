Return-Path: <linux-aspeed+bounces-3939-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE8F94CA1
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 17:57:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0VS85026z30Kg;
	Wed, 22 Apr 2026 03:57:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776794248;
	cv=none; b=bzP71221NK0s6wcQ3V99FpJpurjyjw6Km9z0OGgiFugYXuvRaJl0ZhazaSL7eNnesbklnoZba/msmvEbcYOess6RjAeJhjr8snWissuaPRX/2g3K6ZaUh7UjpS7PaizLp9PzoQ45MHS4LWTAxF3dm2iwOBZyFwSRkVAxzmhTWsS/tvbGU4Sst22RIUNg9bhJQF5PN9Cr9pp5aN93A+pKQ7g0h+cMSv36nXEIJtnEXqQP/0tz68Ymq+fg48mqgiBc3nKQ+4tuIrPAguZH+Px9z0KfGHjMxm3MRmNkKyOmTnQc8iyP9KW5/qN8HoyCJpm4BwKFYeNDIzv0DUM2HTcsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776794248; c=relaxed/relaxed;
	bh=dzRGwExDvSn0USCPgmwZ9kLflNT4n4wMtNTWealPhJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDCeRWNQ7iPMsADOmKYdo/cZnCqqoxlMMKEcdLAVqhn1wkq4a1O8mirCDzUPSLaSONdvnyxD24BfgFrm8Bbd7IEorMpH/KnlQGz4V6sFmsaqfjHV036p0petKJQrxdCEQ4qLpDFMHEa2X5ysuu66l6gJa/b3jMciSLB2EjtyzjCP+g3TXf3i9oqNJQ9aKvzCqYWZ5e2CYnLN1+dzWd5cWIvqKmnaxClhHY2QEOXcjNqKdwdmyfSf4n55pZhNGgGf4CEZ0SFSsd3aJW2sHtMoe4URtlVllhNFD2kg09ILfH5FwZf7HiYOEwjWT2qAXswohyp2sh32QbTQfU44vh86vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dgfqeyUi; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dgfqeyUi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0VS74BLSz30Jy;
	Wed, 22 Apr 2026 03:57:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 61B32418C4;
	Tue, 21 Apr 2026 17:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4EEC2BCB0;
	Tue, 21 Apr 2026 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776794245;
	bh=xPXf7LTENtfyjseOPX2ZzZFz4nnRhDy+MLhipzCmuqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgfqeyUiTJMOTd4FOP1xIgVEHIDDgHn26SLXHbyk2+09VFA/8aAuxEVwgfeDGCkUZ
	 Md+qmpTZmx21oSG82v6jjqSBIZk7nN+npw4mFcIy3sPor4SbI91HpVyIz5E3COfpmR
	 p97rSJ63+NqXvUwGmn1kUaw2q+d6Lu6cfGhanCVp7CtsR9sysh5BLa9hXcghjfwd1s
	 awKC4R6prDKFylGAbMBYlU23Fa7ku2Ze4u1gHMEaelP4QHjjtsmy6Mp/10uIRzkLg2
	 NQ8wTHO4szxiTvoFNJ0a0oDDGrW1ZnskidMTOmURswFQbe0gRE4764mvrs6LbKmJkM
	 QeRs1EtC4HN6w==
Date: Tue, 21 Apr 2026 18:57:19 +0100
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
Message-ID: <20260421-valid-expanse-ae6b5a9289f2@spud>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
 <20260416-upstream_pinctrl-v7-1-d72762253163@aspeedtech.com>
 <20260416-brutishly-saga-ba7168a4cd14@spud>
 <OSQPR06MB7252EB0C2A1A3313DE49406B8B202@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <20260417-anemia-borrower-fb90ac02b417@spud>
 <OSQPR06MB7252BD7967D2567AD6DA7A1D8B2F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <20260420-footprint-both-967ccd6c120c@spud>
 <OSQPR06MB725251546BFEB158F9AA1C4D8B2C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="e/yrNYrOHY6xz2Ct"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB725251546BFEB158F9AA1C4D8B2C2@OSQPR06MB7252.apcprd06.prod.outlook.com>


--e/yrNYrOHY6xz2Ct
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Billy, Linus,

On Tue, Apr 21, 2026 at 06:15:44AM +0000, Billy Tsai wrote:
> > > > > > > +    properties:
> > > > > > > +      function:
> > > > > > > +        enum:
> > > > > > > +          - EMMC
> > > > > > > +          - JTAGDDR
> > > > > > > +          - JTAGM0
> > > > > > > +          - JTAGPCIEA
> > > > > > > +          - JTAGPCIEB
> > > > > > > +          - JTAGPSP
> > > > > > > +          - JTAGSSP
> > > > > > > +          - JTAGTSP
> > > > > > > +          - JTAGUSB3A
> > > > > > > +          - JTAGUSB3B
> > > > > > > +          - PCIERC0PERST
> > > > > > > +          - PCIERC1PERST
> > > > > > > +          - TSPRSTN
> > > > > > > +          - UFSCLKI
> > > > > > > +          - USB2AD0
> > > > > > > +          - USB2AD1
> > > > > > > +          - USB2AH
> > > > > > > +          - USB2AHP
> > > > > > > +          - USB2AHPD0
> > > > > > > +          - USB2AXH
> > > > > > > +          - USB2AXH2B
> > > > > > > +          - USB2AXHD1
> > > > > > > +          - USB2AXHP
> > > > > > > +          - USB2AXHP2B
> > > > > > > +          - USB2AXHPD1
> > > > > > > +          - USB2BD0
> > > > > > > +          - USB2BD1
> > > > > > > +          - USB2BH
> > > > > > > +          - USB2BHP
> > > > > > > +          - USB2BHPD0
> > > > > > > +          - USB2BXH
> > > > > > > +          - USB2BXH2A
> > > > > > > +          - USB2BXHD1
> > > > > > > +          - USB2BXHP
> > > > > > > +          - USB2BXHP2A
> > > > > > > +          - USB2BXHPD1
> > > > > > > +          - USB3AXH
> > > > > > > +          - USB3AXH2B
> > > > > > > +          - USB3AXHD
> > > > > > > +          - USB3AXHP
> > > > > > > +          - USB3AXHP2B
> > > > > > > +          - USB3AXHPD
> > > > > > > +          - USB3BXH
> > > > > > > +          - USB3BXH2A
> > > > > > > +          - USB3BXHD
> > > > > > > +          - USB3BXHP
> > > > > > > +          - USB3BXHP2A
> > > > > > > +          - USB3BXHPD
> > > > > > > +          - VB
> > > > > > > +          - VGADDC
> > > > > > > +
> > > > > > > +      groups:
> > > > > > > +        enum:
> > > > > > > +          - EMMCCDN
> > > > > > > +          - EMMCG1
> > > > > > > +          - EMMCG4
> > > > > > > +          - EMMCG8
> > > > > > > +          - EMMCWPN
> > > > > > > +          - JTAG0
> > > > > > > +          - PCIERC0PERST
> > > > > > > +          - PCIERC1PERST
> > > > > > > +          - TSPRSTN
> > > > > > > +          - UFSCLKI
> > > > > > > +          - USB2A
> > > > > > > +          - USB2AAP
> > > > > > > +          - USB2ABP
> > > > > > > +          - USB2ADAP
> > > > > > > +          - USB2AH
> > > > > > > +          - USB2AHAP
> > > > > > > +          - USB2B
> > > > > > > +          - USB2BAP
> > > > > > > +          - USB2BBP
> > > > > > > +          - USB2BDBP
> > > > > > > +          - USB2BH
> > > > > > > +          - USB2BHBP
> > > > > > > +          - USB3A
> > > > > > > +          - USB3AAP
> > > > > > > +          - USB3ABP
> > > > > > > +          - USB3B
> > > > > > > +          - USB3BAP
> > > > > > > +          - USB3BBP
> > > > > > > +          - VB0
> > > > > > > +          - VB1
> > > > > > > +          - VGADDC
> > > > > > > +      pins:
> > > > > > > +        enum:
> > > > > > > +          - AB13
> > > > > > > +          - AB14
> > > > > > > +          - AC13
> > > > > > > +          - AC14
> > > > > > > +          - AD13
> > > > > > > +          - AD14
> > > > > > > +          - AE13
> > > > > > > +          - AE14
> > > > > > > +          - AE15
> > > > > > > +          - AF13
> > > > > > > +          - AF14
> > > > > > > +          - AF15
>=20
> > > > > > Why do you have groups and pins?
> > > > > > Is it valid in your device to have groups and pins in the same =
node?
>=20
> > > > > The intent is to support both group-based mux selection and
> > > > > configuration, as well as per-pin configuration.
>=20
> > > > > In our hardware:
> > > > > - `function` + `groups` are used for pinmux selection.
> > > > > - `pins` is used for per-pin configuration (e.g. drive strength,
> > > > >   bias settings).
> > > > > - `groups` may also be used for group-level configuration.
>=20
> > > > > As a result, both `groups` and `pins` may appear in the same node,
> > > > > but they serve different purposes and do not conflict:
> > > > > - `groups` selects the mux function and may apply configuration to
> > > > >   the entire group.
> > > > > - `pins` allows overriding or specifying configuration for indivi=
dual
> > > > >   pins.
>=20
> > > > > In most cases, only one of them is needed, but both are allowed w=
hen
> > > > > both group-level and per-pin configuration are required.
>=20
> > > > To be honest, that sounds like your groups are not sufficiently
> > > > granular and should be reduced such that you can use them for pin
> > > > settings.
>=20
> > > The intent was to keep the binding flexible, but in practice the mixed
> > > use of `groups` and `pins` in the same node is not expected to be use=
d.
> > >=20
> > > Given that, I agree this flexibility is unnecessary and makes the
> > > binding semantics less clear. I'll rework the binding to make the
> > > expected usage explicit rather than allowing combinations that do not
> > > correspond to a real use case.
> > >=20
> > > In particular, I'll split the constraints as follows:
> > >=20
> > > - For pinmux, the presence of `function` will require `groups`, and
> > >   `pins` will not be allowed. This reflects the hardware design, where
> > >   the groups are defined by the pins affected by a given mux expressi=
on
> > >=20
> > > - For pin configuration, exactly one of `groups` or `pins` will be
> > >   required (using oneOf), so that configuration is applied either at
> > >   group level or per-pin, but not both.
> > >=20
> > >=20
> > > - if:
> > >     required:
> > >       - function
> > >   then:
> > >     required:
> > >       - groups
> > >     not:
> > >       required:
> > >         - pins
> > >   else:
> > >     oneOf:
> > >       - required:
> > >           - groups
> > >         not:
> > >           required:
> > >             - pins
> > >       - required:
> > >           - pins
> > >         not:
> > >           required:
> > >             - groups
> > > Does this match what you had in mind?
>=20
> > It's an improvement I think, but I am wondering why you cannot do
> > without pins entirely and apply pinconf stuff at the group level?
> > Of course that may not be possible with the current groups, but if you
> > made the groups more granular, would it be possible?
>=20
> Within a given group, it is not always the case that all pins share the
> same configuration requirements (e.g. drive strength or bias settings),
> so applying pinconf purely at the group level would be too restrictive.

Right. That's pretty normal.

> Making the groups more granular to match all possible configuration
> combinations would not reflect the actual mux granularity and would
> significantly increase the number of groups.

>=20
> For example, we have encountered a timing issue due to the PCB layout,
> where only the eMMC clock pin requires a different drive strength:
>=20
>   # The EMMCG4 group includes pins AC14, AE15, AD14, AE14, AF14, AB13
>   # AC14: clock
>   # AE15: command
>   # AD14=E2=80=93AB13: data
>=20
>   pinconf_emmc_clk: emmc-clk-pinconf {
>       pins =3D "AC14";
>       drive-strength =3D <8>;
>   };
>=20
> In this case, applying pin configuration at the group level would affect
> all pins in the group, which is not desirable. Allowing per-pin
> configuration via `pins` is therefore necessary.
>=20
> For this reason, `groups` is used for mux selection, while `pins` is
> required to express per-pin configuration where needed.

Right, yeah, I figured your objection to it was because of how
annoyingly small it would make the groups. I suppose the alternative is
going without groups and always using pins.
Having groups and pins seems really suboptimal to me, but there are
some other bindings where this is done. Linus, what is your take on
nodes supporting both? I'm biased towards having a more straightforward
binding but if you think this mix makes sense then I'll defer to your
vastly greater experience with these devices.


--e/yrNYrOHY6xz2Ct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaee6fwAKCRB4tDGHoIJi
0noaAP9jYP09SYhW2PHzSVQFFiUEdcOsiFAlMGJHXxpV2+SxZgEAzvMeVc+SrBA4
Ker/dZO9rTEAMa9/23liJlGnUhKVJQA=
=BQ+S
-----END PGP SIGNATURE-----

--e/yrNYrOHY6xz2Ct--

