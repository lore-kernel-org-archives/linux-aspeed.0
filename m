Return-Path: <linux-aspeed+bounces-2023-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC24CA0EEB
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 18:09:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7BCs3r7Rz3bVW;
	Fri, 22 Aug 2025 04:09:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755799753;
	cv=none; b=Ul4e8sw8uhTVOkEXCZ3FQcvF3fDPnqgnYShGWEYkRVPVTr4shPAhDOXaGE0XlWxIM4/z0OMmLcuqyI/CvQn07lJFOGphzMO/BCmoV2W7FpqHoS1wGlmuCYEqAdfW+CnKqE0k2T6t3d4vewQmV/9txOQ19N+RaixqRNM1HqhX42+CbkiXEeozo2X/hzagyxc/P4kZN8YzvkVK7AoBL4QSsg6nWWz2ux2Wp/wZZhmPO1VpnT1LKKu6iWmleTw6nziwMNw19bAhfHNKSXyIG2Ot509oq/raPRfw2Qc2z/6/FkrmwYCMTN/SMI4T6hF7zmobNoEUpk+BGGuKihAwytVkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755799753; c=relaxed/relaxed;
	bh=FzYuyGs+6TrzNkh6JNP554EuLT+q8pZw4x3vd2nOyGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTRwcCqVOErnCyOPlhIk3eSzm2VLH6M4XVmxtHAUL57g8ewi7xrNhVrKk7KJPnC6nCE/glCfp/4CsCiypiYr1C1VfMX0/jSZoLALRpI6tcC7y565jJM8rN4wR8jlmJu7zH9zNSFxr46aPKSXKlDW306iRpMas81JSOWNDQb3FDdYQtfjBAiyE9eEzG+Ev5+J9iBrcZ9xEDlQgL0gEVdKeqNIiaz3Hg6Ba+ZzPlh7zNljPFcTaYAMmqkQuA2vW9DoP/G5VvI7s15dv2I2A/OZZTTmqmArTLQjugIYd8FWvG1ExpeOf9Z7AeQkj52kOFWLPHb9izOzEP3yJK0JBfYAYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B1DZM6QJ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=B1DZM6QJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7BCr4Hy7z30T9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Aug 2025 04:09:12 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3A9285C4547;
	Thu, 21 Aug 2025 18:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A88C4CEEB;
	Thu, 21 Aug 2025 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799748;
	bh=EJZmiyPbt2FW7J7B2uq5opO2n/Df0WYHvpZBf3tfFA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1DZM6QJ70flQ25VkDsB8ZaRvn6p6tir2J+qFk1eGRgtwb9OkqoJ8opQPWsTfZOqZ
	 ifEAW9k6SKWCDs+3NrjwvtrLE1vtbla5HOnt0MJ8zxXsJb8iRndfb4KuyjN/3Me26z
	 pII+wpS+O98GVdBYf9wK61mWdN6bjfZyi3NVwn9T89gcWqQQff/aR4Y0KxsplXCECc
	 ffl30J8OOX1egfkTzAHKksslozYlO9UfZIQXn6G8wRDJJrOyPkjLBuCfYFuJ4ocEkq
	 NLo+etTUhhgyEf77+CS7XabLnSUhtQS/A4vhKPpnG6v9iB8Rv9PHSwQhoCWFMd6Zss
	 oRtFvdatJknBQ==
Date: Thu, 21 Aug 2025 19:09:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Nishanth Menon <nm@ti.com>, nfraprado@collabora.com,
	Taniya Das <quic_tdas@quicinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Eric Biggers <ebiggers@google.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, soc@lists.linux.dev,
	Mo Elbadry <elbadrym@google.com>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>, wthai@nvidia.com,
	leohu@nvidia.com, dkodihalli@nvidia.com, spuranik@nvidia.com
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: aspeed: Add AST2700 board
 compatible
Message-ID: <20250821-nineteen-purveyor-a5fe7e86296c@spud>
References: <20250821080214.513090-1-ryan_chen@aspeedtech.com>
 <20250821080214.513090-2-ryan_chen@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="eFNKcWxN80Jeyx0s"
Content-Disposition: inline
In-Reply-To: <20250821080214.513090-2-ryan_chen@aspeedtech.com>


--eFNKcWxN80Jeyx0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 04:02:10PM +0800, Ryan Chen wrote:
> Add device tree compatible string for AST2700 based boards
> ("aspeed,ast2700-evb" and "aspeed,ast2700") to the Aspeed SoC
> board bindings. This allows proper schema validation and
> enables support for AST2700 platforms.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..660529c81af9 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -102,5 +102,10 @@ properties:
>                - quanta,s6q-bmc
>                - ufispace,ncplite-bmc
>            - const: aspeed,ast2600

Missing blank line here. Otherwisem
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +      - description: AST2700 based boards
> +        items:
> +          - enum:
> +              - aspeed,ast2700-evb
> +          - const: aspeed,ast2700
> =20
>  additionalProperties: true
> --=20
> 2.34.1
>=20

--eFNKcWxN80Jeyx0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKdgvQAKCRB4tDGHoIJi
0rjNAP4oi5C9FbNOm/t79PDWG4cZleruMzdozxf6Qctl5HCZ1gEAqDbhG+pz7KL9
PdVRZR6lS8PNdFBwdqaDS4H3zzJ8Hgw=
=XlDw
-----END PGP SIGNATURE-----

--eFNKcWxN80Jeyx0s--

