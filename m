Return-Path: <linux-aspeed+bounces-1230-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91530C3ABDD
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 15:47:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1zTb0G3wz2yDM;
	Wed, 21 May 2025 01:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747756066;
	cv=none; b=itIbuAu0pSdI24QL/6cZG4lSbtTAQiJ9PQlRiSZcJYuSjgJvXFw6lU21Rljd6xGy2LOW+fuBm3EAVa/Cuv9/zbNdCCUD0Zm0/yav3cBxLOR8JsBHZEytsovYZ1Wf5nMweBtcdyxdLOHEz/a4U8ON/OD0LesY0gzLLE7V/wXQ16jhbq+cWCdJ3hJJgKc4D6msTpX6diNQViEyl72T174z7H+4fGoWm/b9RHDjoLBysfKwRZVVnuuWKVv2KlJJPonlB3tl0LAkAL38SxnV70LUWc5A3P079IKTSEK2TIs2oGw+kBaKb5qJ52o/IH7PBqOnZlKnajCvcyk8bJiQ1iVfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747756066; c=relaxed/relaxed;
	bh=58gDZVLa6Ht0FSHmZITUm7NmcPXfc1FuPcB86sHdzp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqRh7s+XuvRFBfPGSCOTG114pAyH+z5TQ3f0IiQ+e2jCpYoTLdbvkrlSCTMCiLm4t+qgGh+cDT5Y4NoOAM8xSnl9WWyAXA8pEMMgTkncdy6KdZaSS9t185P9x/pIz7dYZXampo/XOeIrIA074RyDH3MPLtbiBrHE6xqUAm4nFXZ15kGcf4hFlz26V9+/Rxwt+z6YeRI4jatCX23j4XD3g4VEnaS8N1bkhJrSHpgNlcOcV34QCKgmqcDs9PWSDD0TW/msYMJQvl4LCO3RY/lLkd336zzAqcEOipxVVCDy7IZn5+xnLlTGaDitD5dWeZzKD3vHyyziu0Xu4yKOTenIRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hDHIr2AL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hDHIr2AL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1zTY6yskz2xrb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 May 2025 01:47:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 809B461126;
	Tue, 20 May 2025 15:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6480CC4CEE9;
	Tue, 20 May 2025 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756063;
	bh=Kx5G6jb5VVr3oqqGbr04JrYV0NFaNI05NayVcBLr/w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDHIr2ALlh8Morhko7v8apJ8Wf7asZINSwivtyHAkUn9ZrbEKdsayhHxZXZh4H+4R
	 Z7qxw5zKWSJGNISJvIzArsoDxoXB2buC5LyPKDBNpPJr7O2MZUxOaxZaw+kpW7d5Cb
	 qj48E+LAch77GIp6/cqnk13gPn3LIDDyS5QDyRcvM/Tdh513xGXroq6pmuAdjnP1Qe
	 cfwOsBrw6lNPMb7+gCZT+NDIHqIzRroJQfireRm6trozaM+8Xjv8IZCPfNyS/v4gZ4
	 SyDv93Q91Kh/KVnQ6AC1RwUzsRNMvruQ8QL8VizeKjtyO2s21zuvV0DPGgN3I575J1
	 tPbBN43Jku3qA==
Date: Tue, 20 May 2025 16:47:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Message-ID: <20250520-creature-strenuous-e8b1f36ab82d@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vqRuqlVkPNRifbyp"
Content-Disposition: inline
In-Reply-To: <20250520092848.531070-2-jacky_chou@aspeedtech.com>


--vqRuqlVkPNRifbyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 05:28:45PM +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and
> RGMII/RMII.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml=
 b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..f7af2cd432d3 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -35,6 +35,11 @@ properties:
>        - description: MAC IP clock
>        - description: RMII RCLK gate for AST2500/2600
> =20
> +  resets:
> +    maxItems: 1
> +    description:
> +      Optional reset control for the MAC controller (e.g. Aspeed SoCs)

If only aspeed socs support this, then please restrict to just your
products.

> +
>    clock-names:
>      minItems: 1
>      items:
> --=20
> 2.34.1
>=20

--vqRuqlVkPNRifbyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCykGAAKCRB4tDGHoIJi
0ldUAQCs0SeY54j9yeQV50Qs6FaOw51w5rsiRnuKhNfqKgBERAD/bi4/ULFOC+eK
hIqwX2TOHjPWTh/uDyZS4qnyKuCRnAs=
=5R4U
-----END PGP SIGNATURE-----

--vqRuqlVkPNRifbyp--

