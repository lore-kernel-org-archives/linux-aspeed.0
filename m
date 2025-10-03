Return-Path: <linux-aspeed+bounces-2394-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5254BCAC5B0
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 20:50:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdgmM5w5Wz3d9W;
	Sat,  4 Oct 2025 06:50:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759524643;
	cv=none; b=YlqNd55Me8jKP1tZJcxlYYgqFAT6xn1Ews/SUHM74xaTtXWlTc8UGxBfcZ6yFnELuPz52vPhqjOoKhcFrGB5AkPyhl/PxeRWYGqAfXWRtgLy6NsgYriWXX/Fp6CDNKKPQYucR/zts9EHlDE3YfYH7zwC9cf673U+Q+3zCQBfeEys7EO3dNXo0UjStxrZZMvErpFO3iZ+1iShJZuV518XNBAHhe3oInzlq0US/hqRBt7Ao0FlW4CmLeKZ9kKsLmQ7lj4gq9JT8ptc3wi3mdyB3YsLWb/j6QW+1IXv6fwc/SQH+0fLii4B+39PStmJ+nI0MftvXqT9sxqOL0PfeNA+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759524643; c=relaxed/relaxed;
	bh=hPeMK+aPi3Ea6pKnys1Zt7heTc1Mex9kTE3qfEXv6vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVu5qrptINYfkTj5DzPSTh3rfx3UdBzJNI59nc/Bd+jJtm4HNNEENS1CkcXvbgxpyxLho0FPFWzZ5VkoEAVd4NUZFmFpLdyf+UhAv+HS3ZeOhkcXVaigA+PaHFKGdSH8FHkX6MQ5RQuznLUeFa1J0adlpt757c+d5F1hYZMleMh6Pk/dd1B9DCdCIQBXuZsGo45Y2RMj+GhxmTVnRi+hRyJbbbvCbIOcMJVHUdw/8NORc090dyqo2q/pEDZe5jwHEKAdQYwgb/z8chdy2XwqGyBtEq8vFu7WtYtsd4OaQe2PrQl5p5JyXgiTs6hwZOMT6cQAgezZl9Dy2AYBBLOMXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4enKN8j; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N4enKN8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdgmM22fjz3d8S
	for <linux-aspeed@lists.ozlabs.org>; Sat,  4 Oct 2025 06:50:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 51BCE61FAF;
	Fri,  3 Oct 2025 20:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7FC4CEF5;
	Fri,  3 Oct 2025 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524640;
	bh=1p94Kd/jPrr2ZswfHfsej8PaEZcEH+oj56Meu5Y2CAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4enKN8j2eK1CuI01fDM+arTXjdajKM5HCHwySG5f+hXMd/308SPC3ZKY+m6hNJIn
	 rj1I1cP1ma/1XbdRYYoKhtL3/WAFyYK9PlKxHPvi8YXtKR3g4C8pO96B6ICtkj/3j4
	 fZVMVsb1JIlKqs9WL2yWndnGpXEJc4Ch+t7KHUiWtyPtfiLKw+3ydxhQWqaNADC4sp
	 Sri0fUxt0pBeYaMDyKbnTI25jupqutIRZAlLpvrL1JMfl2BG7ITjoava+9x+YDL/q8
	 DohfD3vWnSDAiwoa8sfKlZVsB4MAoZ+CiR4ArHYivxgxrMcuDRW+GYUMf/sOgrVKWz
	 ilHIilMvIjqkQ==
Date: Fri, 3 Oct 2025 21:50:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: aspeed: Add VIDEO reset
 definition
Message-ID: <20251003-winking-surround-d047d3c90fd3@spud>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com>
 <20251003015845.2715538-2-jammy_huang@aspeedtech.com>
 <20251003-paralyze-herald-f9ef464d43e2@spud>
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
	protocol="application/pgp-signature"; boundary="GbO01kysT0Oxu35+"
Content-Disposition: inline
In-Reply-To: <20251003-paralyze-herald-f9ef464d43e2@spud>


--GbO01kysT0Oxu35+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 09:49:00PM +0100, Conor Dooley wrote:
> On Fri, Oct 03, 2025 at 09:58:44AM +0800, Jammy Huang wrote:
> > ASPEED clock controller provides a couple of resets. Add the define of
> > video to allow referring to it.
> >=20
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  v2 changes:
> >   - Update index of ASPEED_RESET_VIDEO
>=20
> Ah, so here is the next version. I don't see how this can be correct if
> 21 was correct before. Was 21 wrong?

Given the driver has mappings, I guess this is actually correct.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bind=
ings/clock/aspeed-clock.h
> > index 06d568382c77..671e5a476eae 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -53,5 +53,6 @@
> >  #define ASPEED_RESET_AHB		8
> >  #define ASPEED_RESET_CRT1		9
> >  #define ASPEED_RESET_HACE		10
> > +#define ASPEED_RESET_VIDEO		11
> > =20
> >  #endif
> > --=20
> > 2.25.1
> >=20



--GbO01kysT0Oxu35+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA3HAAKCRB4tDGHoIJi
0vYZAQCmKLwDhm+cuPWduwkWTnpOANP4HjnQu7jEQpxmnAp8vQEA8Hg6Ok19zE03
5dhdXT+b7zt9X10JDsEcH5iw3pm2rgU=
=lZUw
-----END PGP SIGNATURE-----

--GbO01kysT0Oxu35+--

