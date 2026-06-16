Return-Path: <linux-aspeed+bounces-4265-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CCDCD98E1
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 16:00:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfsBq2NN3z3byk;
	Wed, 17 Jun 2026 02:00:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781625602;
	cv=none; b=jH1wcV7Yoz43gqfojr4eVdKcCjkf4xX7tlegW6DSQnfANOk2CxKFr+c/WUojs/YfV1oTOYtIiVhtf6VHlAbScDWcOR9JKpZ2RYlS041xlc8xdYqDvk5O3iORSdONf1uJ8t0P4C+EyTLmM5aUBfvgXUgFY+GWde9kiDGC5oJ/v4s/XpykWfY2GIQQ1b+lKOxB3pHqnnk5PWYIylt6ieY2J/sj510LvGnp7aQtbHD7d5vS8L1fJLqglgAmZQpGOvS97ADhBqJaPmu//GfWP240i+5CBN62ylUA9RTvh31pwQoNifSlVELGqa5yJ0Jp/kCssuSrnxpb6ck+/g+qgkIPag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781625602; c=relaxed/relaxed;
	bh=RIse3iwtT2+Os5evlGt3yi2fypjT2QT8SgerPML2hCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzeWMcr8CYaopFHB2xFjKPTkYAudTsok4FP7FPZgNA+9RYK2mYKHdE6apSWIiQ8Qm89MMXyE2SgNHUwjgk8Yy+HSl0WCjyN9juKlzt4GmMLGrUI/ptSO8rR+mny4hyuu/l9hpxtI67+E6i5Ha/H31Wm9+juvN8bpXXUZ896IZ6aI3/hVMqOz7PYf+FUvSEN4gVnNZKxYnUGH9hlWdx6uHvNtJmhMRQB55t8C2DfOltaEZx/VEKmfuxp/9P89I+H6vCOZEku+mO4qK2se96xRJNWG2UULpjvhH0eCQvadvVwRI2jKvQrL4Dk/KtZOuSrYHH9myQ1fFraGGOYVk19gyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVIlwhd6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVIlwhd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfsBn4xTBz3bsY;
	Wed, 17 Jun 2026 02:00:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 880ED42B6C;
	Tue, 16 Jun 2026 15:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00A31F00A3A;
	Tue, 16 Jun 2026 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625598;
	bh=RIse3iwtT2+Os5evlGt3yi2fypjT2QT8SgerPML2hCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZVIlwhd6oD9IM9hhq5ifVe+dQbWEypsk7MvrPoQ2DIj+CRLFkMXl+uddZ/IeXoUXw
	 Ds3gOZI6riFQezdvBQmcNg+WuPytgkqRr1OULzZqCDqHBYvdtCGQglpJI2rTDNn0ot
	 AQDV030F2Ul9tFkcYm86ptat4zuo/XbkBo1ZuvO3iJwwgyv6V65xaGLv56N7F7fRd/
	 GR9wT6b0BkcRKW6NDH0yz3chjaWNV4h7KAC4xQoJN84gvASWUe+wYx4F2U2pOIZGBN
	 DFGckWFG17boMCTZdPEDRFotpe1siIgTvppyMACFl/J6znVoICieUGDYbCCq1IZI2F
	 iK7zZ7fJOZ86w==
Date: Tue, 16 Jun 2026 16:59:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: aspeed,ast2700-soc1: Add
 JTAGM1TRST group
Message-ID: <20260616-surgery-fritter-8583b091fd6b@spud>
References: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
 <20260616-pinctrl-fix-v1-1-621036e45c7c@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="sLe+DVJgetvs8zz8"
Content-Disposition: inline
In-Reply-To: <20260616-pinctrl-fix-v1-1-621036e45c7c@aspeedtech.com>


--sLe+DVJgetvs8zz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sLe+DVJgetvs8zz8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajFy+QAKCRB4tDGHoIJi
0nyzAQD/cfSEv7EyKRM044BXBjhasA9Yr52g/vKaTKlxcUnd+gD/dLz2G4ZVL2LX
+vn4OonXgVtVBt+atEzn1pOoaRvRjAk=
=uh/e
-----END PGP SIGNATURE-----

--sLe+DVJgetvs8zz8--

