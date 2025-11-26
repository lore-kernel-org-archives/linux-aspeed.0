Return-Path: <linux-aspeed+bounces-3004-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE83D116E1
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Nov 2025 23:38:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dGwwv40tVz2ytv;
	Thu, 27 Nov 2025 10:38:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764200303;
	cv=none; b=M+uJBBW9Rj2hQi3IjM8gTz5OnGjiYygBE2Mzfk8r3/7Cn57L3TWYk+h3KLgY/56NJuG/1cyO76G9oHILwowEvoU9W208Po1xrJvSujlWA2i57nYeRGi7ATU2j8etcB0eE/pgbj8K1lq8FfoWFtLOhOR8vQEqAuEWRCSW49mx/31+ItBZ0wf0osL9bH8RoWhKmzMY2rwEJZ/tnlbCKKkTCX9MfZRb/ixsgzlksoc0iq0i2br5XB/C837hXnh1l1r/YWwki2CT6m50CpQC+P1cRZ+r1AYnVJNlHk0oqhk+aOiCYSWe8emZvXeeZLePYJLI18mTO/yNsU8OUzlBp3wKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764200303; c=relaxed/relaxed;
	bh=1h6WNJy17sj34mCnfEYhILwT7lHGBmPDVuBZNGD7NM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBGFoB4a2vdXM0YU39l6RP7z7phE2+DOt9Vb8rG9hmsLZBn9BOHvP5+yJ08BN6zbPzQ5HGScE6s09V36OY8PP423AIA9/S8JLQ8sBWmfQYiJSfL8x9xLUAnflYDQaJHNX5t5qjO/hUFtzCF3RB6pEeFLGpOeUX12+y3Gw1mR+OcEjDhpiRtUPIsxvHzQmwr9x3FD3ELMqx1fBxnxkx3NX6OvqD8gxJjHOh489VBBTOTAGPoIwswnHKMFbqYRN0W6081L0KbDz7hzEDDaej+QlmLYhbYrEH8fF+hLaaXD/AwOiZBjzFil4PmHR0nmW2W2vt0dlDqD7zo+hq4NU7zBrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=j7MI0T4h; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=j7MI0T4h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dGwwt3XZVz2xP8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 27 Nov 2025 10:38:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764200300;
	bh=1h6WNJy17sj34mCnfEYhILwT7lHGBmPDVuBZNGD7NM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j7MI0T4hAz8rhojuM9jtbMJ8tqsaJT2YXSHoBYHXPvC3lwXB68NI0uZGrD0ILEXE2
	 hTxVDx45cT3CWYZOaQt5l/Vq653Y4F9C+VVrhKD9fpE9fc9lSfO1Pf92dPiDYCZl20
	 XJqKtF3b2Pqwfc2Xavg14Tg6aJpzoUo/JVlyG03s93/K1zwq1F5e2trrBfctmcBKi5
	 SSXAorbazL9yiqr5MirI/+TezAYp3wpY0YbSikGkoqs8dZ2xhD9Jrcot+RflgUQ6an
	 l8/6X7bUyg9gpWoECpWMjZ/zjix6ZpDJySxNdD1JR4c7JOUnHbgxubvuWJIn3xuAYt
	 DOd5n+rXk5i0Q==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0D70A6561D;
	Thu, 27 Nov 2025 07:38:18 +0800 (AWST)
Message-ID: <1db579becd8fc49e40acdc817bf4417d77feb47e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Shen <sjg168@gmail.com>, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, peter.shen@amd.com, colin.huang2@amd.com
Date: Thu, 27 Nov 2025 10:08:17 +1030
In-Reply-To: <20251124212106.2068069-3-sjg168@gmail.com>
References: <20251124212106.2068069-1-sjg168@gmail.com>
	 <20251124212106.2068069-3-sjg168@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Peter,

A few follow-ups below on further inspection. Apologies for not
addressing more of these in your earlier submissions.

As a bit of a nit I'd prefer we use "devicetree" instead of "Device
Tree" in the subject. That said, it's also implied by the "dts:" part
of the prefix, so even better would be to drop it altogether:

ARM: dts: aspeed: Add Facebook Anacapa platform

On Tue, 2025-11-25 at 05:21 +0800, Peter Shen wrote:
> Add the initial device tree source file for the Facebook Anacapa BMC
> platform, based on the Aspeed AST2600 SoC.
>=20
> This device tree configures the platform-specific peripherals and
> aliases for OpenBMC usage.

This describes what we can see in the commit itself. Can you please
rather describe the purpose of the platform? Why does the design exist?

>=20
> Signed-off-by: Peter Shen <sjg168@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa.dts=C2=A0=C2=A0=C2=A0 | 1044=
 +++++++++++++++++
> =C2=A02 files changed, 1045 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ana=
capa.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 0f0b5b707654..e1b2fc7b8c08 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-asus-x4tf.dtb \
> =C2=A0	aspeed-bmc-bytedance-g220a.dtb \
> =C2=A0	aspeed-bmc-delta-ahe50dc.dtb \
> +	aspeed-bmc-facebook-anacapa.dtb \
> =C2=A0	aspeed-bmc-facebook-bletchley.dtb \
> =C2=A0	aspeed-bmc-facebook-catalina.dtb \
> =C2=A0	aspeed-bmc-facebook-clemente.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> new file mode 100644
> index 000000000000..a9bed728339b
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -0,0 +1,1044 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model =3D "Facebook Anacapa BMC";
> +	compatible =3D "facebook,anacapa-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 =3D &uart1;
> +		serial2 =3D &uart3;

Aliases should be defined sequentially. Is there a strong reason to
skip serial1 here?

> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		i2c16 =3D &i2c0mux0ch0;
> +		i2c17 =3D &i2c0mux0ch1;

...

> +
> +&adc0 {
> +	aspeed,int-vref-microvolt =3D <2500000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +	status =3D "okay";
> +};
> +
> +&adc1 {
> +	aspeed,int-vref-microvolt =3D <2500000>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_adc10_default>;
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&uhci {
> +	status =3D "okay";
> +};
> +
> +&fmc {

Can you please order all label references alphabetically? There are
other options in the DTS style guide, but alphabetical order is the
easiest to enforce by simple inspection.

Andrew

> +	status =3D "okay";
> +
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "bmc";
> +		spi-max-frequency =3D <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +
> +	flash@1 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "alt-bmc";
> +		spi-max-frequency =3D <50000000>;
> +	};
> +};
> +

...

