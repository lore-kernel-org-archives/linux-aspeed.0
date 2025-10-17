Return-Path: <linux-aspeed+bounces-2485-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FF6CCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 05:42:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cntyC68Yxz2yqh;
	Fri, 17 Oct 2025 16:42:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760679763;
	cv=none; b=Pbu6dXkdGV+F1D5R8S02kTWqlcGxPEaeu08iya7gtwJobPNfU/jW/GVomA39IfzbFkhybDiW+bXCupF4zJ5Wu0V0Tdt4CSPHGii8C1VDRKfQDe2yPH0359JdHEEKA+zEs6+S6x/KC9zS0WfpsEdOdy+OQCd6dkvxFDK45EiNrrJiazoG6nE8r1HVcdBRGcoqg7Gx1W1WHWu4QXZonheptWNngzrEzFUNmtiYpAK+WVIltQw/pSC3lDc1Mus1jztMzKITIKcn1yv2RukGySmMA2S0RND7zuYbhBwe13H+ySEqwSs9VRFGuEuPiHMAvo+0dj5DZg5s8mYHU/wgiFt+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760679763; c=relaxed/relaxed;
	bh=FBOBE2lJJ4ubL1SZFxRHcJFjs6sCvB23xdXmM4GToK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxmzjnBPL6saDKud0QcFI+hzD+csWc8IF6ZD2TW8oEkdTQUDYsOgvz7sbp7HXHYzR5JQl2+LYRBqz8+kMVKC5PdjZFzoSZEQ3Hf94060jp5Qd5LMRuEhtEyYTpl8hUpyPSL0xwzUEKa79k/R6GuTQ6eRRgOOsD6XGNgQAwQycdZQgaWyJF6DO7eAYF1/knsLknGMj8zkGn9zbA0ZiBXfsKOVBRY4lNEchTz4AqNE4KbVI79k4M5ebV36R4xA18losS1C+QbygpDgFXONFf7G294FSfo9QTWrsDMEJIS62LCY6gu8SE7pw1uqLvNBRy8LPSrF5S7b06LyqtFGjYpQnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Hm0yU3a2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Hm0yU3a2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cntyC37Fyz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 16:42:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760679762;
	bh=FBOBE2lJJ4ubL1SZFxRHcJFjs6sCvB23xdXmM4GToK8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hm0yU3a2z4bD4DKGw34ZbPDfR4rW6dPHM7WeC4kQPhcDJVhiSCwheDLG7f3xa0io2
	 5H/RYHexWp3moLpTsY05ufX3r1a7hG4pRri3O9/rWF1BwkofObOZcvlSrYycV0aCvw
	 REsTNvcvGFUcT+RqwUVeaChsa7nLBkhXXYTFN8O8177yP4u0tm+ranaQChlIQQVTQT
	 QSxuaeyPqBJSz/3EpmlmIJ1R7MiYaGKmPVNyx4yJsBzcQ/5D86RLiQVhPG82yIAogi
	 0GKMzuIzyg1tVgF91bMvdOtfyWDX4m8iD7aYuO15s1k1US+vBSe2AcUbZpz7Lx2rFF
	 Rt0o3NL2o9G0g==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E4193766F5;
	Fri, 17 Oct 2025 13:42:41 +0800 (AWST)
Message-ID: <eb9ed79a820b67d7d3dbb0ab7ec6349bf962fe9c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tan Siewert <tan@siewert.io>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Cc: Zev Weiss <zev@bewilderbeest.net>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 16:12:41 +1030
In-Reply-To: <20251011112124.17588-3-tan@siewert.io>
References: <20251011112124.17588-1-tan@siewert.io>
	 <20251011112124.17588-3-tan@siewert.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Sat, 2025-10-11 at 13:21 +0200, Tan Siewert wrote:
> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
> 64MB SPI flash.
>=20
> This mainboard exists in three known "flavors" which only differ in the
> used host NIC, the BMC SPI size and some parts that may be un-populated.
>=20
> To keep the complexity low with the BMC SPI, use the 32MB layout
> regardless of the used SPI or mainboard flavor.
>=20
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
> v2:
> =C2=A0 - fix led node names [robh]
> =C2=A0 - fix missing gfx memory region and other offenses [Tan]
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts=C2=A0 | 350 ++++++++++=
++++++++
> =C2=A02 files changed, 351 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d=
4u.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 0f0b5b707654..c601af36915e 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-asrock-e3c256d4i.dtb \
> =C2=A0	aspeed-bmc-asrock-romed8hm3.dtb \
> =C2=A0	aspeed-bmc-asrock-spc621d8hm3.dtb \
> +	aspeed-bmc-asrock-x470d4u.dtb \
> =C2=A0	aspeed-bmc-asrock-x570d4u.dtb \
> =C2=A0	aspeed-bmc-asus-x4tf.dtb \
> =C2=A0	aspeed-bmc-bytedance-g220a.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> new file mode 100644
> index 000000000000..e9804b0ace9f
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "Asrock Rack X470D4U-series BMC";
> +	compatible =3D "asrock,x470d4u-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &uart5;
> +	};
>=20
>=20

*snip*

> nvmem-cell-names =3D "mac-address";
> +};
> +
> +&mac1 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_rmii2_default &pinctrl_mdio2_default>;

If you're using NCSI you don't need the MDIO pins here, right?

> +	use-ncsi;
> +
> +	nvmem-cells =3D <&eth1_macaddress>;
> +	nvmem-cell-names =3D "mac-address";
> +};
> +

Andrew

