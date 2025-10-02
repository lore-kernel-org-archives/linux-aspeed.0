Return-Path: <linux-aspeed+bounces-2383-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AA1CAC5B0
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Oct 2025 18:35:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cd0pq6H3cz2yqq;
	Fri,  3 Oct 2025 04:35:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759430131;
	cv=none; b=arenN9n/Z4A1+xWH/NwobTz7HMP+HQ1zyNecUXk54/NEQ367vI8uqiZ5Ol0QN1eN9pQ32aLnwl6KNmy4OjyoKEs+8xv3/P+XdSeuJ2AtvkfzFdRnMu7hDrZ8zssXBGslApA7ICOnVIGzi/osX1aEgub1yKuo6GDnt47X0X2px4A6zcOkt5k7ZbGqY/NJvSIEb6GGeR1DvQ6jxGrtCeFjI7lfRBVisSB5JZVzeOMhl7gX3LjsIumwm2SNkV+6X6ES+vPG7vdzsGwOZd0ViRD/0SAKmxoNfsh0Qa23M+RrjLdIe+L7C/DUs44yMYxE//j6bB2rTpX/BDQ9powLL+lbog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759430131; c=relaxed/relaxed;
	bh=PO1LnekXZXs5OC6s4+89X/AETD36EzX1wvYZOnIKT3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0KxRvR5PoIuY9OvC0Ug+66CLRfkML9pAN2ebOiKwnIPPliWjoBm8dvUg+xjikU3Eqvu6MV5b41IWPWAoX8FtdAsEjCETrsrXiZM/8iCLCqo1/oHE/wxmPZBg/7kpjpWLfOe+KGgKY6AzrWjxiX4xu5NNpIwcDvAvP9YYwpk9/Ts3Wq20HrfATfuoRQLVpErrWoSRLSRkG1zo784/ETFYxm26VBZ12i/lSQoU11jPizg7KKxcXXdtrOHCjIEx6FS+o34z7jTFJouW5W87n/+Kq+BC2ZRCIUKxgs6tVQRIPar8aYJ4FT55sPYhjD2U7JaFXPNa59eK3da2HEI1BAJag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t08FxlBe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t08FxlBe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cd0pp0z5Tz2xnt
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 04:35:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3636D611BD;
	Thu,  2 Oct 2025 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44C8C4CEF4;
	Thu,  2 Oct 2025 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430125;
	bh=zHJ1GL2dHHNTvje7wfAsF9YbHWtTxN7jX71+3I/wsHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t08FxlBeAOkMnjhbkf8zCIx5OpnQBktugZTsxCd4Tgd6msXMaoGiYZNwwoXi/1m08
	 EycjQh3GLFu5QzD1tlYBZKlY2QpP0xmjwRFgherDKSmdu2nq1v0ymqW5GIxx8CU6Xx
	 x8qgVnGh4GZJumMlTZJtQuDdSjFYpFMwGS+BthR4QsoNAiJmXTq3SlHllrB8yGtxDP
	 tnSKBW9gQsyPA+HIpWpGtAcY+1qWOUZcmsVztryCEIYrwYkHyqRn9zCLUW6xDhTHkE
	 AmReNgMl4mIkh6TfSolIRy4+aKZ/hKgNGHuNKnaRegTr6pXt1FqUxe0SAwXoyimlKf
	 dHfaDyEh4Q/fQ==
Date: Thu, 2 Oct 2025 19:35:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Amithash Prasasd <amithash@meta.com>,
	Kevin Tung <Kevin.Tung@quantatw.com>,
	Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Yosemite5 board
Message-ID: <20251002-outmost-epic-9cb3bab4d352@spud>
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
 <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com>
 <20251001-bonding-surging-af8cd0d09e07@spud>
 <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="y+7trX4Eurr9Vg9P"
Content-Disposition: inline
In-Reply-To: <CABh9gBcKt1zqvMQ=390HESPR5KrA42jaMFj9Ca4qmeS0d0ToAw@mail.gmail.com>


--y+7trX4Eurr9Vg9P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 12:23:47PM +0800, Kevin Tung wrote:
> On Thu, Oct 2, 2025 at 2:33=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> > > Document the new compatibles used on Meta Yosemite5.
> > >
> > > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> >
> > You've repeatedly ignored my ack, so I assume you don't want it.
> > Maybe you want a nak instead?
> >
>=20
> Apologies for ignoring your ack repeatedly, that was not intentional.
> I truly value your review and will make sure to include it. Would you
> suggest that I send a v4 to pick it up, or is it fine to carry it
> forward in the next revision?
> Thank you again for taking the time to review my patches.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

The maintainer will add it when they apply, there's no need to make
another version for this alone.

>=20
> Kevin
> > > ---
> > >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml=
 b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175=
e109a78d931dffdfe28 100644
> > > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > > @@ -89,6 +89,7 @@ properties:
> > >                - facebook,minerva-cmc
> > >                - facebook,santabarbara-bmc
> > >                - facebook,yosemite4-bmc
> > > +              - facebook,yosemite5-bmc
> > >                - ibm,blueridge-bmc
> > >                - ibm,everest-bmc
> > >                - ibm,fuji-bmc
> > >
> > > --
> > > 2.51.0
> > >

--y+7trX4Eurr9Vg9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN7F6AAKCRB4tDGHoIJi
0sRwAQCwFXlCkLmxyD0w0Te9XN21MKFsXX3OKi+6iraKLaemqgEA9P77/sCLgfDi
ArNrGiKmZ7zFrzI9JsZPFV6Lu0VuBwE=
=wXDY
-----END PGP SIGNATURE-----

--y+7trX4Eurr9Vg9P--

