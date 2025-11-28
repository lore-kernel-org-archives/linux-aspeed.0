Return-Path: <linux-aspeed+bounces-3017-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C1D116E2
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Nov 2025 17:32:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dJ0jX0K4nz2yG7;
	Sat, 29 Nov 2025 04:32:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764351135;
	cv=none; b=h96qXW/LcitXYsniMH3c3mBxwPbFnIDKcJj05img6V3Sw+xawrTZpJVnsfoZEnzucir2HQqVNUlZFPnktor8b/YZCRdKihx/G0uE7vS3XkLw7qUyZBGDLkBXGO1f2mOBTtjn01Ggy6dTJ4aZ0DK/FMngLOqVwYAw2/QwdUWCwOsdB2f3msV5VNjY8VqKsiMq5fw91hy6W0Ft3yB3ZmLzOc4Rugi/hSS1xitVKEYJMcnF9QxHFwQU+tkhI3mIQZ9QiGBbvJW3PEnEqsbRq/z05eL7PmO9XN5mlVYd5cig+KTS2G5wiGtKxED1b4SEdB18weXsuYATYwNtu076h+4WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764351135; c=relaxed/relaxed;
	bh=DXtdLdYNGI2Def47xLdO+K+KvZUz52lKdw1ZAleee5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB6ctYBGP0OaEFoowzuQ/292OTSqxBpEb4ytZodqOt1/aOEHkhYaGzLMWeDEeIOgO6qs3NSMF6uPDdA48SykrcvcZ/VyHF92LfRrCuufPJ+jX+fHDX1aOnqbiuY2TEjzY8f7dzCb1qyymcAxFB1qKaKwCpS/h/j0KNTwDH/F6i2zlE0Wv0UBWJRCzcUigNUo3nfS1stP8cAjYNC3kXMq0CxURz1LYmRD9mfv5r3SvAfomq3q+A3h4b8VUzgylogqFVG0QdWn+sFcTbleEbj99YuUN1Fol5x7XAXReswYCwVcNONucHKCE/waOj8oyzmqwrMu2LNgWAlnGQrbzAQfFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dYkSpEqa; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dYkSpEqa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dJ0jW036gz2yG5
	for <linux-aspeed@lists.ozlabs.org>; Sat, 29 Nov 2025 04:32:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C5FB560125;
	Fri, 28 Nov 2025 17:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C628EC4CEF1;
	Fri, 28 Nov 2025 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764351131;
	bh=DXtdLdYNGI2Def47xLdO+K+KvZUz52lKdw1ZAleee5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYkSpEqaLqnSBU6hF/5r6RXEsVVv5oXSmgzA8qNIH9Fn1IBazC9GKCNNXu3o6nbjM
	 mN8A+4UefvGHlGZG6yDmLE6EV/tKM0faRfVmKcw01Z4KRYVy1d9Q8bHRCdaNvZ2AMn
	 kjId8/Wqf2dDVWYrgRNTbeeZvlPSY3/3J3GSiaQ9pwebN+K/859W0Q/5Hu1M1CNLph
	 4pRhmMizHErz/2hqh8Z238J8fb9mkTwDKyFaud4dOg3SJSlx875Jv5YnqMl7qo1WJ8
	 ZKAXDbBGG7ug66gJLSVIF+7p4BNrbzSvPwvgum0Uvdnk2OPDDRHVVbn+RyJ3rwy+En
	 Jbr9/wLCexsUw==
Date: Fri, 28 Nov 2025 17:32:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
 support
Message-ID: <20251128-ajar-headcount-a8589beec00c@spud>
References: <20251128-upstream_vhub-v2-0-1fa66a5833c2@aspeedtech.com>
 <20251128-upstream_vhub-v2-1-1fa66a5833c2@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="PTCSciaf+pNNOYVt"
Content-Disposition: inline
In-Reply-To: <20251128-upstream_vhub-v2-1-1fa66a5833c2@aspeedtech.com>


--PTCSciaf+pNNOYVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 08:27:30AM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-usb-vhub" compatible. The ast2700 vhub
> controller requires an reset, so make the "resets" property
> mandatory for this compatible to reflect the hardware requirement.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--PTCSciaf+pNNOYVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSnckgAKCRB4tDGHoIJi
0lyuAQDcadUyChIKt4hLNny6wAUoqQNARS1SLjiQFJLqGfv2rAEA6tf88roWmvmr
QQPQ4wsg2bKnhY9WdzB5cH62ydNRGAc=
=yqmb
-----END PGP SIGNATURE-----

--PTCSciaf+pNNOYVt--

