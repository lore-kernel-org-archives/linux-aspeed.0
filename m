Return-Path: <linux-aspeed+bounces-3754-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D3F532C7
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 03:11:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffw712Rd1z2ykV;
	Tue, 24 Mar 2026 14:11:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774321901;
	cv=none; b=L6Lk/6NmkeZ5BLjzwTIZHBcRvpyY74qxS0pxmUr5Vk2H3h7PWT0L1GjuUcTpPa3sspueOu3ZUtPkLHmMqh1bMQ/V5a7ipxlww/CvWoQR/cEd9xlF34PKHqDM1/gxZFd6qtyHB7/nxiwSROsxdiXTPEtep0DE8BZLmaqrvDcPXtV+riW0bc/J9K/0/DtEfEa0AQ3gy8qnqbQ718tY529Ptug9dRoENj+t24qRAXloJw5jF9krZ1cAxPHY9S+gFaDHfiqhqGOnhD6B7J4q1uGzO53vKytPpLV0t9rvvccsBAXWTjRf0hEMdAD4xO8sS9SFs8aXhELbb/601MxwekeDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774321901; c=relaxed/relaxed;
	bh=40hYrgHMhL5Y3sgIvyGDHr2DSh4JcFjI1IXGpM/589E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RHsv8NwgzmqrzqInxPFskVTZ2+9HYRHspbRWfzlpfi8feGiR/ChI86e+Fo7oRraeyndKtm0ir8KyRrCrkh/LZjWQakSvKWKntvniBcEHIJIe47P858wO4rypjIM0dkDeI0XHl7Hds0D7YmkHVUz6K5mYK95+oCVlWjjLlj1ZYvx/MpM2pTZ2MnWBOTizDhpmut2i75pTnyjNkZl9RnFJbFD2KpWueW5+nA86Ss3hvgv4AfjyEYMaoMpsVzupEP9gM+y3f88m7BSG7/bXp0BX4v6dN/xQZUcKLGq+8J70qdZUAQ6C0xYjA3Dpvlk8sR7pBdHAuRingzgbQn4XG56vjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E8hVtBNg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E8hVtBNg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffw701yPmz2yj3;
	Tue, 24 Mar 2026 14:11:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774321899;
	bh=40hYrgHMhL5Y3sgIvyGDHr2DSh4JcFjI1IXGpM/589E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E8hVtBNgBrNdvLlWQvKdjHzlxebKnv8/HKVeiS/DFd3RTyaMLM8i+lnyTJLUyqnr1
	 5oRE0irl1i5UBIeJ+/lz6onh2hv1Mg4d4Cj1xC8RNAAChpl7eoCItUni3F0TUoG7pT
	 brHVXfEIUCGD0f//XMqUytT4jc2dqB+rDmmnVmDTyrmHzYtoDbiu3sZBR2mXO1HPIv
	 vhuugmBNZWegkcJlc0y6P5gnPNRLuEbzAhlbYrORsfXNnOY1wetPJ3LqYkgse9r/On
	 c2JhmK/wPo2fBHKDGUjamOc/QPN5gwwp46CruZ/qVp5cVLwt2eEgG8Z1CQCe1jIElO
	 WFCplhl1kCfgw==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 605EF602C2;
	Tue, 24 Mar 2026 11:11:38 +0800 (AWST)
Message-ID: <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andriy.shevchenko@linux.intel.com,
  Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Rayn Chen <rayn_chen@aspeedtech.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date: Tue, 24 Mar 2026 11:11:38 +0800
In-Reply-To: <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
	 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
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

Hi Ryan,

> The AST2600 I2C controller supports three transfer modes (byte, buffer,
> DMA). Add "aspeed,transfer-mode" so DT can select the preferred transfer
> method per controller instance.

This patch does not add an aspeed,transfer-mode property.

> Also add the "aspeed,global-regs"
> phandle to reference the AST2600 global registers syscon/regmap used by
> the controller.
>=20
> These properties apply only to the AST2600 binding and are not part of
> the legacy binding, which uses a mixed controller/target register layout
> and does not have the split register blocks or these new configuration
> registers. Legacy DTs remain unchanged.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.

What about all the previous changes?

> ---
> =C2=A0.../devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0 | 17 +++++++++++++++++
> =C2=A01 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yam=
l b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> index de2c359037da..38da6fc6424f 100644
> --- a/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml
> @@ -37,6 +37,21 @@ properties:
> =C2=A0=C2=A0 resets:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0
> +=C2=A0 aspeed,enable-dma:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I2C bus enable dma mode transfer.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED ast2600 platform equipped with 16 =
I2C controllers that share a
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 single DMA engine. DTS files can specify =
the data transfer mode to/from
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the device, either DMA or programmed I/O.

As we had discussed: this does not define the transfer mode, only
whether DMA is available to the peripheral.

Why mention the 16 i2c controllers here?

Please keep this description simple and relevant to the specific purpose
of the property.

> +
> +=C2=A0 aspeed,global-regs:
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Phandle reference to the i2c global sysco=
n node, containing the
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SoC-common i2c register set.
> +
> =C2=A0required:
> =C2=A0=C2=A0 - reg
> =C2=A0=C2=A0 - compatible
> @@ -59,4 +74,6 @@ examples:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&syscon ASPE=
ED_RESET_I2C>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-frequency =3D <100=
000>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI =
110 IRQ_TYPE_LEVEL_HIGH>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed,global-regs =3D <&i2c_=
global>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed,transfer-mode =3D "buf=
fer";

This example does not match the binding.

Cheers,


Jeremy

