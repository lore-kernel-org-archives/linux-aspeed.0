Return-Path: <linux-aspeed+bounces-3666-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A8107BCCC
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 16:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXVmy4Y8nz3cKQ;
	Sat, 14 Mar 2026 03:48:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773420530;
	cv=none; b=My1BBtFnQNNlYnpJfCy3x8dHwgXJofUQ6CRtjskMu5J69skqLDYZRNQRDN8+QS8byUq59pwruhNvu708/tly7WP9GFmUtCNnM54NffOjdIBKy/bzicqMEQeC97oiWbotsdegRePh0px1UffucD7zp0GtFF+fqfULenvuybh0Bc2Gsh1PatfHb/rwF8oyeqTE2UitKFDqtGm6yy0zi4yYGUdd7t2J/KcAjZcM25/Fsf6tH4GvKD2qDPuN+X7TTZnvc6Au925RzPggkghVmoAwyCtm8wsllrd/2QZybNVnYROIR2/FcGW49WvS2VB5G52UKUxUaGYJzUdw/AbdnzNhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773420530; c=relaxed/relaxed;
	bh=aCmb03AT0Z9uOVWvUD6gxDyM9KZ8csF4y3lfbWNQJag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4fFXaYWyFyTYQix4bFokIR1OTBfQUogSXd78ceF/hqR42rdDf7FYKEYRwj9mvfojO+fNVZ1TNYtJ9LhCvaLhf3y9ZNJMeFQW7vHjz/fqbT6k+HTdtGBCO3mao0kXJUFvtuPT8a8F0zHXLqi+ATCKhzPb7Pt3d37VVBkjovGpycmlSsIQw9H9Y89URCEXCIdgis0yT8MU76p+hbLR0gF17VPONDPhu/XFiMnyDIE2z0I2WaASQC6vUZw1vFAX3KJeP5pZhJlgQb0G4+DO14R3IPb5JW6HGhnCEpv9+EzGgF4u3VL3xMYxlGTbECT+GFBmF+Z38MwGc9es8vS5CIvmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sGt6Mihz; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sGt6Mihz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXVmx4vqdz3cK8;
	Sat, 14 Mar 2026 03:48:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 49E8F60142;
	Fri, 13 Mar 2026 16:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4F3C19421;
	Fri, 13 Mar 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420527;
	bh=OuMawjsTQP6cRs8Og0jene1oaf3BQHmjfu6JPCuI+qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGt6MihzN7ZITGSFxs3kQmaBpJSHcy2h7b/kBGbIrykgGW64Q7NwHNZx8gArniJX2
	 ch1szy2zLk4bRsr9AfJr7SWq5NNNaPcqfx/38ysRBN8TeyhONvikvoYPh0C9CkkrnD
	 acPFQDeVsCcqBHibaSQ/ioWYqfhmsIoO9s5Hrg0qoMa7nnbsCw0qVA4orbGD2YAWOn
	 5Bb+P3DFuBGlHsizaULb+8fPR6gWUjcbLAnfvqm9py5OWuvDihuPCoVmr9vM4+IW16
	 kediO84vA6SEq13UnD617uoU09BD04Lh5fq49icVt0jPiwGrhK4L4pkkhRowMjwobn
	 jFYVArGOWpfHw==
Date: Fri, 13 Mar 2026 16:48:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: aspeedyh <yh_chung@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	maciej.lawniczak@intel.com
Subject: Re: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Message-ID: <de40d5d7-2d2b-46a6-a725-c691005b63bd@sirena.org.uk>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <903bcc13-5b50-462c-8fa8-051f07748127@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="JTpyDRd0+0jBU6j/"
Content-Disposition: inline
In-Reply-To: <903bcc13-5b50-462c-8fa8-051f07748127@sirena.org.uk>
X-Cookie: Monitor not included.


--JTpyDRd0+0jBU6j/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 04:32:31PM +0000, Mark Brown wrote:
> On Fri, Mar 13, 2026 at 04:24:22PM +0000, Conor Dooley wrote:
> > On Fri, Mar 13, 2026 at 06:07:35PM +0800, aspeedyh wrote:
> > > This series adds initial support for the eSPI controller found on ASP=
EED
> > > AST2600 BMC SoCs.
> > >=20
> > > The series introduces a eSPI controller framework for ASPEED SoCs und=
er
> > > drivers/soc/aspeed/, adds AST2600-specific controller support for
> > > peripheral and flash channels, defines the corresponding devicetree=
=20
> > > binding, and adds the AST2600 eSPI controller node to the SoC dtsi.
> > >=20
> > > The driver is intended to support host-BMC communication over the BMC=
-side
> > > eSPI slave controller present on AST2600 systems.
> >=20
> > This all seems to be in the wrong places entirely, shouldn't an eSPI
> > driver and bindings go in the spi subsystem? FSL's appears to be there.
> > Mark?
>=20
> As documented in submitting-patches.rst please send patches to the=20
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

If this is a driver for SPI hardware it should be under drivers/spi and
use the framework there.

--JTpyDRd0+0jBU6j/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm0P+gACgkQJNaLcl1U
h9B1bAgAhjDExdU7nWhBppym32h9JFvlNIdUal4t5ZuJWbf/lg8HFHnKImexzapT
oqN8FEnJdxLhzctp0aZE6FFgGWBc6Qk6Jkv+WoSyp+sS1bLUHjiwJlh4ecwb2cVU
g4WdcDGRRhx1dQSz8TW8oO22pViEYB7Q2FKXQAcZ3LMqPJV74ApRW0tzit+Z4bQd
PIQambqXcdo93X4Q2o+wZVmwFeHbJ5vYIYYfleaW5jYK1qb1ONdAd4L+1L521cyy
M6SeYTGeKJQqoqYRkVZlQ63dxnzWgOtJ3QQ7xppqXAYZTOZPHSiW4T00XlKfpBRT
2CLzUfNjBHHo43MpAzeQghjxjs0t8w==
=Qtsp
-----END PGP SIGNATURE-----

--JTpyDRd0+0jBU6j/--

