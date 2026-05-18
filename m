Return-Path: <linux-aspeed+bounces-4065-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F117CD4F52
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 12:22:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJxkn08ybz2xpn;
	Mon, 18 May 2026 22:22:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779106928;
	cv=none; b=KzWedyvy7c/dKsNyec0VGzy19KNXmOp6XJqk+4P9ESGWdxbG5hTMzJaywKhVkAZSH/l0tREP9SB+kn//sM7ry0GEdh/VjO0pcSWqyzDMYpYJkZ83qQQmIYQUtDT9RBEpa2bq9tcwdb7tw0DKcFfK37BTZIvLcKtRzH+B2CAxYo49hGQeX4CMk7T3o2c7Cq/cSgqL7O3hXbytvMYljFbCVuvZbwHxzRNDsskMWOSN34lXzd9WT60YvUcAhoOpODueMf9dTB/rMkuJ6Uw8GKrm14ZCM0u0b9dqA9iara/KStRi1ZOqfw+w7dU7VuVSzyRu+Xe3ZqR1ttLsCVpzzQGSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779106928; c=relaxed/relaxed;
	bh=oHFWziLvncRM91/hv45QHybaLAi9Rx72zyGVXfpBHSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbvjq5JsPJM1BShbsVTiME4snX/SKf7FhnUhAs/bza/V4TGjfPVCMY7Z9hqF8mOYIqAe+cy6FxnH1+u/8v1EafRq7bSaUaanc5Fn6+fu7YnM0aGkGmNxwT2m3fYGdkN6xipGX9vcpMLSkUTQ4cavLXo6y6lBbasmOZPuCxIO/bAC7SfcoSPF72zxGCZcPePqNIgWDaqSdI467ReMw1VOS2u75EUNtu4LUF/FKe7rDK/2q3bAanpkF4amSt8lT9FFFId3+Tbjvy/SejZw07V73KyRd+AoMkm2SIyZb0PNDY0w/5Ce66ADdM7H5qTLfOCoIyIPuX3euoIuaYbGmM3isg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dwnG5/yL; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dwnG5/yL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJxkm0NV6z2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 22:22:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779106926;
	bh=oHFWziLvncRM91/hv45QHybaLAi9Rx72zyGVXfpBHSY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dwnG5/yL+eIioBdYDufbaQO2CbDUv/QlepkSyOxUnpJIvJqqekxWCN6gcZg5xxrjv
	 FPaUEVzokmrjgz3icibmQZ0nXfqNNItRZBLmFH13t9bP4Qfpu/ikoWMN+Mf3przGCa
	 +5NgQbpiYSTHytvXpZP1y3PVwUnwrfnmzasJgNYJgXPjzIshUmszQo5Z051BYFigz2
	 Ll8YPaQYGQDqYOSNLp7EgM1PTOdOir2aa1GKJXfAETkfLIOtdP9c4bq8UxzosrOStq
	 PBXt4X0AKUSfDYWnrWl3HFpnW/gwhSN4TeWIAIXJA5U5X4QA5geRKEjK8e3cTiK7lz
	 jvAYxcjUyqLVw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DFEF26024D;
	Mon, 18 May 2026 20:22:05 +0800 (AWST)
Message-ID: <e5d1cbdb34dddf17b4d474446fb9cebddc0894d9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v13 2/2] arm: dts: aspeed: ventura: add Meta Ventura BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "P.K. Lee" <pkleequanta@gmail.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Jason-Hsu@quantatw.com, p.k.lee@quantatw.com
Date: Mon, 18 May 2026 21:52:05 +0930
In-Reply-To: <20260407081700.2658011-3-pkleequanta@gmail.com>
References: <20260407081700.2658011-1-pkleequanta@gmail.com>
	 <20260407081700.2658011-3-pkleequanta@gmail.com>
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

Hi P.K.

On Tue, 2026-04-07 at 16:17 +0800, P.K. Lee wrote:
> Add Linux device tree related to Meta (Facebook) Ventura specific
> devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
> detect liquid leakage from all compute trays, switch trays and rack
> sensors within the rack, log the events, and take necessary actions
> accordingly.
>=20
> Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-facebook-ventura.dts=C2=A0=C2=A0=C2=A0 | 1636=
 +++++++++++++++++
> =C2=A02 files changed, 1637 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ven=
tura.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 0f0b5b707654..f5ac72d5933c 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-facebook-minipack.dtb \
> =C2=A0	aspeed-bmc-facebook-santabarbara.dtb \
> =C2=A0	aspeed-bmc-facebook-tiogapass.dtb \
> +	aspeed-bmc-facebook-ventura.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge40.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge100.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge400-data64.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
> new file mode 100644
> index 000000000000..6ce6201f7755
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
> @@ -0,0 +1,1636 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model =3D "Facebook ventura RMC";

I suggest capitalising 'Ventura'.

> +	compatible =3D "facebook,ventura-rmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 =3D &uart5;
> +		i2c16 =3D &i2c3mux0ch3;
> +		i2c17 =3D &i2c3mux0ch4;
> +		i2c18 =3D &i2c3mux0ch5;
> +		i2c19 =3D &i2c3mux0ch6;
> +		i2c20 =3D &i2c3mux0ch0;
> +		i2c21 =3D &i2c3mux0ch1;
> +		i2c22 =3D &i2c3mux0ch2;
> +		i2c23 =3D &i2c3mux0ch7;
> +		i2c24 =3D &i2c0mux0ch0;
> +		i2c25 =3D &i2c0mux0ch1;
> +		i2c26 =3D &i2c0mux0ch2;
> +		i2c27 =3D &i2c0mux0ch3;
> +		i2c28 =3D &i2c0mux0ch4;
> +		i2c29 =3D &i2c0mux0ch5;
> +		i2c30 =3D &i2c0mux0ch6;
> +		i2c31 =3D &i2c0mux0ch7;
> +		i2c32 =3D &i2c1mux0ch0;
> +		i2c33 =3D &i2c1mux0ch1;
> +		i2c34 =3D &i2c1mux0ch2;
> +		i2c35 =3D &i2c1mux0ch3;
> +		i2c36 =3D &i2c1mux0ch4;
> +		i2c37 =3D &i2c1mux0ch5;
> +		i2c38 =3D &i2c1mux0ch6;
> +		i2c39 =3D &i2c1mux0ch7;
> +		i2c40 =3D &i2c2mux0ch0;
> +		i2c41 =3D &i2c2mux0ch1;
> +		i2c42 =3D &i2c2mux0ch2;
> +		i2c43 =3D &i2c2mux0ch3;
> +		i2c44 =3D &i2c2mux0ch4;
> +		i2c45 =3D &i2c2mux0ch5;
> +		i2c46 =3D &i2c2mux0ch6;
> +		i2c47 =3D &i2c2mux0ch7;

Many of the buses aliased here don't have any devices described below
them. Can you add some commentary about why it's necessary to enable
and alias each of these?

> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial4:57600n8";
> +	};
> +
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +			<&adc1 2>;
> +	};
> +

...

> +		i2c3mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +
> +			adc@1f {
> +				compatible =3D "ti,adc128d818";
> +				reg =3D <0x1f>;
> +				ti,mode =3D /bits/ 8 <1>;
> +			};
> +
> +			fan_leds_g2_gpio: gpio@21 {
> +				compatible =3D "nxp,pca9555";
> +				reg =3D <0x21>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +
> +				gpio-line-names =3D
> +				"", "",
> +				"", "",
> +				"", "",
> +				"", "",
> +				"FAN2_PRSNT", "FAN3_PRSNT",
> +				"", "",
> +				"", "",
> +				"", "";
> +			};
> +
> +			adc@35 {
> +				compatible =3D "maxim,max11617";
> +				reg =3D <0x35>;
> +			};
> +
> +			// Fan Board 1 FRU

I'd rather we pick one commenting style (/* */). Can you please fix
that throughout?

> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c3mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +
> +			pwm@20 {
> +				compatible =3D "maxim,max31790";
> +				reg =3D <0x20>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				channel@2 {
> +					reg =3D <2>;
> +					sensor-type =3D "TACH";
> +				};
> +				channel@5 {
> +					reg =3D <5>;
> +					sensor-type =3D "TACH";
> +				};
> +			};
> +
> +			hwmon: hwmon@23 {
> +				compatible =3D "nuvoton,nct7363";
> +				reg =3D <0x23>;
> +				#pwm-cells =3D <2>;
> +
> +				//fan 0 IL

Can you please add a space between the comment marker and the comment
itself? This needs fixing throughout.

> +				fan-0 {
> +					pwms =3D <&hwmon 0 20000>;
> +					tach-ch =3D /bits/ 8 <0x09>;
> +				};
> +
> +				//fan 0 OL
> +				fan-1 {
> +					pwms =3D <&hwmon 0 20000>;
> +					tach-ch =3D /bits/ 8 <0x0B>;
> +				};
> +
> +				//fan 1 IL
> +				fan-2 {
> +					pwms =3D <&hwmon 4 20000>;
> +					tach-ch =3D /bits/ 8 <0x0A>;
> +				};
> +
> +				//fan 1 OL
> +				fan-3 {
> +					pwms =3D <&hwmon 4 20000>;
> +					tach-ch =3D /bits/ 8 <0x0D>;
> +				};
> +
> +				//fan 2 IL
> +				fan-4 {
> +					pwms =3D <&hwmon 6 20000>;
> +					tach-ch =3D /bits/ 8 <0x0F>;
> +				};
> +
> +				//fan 2 OL
> +				fan-5 {
> +					pwms =3D <&hwmon 6 20000>;
> +					tach-ch =3D /bits/ 8 <0x01>;
> +				};
> +
> +				//fan 3 IL
> +				fan-6 {
> +					pwms =3D <&hwmon 10 20000>;
> +					tach-ch =3D /bits/ 8 <0x00>;
> +				};
> +
> +				//fan 3 OL
> +				fan-7 {
> +					pwms =3D <&hwmon 10 20000>;
> +					tach-ch =3D /bits/ 8 <0x03>;
> +				};
> +			};
> +		};
> +
>=20

...

> +
> +&mdio0 {
> +	status =3D "okay";
> +	/* * Intentionally left empty.

The comment is a bit busted here. Can you please fix it?

Andrew

> +	 * Enabled to allow user-space tools (e.g., mdio)
> +	 * to access the unmanaged Marvell switch registers.
> +	 */
> +};
> +

