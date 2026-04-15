Return-Path: <linux-aspeed+bounces-3907-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55682F43832
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 15:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwlDV0Gvrz2yvh;
	Thu, 16 Apr 2026 01:19:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776266361;
	cv=none; b=CTQi1/F5yjQKw0Tz5h/H4niUvyIouK2fedpwCAStD7b9YaDv5DAkzNo0kgJ5fPHbLyZQe8k58pl4coNhIzU/KzTQDbZR+68rMo+KVMXP4sPjzLNL5DySEdOELAuVLsQLLddAfdAK8GWewApUSCaMC2Oa5HRIn7w3r/JFSdhvtPj079fh/V6X4q2gPGoV5hdvdLSAa0lv0srNokxpPo8VXLW7HKNglQAifzMkXIT8mdZqcjo5PMrSTmx4v6nzAMwSzWaf0AN3FVshFgRA6u3nmZl0NGxZFjC/MMWTFbyz6TTiTuydDeN79EI3PQODCyPYDqP9CPt2pwo/D3FPlJFn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776266361; c=relaxed/relaxed;
	bh=Dee28jZnToSIv/2KhtAbQI/WuccJs8QoILf+fdpRKPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3FSWgZ6ZhISbX7V7J8/7HD3sc1UqpexzZy1A62qiWXGp9A6avE5We9zvX+L2ceFIjc75PSUXK3/UZsXm6AIqU08f8IVv92BAqX2u8Vg4i/9y/OEskP8CV9Sw8uV5VaE6GpynqRjFs4iWQCWWEAyN+e5+e5bN3bf3Rod9G9xv3ChxYyjdL2TxcZntX3aaGbTjNcUEvknL1liurTEgQ6fpVst4cflARYEA7G1vqBYfPByt6pJPXWxzEY+7VaKfqHhSGM8aP1yeaddfAOhQ/pb0eIds29UXvk1di1MpHfUfZprE6n48IskqU3aASApg50uAdYqZIEGVhGnlJ8ELUHj0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bS4AIlrT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bS4AIlrT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwlDT15cFz2yvG;
	Thu, 16 Apr 2026 01:19:21 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D1ABA440B9;
	Wed, 15 Apr 2026 15:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8CEC19424;
	Wed, 15 Apr 2026 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776266358;
	bh=C2CEKkmCH9aV17LYLLM5/3fFEfH0fiYdFqoFdPLbCN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS4AIlrTVya99sPUUaSqchJnoC6rYci6Xzps/4CQD2kUYYTmQDqXTctvL4FGXcCzN
	 X2IMTtcMBZa1NoBprs5sXGpMnltuGHDSD9onfKIKmRwOLCKIhTrX4VGTkJ9y1Ewjr7
	 jwJXWgWa9sfdD+xI8InH8vG3rho7h10owTtFx/8RPxFFImdgU6Z4lo3RgaPRSMg3S+
	 48jQ4ZE2kL+PI+CEk2JqSXD5+PZ5Rz97yOjVAPANdEA567ruWCca51wpQmDpWBvV9T
	 BEZ0NLRsjjZ0M1/L1Wqjr6NkZDOPzQiKBhADFn+WcQoQpOQ+zMpqCsbbTFDQTQ8p1x
	 6OP7bi0P8k8gg==
Date: Wed, 15 Apr 2026 16:19:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: jk@codeconstruct.com.au, andriy.shevchenko@linux.intel.com,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Message-ID: <20260415-unrushed-collected-562130070d8b@spud>
References: <20260415-upstream_i2c-v29-0-317c1a905ae1@aspeedtech.com>
 <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="k6I7hnG3lmH5OCNw"
Content-Disposition: inline
In-Reply-To: <20260415-upstream_i2c-v29-2-317c1a905ae1@aspeedtech.com>


--k6I7hnG3lmH5OCNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 01:14:03PM +0800, Ryan Chen wrote:
> Add the aspeed,global-regs phandle to reference the AST2600 global
> registers syscon node, containing the SoC-common I2C register set.
>=20
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

I hate to do it to you on v29, but can you please explain what this
"soc-common i2c register set" actually is/does in your commit message.
The patch seems fine, so with that
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
> Changes in v29:
> - remove aspeed,enable-dma properties.
>=20
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
>=20
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yam=
l b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..0c769efb76a5 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,12 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  aspeed,global-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle reference to the i2c global syscon node, containing the
> +      SoC-common i2c register set.
> +
>  required:
>    - reg
>    - compatible
> @@ -59,4 +65,5 @@ examples:
>          resets =3D <&syscon ASPEED_RESET_I2C>;
>          clock-frequency =3D <100000>;
>          interrupts =3D <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +        aspeed,global-regs =3D <&i2c_global>;
>      };
>=20
> --=20
> 2.34.1
>=20

--k6I7hnG3lmH5OCNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+scQAKCRB4tDGHoIJi
0kJHAQCCIue29Y53DEXwYeyc7bzKCGyQ41fURdeMFKTMRVm7uAD9FboLEsQkGSoy
RW+T31SM4kdnSSbuJvWj/tlGvWC9xQ8=
=8TWM
-----END PGP SIGNATURE-----

--k6I7hnG3lmH5OCNw--

