Return-Path: <linux-aspeed+bounces-3952-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B23FDEE38
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Apr 2026 17:44:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1k4H60lsz2yFm;
	Fri, 24 Apr 2026 03:44:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776966271;
	cv=none; b=nwij3zKhZTCZ0whxedGUAyaSe8/dHFTTGHu/QN6NoABXKHDyFHGJ+ZeulYpwOGDP/bC6kw+3HIv8baaEfxyKUTSGKHMbQ+r5015RA2atmc/5qCrDjaqzv13u+6MNbPMhjaSXkWayjljXlrdjSKkb7xCHixOhZbxzrY+d9yudLjtalBPoPI8YqzIUr+0+r+CReOiX+bWdV55zcRNbCvJg1RBX5Wxm88snQAka2RUaVZpFzZ0BEYQf1UTl6FLDuEhD6ZhnZsXuNM207lel1ELUMxLj4ptB+Ch2oYDJ47lSRXIG1gbrOcPKSxUhgtsc8rIBb3G5jisGdwp0dWMhoic+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776966271; c=relaxed/relaxed;
	bh=pN1bHXTr1LlOb/G1azX3CC1+rwLeWTb7QNVStx+Ul2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD9P2Uv4vkTeyMqVIUoS/4qEFFJRuZOABkjk4KG1iAffuzf7akvQt1UAb4IsEyAFZj7mVI3EuXt6xlI1W56NDX/xmvwIEPIS4CYU0bT2ErmHn2WKUw79GTXVjN4nbP4Fc+dG7pgF3tayALK1nzieoc0YTsmAUClUBKwX0DxI/LoRLYPSFGZOMIyBfsw+deYROzCOgK82UhUZV3bmmtpeWu9dUqW8DoB317eAdXoW7sOEjF7Ouq6ZEszo7s5ewdMqXeZiHzLGD6B7MXWXmmJ2ex2i8wUBafIZklxwEfK1MjEirU3SmfvjA4WOKIkX+ZiWz8UyiB1RtA7wrYU6BGl42A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aBu8iRtF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aBu8iRtF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1k4G4N6Cz2xlt;
	Fri, 24 Apr 2026 03:44:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5119760139;
	Thu, 23 Apr 2026 17:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B558DC2BCAF;
	Thu, 23 Apr 2026 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776966268;
	bh=Ca6918fcOAXDM3mevQIr9UFJydEQNXb86m/+edpbIC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBu8iRtFL+Ml28WAMlWVSTzNQysPYMICkXs8iHwEl66fo33PA83dxwmevXPQQ+8r+
	 03oNzphPXfEn2JbEdywqHe7tIQBtSWk2smDoiP5qJEz4T9SIQJTUmfhl4b9SQHt5je
	 ZOwt4sdI6EeBvPuh2YSRd1/7Nzc0ld+fSTlcJlo/M6Q/KKZVTJ9Yb0rkFLeCpYg3vq
	 RUXInthqnG+cSRYc7ZytRSXcRZSrWI99++7ZWujhmzXACHfFkIte2jw04JlDIc58OZ
	 +EYO0HeTnSkElit8Iw3fYHtGMH0IddZ9VlxfAChsS1CaEM59XvTguRxlE6Em7hXYYF
	 Onb3Y/C9LQ6gA==
Date: Thu, 23 Apr 2026 18:44:22 +0100
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
Message-ID: <20260423-clever-swooned-a06907e9101e@spud>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
 <20260416-upstream_pinctrl-v7-1-d72762253163@aspeedtech.com>
 <20260416-brutishly-saga-ba7168a4cd14@spud>
 <OSQPR06MB7252EB0C2A1A3313DE49406B8B202@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <20260417-anemia-borrower-fb90ac02b417@spud>
 <OSQPR06MB7252BD7967D2567AD6DA7A1D8B2F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="JAt2RGrDeiha8/Di"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB7252BD7967D2567AD6DA7A1D8B2F2@OSQPR06MB7252.apcprd06.prod.outlook.com>


--JAt2RGrDeiha8/Di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 07:22:57AM +0000, Billy Tsai wrote:
> In particular, I'll split the constraints as follows:
>=20
> - For pinmux, the presence of `function` will require `groups`, and
>   `pins` will not be allowed. This reflects the hardware design, where
>   the groups are defined by the pins affected by a given mux expression
>=20
> - For pin configuration, exactly one of `groups` or `pins` will be
>   required (using oneOf), so that configuration is applied either at
>   group level or per-pin, but not both.
>=20
>=20
> - if:
>     required:
>       - function
>   then:
>     required:
>       - groups
>     not:
>       required:
>         - pins

>   else:

I think this is a separate section under an allOf, rather than an else.
You can also simplify the condition above to just be
- if:
    required:
      - function
  then:
    required:
      - groups
since the node will then always be tested against what you have below

>     oneOf:
>       - required:
>           - groups
>         not:
>           required:
>             - pins
>       - required:
>           - pins
>         not:
>           required:
>             - groups

I think this here simplifies to
oneOf:
  - required:
     - groups
  - required:
     - pins

You'd also need to note that pin level config settings should take
precedence over group level ones.

--JAt2RGrDeiha8/Di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepadgAKCRB4tDGHoIJi
0iGUAQCSvZRjl2it7AaROKHK0Bp704DuQXDbJXJ0D6NcO6IYSQD/TPXLQsCR9Y10
jtbhzr6qfBOMLqlIhuZTFyJ2Xq5jBAw=
=i4l7
-----END PGP SIGNATURE-----

--JAt2RGrDeiha8/Di--

