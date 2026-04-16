Return-Path: <linux-aspeed+bounces-3925-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC560F8D75F
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 15:54:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxMyH5fvLz2yks;
	Fri, 17 Apr 2026 01:54:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776354855;
	cv=none; b=EOq1KlpD4c1Zau6FM6lhRhld7NwnrjJg3sQbeMnQq/CP/5TsQAqWxK+KaSwlPYRXc6RSBs6sry4M3BNZ+cA4B/Z6wrtQIU/lexti9OlC2/Qp8WSX94WU4MtYx7V/rSM4QQcCJOZyTeTsbEwxx6fJEcWzaAtnS4uIG6CVyxj/ZcYPDnyCWeYViRofdIz8f6EUz9i+zuigVGG5GQomKYksDrx4gSE3avJNzxhVbCdK/QU9RNc6V7pdZgu13shbfecoskQ8bL5f2M/ts29NvJ3kRugYEeTXCDmeKshijxAkXgWSppA0zHln9kcKpLh/SkB2OYYwbDrOLZPeEEW4ghBJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776354855; c=relaxed/relaxed;
	bh=ZIBe12t9QAVK2C+Ee112YHeNFZOqGP7jIyw1SMfJwys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLJ5PmNznS2wz40oOOOx/xYEalGz5Zd0phHUvzSVHApqYizBg9SXFbjS1phRR+XUV0DK6+6YAn9B3dFhfi/2viV9OuSwCKOmJbF8W6rg18tqfsxs7PWoXKPUV0HVPNP+zJHAco8nhmMQ4P8CRT0n/1Xvy5kEnHkgG2ex+x01eDrU9TTIrAlCV38w0O+kPMAGJnUlPQdojYlVOTvwuHmhvdQKDoRvwo+x+9L9QJBDkEpCwQdkzGyjpZHRY3MKROa+Q9WEHYPiPXT+q1RK5ynsvHeHGCJZi+NtSSezmnhEKLLyuGLMXivL5LYNErbaYlmdwAle7dxGzKRR2pbH5IxNQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oj41PPQr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oj41PPQr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxMyG0k2Tz2yhP;
	Fri, 17 Apr 2026 01:54:13 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BF44D43A40;
	Thu, 16 Apr 2026 15:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DF5C2BCAF;
	Thu, 16 Apr 2026 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354850;
	bh=A6PmtdwoxMFwfTIxnTYwHoYQS2S6o0smJnblGS/cOiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj41PPQr4urm3jmdEHQld+x/hq5vcKf+0oRYTBilCdX6ioul/2rHuuqOaI588SFkM
	 j63PF99F+bmFIw8RsSLouiYzz4N25hKzx+inOkOCc0GrTulum2nJXqU8JbIGg/4Oqj
	 sG6MuwQq3eidTpb+kJQvX+jjv00YMyDSdDBab1cD5wYIxYs2B1e/0Nl9tbxVAwTsgs
	 FQfV7cq0V2yJEUjRvwY0IcIbsrLwAyDTSYNvJfUkt+/dNzy4AK5nUt0OcfIEwE3tqE
	 8imsmrb5NLeLor0VoNqTTmgBTjB8oYu+SCl25g4HiLjkUFe8xvXSKS9LLNUp4gylcE
	 VndHwdRKDCdlA==
Date: Thu, 16 Apr 2026 16:54:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: pinctrl: Add
 aspeed,ast2700-soc0-pinctrl
Message-ID: <20260416-brutishly-saga-ba7168a4cd14@spud>
References: <20260416-upstream_pinctrl-v7-0-d72762253163@aspeedtech.com>
 <20260416-upstream_pinctrl-v7-1-d72762253163@aspeedtech.com>
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
	protocol="application/pgp-signature"; boundary="F+crD9IVk8CdCT4u"
Content-Disposition: inline
In-Reply-To: <20260416-upstream_pinctrl-v7-1-d72762253163@aspeedtech.com>


--F+crD9IVk8CdCT4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 03:29:43PM +0800, Billy Tsai wrote:
> Add a device tree binding for the pin controller found in the
> ASPEED AST2700 SoC0.
>=20
> The controller manages various peripheral functions such as eMMC, USB,
> VGA DDC, JTAG, and PCIe root complex signals.
>=20
> Describe the AST2700 SoC0 pin controller using standard pin multiplexing
> and configuration properties.
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../pinctrl/aspeed,ast2700-soc0-pinctrl.yaml       | 162 +++++++++++++++=
++++++
>  1 file changed, 162 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc=
0-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-s=
oc0-pinctrl.yaml
> new file mode 100644
> index 000000000000..947f3cd09fcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2700-soc0-pinct=
rl.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/aspeed,ast2700-soc0-pinctrl.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2700 SoC0 Pin Controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description:
> +  The AST2700 features a dual-SoC architecture with two interconnected S=
oCs,
> +  each having its own System Control Unit (SCU) for independent pin cont=
rol.
> +  This pin controller manages the pin multiplexing for SoC0.
> +
> +  The SoC0 pin controller manages pin functions including eMMC, VGA DDC,
> +  dual USB3/USB2 ports (A and B), JTAG, and PCIe root complex interfaces.
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2700-soc0-pinctrl
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-state$':
> +    type: object
> +    allOf:
> +      - $ref: pinmux-node.yaml#
> +      - $ref: pincfg-node.yaml#
> +
> +    additionalProperties: false
> +
> +    properties:
> +      function:
> +        enum:
> +          - EMMC
> +          - JTAGDDR
> +          - JTAGM0
> +          - JTAGPCIEA
> +          - JTAGPCIEB
> +          - JTAGPSP
> +          - JTAGSSP
> +          - JTAGTSP
> +          - JTAGUSB3A
> +          - JTAGUSB3B
> +          - PCIERC0PERST
> +          - PCIERC1PERST
> +          - TSPRSTN
> +          - UFSCLKI
> +          - USB2AD0
> +          - USB2AD1
> +          - USB2AH
> +          - USB2AHP
> +          - USB2AHPD0
> +          - USB2AXH
> +          - USB2AXH2B
> +          - USB2AXHD1
> +          - USB2AXHP
> +          - USB2AXHP2B
> +          - USB2AXHPD1
> +          - USB2BD0
> +          - USB2BD1
> +          - USB2BH
> +          - USB2BHP
> +          - USB2BHPD0
> +          - USB2BXH
> +          - USB2BXH2A
> +          - USB2BXHD1
> +          - USB2BXHP
> +          - USB2BXHP2A
> +          - USB2BXHPD1
> +          - USB3AXH
> +          - USB3AXH2B
> +          - USB3AXHD
> +          - USB3AXHP
> +          - USB3AXHP2B
> +          - USB3AXHPD
> +          - USB3BXH
> +          - USB3BXH2A
> +          - USB3BXHD
> +          - USB3BXHP
> +          - USB3BXHP2A
> +          - USB3BXHPD
> +          - VB
> +          - VGADDC
> +
> +      groups:
> +        enum:
> +          - EMMCCDN
> +          - EMMCG1
> +          - EMMCG4
> +          - EMMCG8
> +          - EMMCWPN
> +          - JTAG0
> +          - PCIERC0PERST
> +          - PCIERC1PERST
> +          - TSPRSTN
> +          - UFSCLKI
> +          - USB2A
> +          - USB2AAP
> +          - USB2ABP
> +          - USB2ADAP
> +          - USB2AH
> +          - USB2AHAP
> +          - USB2B
> +          - USB2BAP
> +          - USB2BBP
> +          - USB2BDBP
> +          - USB2BH
> +          - USB2BHBP
> +          - USB3A
> +          - USB3AAP
> +          - USB3ABP
> +          - USB3B
> +          - USB3BAP
> +          - USB3BBP
> +          - VB0
> +          - VB1
> +          - VGADDC
> +      pins:
> +        enum:
> +          - AB13
> +          - AB14
> +          - AC13
> +          - AC14
> +          - AD13
> +          - AD14
> +          - AE13
> +          - AE14
> +          - AE15
> +          - AF13
> +          - AF14
> +          - AF15

Why do you have groups and pins?

Is it valid in your device to have groups and pins in the same node?

> +
> +      drive-strength:
> +        enum: [3, 6, 8, 11, 16, 18, 20, 23, 30, 32, 33, 35, 37, 38, 39, =
41]
> +
> +      bias-disable: true
> +      bias-pull-up: true
> +      bias-pull-down: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl@400 {
> +        compatible =3D "aspeed,ast2700-soc0-pinctrl";
> +        reg =3D <0x400 0x318>;
> +        emmc-state {
> +            function =3D "EMMC";
> +            groups =3D "EMMCG1";
> +        };
> +    };
>=20
> --=20
> 2.34.1
>=20

--F+crD9IVk8CdCT4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeEGHQAKCRB4tDGHoIJi
0hrJAQCL/qPAeh9PhP0f+9cy9zlA9Di9yMRwuiovxWHDxpgp2QEAzMKci8tRvglD
bIbgOLVyP2ugZhGFkQQHHd7o6vRTLQg=
=QgdD
-----END PGP SIGNATURE-----

--F+crD9IVk8CdCT4u--

