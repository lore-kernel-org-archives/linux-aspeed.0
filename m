Return-Path: <linux-aspeed+bounces-4213-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37515CD8CB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 11:15:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb38n1Ycgz2xll;
	Wed, 10 Jun 2026 21:15:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781090105;
	cv=none; b=BE8Z7mU6BEY/ag95XzHWDKvJsKm/8sqtqX+Q37mwuGy71/TXR9B1y5VExGuSH7pX25NFRJPQ27o+tTsnvqC5tTlLUYaJ4EN+hSL+tJFzrdF2Eq9WCyf2qTVA9FGYFD8GWSCNX0g+KnrS4aLmUyneM5zeFiinAg/M+tYvx1rHfWuUSHof20Q7hsW4AaD+3wymSGKhrEcwZWrVhQ160CyCLTjJogGE9JoW3N+khbfoY8ZI/I0MRxr+w09uQY72CwhUvjpS40YlrlTX5vGdvj0cp6aCaOW5okpvfgIf7RUklOqRpSd3CeP6bBGOV7CgEs7bsmSJV9diQBu8HaJLLWxl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781090105; c=relaxed/relaxed;
	bh=huOArweXhGZIE9bNjo12S1RadYYw8h6SUyOuwXeK+9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxYicvEt7p9gwYQ50PQ0chhFUSe/4Se6H20JuHYOkZU4tAVIJjdDE7Oup3MmaPoPQHslSg8p5H9sFVqoVfHA4PDpapdoORBfRwheNeTKDu8KcL76s//ec1Uy8dvbsrTysxfmd1BuRiNn2tA3vlMw5gUtGGj+IrhFec3HhpI0TCqvKCR7pfPtObNpLKVQ4ZQ55p//iVwnWpfhMi2j1jy8Agyt6K+76lo9YstAjZZRGsPzsl9co9O3ctknLe68HUvc6Ow7WKEus2BmI7tJVmtZkYzVKaIDOTTVPPwsvesecZENjkvBON+hf/QERsRC1bMKKvXUZQ43MiwpumMBevmjzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GS2dT7ky; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GS2dT7ky;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb38m2nm4z2xdb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 21:15:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781090103;
	bh=huOArweXhGZIE9bNjo12S1RadYYw8h6SUyOuwXeK+9c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GS2dT7kyT+8KmH/uyXKZYYMSKcKjdLp2WjzBp+OrvXxhLfoSk+nuo0AGiKUXPSDKb
	 ogljH0Z4KhiNg7c7//rN+PxEOaiAIUZnbZxnVQP2BZZ/hOrAcScGbIcA2OyIcG5uY2
	 3JnXl7nYmOqmNSAY1UTpRdm19/pUHGiCNV4+w37ya5KjAhNGojedO02bv8PDIsuXU0
	 BAA32Z1hDNlouzgEN4WhBpEZ3IYemBluFlO6V8epIeaz5adY+2b13NdYQ2E3WRPl7f
	 8Ef+ffTcSoG8ronceSCvim4zaXtgkEws3EqrEZs+tdeo7BOrbvVqMdpHZuajVSSbaq
	 IJOpOzwdXc3Fg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E6E3760A19;
	Wed, 10 Jun 2026 19:15:02 +0800 (AWST)
Message-ID: <3d56889c004fc2d11b76ace6033c7ccfb8a37d03.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:45:02 +0930
In-Reply-To: <20260608-ventura2_initial_dts-v5-2-37ee5bcf58b6@gmail.com>
References: <20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com>
	 <20260608-ventura2_initial_dts-v5-2-37ee5bcf58b6@gmail.com>
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

Hi Kyle,

On Mon, 2026-06-08 at 10:42 +0800, Kyle Hsieh wrote:
> Add linux device tree entry related to the Meta(Facebook) rmc-node.

This is redundant as it is evident from the patch itself. Can you
please remove it?

> The system use an AT2600 BMC.
> This node is named "ventura2".

Can you provide some more detail about the platform in the commit
message? What's it's purpose? Can you describe some interesting
features or details about its design?

>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-ventura2.dts=C2=A0=C2=A0=C2=A0 |=
 2888 ++++++++++++++++++++
> =C2=A02 files changed, 2889 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 9adf9278dc94..6b96997629d4 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-facebook-minipack.dtb \
> =C2=A0	aspeed-bmc-facebook-santabarbara.dtb \
> =C2=A0	aspeed-bmc-facebook-tiogapass.dtb \
> +	aspeed-bmc-facebook-ventura2.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge40.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge100.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge400-data64.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> new file mode 100644
> index 000000000000..9bf7d6e52e40
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> @@ -0,0 +1,2888 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model =3D "Facebook Ventura2 RMC";
> +	compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
>=20

...

> +};
> +

...

> +&gpio1 {
> +	gpio-line-names =3D
> +	/*18A0-18A7*/	"","","","","","","","",
> +	/*18B0-18B7*/	"","","","",
> +			"FM_BOARD_BMC_REV_ID0","FM_BOARD_BMC_REV_ID1",
> +			"FM_BOARD_BMC_REV_ID2","",
> +	/*18C0-18C7*/	"SPI_BMC_BIOS_ROM_IRQ0_R_N","","","","","","","",
> +	/*18D0-18D7*/	"","","","","","","","",
> +	/*18E0-18E3*/	"FM_BMC_PROT_LS_EN","AC_PWR_BMC_BTN_R_N","","";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c0mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +		};
> +
> +		i2c0mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +		};
> +
> +		i2c0mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +		};
> +
> +		i2c0mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c0mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c0mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c0mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +
> +			fan_io_expander0: gpio@20 {
> +				compatible =3D "nxp,pca9555";
> +				reg =3D <0x20>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			fan_io_expander1: gpio@21 {
> +				compatible =3D "nxp,pca9555";
> +				reg =3D <0x21>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +			};
> +
> +			adc@1d {
> +				compatible =3D "ti,adc128d818";
> +				reg =3D <0x1d>;
> +				ti,mode =3D /bits/ 8 <1>;
> +			};
> +
> +			adc@35 {
> +				compatible =3D "maxim,max11617";
> +				reg =3D <0x35>;
> +			};
> +		};
> +
> +		i2c0mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +
> +			fanctl0: fan-controller@20 {
> +				compatible =3D "maxim,max31790";
> +				reg =3D <0x20>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				channel@2 {

Can you make sure that you consistently use a blank line to separate
child nodes from each other and from properties in their parent?

Please fix throughout.

> +					reg =3D <2>;
> +					sensor-type =3D "TACH";
> +				};
> +				channel@5 {
> +					reg =3D <5>;
> +					sensor-type =3D "TACH";
> +				};
> +			};
> +
> +			fanctl1: fan-controller@23 {
> +				compatible =3D "nuvoton,nct7363";
> +				reg =3D <0x23>;
> +				#pwm-cells =3D <2>;
> +
> +				fan-9 {
> +					pwms =3D <&fanctl1 0 20000>;
> +					tach-ch =3D /bits/ 8 <0x09>;
> +				};
> +
> +				fan-11 {
> +					pwms =3D <&fanctl1 0 20000>;
> +					tach-ch =3D /bits/ 8 <0x0B>;
> +				};
> +
> +				fan-10 {
> +					pwms =3D <&fanctl1 4 20000>;
> +					tach-ch =3D /bits/ 8 <0x0A>;
> +				};
> +
> +				fan-13 {
> +					pwms =3D <&fanctl1 4 20000>;
> +					tach-ch =3D /bits/ 8 <0x0D>;
> +				};
> +
> +				fan-15 {
> +					pwms =3D <&fanctl1 6 20000>;
> +					tach-ch =3D /bits/ 8 <0x0F>;
> +				};
> +
> +				fan-1 {

Can you please sort the fan nodes in ascending order?

> +					pwms =3D <&fanctl1 6 20000>;
> +					tach-ch =3D /bits/ 8 <0x01>;
> +				};
> +
> +				fan-0 {
> +					pwms =3D <&fanctl1 10 20000>;
> +					tach-ch =3D /bits/ 8 <0x00>;
> +				};
> +
> +				fan-3 {
> +					pwms =3D <&fanctl1 10 20000>;
> +					tach-ch =3D /bits/ 8 <0x03>;
> +				};
> +			};
> +		};
> +	};
> +};
>=20

...

> +
> +	// Marvell 88E6393X EEPROM

Please try to be consistent with the comment style (prefer /* */).

> +	eeprom@50 {
> +		compatible =3D "atmel,24c64";
> +		reg =3D <0x50>;
> +	};
> +
> +	rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +	};
> +};
> +

