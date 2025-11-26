Return-Path: <linux-aspeed+bounces-3003-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55725D1118E
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Nov 2025 18:57:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGpj713VCz2xQs;
	Thu, 27 Nov 2025 05:57:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764183467;
	cv=none; b=MrkYTdIWv+qIlWYEYttvSmWQwT+kZRSWpRgEUydmVnCZyqEnOtp22iQtUmmHcTzWc74OjZG2FjNaCeMqb+B1vOPV4UlDE+xFP76YqaiqCkLIGLZA5X36cX9YL7+TJYSINkNMvBMadGv08KDAVVYCcMa20F8cyNc45/E4M1vvI6uVqVxhzF3llfBoLVsZj0VHvo/oPmCl4IDsqNsy6wOVRiDqnOwPYEu/MCmh9ABC0aZorW6yEbYLOa7MfyKl+dLTjXFE1yy46QT/HeSpeUntmRGH6Gb84VRToP/YehY6FaDGgtjyVAbrMiTb1qy8JdFfpJOaMfdNxy5oQPA7hhYGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764183467; c=relaxed/relaxed;
	bh=Ib2tplNfyo+QwZAc4rGlXV64eR9y1CRE05Zpi1i8XrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIGxLvck/tbkKAWhW+emvLxFmEsVzvCMcWPRxdi9I6w4HeJC6/TSmLsdQ1DMVTcaaLaDGEHOzFmwA7BByYMscXVKIzKtNCaPrSvMfruwhOCCeGB222wM/hAgm68o1rbXBAmHVFG8pZXmO+IpxPWgaMtKYKf4gqHBbX4ljDwZdlC+4HcerEvSnFw5vFXqm1M/fa50oURzDAjlAoz7Dnr0i8WumhlHs7E1WVv4DAM7GmbCISz2k+eyg8mlpqe4cueauG2YAPuUJQI9KHR61Dr54CSgA+3o66/zBc7Mb9rWa9ZDUZbJ8YHJUDgXA+VBfO/KnneriUpo4lIQZ5XBQuIdMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SFP2/FOM; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SFP2/FOM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGpj55Bqfz2xPB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 05:57:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 60E8C40521;
	Wed, 26 Nov 2025 18:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B269C4CEF7;
	Wed, 26 Nov 2025 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764183463;
	bh=5WZhiEaQvVblhY9cHM2bDr2i/VGrZtzzWJLLnZPv9/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFP2/FOM2zXTrZN2QsYPPCPXEpFVOSFXEAZGmBRZ61FBruYQAQezRO2q3/C8mqgEp
	 UsmodebIZPM4M50YGMjgQpYsALxbwTOIDGs7D8Tf631RGMUUE48D9SSlRITcFqm4lx
	 SVNxcMsAhN16tIapEs4jJQsIz587hM82BNqZOdtyQpSv0fxx+4yQe/y5Tz4ChxkhXg
	 70SBH1LyAPX7iD2SDtkc7RoMXmvX6uH2FipmM/JdEDsWrxHZb5Oun1M49hSPZTkbcz
	 z1D5gRCMvzAKFYVTfz4xVp2vy0SMTyNu283EW2Xs84tXTSEu5vQvsGIXZbUS9mYqS6
	 DHWwoc69+l7jA==
Date: Wed, 26 Nov 2025 18:57:38 +0000
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
Subject: Re: [PATCH 1/2] dt-bindings: usb: aspeed,usb-vhub: Add ast2700
 support
Message-ID: <20251126-protegee-ragged-067de2fd6488@spud>
References: <20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com>
 <20251126-upstream_vhub-v1-1-910709937ee0@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="uyAOyONr3gMni1/q"
Content-Disposition: inline
In-Reply-To: <20251126-upstream_vhub-v1-1-910709937ee0@aspeedtech.com>


--uyAOyONr3gMni1/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 04:26:30PM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-usb-vhub" compatible. The ast2700 vhub
> controller requires an reset, so make the "resets" property
> mandatory for this compatible to reflect the hardware requirement.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml b=
/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> index 7f22f9c031b2..c9ebb6e004d1 100644
> --- a/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> +++ b/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> @@ -26,6 +26,7 @@ properties:
>        - aspeed,ast2400-usb-vhub
>        - aspeed,ast2500-usb-vhub
>        - aspeed,ast2600-usb-vhub
> +      - aspeed,ast2700-usb-vhub
> =20
>    reg:
>      maxItems: 1
> @@ -33,6 +34,9 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1
> +
>    interrupts:
>      maxItems: 1
> =20
> @@ -107,6 +111,16 @@ required:
>    - aspeed,vhub-downstream-ports
>    - aspeed,vhub-generic-endpoints
> =20
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: aspeed,ast2700-usb-vhub
> +
> +then:
> +  required:
> +    - resets

Do other aspeed platforms have resets? If not, please add an else here
to block its use on other platforms.

> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.34.1
>=20

--uyAOyONr3gMni1/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSdNogAKCRB4tDGHoIJi
0vfcAP4+UCM4+9oWQTzC169bxxTWFttidmoFlgVoPjRLljlb4wEA6tOi+qKVBja+
SvHDIXAz6NXJyWJc8UKtdaXJy+N1sw0=
=wiN/
-----END PGP SIGNATURE-----

--uyAOyONr3gMni1/q--

