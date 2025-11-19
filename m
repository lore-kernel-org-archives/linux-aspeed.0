Return-Path: <linux-aspeed+bounces-2958-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E0CF58C9
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Nov 2025 18:41:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBVgG6wqHz3dL4;
	Thu, 20 Nov 2025 05:41:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763577674;
	cv=none; b=V1T4uYvpCdx60Q4z6BnRXw3Y9hAu0FBITqWgxceY70djeFv5YeeTqsET+X3WauuNK2n5JFo05B9a9qqwz+RIcTQXbwm2Hx/KyjJC/71y1RGG9FfNpx9zNU68/M/75QXQIHP9RWabnvN2gbj+Otc1VqKbv7otC82u+D4GYFiVPlonVezzrgFgIl2z9sWyrWEWC/uqg3sV/T6MLUUV+FtBIDZb6N+ZHkClXa2N/NlHl7VnSaqlOvzr9J0Qe/vcbLa4w4IS3Kzeu7rh1/yEVibph4Bzivwy8l2ibDtsEuP5xIi4uD9XRBWo1UpL4Ylp9HQepkDY6k3p/usDf85Qo5lJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763577674; c=relaxed/relaxed;
	bh=rkVTBEWqVaZ94WPO1n0cpMljTE5QytXBtSx70+iCgmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgWzjm8x7yTtyYdB4MPii0HxK+yMjizqiGDLU4+4ToJZEtTXJjLIhJvkuc4hA4I6yG6OL6GfJcTFEh/CVi4IHPIv/76DLNqREuh0u+/OL6OanSu/TG/l7AcrGmxloFQb/3pTKavyzoblxg1Ob/n9iUOVSuDjaa5LaueeHJ4d9LjcHSUsPc8yF7iOpPezj7z+ksyXYL1/TOA6GWKY1PqBqrGOmnM5VdobsK7n0HGv3SOqCcUyRF0a8orn3ksXBZVrDqRT8kxyBYHvVxW/NpiWbXOBnkbrrB8cXsuw95uDzac6wK5phrLjAA3ehe4wP1iQdDQVOYUdKCxhQ8zG1IMKNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KOgLihFq; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KOgLihFq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBVgF6k2Hz3dJX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 05:41:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 383B160134;
	Wed, 19 Nov 2025 18:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83CDC4CEF5;
	Wed, 19 Nov 2025 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577670;
	bh=jPiEf9D0enUbIPbwxeeiH63YOLo0c0B5JvI5bNTryrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOgLihFq4e/zbXry3OmMxJlk6/wjfu+Jr63VKL/cUMy8nfY0GxXWpBkKYZ1QGc0pk
	 Um07NKpisn+tyRjh2S/CXmXsUP+rEuir7t5OsaER3oyjiogna/0vI5rFEoiE1KF0yt
	 qdfubygGYscPwGZWQX58N7otP6RQ8wxvOwoHBFY7pE8B7jbUxwJl0WIfleN6HIOruG
	 UrN0npsdRbxaD41STo+S2rD1KA8Pv7d+0JAutXnz/HUO7YYgSoyP84CD07pW8NFWW3
	 FYAR3znkbbNwNFk7Etp1O1A4Ekbi2Uj3RWiWDvGyHx8tfdkad/o2xcSnTRDZ9akjzu
	 pVDIKc8TNSA5g==
Date: Wed, 19 Nov 2025 18:41:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Jeffery <andrew@aj.id.au>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
Message-ID: <20251119-gooey-wifi-413598a8a1d7@spud>
References: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="2bWqpCW/1YghVWvY"
Content-Disposition: inline
In-Reply-To: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>


--2bWqpCW/1YghVWvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 03:30:18PM +0800, Jacky Chou wrote:
> Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
> to "aspeed,ast2600-mdio".
>=20
> Although the MDIO controller on AST2700 is functionally the same as the
> one on AST2600, it's good practice to add a SoC-specific compatible for
> new silicon. This allows future driver updates to handle any 2700-specific
> integration issues without requiring devicetree changes or complex
> runtime detection logic.
>=20
> For now, the driver continues to bind via the existing
> "aspeed,ast2600-mdio" compatible, so no driver changes are needed.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 8 +++++=
++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.ya=
ml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index d6ef468495c5..1c90e7c15a44 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -13,13 +13,19 @@ description: |+
>    The ASPEED AST2600 MDIO controller is the third iteration of ASPEED's =
MDIO
>    bus register interface, this time also separating out the controller f=
rom the
>    MAC.
> +  The ASPEED AST2700 MDIO controller is similar to the AST2600's.

This statement disagrees with your commit message that claims
functionally identical, and implies that the 2700 supports some extra
features or whatever.
I think I'd drop this entirely from the patch, rather than try to reword
it. Remove it and then:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>  allOf:
>    - $ref: mdio.yaml#
> =20
>  properties:
>    compatible:
> -    const: aspeed,ast2600-mdio
> +    oneOf:
> +      - const: aspeed,ast2600-mdio
> +      - items:
> +          - enum:
> +              - aspeed,ast2700-mdio
> +          - const: aspeed,ast2600-mdio
> =20
>    reg:
>      maxItems: 1
>=20
> ---
> base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
> change-id: 20251117-aspeed_mdio_ast2700-aa089c4f0474
>=20
> Best regards,
> --=20
> Jacky Chou <jacky_chou@aspeedtech.com>
>=20

--2bWqpCW/1YghVWvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4PQQAKCRB4tDGHoIJi
0sqUAP9r+wKYrCdpXMLj+cK8mnW1jeDSeXieLhR1kXkxcYrCUgEAvz3f7zkatpMU
AoB7sxn/YdlOC4WEHCby7J2J47TRzAo=
=rJkd
-----END PGP SIGNATURE-----

--2bWqpCW/1YghVWvY--

