Return-Path: <linux-aspeed+bounces-2745-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D93CCFA04
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 17:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d1FfJ0cZWz3bf3;
	Wed,  5 Nov 2025 04:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762277000;
	cv=none; b=FdQCfYENS0+BnnUUoDf/wzOc654nJ4s9j5EXtEUC8Hfcosne15WWDjndYDEqZaPGV5UWbKqe4KbEpUTOSwJ5vVpE1Kc9E8yZ0uS8GtWc/AvbLHNj0MFBYfsPPUji8rFYyXJ1U8tu+NT3SWqWySh0x87pwCMNQMxqJSvDKeEsBFlq/cHhJdq1SBcbt0S2+1ix88UQmr3jVMto/glsq0bYZo8sQL/ZbVW7xgwwrWZJaN+Eqgs+GAo0BqfOPPIuwQSfcWtjtxiXgm/lO5gs2yFaTsrxnGz4e6Ms3+J91Uxvj30vMzPAtn78DWRP2wg4NlE73BnnwlgNc158oIBulMJquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762277000; c=relaxed/relaxed;
	bh=H1XSY0vT6OMbSFwYM3WYl0nmIcd2JaGA5/JSzPeHm6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh2qev8e2PJ8Zd8ZoE32puwQ/1thLkJ1nrB4n+8t0oFHMZCVd0PstA18ChXKC+Yp0vF3e72mE9JW331w6UajCiWsa3vgNihMN1GiZ6KCSv6K8DvViOO3EqnMRtC6nvYriy2CYiBDHc13VaTnASSkV3JKOQLdjPKZfgp/vLwRPkOX8mScTXlgu6ZChaEh1wSmos71f1Gpi+GQUsIyBFT65foV5goAhi74dxQYQLQSM8vU7qlUzwFaKevUQQagSFj4j+/gGnb3eo8QjEWZx8wMZVVe0OkW5rweVJTzIbDIiXhOzGguO2b6enaPA9uodpPU5TUGOQQZp6AZnGGQcyl4Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HaetDQwr; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HaetDQwr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d1FfH2C0dz2yvv
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Nov 2025 04:23:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FB52601FE;
	Tue,  4 Nov 2025 17:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B8C4CEF7;
	Tue,  4 Nov 2025 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276996;
	bh=E5LlO3nuIGMGzEZzuymHEqptWv1aueAZNyEcApu+pa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaetDQwrl/7Fkot0PU9d+nSTeVzFdfuXVDZmdtpJpJVeBaaA0klVmA1eENrt1+e+5
	 TvhgjKUbjrZtovhEDg0p/Am7ivqIXvS57RaliFTnO9C2HOAGLORQ+0s4yJ1549qzi5
	 gnwahsmhyujkKSeMLxE7Jq6+mB8ZvHH3Eqy2gdJKkij38H6iV88jCabEwF+N90TP+d
	 nkBwS/85Hd9v0+6QjTt5T3ckOMj14HwnAD/nWS9HVhCHfN326C9iagieA4W0sQaU1i
	 OHNav7/x0N7m+JDB2QKDKumsi6pntWjK6Fai4t3GiS1oW6jXuTiAMboyPolY1CBmjo
	 4EbUobAL5zV1w==
Date: Tue, 4 Nov 2025 17:23:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: Add AST2700 compatible
Message-ID: <20251104-grumbling-document-6483add9415e@spud>
References: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="EAVUn09jG7fwpxUy"
Content-Disposition: inline
In-Reply-To: <20251104055112.2679087-1-billy_tsai@aspeedtech.com>


--EAVUn09jG7fwpxUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 01:51:11PM +0800, Billy Tsai wrote:
> Adds support for the AST2700 PWM/Tach controller by extending the
> compatible string enumeration in the device tree binding.
>=20
> The AST2700 PWM/Tach hardware is compatible with the existing binding
> schema and requires no additional properties or modifications beyond
> the new compatible string.

With this commit message, I expected there to be a fallback compatible.
Why isn't one used?

>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.y=
aml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> index 9e5ed901ae54..d6ff4182085e 100644
> --- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - aspeed,ast2600-pwm-tach
> +      - aspeed,ast2700-pwm-tach
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--EAVUn09jG7fwpxUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQo2fwAKCRB4tDGHoIJi
0sYTAQDbftqnYaV1ZmhlGS+OCOMPY79jqcr4MOlskykoteVUhgD6AqEmQ/T3y0h7
Z5h+xKS/iDZ9j7HhE/bIphciTJDIMgQ=
=uT06
-----END PGP SIGNATURE-----

--EAVUn09jG7fwpxUy--

