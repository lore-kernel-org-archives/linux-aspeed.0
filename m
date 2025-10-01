Return-Path: <linux-aspeed+bounces-2376-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203ABCCA470
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 18:33:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccNqQ2Xh8z3cfL;
	Thu,  2 Oct 2025 04:33:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759343634;
	cv=none; b=RvJclhxHVqiUKRBwtwT/3jh/kAS9VKqYPewjl46FrjkIgmLFZtVSkoVMx2sT2fTzR6NfmAI8ApgYSSbZxyqT6snHw2vOAV2uCIIB7j1h/GBlWMyX0Yk32IRz/X/WvqgOeG23FjVGcpyri8S0NgxvOrcCUA5pSVSyC/wGPqRspeNkm37TAKSZRX4BYAZvWmZSP9ghXU4ZIIRepj9/y7/rzpB1W5UUrf+gdmsBM1Z/Zm9VeiIeCYzIyQJE0iOoI/p8Jtb9UvDnUvxe3+QXbwd0TyVNH6zQbRq8gBGFfb6qXGZJXXEjM1mpQgWuMVMdyhcNU0NO6CFJ9ctRjvi81P2Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759343634; c=relaxed/relaxed;
	bh=kGbiHINkHdj+BEyy30Si4Wj3e1RckJgbpESUr/nVpDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOxYiXiCAOL73fLF6QYT/Fl5jydTdJl1VJToOR2Ad4L2IF35W+MY3YPLkKaGMYZBLdcsz6ELnZAKOUOn4XDoPCfnSK90Qhk5qBSMr/ijjW7qDB70J+42xBr0NVv6h//2CIV0IS10QjqscCf5RMX2CdbjUTs+8T+qHZPJ+Mlyd6s8Lqlg1JmijJEosWdU8nIUcVZm5+Yg7Qma+qk0IHL4YeyWPbXcHRCQegBbnb77DrpN1r1R0pk33e1QA0oM4Q1zEZkp6S+0W6X9QJvewgxy1F0TzMb9G51E+w1EsXjZEbsfJZuTJBqbL7pCTa/PEneF3VhsC4f7f6pvWDBCN11IkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nZ0jdwUA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nZ0jdwUA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccNqP0wwGz3cf7
	for <linux-aspeed@lists.ozlabs.org>; Thu,  2 Oct 2025 04:33:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0899D44F5A;
	Wed,  1 Oct 2025 18:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8B4C4CEF1;
	Wed,  1 Oct 2025 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343629;
	bh=Xb2lH0sV16eeETFsmOI0Y8doM7vNsNLpecPTgoVug9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ0jdwUAbWT/9x4SadJIY2f4V/NL3jEI+DJHNGWWhIxzczO13aFPh/6klDqwA8bL9
	 cLcgoW557k6R40KFRWM8Tw9dxoZPfUa4sqnn8MgwMwVsxuoUTexDoY+TuVR2m1U1LS
	 n41xfrN/iRQlc0P/yScu/JOxqqa+e5I/Xtmu3ug1AsYLlMjpsxgNJxDZ3AO2ymxE33
	 FF51i9KgZCiSognZU8iMD11mIHZVDtNyEEG0T6AJJ0ptTU3EYOhaDlHvaGxzCvSmau
	 EIO8mt5aff/aLLg/CfFJgfFyqDGqOGBw0+yZ08QoUJXsAuH6HptbAodY1Tba5+7l2p
	 jFjG/5jVsEFpA==
Date: Wed, 1 Oct 2025 19:33:44 +0100
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
Message-ID: <20251001-bonding-surging-af8cd0d09e07@spud>
References: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
 <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com>
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
	protocol="application/pgp-signature"; boundary="N49fSXuRnpf7iDQV"
Content-Disposition: inline
In-Reply-To: <20251001-yv5_add_dts-v3-1-54190fbc0785@gmail.com>


--N49fSXuRnpf7iDQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 04:47:50PM +0800, Kevin Tung wrote:
> Document the new compatibles used on Meta Yosemite5.
>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>

You've repeatedly ignored my ack, so I assume you don't want it.
Maybe you want a nak instead?

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 456dbf7b5ec8f4442be815284e1ad085287dc443..6f2b12f96bd6ce31b4175e109=
a78d931dffdfe28 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -89,6 +89,7 @@ properties:
>                - facebook,minerva-cmc
>                - facebook,santabarbara-bmc
>                - facebook,yosemite4-bmc
> +              - facebook,yosemite5-bmc
>                - ibm,blueridge-bmc
>                - ibm,everest-bmc
>                - ibm,fuji-bmc
>=20
> --=20
> 2.51.0
>=20

--N49fSXuRnpf7iDQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN10CAAKCRB4tDGHoIJi
0rToAP48ObGVhLOzqtINSi0uK5cZGsYs4Yk4UKr5h8fYmM++rQD/bO5IqlbvGU3Q
ohXJpk3bM7P7wKsfp835IM8Bn2xMTAE=
=on5v
-----END PGP SIGNATURE-----

--N49fSXuRnpf7iDQV--

