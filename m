Return-Path: <linux-aspeed+bounces-3333-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07569D3CC88
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 01:24:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds4zF4wyRz2xqj;
	Thu, 15 Jan 2026 12:24:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768440297;
	cv=none; b=Hc1G0uzNvcs2BGuokJCaqu0yx1A7wITfRy8W5gVEw8cRupRKljpPble+Ja5KZf/1tI+o+7Sxqegi7Vowfoxu/oulp9YBWDlTYZafNMp26O9ZcMiV9x89KVy+uM20aScwBeNF0ZCFZE+2yXxuXE2vHYaq2KEVcYJqE2623aY0GPvH/G4Hfg2QYbMh3QhHAAvwTRNiyWxAUYD++7dUbhXUYl3e6sVc+z4M5UHyHEdjy2NS652rwh6cCMgGHfhMWpnO+LX8bCqHqOPZQbq7RVR+y7njBbVzpENXkf2VpP/ouWyn1tGU5RnNIcQJihKbSRo1ID34DZy4PzJDhuiyGL4rtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768440297; c=relaxed/relaxed;
	bh=scQ9LMb+W1VW4eYWUgRU7of0LpBW7Oo2Q4Ldq3EYPF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGTRTgxHVJYSt4Y5r0jgF/GRh0XrZ55vH9kNGREZA1HjaHcFR2jCqQJ8fIN3aspzV9MX/rylAwmnpO8PW0OQ1K2o95GqGOZJ3IZ7BQa276oE5Ez0AzaZNISczdww/aQsPBubZ/t3qEbgiJ6B4HTVS2vzAf/77A+XGbeqaj89jkJaCLwo/eQoiG8zmeVJukr8cBNU6zBn+baSex57uFw4DK62eaMppAEqwHzJ40HBnrJ6AcNMv0//TDH1EsrXHv0ZB4wi2/hy3SsCR/Zjumw81ARFfpDZIxv/wEFJIeSUqBk4awvZHiKfaw0UvIWQhzg1fFbLW5IvH2g/vIRCTO+iqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=H6IXysFr; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=H6IXysFr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds4zD4vr7z2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 12:24:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768440296;
	bh=scQ9LMb+W1VW4eYWUgRU7of0LpBW7Oo2Q4Ldq3EYPF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H6IXysFrlrilO6qgbcHbbwP5DMlPJAV/3Zsw8jSfCZuS/ww+SXxCD21/c16SBtoBT
	 nueIoVMZRWPNl0lD9OzfwHi+FjIuNk/8NrC6pYseoAqaLI4trGjYRt/DDgaQGWWSca
	 AfuQ34XjkbnnqcnpEwpCXtVu0nNZFt7fWb4GS62TC+jjz0VrIzdCxdJQEAlbdyY3n+
	 cEuYOjfrZ6i2KuCG0n3Fn+GNhwAKJar8KLy3f5oTlWhf79eGWgS41QEjWbJk27ti6L
	 tRUzn7dEzhznIukGJa3769GxJbRr7U3atTaWIov6kkPai7HWOh0hJCfLd7PlDIX4Ab
	 XeATDYLsrLavw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7B9826472A;
	Thu, 15 Jan 2026 09:24:55 +0800 (AWST)
Message-ID: <c0f31e45d0324f8aec4fe6ebeae50a4d69b7026e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 11:54:55 +1030
In-Reply-To: <20260113-ventura2_initial_dts-v3-2-2dbfda6a5b47@gmail.com>
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
	 <20260113-ventura2_initial_dts-v3-2-2dbfda6a5b47@gmail.com>
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

On Tue, 2026-01-13 at 10:57 +0800, Kyle Hsieh wrote:
> Add linux device tree entry related to the Meta(Facebook) rmc-node.
> The system use an AT2600 BMC.
> This node is named "ventura2".
>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-ventura2.dts=C2=A0=C2=A0=C2=A0 |=
 2874
> ++++++++++++++++++++
> =C2=A02 files changed, 2875 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile
> b/arch/arm/boot/dts/aspeed/Makefile
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
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> ventura2.dts
> new file mode 100644
> index 000000000000..be9a166d0b41
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> @@ -0,0 +1,2874 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model =3D "Facebook ventura2 RMC";

I feel 'ventura2' should be capitalised ('Ventura2')?

> +	compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> +	aliases {
> +=09

*snip*

> +
> +&gpio0 {
> +	gpio-line-names =3D
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"BATTERY_DETECT","","","BMC_READY_R",
> +				"","FM_ID_LED","","",

I'm not a huge fan of this indentation approach. Can we maintain the
initial alignment instead? See e.g. aspeed/aspeed-bmc-facebook-
yosemite5.dts

> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"","","","","","","","",
> +	/*G0-G7*/	"FM_MUX1_SEL_R","","","",
> +				"","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","","","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","STBY_POWER_PG_3V3","","","",
> +	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
> +				"LED_POSTCODE_2","LED_POSTCODE_3",
> +				"LED_POSTCODE_4","LED_POSTCODE_5",
> +				"LED_POSTCODE_6","LED_POSTCODE_7",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-
> P7*/	"PWR_BTN_BMC_BUF_N","","ID_RST_BTN_BMC_N","",
> +				"PWR_LED","","","BMC_HEARTBEAT_N",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/	"","","","","","","","";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =3D
> +	/*18A0-18A7*/	"","","","","","","","",
> +	/*18B0-18B7*/	"","","","",
> +					"FM_BOARD_BMC_REV_ID0","FM_B
> OARD_BMC_REV_ID1",
> +					"FM_BOARD_BMC_REV_ID2","",

Again, this alignment looks quite whacky to me.

> +	/*18C0-
> 18C7*/	"SPI_BMC_BIOS_ROM_IRQ0_R_N","","","","","","","",
> +	/*18D0-18D7*/	"","","","","","","","",
> +	/*18E0-
> 18E3*/	"FM_BMC_PROT_LS_EN","AC_PWR_BMC_BTN_R_N","","";
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
> +			temp-sensor@4c {
> +				compatible =3D "adi,adt7461";
> +				reg =3D <0x4c>;
> +			};
> +		};
> +
> +		i2c0mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			temp-sensor@4c {
> +				compatible =3D "adi,adt7461";
> +				reg =3D <0x4c>;
> +			};
> +		};
> +
> +		i2c0mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
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
> +
> +				gpio-line-names =3D
> +				"FM_FAN0_POWER_LED_N",
> "FM_FAN1_POWER_LED_N",
> +				"P12V_FAN0_PWR_GD",
> "P12V_FAN1_PWR_GD",
> +				"FM_FAN0_FAULT_LED_N",
> "FM_FAN1_FAULT_LED_N",
> +				"P12V_FAN0_FLTB", "P12V_FAN1_FLTB",
> +				"FM_FAN0_BUF_PRESENT_R",
> "FM_FAN1_BUF_PRESENT_R",
> +				"", "",
> +				"FM_FAN0_P12V_EN",
> "FM_FAN1_P12V_EN",
> +				"", "";
> +			};
> +
> +			fan_io_expander1: gpio@21 {
> +				compatible =3D "nxp,pca9555";
> +				reg =3D <0x21>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +
> +				gpio-line-names =3D
> +				"FM_FAN2_POWER_LED_N",
> "FM_FAN3_POWER_LED_N",
> +				"P12V_FAN2_PWR_GD",
> "P12V_FAN3_PWR_GD",
> +				"FM_FAN2_FAULT_LED_N",
> "FM_FAN3_FAULT_LED_N",
> +				"P12V_FAN2_FLTB", "P12V_FAN3_FLTB",
> +				"FM_FAN2_BUF_PRESENT_R",
> "FM_FAN3_BUF_PRESENT_R",
> +				"", "",
> +				"FM_FAN2_P12V_EN",
> "FM_FAN3_P12V_EN",
> +				"", "";
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
> +
> +&i2c1 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c1mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c1mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +	bus-frequency =3D <400000>;
> +};
> +
> +&i2c3 {
> +	status =3D "okay";
> +	bus-frequency =3D <400000>;
> +
> +	dac@c {
> +		reg =3D <0x0c>;
> +		compatible =3D "adi,ad5612";
> +		vcc-supply =3D <&p5v_dac_aux>;
> +	};
> +
> +	dac@e {
> +		reg =3D <0x0e>;
> +		compatible =3D "adi,ad5612";
> +		vcc-supply =3D <&p5v_dac_aux>;
> +	};
> +
> +	dac@f {
> +		reg =3D <0x0f>;
> +		compatible =3D "adi,ad5612";
> +		vcc-supply =3D <&p5v_dac_aux>;
> +	};
> +
> +	prsnt_io_expander0: gpio@30 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x30>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <48 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN1_TRAY1_PRSNT", "CAN1_TRAY2_PRSNT",

Can you increase the indentation here to distinguish the values from
the properties? And fix throughout?

> +		"CAN1_TRAY3_PRSNT", "CAN1_TRAY4_PRSNT",
> +		"CAN1_TRAY5_PRSNT", "CAN1_TRAY6_PRSNT",
> +		"CAN1_TRAY7_PRSNT", "CAN1_TRAY8_PRSNT",
> +		"CAN1_TRAY9_PRSNT", "CAN1_TRAY10_PRSNT",
> +		"CAN1_TRAY11_PRSNT", "CAN1_TRAY12_PRSNT",
> +		"CAN1_TRAY13_PRSNT", "CAN1_TRAY14_PRSNT",
> +		"CAN1_TRAY15_PRSNT", "CAN1_TRAY16_PRSNT",
> +		"CAN1_TRAY17_PRSNT", "CAN1_TRAY18_PRSNT",
> +		"CAN1_TRAY19_PRSNT", "CAN1_TRAY20_PRSNT",
> +		"CAN1_TRAY21_PRSNT", "CAN1_TRAY22_PRSNT",
> +		"CAN1_TRAY23_PRSNT", "CAN1_TRAY24_PRSNT",
> +		"CAN1_TRAY25_PRSNT", "CAN1_TRAY26_PRSNT",
> +		"CAN1_TRAY27_PRSNT", "CAN1_TRAY28_PRSNT",
> +		"CAN1_TRAY29_PRSNT", "CAN1_TRAY30_PRSNT",
> +		"CAN1_TRAY31_PRSNT", "CAN1_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander1: gpio@31 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x31>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <56 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN2_TRAY1_PRSNT", "CAN2_TRAY2_PRSNT",
> +		"CAN2_TRAY3_PRSNT", "CAN2_TRAY4_PRSNT",
> +		"CAN2_TRAY5_PRSNT", "CAN2_TRAY6_PRSNT",
> +		"CAN2_TRAY7_PRSNT", "CAN2_TRAY8_PRSNT",
> +		"CAN2_TRAY9_PRSNT", "CAN2_TRAY10_PRSNT",
> +		"CAN2_TRAY11_PRSNT", "CAN2_TRAY12_PRSNT",
> +		"CAN2_TRAY13_PRSNT", "CAN2_TRAY14_PRSNT",
> +		"CAN2_TRAY15_PRSNT", "CAN2_TRAY16_PRSNT",
> +		"CAN2_TRAY17_PRSNT", "CAN2_TRAY18_PRSNT",
> +		"CAN2_TRAY19_PRSNT", "CAN2_TRAY20_PRSNT",
> +		"CAN2_TRAY21_PRSNT", "CAN2_TRAY22_PRSNT",
> +		"CAN2_TRAY23_PRSNT", "CAN2_TRAY24_PRSNT",
> +		"CAN2_TRAY25_PRSNT", "CAN2_TRAY26_PRSNT",
> +		"CAN2_TRAY27_PRSNT", "CAN2_TRAY28_PRSNT",
> +		"CAN2_TRAY29_PRSNT", "CAN2_TRAY30_PRSNT",
> +		"CAN2_TRAY31_PRSNT", "CAN2_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander2: gpio@32 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x32>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <64 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN3_TRAY1_PRSNT", "CAN3_TRAY2_PRSNT",
> +		"CAN3_TRAY3_PRSNT", "CAN3_TRAY4_PRSNT",
> +		"CAN3_TRAY5_PRSNT", "CAN3_TRAY6_PRSNT",
> +		"CAN3_TRAY7_PRSNT", "CAN3_TRAY8_PRSNT",
> +		"CAN3_TRAY9_PRSNT", "CAN3_TRAY10_PRSNT",
> +		"CAN3_TRAY11_PRSNT", "CAN3_TRAY12_PRSNT",
> +		"CAN3_TRAY13_PRSNT", "CAN3_TRAY14_PRSNT",
> +		"CAN3_TRAY15_PRSNT", "CAN3_TRAY16_PRSNT",
> +		"CAN3_TRAY17_PRSNT", "CAN3_TRAY18_PRSNT",
> +		"CAN3_TRAY19_PRSNT", "CAN3_TRAY20_PRSNT",
> +		"CAN3_TRAY21_PRSNT", "CAN3_TRAY22_PRSNT",
> +		"CAN3_TRAY23_PRSNT", "CAN3_TRAY24_PRSNT",
> +		"CAN3_TRAY25_PRSNT", "CAN3_TRAY26_PRSNT",
> +		"CAN3_TRAY27_PRSNT", "CAN3_TRAY28_PRSNT",
> +		"CAN3_TRAY29_PRSNT", "CAN3_TRAY30_PRSNT",
> +		"CAN3_TRAY31_PRSNT", "CAN3_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander3: gpio@33 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x33>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <72 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN4_TRAY1_PRSNT", "CAN4_TRAY2_PRSNT",
> +		"CAN4_TRAY3_PRSNT", "CAN4_TRAY4_PRSNT",
> +		"CAN4_TRAY5_PRSNT", "CAN4_TRAY6_PRSNT",
> +		"CAN4_TRAY7_PRSNT", "CAN4_TRAY8_PRSNT",
> +		"CAN4_TRAY9_PRSNT", "CAN4_TRAY10_PRSNT",
> +		"CAN4_TRAY11_PRSNT", "CAN4_TRAY12_PRSNT",
> +		"CAN4_TRAY13_PRSNT", "CAN4_TRAY14_PRSNT",
> +		"CAN4_TRAY15_PRSNT", "CAN4_TRAY16_PRSNT",
> +		"CAN4_TRAY17_PRSNT", "CAN4_TRAY18_PRSNT",
> +		"CAN4_TRAY19_PRSNT", "CAN4_TRAY20_PRSNT",
> +		"CAN4_TRAY21_PRSNT", "CAN4_TRAY22_PRSNT",
> +		"CAN4_TRAY23_PRSNT", "CAN4_TRAY24_PRSNT",
> +		"CAN4_TRAY25_PRSNT", "CAN4_TRAY26_PRSNT",
> +		"CAN4_TRAY27_PRSNT", "CAN4_TRAY28_PRSNT",
> +		"CAN4_TRAY29_PRSNT", "CAN4_TRAY30_PRSNT",
> +		"CAN4_TRAY31_PRSNT", "CAN4_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander4: gpio@34 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x34>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <80 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN5_TRAY1_PRSNT", "CAN5_TRAY2_PRSNT",
> +		"CAN5_TRAY3_PRSNT", "CAN5_TRAY4_PRSNT",
> +		"CAN5_TRAY5_PRSNT", "CAN5_TRAY6_PRSNT",
> +		"CAN5_TRAY7_PRSNT", "CAN5_TRAY8_PRSNT",
> +		"CAN5_TRAY9_PRSNT", "CAN5_TRAY10_PRSNT",
> +		"CAN5_TRAY11_PRSNT", "CAN5_TRAY12_PRSNT",
> +		"CAN5_TRAY13_PRSNT", "CAN5_TRAY14_PRSNT",
> +		"CAN5_TRAY15_PRSNT", "CAN5_TRAY16_PRSNT",
> +		"CAN5_TRAY17_PRSNT", "CAN5_TRAY18_PRSNT",
> +		"CAN5_TRAY19_PRSNT", "CAN5_TRAY20_PRSNT",
> +		"CAN5_TRAY21_PRSNT", "CAN5_TRAY22_PRSNT",
> +		"CAN5_TRAY23_PRSNT", "CAN5_TRAY24_PRSNT",
> +		"CAN5_TRAY25_PRSNT", "CAN5_TRAY26_PRSNT",
> +		"CAN5_TRAY27_PRSNT", "CAN5_TRAY28_PRSNT",
> +		"CAN5_TRAY29_PRSNT", "CAN5_TRAY30_PRSNT",
> +		"CAN5_TRAY31_PRSNT", "CAN5_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander5: gpio@35 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x35>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN6_TRAY1_PRSNT", "CAN6_TRAY2_PRSNT",
> +		"CAN6_TRAY3_PRSNT", "CAN6_TRAY4_PRSNT",
> +		"CAN6_TRAY5_PRSNT", "CAN6_TRAY6_PRSNT",
> +		"CAN6_TRAY7_PRSNT", "CAN6_TRAY8_PRSNT",
> +		"CAN6_TRAY9_PRSNT", "CAN6_TRAY10_PRSNT",
> +		"CAN6_TRAY11_PRSNT", "CAN6_TRAY12_PRSNT",
> +		"CAN6_TRAY13_PRSNT", "CAN6_TRAY14_PRSNT",
> +		"CAN6_TRAY15_PRSNT", "CAN6_TRAY16_PRSNT",
> +		"CAN6_TRAY17_PRSNT", "CAN6_TRAY18_PRSNT",
> +		"CAN6_TRAY19_PRSNT", "CAN6_TRAY20_PRSNT",
> +		"CAN6_TRAY21_PRSNT", "CAN6_TRAY22_PRSNT",
> +		"CAN6_TRAY23_PRSNT", "CAN6_TRAY24_PRSNT",
> +		"CAN6_TRAY25_PRSNT", "CAN6_TRAY26_PRSNT",
> +		"CAN6_TRAY27_PRSNT", "CAN6_TRAY28_PRSNT",
> +		"CAN6_TRAY29_PRSNT", "CAN6_TRAY30_PRSNT",
> +		"CAN6_TRAY31_PRSNT", "CAN6_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander6: gpio@36 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x36>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <96 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN7_TRAY1_PRSNT", "CAN7_TRAY2_PRSNT",
> +		"CAN7_TRAY3_PRSNT", "CAN7_TRAY4_PRSNT",
> +		"CAN7_TRAY5_PRSNT", "CAN7_TRAY6_PRSNT",
> +		"CAN7_TRAY7_PRSNT", "CAN7_TRAY8_PRSNT",
> +		"CAN7_TRAY9_PRSNT", "CAN7_TRAY10_PRSNT",
> +		"CAN7_TRAY11_PRSNT", "CAN7_TRAY12_PRSNT",
> +		"CAN7_TRAY13_PRSNT", "CAN7_TRAY14_PRSNT",
> +		"CAN7_TRAY15_PRSNT", "CAN7_TRAY16_PRSNT",
> +		"CAN7_TRAY17_PRSNT", "CAN7_TRAY18_PRSNT",
> +		"CAN7_TRAY19_PRSNT", "CAN7_TRAY20_PRSNT",
> +		"CAN7_TRAY21_PRSNT", "CAN7_TRAY22_PRSNT",
> +		"CAN7_TRAY23_PRSNT", "CAN7_TRAY24_PRSNT",
> +		"CAN7_TRAY25_PRSNT", "CAN7_TRAY26_PRSNT",
> +		"CAN7_TRAY27_PRSNT", "CAN7_TRAY28_PRSNT",
> +		"CAN7_TRAY29_PRSNT", "CAN7_TRAY30_PRSNT",
> +		"CAN7_TRAY31_PRSNT", "CAN7_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	prsnt_io_expander7: gpio@37 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x37>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <104 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN8_TRAY1_PRSNT", "CAN8_TRAY2_PRSNT",
> +		"CAN8_TRAY3_PRSNT", "CAN8_TRAY4_PRSNT",
> +		"CAN8_TRAY5_PRSNT", "CAN8_TRAY6_PRSNT",
> +		"CAN8_TRAY7_PRSNT", "CAN8_TRAY8_PRSNT",
> +		"CAN8_TRAY9_PRSNT", "CAN8_TRAY10_PRSNT",
> +		"CAN8_TRAY11_PRSNT", "CAN8_TRAY12_PRSNT",
> +		"CAN8_TRAY13_PRSNT", "CAN8_TRAY14_PRSNT",
> +		"CAN8_TRAY15_PRSNT", "CAN8_TRAY16_PRSNT",
> +		"CAN8_TRAY17_PRSNT", "CAN8_TRAY18_PRSNT",
> +		"CAN8_TRAY19_PRSNT", "CAN8_TRAY20_PRSNT",
> +		"CAN8_TRAY21_PRSNT", "CAN8_TRAY22_PRSNT",
> +		"CAN8_TRAY23_PRSNT", "CAN8_TRAY24_PRSNT",
> +		"CAN8_TRAY25_PRSNT", "CAN8_TRAY26_PRSNT",
> +		"CAN8_TRAY27_PRSNT", "CAN8_TRAY28_PRSNT",
> +		"CAN8_TRAY29_PRSNT", "CAN8_TRAY30_PRSNT",
> +		"CAN8_TRAY31_PRSNT", "CAN8_TRAY32_PRSNT",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander0: gpio@38 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x38>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <50 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN1_TRAY1_PWRGD", "CAN1_TRAY2_PWRGD",
> +		"CAN1_TRAY3_PWRGD", "CAN1_TRAY4_PWRGD",
> +		"CAN1_TRAY5_PWRGD", "CAN1_TRAY6_PWRGD",
> +		"CAN1_TRAY7_PWRGD", "CAN1_TRAY8_PWRGD",
> +		"CAN1_TRAY9_PWRGD", "CAN1_TRAY10_PWRGD",
> +		"CAN1_TRAY11_PWRGD", "CAN1_TRAY12_PWRGD",
> +		"CAN1_TRAY13_PWRGD", "CAN1_TRAY14_PWRGD",
> +		"CAN1_TRAY15_PWRGD", "CAN1_TRAY16_PWRGD",
> +		"CAN1_TRAY17_PWRGD", "CAN1_TRAY18_PWRGD",
> +		"CAN1_TRAY19_PWRGD", "CAN1_TRAY20_PWRGD",
> +		"CAN1_TRAY21_PWRGD", "CAN1_TRAY22_PWRGD",
> +		"CAN1_TRAY23_PWRGD", "CAN1_TRAY24_PWRGD",
> +		"CAN1_TRAY25_PWRGD", "CAN1_TRAY26_PWRGD",
> +		"CAN1_TRAY27_PWRGD", "CAN1_TRAY28_PWRGD",
> +		"CAN1_TRAY29_PWRGD", "CAN1_TRAY30_PWRGD",
> +		"CAN1_TRAY31_PWRGD", "CAN1_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander1: gpio@39 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x39>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <58 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN2_TRAY1_PWRGD", "CAN2_TRAY2_PWRGD",
> +		"CAN2_TRAY3_PWRGD", "CAN2_TRAY4_PWRGD",
> +		"CAN2_TRAY5_PWRGD", "CAN2_TRAY6_PWRGD",
> +		"CAN2_TRAY7_PWRGD", "CAN2_TRAY8_PWRGD",
> +		"CAN2_TRAY9_PWRGD", "CAN2_TRAY10_PWRGD",
> +		"CAN2_TRAY11_PWRGD", "CAN2_TRAY12_PWRGD",
> +		"CAN2_TRAY13_PWRGD", "CAN2_TRAY14_PWRGD",
> +		"CAN2_TRAY15_PWRGD", "CAN2_TRAY16_PWRGD",
> +		"CAN2_TRAY17_PWRGD", "CAN2_TRAY18_PWRGD",
> +		"CAN2_TRAY19_PWRGD", "CAN2_TRAY20_PWRGD",
> +		"CAN2_TRAY21_PWRGD", "CAN2_TRAY22_PWRGD",
> +		"CAN2_TRAY23_PWRGD", "CAN2_TRAY24_PWRGD",
> +		"CAN2_TRAY25_PWRGD", "CAN2_TRAY26_PWRGD",
> +		"CAN2_TRAY27_PWRGD", "CAN2_TRAY28_PWRGD",
> +		"CAN2_TRAY29_PWRGD", "CAN2_TRAY30_PWRGD",
> +		"CAN2_TRAY31_PWRGD", "CAN2_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander2: gpio@3a {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3a>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <66 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN3_TRAY1_PWRGD", "CAN3_TRAY2_PWRGD",
> +		"CAN3_TRAY3_PWRGD", "CAN3_TRAY4_PWRGD",
> +		"CAN3_TRAY5_PWRGD", "CAN3_TRAY6_PWRGD",
> +		"CAN3_TRAY7_PWRGD", "CAN3_TRAY8_PWRGD",
> +		"CAN3_TRAY9_PWRGD", "CAN3_TRAY10_PWRGD",
> +		"CAN3_TRAY11_PWRGD", "CAN3_TRAY12_PWRGD",
> +		"CAN3_TRAY13_PWRGD", "CAN3_TRAY14_PWRGD",
> +		"CAN3_TRAY15_PWRGD", "CAN3_TRAY16_PWRGD",
> +		"CAN3_TRAY17_PWRGD", "CAN3_TRAY18_PWRGD",
> +		"CAN3_TRAY19_PWRGD", "CAN3_TRAY20_PWRGD",
> +		"CAN3_TRAY21_PWRGD", "CAN3_TRAY22_PWRGD",
> +		"CAN3_TRAY23_PWRGD", "CAN3_TRAY24_PWRGD",
> +		"CAN3_TRAY25_PWRGD", "CAN3_TRAY26_PWRGD",
> +		"CAN3_TRAY27_PWRGD", "CAN3_TRAY28_PWRGD",
> +		"CAN3_TRAY29_PWRGD", "CAN3_TRAY30_PWRGD",
> +		"CAN3_TRAY31_PWRGD", "CAN3_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander3: gpio@3b {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3b>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <74 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN4_TRAY1_PWRGD", "CAN4_TRAY2_PWRGD",
> +		"CAN4_TRAY3_PWRGD", "CAN4_TRAY4_PWRGD",
> +		"CAN4_TRAY5_PWRGD", "CAN4_TRAY6_PWRGD",
> +		"CAN4_TRAY7_PWRGD", "CAN4_TRAY8_PWRGD",
> +		"CAN4_TRAY9_PWRGD", "CAN4_TRAY10_PWRGD",
> +		"CAN4_TRAY11_PWRGD", "CAN4_TRAY12_PWRGD",
> +		"CAN4_TRAY13_PWRGD", "CAN4_TRAY14_PWRGD",
> +		"CAN4_TRAY15_PWRGD", "CAN4_TRAY16_PWRGD",
> +		"CAN4_TRAY17_PWRGD", "CAN4_TRAY18_PWRGD",
> +		"CAN4_TRAY19_PWRGD", "CAN4_TRAY20_PWRGD",
> +		"CAN4_TRAY21_PWRGD", "CAN4_TRAY22_PWRGD",
> +		"CAN4_TRAY23_PWRGD", "CAN4_TRAY24_PWRGD",
> +		"CAN4_TRAY25_PWRGD", "CAN4_TRAY26_PWRGD",
> +		"CAN4_TRAY27_PWRGD", "CAN4_TRAY28_PWRGD",
> +		"CAN4_TRAY29_PWRGD", "CAN4_TRAY30_PWRGD",
> +		"CAN4_TRAY31_PWRGD", "CAN4_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander4: gpio@3c {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3c>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <82 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN5_TRAY1_PWRGD", "CAN5_TRAY2_PWRGD",
> +		"CAN5_TRAY3_PWRGD", "CAN5_TRAY4_PWRGD",
> +		"CAN5_TRAY5_PWRGD", "CAN5_TRAY6_PWRGD",
> +		"CAN5_TRAY7_PWRGD", "CAN5_TRAY8_PWRGD",
> +		"CAN5_TRAY9_PWRGD", "CAN5_TRAY10_PWRGD",
> +		"CAN5_TRAY11_PWRGD", "CAN5_TRAY12_PWRGD",
> +		"CAN5_TRAY13_PWRGD", "CAN5_TRAY14_PWRGD",
> +		"CAN5_TRAY15_PWRGD", "CAN5_TRAY16_PWRGD",
> +		"CAN5_TRAY17_PWRGD", "CAN5_TRAY18_PWRGD",
> +		"CAN5_TRAY19_PWRGD", "CAN5_TRAY20_PWRGD",
> +		"CAN5_TRAY21_PWRGD", "CAN5_TRAY22_PWRGD",
> +		"CAN5_TRAY23_PWRGD", "CAN5_TRAY24_PWRGD",
> +		"CAN5_TRAY25_PWRGD", "CAN5_TRAY26_PWRGD",
> +		"CAN5_TRAY27_PWRGD", "CAN5_TRAY28_PWRGD",
> +		"CAN5_TRAY29_PWRGD", "CAN5_TRAY30_PWRGD",
> +		"CAN5_TRAY31_PWRGD", "CAN5_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander5: gpio@3d {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3d>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <90 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN6_TRAY1_PWRGD", "CAN6_TRAY2_PWRGD",
> +		"CAN6_TRAY3_PWRGD", "CAN6_TRAY4_PWRGD",
> +		"CAN6_TRAY5_PWRGD", "CAN6_TRAY6_PWRGD",
> +		"CAN6_TRAY7_PWRGD", "CAN6_TRAY8_PWRGD",
> +		"CAN6_TRAY9_PWRGD", "CAN6_TRAY10_PWRGD",
> +		"CAN6_TRAY11_PWRGD", "CAN6_TRAY12_PWRGD",
> +		"CAN6_TRAY13_PWRGD", "CAN6_TRAY14_PWRGD",
> +		"CAN6_TRAY15_PWRGD", "CAN6_TRAY16_PWRGD",
> +		"CAN6_TRAY17_PWRGD", "CAN6_TRAY18_PWRGD",
> +		"CAN6_TRAY19_PWRGD", "CAN6_TRAY20_PWRGD",
> +		"CAN6_TRAY21_PWRGD", "CAN6_TRAY22_PWRGD",
> +		"CAN6_TRAY23_PWRGD", "CAN6_TRAY24_PWRGD",
> +		"CAN6_TRAY25_PWRGD", "CAN6_TRAY26_PWRGD",
> +		"CAN6_TRAY27_PWRGD", "CAN6_TRAY28_PWRGD",
> +		"CAN6_TRAY29_PWRGD", "CAN6_TRAY30_PWRGD",
> +		"CAN6_TRAY31_PWRGD", "CAN6_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander6: gpio@3e {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3e>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <98 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN7_TRAY1_PWRGD", "CAN7_TRAY2_PWRGD",
> +		"CAN7_TRAY3_PWRGD", "CAN7_TRAY4_PWRGD",
> +		"CAN7_TRAY5_PWRGD", "CAN7_TRAY6_PWRGD",
> +		"CAN7_TRAY7_PWRGD", "CAN7_TRAY8_PWRGD",
> +		"CAN7_TRAY9_PWRGD", "CAN7_TRAY10_PWRGD",
> +		"CAN7_TRAY11_PWRGD", "CAN7_TRAY12_PWRGD",
> +		"CAN7_TRAY13_PWRGD", "CAN7_TRAY14_PWRGD",
> +		"CAN7_TRAY15_PWRGD", "CAN7_TRAY16_PWRGD",
> +		"CAN7_TRAY17_PWRGD", "CAN7_TRAY18_PWRGD",
> +		"CAN7_TRAY19_PWRGD", "CAN7_TRAY20_PWRGD",
> +		"CAN7_TRAY21_PWRGD", "CAN7_TRAY22_PWRGD",
> +		"CAN7_TRAY23_PWRGD", "CAN7_TRAY24_PWRGD",
> +		"CAN7_TRAY25_PWRGD", "CAN7_TRAY26_PWRGD",
> +		"CAN7_TRAY27_PWRGD", "CAN7_TRAY28_PWRGD",
> +		"CAN7_TRAY29_PWRGD", "CAN7_TRAY30_PWRGD",
> +		"CAN7_TRAY31_PWRGD", "CAN7_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	pwrgd_io_expander7: gpio@3f {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x3f>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <106 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN8_TRAY1_PWRGD", "CAN8_TRAY2_PWRGD",
> +		"CAN8_TRAY3_PWRGD", "CAN8_TRAY4_PWRGD",
> +		"CAN8_TRAY5_PWRGD", "CAN8_TRAY6_PWRGD",
> +		"CAN8_TRAY7_PWRGD", "CAN8_TRAY8_PWRGD",
> +		"CAN8_TRAY9_PWRGD", "CAN8_TRAY10_PWRGD",
> +		"CAN8_TRAY11_PWRGD", "CAN8_TRAY12_PWRGD",
> +		"CAN8_TRAY13_PWRGD", "CAN8_TRAY14_PWRGD",
> +		"CAN8_TRAY15_PWRGD", "CAN8_TRAY16_PWRGD",
> +		"CAN8_TRAY17_PWRGD", "CAN8_TRAY18_PWRGD",
> +		"CAN8_TRAY19_PWRGD", "CAN8_TRAY20_PWRGD",
> +		"CAN8_TRAY21_PWRGD", "CAN8_TRAY22_PWRGD",
> +		"CAN8_TRAY23_PWRGD", "CAN8_TRAY24_PWRGD",
> +		"CAN8_TRAY25_PWRGD", "CAN8_TRAY26_PWRGD",
> +		"CAN8_TRAY27_PWRGD", "CAN8_TRAY28_PWRGD",
> +		"CAN8_TRAY29_PWRGD", "CAN8_TRAY30_PWRGD",
> +		"CAN8_TRAY31_PWRGD", "CAN8_TRAY32_PWRGD",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander0: gpio@40 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x40>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <54 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN1_TRAY1_LARGE_LEAK", "CAN1_TRAY2_LARGE_LEAK",
> +		"CAN1_TRAY3_LARGE_LEAK", "CAN1_TRAY4_LARGE_LEAK",
> +		"CAN1_TRAY5_LARGE_LEAK", "CAN1_TRAY6_LARGE_LEAK",
> +		"CAN1_TRAY7_LARGE_LEAK", "CAN1_TRAY8_LARGE_LEAK",
> +		"CAN1_TRAY9_LARGE_LEAK", "CAN1_TRAY10_LARGE_LEAK",
> +		"CAN1_TRAY11_LARGE_LEAK", "CAN1_TRAY12_LARGE_LEAK",
> +		"CAN1_TRAY13_LARGE_LEAK", "CAN1_TRAY14_LARGE_LEAK",
> +		"CAN1_TRAY15_LARGE_LEAK", "CAN1_TRAY16_LARGE_LEAK",
> +		"CAN1_TRAY17_LARGE_LEAK", "CAN1_TRAY18_LARGE_LEAK",
> +		"CAN1_TRAY19_LARGE_LEAK", "CAN1_TRAY20_LARGE_LEAK",
> +		"CAN1_TRAY21_LARGE_LEAK", "CAN1_TRAY22_LARGE_LEAK",
> +		"CAN1_TRAY23_LARGE_LEAK", "CAN1_TRAY24_LARGE_LEAK",
> +		"CAN1_TRAY25_LARGE_LEAK", "CAN1_TRAY26_LARGE_LEAK",
> +		"CAN1_TRAY27_LARGE_LEAK", "CAN1_TRAY28_LARGE_LEAK",
> +		"CAN1_TRAY29_LARGE_LEAK", "CAN1_TRAY30_LARGE_LEAK",
> +		"CAN1_TRAY31_LARGE_LEAK", "CAN1_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander1: gpio@41 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x41>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <62 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN2_TRAY1_LARGE_LEAK", "CAN2_TRAY2_LARGE_LEAK",
> +		"CAN2_TRAY3_LARGE_LEAK", "CAN2_TRAY4_LARGE_LEAK",
> +		"CAN2_TRAY5_LARGE_LEAK", "CAN2_TRAY6_LARGE_LEAK",
> +		"CAN2_TRAY7_LARGE_LEAK", "CAN2_TRAY8_LARGE_LEAK",
> +		"CAN2_TRAY9_LARGE_LEAK", "CAN2_TRAY10_LARGE_LEAK",
> +		"CAN2_TRAY11_LARGE_LEAK", "CAN2_TRAY12_LARGE_LEAK",
> +		"CAN2_TRAY13_LARGE_LEAK", "CAN2_TRAY14_LARGE_LEAK",
> +		"CAN2_TRAY15_LARGE_LEAK", "CAN2_TRAY16_LARGE_LEAK",
> +		"CAN2_TRAY17_LARGE_LEAK", "CAN2_TRAY18_LARGE_LEAK",
> +		"CAN2_TRAY19_LARGE_LEAK", "CAN2_TRAY20_LARGE_LEAK",
> +		"CAN2_TRAY21_LARGE_LEAK", "CAN2_TRAY22_LARGE_LEAK",
> +		"CAN2_TRAY23_LARGE_LEAK", "CAN2_TRAY24_LARGE_LEAK",
> +		"CAN2_TRAY25_LARGE_LEAK", "CAN2_TRAY26_LARGE_LEAK",
> +		"CAN2_TRAY27_LARGE_LEAK", "CAN2_TRAY28_LARGE_LEAK",
> +		"CAN2_TRAY29_LARGE_LEAK", "CAN2_TRAY30_LARGE_LEAK",
> +		"CAN2_TRAY31_LARGE_LEAK", "CAN2_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander2: gpio@42 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x42>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <70 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN3_TRAY1_LARGE_LEAK", "CAN3_TRAY2_LARGE_LEAK",
> +		"CAN3_TRAY3_LARGE_LEAK", "CAN3_TRAY4_LARGE_LEAK",
> +		"CAN3_TRAY5_LARGE_LEAK", "CAN3_TRAY6_LARGE_LEAK",
> +		"CAN3_TRAY7_LARGE_LEAK", "CAN3_TRAY8_LARGE_LEAK",
> +		"CAN3_TRAY9_LARGE_LEAK", "CAN3_TRAY10_LARGE_LEAK",
> +		"CAN3_TRAY11_LARGE_LEAK", "CAN3_TRAY12_LARGE_LEAK",
> +		"CAN3_TRAY13_LARGE_LEAK", "CAN3_TRAY14_LARGE_LEAK",
> +		"CAN3_TRAY15_LARGE_LEAK", "CAN3_TRAY16_LARGE_LEAK",
> +		"CAN3_TRAY17_LARGE_LEAK", "CAN3_TRAY18_LARGE_LEAK",
> +		"CAN3_TRAY19_LARGE_LEAK", "CAN3_TRAY20_LARGE_LEAK",
> +		"CAN3_TRAY21_LARGE_LEAK", "CAN3_TRAY22_LARGE_LEAK",
> +		"CAN3_TRAY23_LARGE_LEAK", "CAN3_TRAY24_LARGE_LEAK",
> +		"CAN3_TRAY25_LARGE_LEAK", "CAN3_TRAY26_LARGE_LEAK",
> +		"CAN3_TRAY27_LARGE_LEAK", "CAN3_TRAY28_LARGE_LEAK",
> +		"CAN3_TRAY29_LARGE_LEAK", "CAN3_TRAY30_LARGE_LEAK",
> +		"CAN3_TRAY31_LARGE_LEAK", "CAN3_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander3: gpio@43 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x43>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <78 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN4_TRAY1_LARGE_LEAK", "CAN4_TRAY2_LARGE_LEAK",
> +		"CAN4_TRAY3_LARGE_LEAK", "CAN4_TRAY4_LARGE_LEAK",
> +		"CAN4_TRAY5_LARGE_LEAK", "CAN4_TRAY6_LARGE_LEAK",
> +		"CAN4_TRAY7_LARGE_LEAK", "CAN4_TRAY8_LARGE_LEAK",
> +		"CAN4_TRAY9_LARGE_LEAK", "CAN4_TRAY10_LARGE_LEAK",
> +		"CAN4_TRAY11_LARGE_LEAK", "CAN4_TRAY12_LARGE_LEAK",
> +		"CAN4_TRAY13_LARGE_LEAK", "CAN4_TRAY14_LARGE_LEAK",
> +		"CAN4_TRAY15_LARGE_LEAK", "CAN4_TRAY16_LARGE_LEAK",
> +		"CAN4_TRAY17_LARGE_LEAK", "CAN4_TRAY18_LARGE_LEAK",
> +		"CAN4_TRAY19_LARGE_LEAK", "CAN4_TRAY20_LARGE_LEAK",
> +		"CAN4_TRAY21_LARGE_LEAK", "CAN4_TRAY22_LARGE_LEAK",
> +		"CAN4_TRAY23_LARGE_LEAK", "CAN4_TRAY24_LARGE_LEAK",
> +		"CAN4_TRAY25_LARGE_LEAK", "CAN4_TRAY26_LARGE_LEAK",
> +		"CAN4_TRAY27_LARGE_LEAK", "CAN4_TRAY28_LARGE_LEAK",
> +		"CAN4_TRAY29_LARGE_LEAK", "CAN4_TRAY30_LARGE_LEAK",
> +		"CAN4_TRAY31_LARGE_LEAK", "CAN4_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander4: gpio@44 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x44>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <86 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN5_TRAY1_LARGE_LEAK", "CAN5_TRAY2_LARGE_LEAK",
> +		"CAN5_TRAY3_LARGE_LEAK", "CAN5_TRAY4_LARGE_LEAK",
> +		"CAN5_TRAY5_LARGE_LEAK", "CAN5_TRAY6_LARGE_LEAK",
> +		"CAN5_TRAY7_LARGE_LEAK", "CAN5_TRAY8_LARGE_LEAK",
> +		"CAN5_TRAY9_LARGE_LEAK", "CAN5_TRAY10_LARGE_LEAK",
> +		"CAN5_TRAY11_LARGE_LEAK", "CAN5_TRAY12_LARGE_LEAK",
> +		"CAN5_TRAY13_LARGE_LEAK", "CAN5_TRAY14_LARGE_LEAK",
> +		"CAN5_TRAY15_LARGE_LEAK", "CAN5_TRAY16_LARGE_LEAK",
> +		"CAN5_TRAY17_LARGE_LEAK", "CAN5_TRAY18_LARGE_LEAK",
> +		"CAN5_TRAY19_LARGE_LEAK", "CAN5_TRAY20_LARGE_LEAK",
> +		"CAN5_TRAY21_LARGE_LEAK", "CAN5_TRAY22_LARGE_LEAK",
> +		"CAN5_TRAY23_LARGE_LEAK", "CAN5_TRAY24_LARGE_LEAK",
> +		"CAN5_TRAY25_LARGE_LEAK", "CAN5_TRAY26_LARGE_LEAK",
> +		"CAN5_TRAY27_LARGE_LEAK", "CAN5_TRAY28_LARGE_LEAK",
> +		"CAN5_TRAY29_LARGE_LEAK", "CAN5_TRAY30_LARGE_LEAK",
> +		"CAN5_TRAY31_LARGE_LEAK", "CAN5_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander5: gpio@45 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x45>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <94 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN6_TRAY1_LARGE_LEAK", "CAN6_TRAY2_LARGE_LEAK",
> +		"CAN6_TRAY3_LARGE_LEAK", "CAN6_TRAY4_LARGE_LEAK",
> +		"CAN6_TRAY5_LARGE_LEAK", "CAN6_TRAY6_LARGE_LEAK",
> +		"CAN6_TRAY7_LARGE_LEAK", "CAN6_TRAY8_LARGE_LEAK",
> +		"CAN6_TRAY9_LARGE_LEAK", "CAN6_TRAY10_LARGE_LEAK",
> +		"CAN6_TRAY11_LARGE_LEAK", "CAN6_TRAY12_LARGE_LEAK",
> +		"CAN6_TRAY13_LARGE_LEAK", "CAN6_TRAY14_LARGE_LEAK",
> +		"CAN6_TRAY15_LARGE_LEAK", "CAN6_TRAY16_LARGE_LEAK",
> +		"CAN6_TRAY17_LARGE_LEAK", "CAN6_TRAY18_LARGE_LEAK",
> +		"CAN6_TRAY19_LARGE_LEAK", "CAN6_TRAY20_LARGE_LEAK",
> +		"CAN6_TRAY21_LARGE_LEAK", "CAN6_TRAY22_LARGE_LEAK",
> +		"CAN6_TRAY23_LARGE_LEAK", "CAN6_TRAY24_LARGE_LEAK",
> +		"CAN6_TRAY25_LARGE_LEAK", "CAN6_TRAY26_LARGE_LEAK",
> +		"CAN6_TRAY27_LARGE_LEAK", "CAN6_TRAY28_LARGE_LEAK",
> +		"CAN6_TRAY29_LARGE_LEAK", "CAN6_TRAY30_LARGE_LEAK",
> +		"CAN6_TRAY31_LARGE_LEAK", "CAN6_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander6: gpio@46 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x46>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <102 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN7_TRAY1_LARGE_LEAK", "CAN7_TRAY2_LARGE_LEAK",
> +		"CAN7_TRAY3_LARGE_LEAK", "CAN7_TRAY4_LARGE_LEAK",
> +		"CAN7_TRAY5_LARGE_LEAK", "CAN7_TRAY6_LARGE_LEAK",
> +		"CAN7_TRAY7_LARGE_LEAK", "CAN7_TRAY8_LARGE_LEAK",
> +		"CAN7_TRAY9_LARGE_LEAK", "CAN7_TRAY10_LARGE_LEAK",
> +		"CAN7_TRAY11_LARGE_LEAK", "CAN7_TRAY12_LARGE_LEAK",
> +		"CAN7_TRAY13_LARGE_LEAK", "CAN7_TRAY14_LARGE_LEAK",
> +		"CAN7_TRAY15_LARGE_LEAK", "CAN7_TRAY16_LARGE_LEAK",
> +		"CAN7_TRAY17_LARGE_LEAK", "CAN7_TRAY18_LARGE_LEAK",
> +		"CAN7_TRAY19_LARGE_LEAK", "CAN7_TRAY20_LARGE_LEAK",
> +		"CAN7_TRAY21_LARGE_LEAK", "CAN7_TRAY22_LARGE_LEAK",
> +		"CAN7_TRAY23_LARGE_LEAK", "CAN7_TRAY24_LARGE_LEAK",
> +		"CAN7_TRAY25_LARGE_LEAK", "CAN7_TRAY26_LARGE_LEAK",
> +		"CAN7_TRAY27_LARGE_LEAK", "CAN7_TRAY28_LARGE_LEAK",
> +		"CAN7_TRAY29_LARGE_LEAK", "CAN7_TRAY30_LARGE_LEAK",
> +		"CAN7_TRAY31_LARGE_LEAK", "CAN7_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	large_leak_io_expander7: gpio@47 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x47>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <110 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN8_TRAY1_LARGE_LEAK", "CAN8_TRAY2_LARGE_LEAK",
> +		"CAN8_TRAY3_LARGE_LEAK", "CAN8_TRAY4_LARGE_LEAK",
> +		"CAN8_TRAY5_LARGE_LEAK", "CAN8_TRAY6_LARGE_LEAK",
> +		"CAN8_TRAY7_LARGE_LEAK", "CAN8_TRAY8_LARGE_LEAK",
> +		"CAN8_TRAY9_LARGE_LEAK", "CAN8_TRAY10_LARGE_LEAK",
> +		"CAN8_TRAY11_LARGE_LEAK", "CAN8_TRAY12_LARGE_LEAK",
> +		"CAN8_TRAY13_LARGE_LEAK", "CAN8_TRAY14_LARGE_LEAK",
> +		"CAN8_TRAY15_LARGE_LEAK", "CAN8_TRAY16_LARGE_LEAK",
> +		"CAN8_TRAY17_LARGE_LEAK", "CAN8_TRAY18_LARGE_LEAK",
> +		"CAN8_TRAY19_LARGE_LEAK", "CAN8_TRAY20_LARGE_LEAK",
> +		"CAN8_TRAY21_LARGE_LEAK", "CAN8_TRAY22_LARGE_LEAK",
> +		"CAN8_TRAY23_LARGE_LEAK", "CAN8_TRAY24_LARGE_LEAK",
> +		"CAN8_TRAY25_LARGE_LEAK", "CAN8_TRAY26_LARGE_LEAK",
> +		"CAN8_TRAY27_LARGE_LEAK", "CAN8_TRAY28_LARGE_LEAK",
> +		"CAN8_TRAY29_LARGE_LEAK", "CAN8_TRAY30_LARGE_LEAK",
> +		"CAN8_TRAY31_LARGE_LEAK", "CAN8_TRAY32_LARGE_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander0: gpio@48 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x48>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <52 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN1_TRAY1_SMALL_LEAK", "CAN1_TRAY2_SMALL_LEAK",
> +		"CAN1_TRAY3_SMALL_LEAK", "CAN1_TRAY4_SMALL_LEAK",
> +		"CAN1_TRAY5_SMALL_LEAK", "CAN1_TRAY6_SMALL_LEAK",
> +		"CAN1_TRAY7_SMALL_LEAK", "CAN1_TRAY8_SMALL_LEAK",
> +		"CAN1_TRAY9_SMALL_LEAK", "CAN1_TRAY10_SMALL_LEAK",
> +		"CAN1_TRAY11_SMALL_LEAK", "CAN1_TRAY12_SMALL_LEAK",
> +		"CAN1_TRAY13_SMALL_LEAK", "CAN1_TRAY14_SMALL_LEAK",
> +		"CAN1_TRAY15_SMALL_LEAK", "CAN1_TRAY16_SMALL_LEAK",
> +		"CAN1_TRAY17_SMALL_LEAK", "CAN1_TRAY18_SMALL_LEAK",
> +		"CAN1_TRAY19_SMALL_LEAK", "CAN1_TRAY20_SMALL_LEAK",
> +		"CAN1_TRAY21_SMALL_LEAK", "CAN1_TRAY22_SMALL_LEAK",
> +		"CAN1_TRAY23_SMALL_LEAK", "CAN1_TRAY24_SMALL_LEAK",
> +		"CAN1_TRAY25_SMALL_LEAK", "CAN1_TRAY26_SMALL_LEAK",
> +		"CAN1_TRAY27_SMALL_LEAK", "CAN1_TRAY28_SMALL_LEAK",
> +		"CAN1_TRAY29_SMALL_LEAK", "CAN1_TRAY30_SMALL_LEAK",
> +		"CAN1_TRAY31_SMALL_LEAK", "CAN1_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander1: gpio@49 {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x49>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <60 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN2_TRAY1_SMALL_LEAK", "CAN2_TRAY2_SMALL_LEAK",
> +		"CAN2_TRAY3_SMALL_LEAK", "CAN2_TRAY4_SMALL_LEAK",
> +		"CAN2_TRAY5_SMALL_LEAK", "CAN2_TRAY6_SMALL_LEAK",
> +		"CAN2_TRAY7_SMALL_LEAK", "CAN2_TRAY8_SMALL_LEAK",
> +		"CAN2_TRAY9_SMALL_LEAK", "CAN2_TRAY10_SMALL_LEAK",
> +		"CAN2_TRAY11_SMALL_LEAK", "CAN2_TRAY12_SMALL_LEAK",
> +		"CAN2_TRAY13_SMALL_LEAK", "CAN2_TRAY14_SMALL_LEAK",
> +		"CAN2_TRAY15_SMALL_LEAK", "CAN2_TRAY16_SMALL_LEAK",
> +		"CAN2_TRAY17_SMALL_LEAK", "CAN2_TRAY18_SMALL_LEAK",
> +		"CAN2_TRAY19_SMALL_LEAK", "CAN2_TRAY20_SMALL_LEAK",
> +		"CAN2_TRAY21_SMALL_LEAK", "CAN2_TRAY22_SMALL_LEAK",
> +		"CAN2_TRAY23_SMALL_LEAK", "CAN2_TRAY24_SMALL_LEAK",
> +		"CAN2_TRAY25_SMALL_LEAK", "CAN2_TRAY26_SMALL_LEAK",
> +		"CAN2_TRAY27_SMALL_LEAK", "CAN2_TRAY28_SMALL_LEAK",
> +		"CAN2_TRAY29_SMALL_LEAK", "CAN2_TRAY30_SMALL_LEAK",
> +		"CAN2_TRAY31_SMALL_LEAK", "CAN2_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander2: gpio@4a {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4a>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <68 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN3_TRAY1_SMALL_LEAK", "CAN3_TRAY2_SMALL_LEAK",
> +		"CAN3_TRAY3_SMALL_LEAK", "CAN3_TRAY4_SMALL_LEAK",
> +		"CAN3_TRAY5_SMALL_LEAK", "CAN3_TRAY6_SMALL_LEAK",
> +		"CAN3_TRAY7_SMALL_LEAK", "CAN3_TRAY8_SMALL_LEAK",
> +		"CAN3_TRAY9_SMALL_LEAK", "CAN3_TRAY10_SMALL_LEAK",
> +		"CAN3_TRAY11_SMALL_LEAK", "CAN3_TRAY12_SMALL_LEAK",
> +		"CAN3_TRAY13_SMALL_LEAK", "CAN3_TRAY14_SMALL_LEAK",
> +		"CAN3_TRAY15_SMALL_LEAK", "CAN3_TRAY16_SMALL_LEAK",
> +		"CAN3_TRAY17_SMALL_LEAK", "CAN3_TRAY18_SMALL_LEAK",
> +		"CAN3_TRAY19_SMALL_LEAK", "CAN3_TRAY20_SMALL_LEAK",
> +		"CAN3_TRAY21_SMALL_LEAK", "CAN3_TRAY22_SMALL_LEAK",
> +		"CAN3_TRAY23_SMALL_LEAK", "CAN3_TRAY24_SMALL_LEAK",
> +		"CAN3_TRAY25_SMALL_LEAK", "CAN3_TRAY26_SMALL_LEAK",
> +		"CAN3_TRAY27_SMALL_LEAK", "CAN3_TRAY28_SMALL_LEAK",
> +		"CAN3_TRAY29_SMALL_LEAK", "CAN3_TRAY30_SMALL_LEAK",
> +		"CAN3_TRAY31_SMALL_LEAK", "CAN3_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander3: gpio@4b {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4b>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <76 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN4_TRAY1_SMALL_LEAK", "CAN4_TRAY2_SMALL_LEAK",
> +		"CAN4_TRAY3_SMALL_LEAK", "CAN4_TRAY4_SMALL_LEAK",
> +		"CAN4_TRAY5_SMALL_LEAK", "CAN4_TRAY6_SMALL_LEAK",
> +		"CAN4_TRAY7_SMALL_LEAK", "CAN4_TRAY8_SMALL_LEAK",
> +		"CAN4_TRAY9_SMALL_LEAK", "CAN4_TRAY10_SMALL_LEAK",
> +		"CAN4_TRAY11_SMALL_LEAK", "CAN4_TRAY12_SMALL_LEAK",
> +		"CAN4_TRAY13_SMALL_LEAK", "CAN4_TRAY14_SMALL_LEAK",
> +		"CAN4_TRAY15_SMALL_LEAK", "CAN4_TRAY16_SMALL_LEAK",
> +		"CAN4_TRAY17_SMALL_LEAK", "CAN4_TRAY18_SMALL_LEAK",
> +		"CAN4_TRAY19_SMALL_LEAK", "CAN4_TRAY20_SMALL_LEAK",
> +		"CAN4_TRAY21_SMALL_LEAK", "CAN4_TRAY22_SMALL_LEAK",
> +		"CAN4_TRAY23_SMALL_LEAK", "CAN4_TRAY24_SMALL_LEAK",
> +		"CAN4_TRAY25_SMALL_LEAK", "CAN4_TRAY26_SMALL_LEAK",
> +		"CAN4_TRAY27_SMALL_LEAK", "CAN4_TRAY28_SMALL_LEAK",
> +		"CAN4_TRAY29_SMALL_LEAK", "CAN4_TRAY30_SMALL_LEAK",
> +		"CAN4_TRAY31_SMALL_LEAK", "CAN4_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander4: gpio@4c {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4c>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <84 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN5_TRAY1_SMALL_LEAK", "CAN5_TRAY2_SMALL_LEAK",
> +		"CAN5_TRAY3_SMALL_LEAK", "CAN5_TRAY4_SMALL_LEAK",
> +		"CAN5_TRAY5_SMALL_LEAK", "CAN5_TRAY6_SMALL_LEAK",
> +		"CAN5_TRAY7_SMALL_LEAK", "CAN5_TRAY8_SMALL_LEAK",
> +		"CAN5_TRAY9_SMALL_LEAK", "CAN5_TRAY10_SMALL_LEAK",
> +		"CAN5_TRAY11_SMALL_LEAK", "CAN5_TRAY12_SMALL_LEAK",
> +		"CAN5_TRAY13_SMALL_LEAK", "CAN5_TRAY14_SMALL_LEAK",
> +		"CAN5_TRAY15_SMALL_LEAK", "CAN5_TRAY16_SMALL_LEAK",
> +		"CAN5_TRAY17_SMALL_LEAK", "CAN5_TRAY18_SMALL_LEAK",
> +		"CAN5_TRAY19_SMALL_LEAK", "CAN5_TRAY20_SMALL_LEAK",
> +		"CAN5_TRAY21_SMALL_LEAK", "CAN5_TRAY22_SMALL_LEAK",
> +		"CAN5_TRAY23_SMALL_LEAK", "CAN5_TRAY24_SMALL_LEAK",
> +		"CAN5_TRAY25_SMALL_LEAK", "CAN5_TRAY26_SMALL_LEAK",
> +		"CAN5_TRAY27_SMALL_LEAK", "CAN5_TRAY28_SMALL_LEAK",
> +		"CAN5_TRAY29_SMALL_LEAK", "CAN5_TRAY30_SMALL_LEAK",
> +		"CAN5_TRAY31_SMALL_LEAK", "CAN5_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander5: gpio@4d {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4d>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <92 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN6_TRAY1_SMALL_LEAK", "CAN6_TRAY2_SMALL_LEAK",
> +		"CAN6_TRAY3_SMALL_LEAK", "CAN6_TRAY4_SMALL_LEAK",
> +		"CAN6_TRAY5_SMALL_LEAK", "CAN6_TRAY6_SMALL_LEAK",
> +		"CAN6_TRAY7_SMALL_LEAK", "CAN6_TRAY8_SMALL_LEAK",
> +		"CAN6_TRAY9_SMALL_LEAK", "CAN6_TRAY10_SMALL_LEAK",
> +		"CAN6_TRAY11_SMALL_LEAK", "CAN6_TRAY12_SMALL_LEAK",
> +		"CAN6_TRAY13_SMALL_LEAK", "CAN6_TRAY14_SMALL_LEAK",
> +		"CAN6_TRAY15_SMALL_LEAK", "CAN6_TRAY16_SMALL_LEAK",
> +		"CAN6_TRAY17_SMALL_LEAK", "CAN6_TRAY18_SMALL_LEAK",
> +		"CAN6_TRAY19_SMALL_LEAK", "CAN6_TRAY20_SMALL_LEAK",
> +		"CAN6_TRAY21_SMALL_LEAK", "CAN6_TRAY22_SMALL_LEAK",
> +		"CAN6_TRAY23_SMALL_LEAK", "CAN6_TRAY24_SMALL_LEAK",
> +		"CAN6_TRAY25_SMALL_LEAK", "CAN6_TRAY26_SMALL_LEAK",
> +		"CAN6_TRAY27_SMALL_LEAK", "CAN6_TRAY28_SMALL_LEAK",
> +		"CAN6_TRAY29_SMALL_LEAK", "CAN6_TRAY30_SMALL_LEAK",
> +		"CAN6_TRAY31_SMALL_LEAK", "CAN6_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander6: gpio@4e {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4e>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <100 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN7_TRAY1_SMALL_LEAK", "CAN7_TRAY2_SMALL_LEAK",
> +		"CAN7_TRAY3_SMALL_LEAK", "CAN7_TRAY4_SMALL_LEAK",
> +		"CAN7_TRAY5_SMALL_LEAK", "CAN7_TRAY6_SMALL_LEAK",
> +		"CAN7_TRAY7_SMALL_LEAK", "CAN7_TRAY8_SMALL_LEAK",
> +		"CAN7_TRAY9_SMALL_LEAK", "CAN7_TRAY10_SMALL_LEAK",
> +		"CAN7_TRAY11_SMALL_LEAK", "CAN7_TRAY12_SMALL_LEAK",
> +		"CAN7_TRAY13_SMALL_LEAK", "CAN7_TRAY14_SMALL_LEAK",
> +		"CAN7_TRAY15_SMALL_LEAK", "CAN7_TRAY16_SMALL_LEAK",
> +		"CAN7_TRAY17_SMALL_LEAK", "CAN7_TRAY18_SMALL_LEAK",
> +		"CAN7_TRAY19_SMALL_LEAK", "CAN7_TRAY20_SMALL_LEAK",
> +		"CAN7_TRAY21_SMALL_LEAK", "CAN7_TRAY22_SMALL_LEAK",
> +		"CAN7_TRAY23_SMALL_LEAK", "CAN7_TRAY24_SMALL_LEAK",
> +		"CAN7_TRAY25_SMALL_LEAK", "CAN7_TRAY26_SMALL_LEAK",
> +		"CAN7_TRAY27_SMALL_LEAK", "CAN7_TRAY28_SMALL_LEAK",
> +		"CAN7_TRAY29_SMALL_LEAK", "CAN7_TRAY30_SMALL_LEAK",
> +		"CAN7_TRAY31_SMALL_LEAK", "CAN7_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	small_leak_io_expander7: gpio@4f {
> +		compatible =3D "nxp,pca9698";
> +		reg =3D <0x4f>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <108 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"CAN8_TRAY1_SMALL_LEAK", "CAN8_TRAY2_SMALL_LEAK",
> +		"CAN8_TRAY3_SMALL_LEAK", "CAN8_TRAY4_SMALL_LEAK",
> +		"CAN8_TRAY5_SMALL_LEAK", "CAN8_TRAY6_SMALL_LEAK",
> +		"CAN8_TRAY7_SMALL_LEAK", "CAN8_TRAY8_SMALL_LEAK",
> +		"CAN8_TRAY9_SMALL_LEAK", "CAN8_TRAY10_SMALL_LEAK",
> +		"CAN8_TRAY11_SMALL_LEAK", "CAN8_TRAY12_SMALL_LEAK",
> +		"CAN8_TRAY13_SMALL_LEAK", "CAN8_TRAY14_SMALL_LEAK",
> +		"CAN8_TRAY15_SMALL_LEAK", "CAN8_TRAY16_SMALL_LEAK",
> +		"CAN8_TRAY17_SMALL_LEAK", "CAN8_TRAY18_SMALL_LEAK",
> +		"CAN8_TRAY19_SMALL_LEAK", "CAN8_TRAY20_SMALL_LEAK",
> +		"CAN8_TRAY21_SMALL_LEAK", "CAN8_TRAY22_SMALL_LEAK",
> +		"CAN8_TRAY23_SMALL_LEAK", "CAN8_TRAY24_SMALL_LEAK",
> +		"CAN8_TRAY25_SMALL_LEAK", "CAN8_TRAY26_SMALL_LEAK",
> +		"CAN8_TRAY27_SMALL_LEAK", "CAN8_TRAY28_SMALL_LEAK",
> +		"CAN8_TRAY29_SMALL_LEAK", "CAN8_TRAY30_SMALL_LEAK",
> +		"CAN8_TRAY31_SMALL_LEAK", "CAN8_TRAY32_SMALL_LEAK",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	io_expander6: gpio@23 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x23>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"P24V_EFUSE1_FAULT", "P24V_EFUSE2_FAULT",
> +		"P24V_EFUSE3_FAULT", "P24V_EFUSE4_FAULT",
> +		"P24V_EFUSE5_FAULT", "P24V_EFUSE6_FAULT",
> +		"TEMP1_ALERT_N_R", "TEMP2_ALERT_N_R",
> +		"RST_FT2232_N", "PRSNT_COME_N",
> +		"FM_COME_BMC_RM_DEBUG_EN",
> "SMB_TMC75_TEMP2_ALERT_N_R",
> +		"SMB_TMC75_TEMP3_ALERT_N_R",
> "SMB_TMC75_TEMP4_ALERT_N_R",
> +		"P24V_EFUSE7_FAULT", "P24V_EFUSE8_FAULT";
> +	};
> +};
> +
> +&i2c4 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c4mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			io_expander3: gpio@23 {
> +				compatible =3D "nxp,pca9555";
> +				reg =3D <0x23>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;
> +
> +				gpio-line-names =3D
> +				"RSVD_GPIO_BMC_A12_R",
> "RSVD_GPIO_BMC_E14_R",
> +				"", "RST_I2CRST_MUX1_N",
> +				"RST_I2CRST_MUX2_N",
> "RST_I2CRST_MUX3_N",
> +				"RST_I2CRST_MUX4_N",
> "RST_I2CRST_MUX5_N",
> +				"RST_I2CRST_MUX6_N",
> "RST_I2CRST_MUX7_N",
> +				"RST_I2CRST_MUX8_N",
> "P24V_EFUSE9_FAULT",
> +				"TRAY30_PWRGD_BUF_R",
> "TRAY31_PWRGD_BUF_R",
> +				"TRAY32_PWRGD_BUF_R",
> "TRAY37_PWRGD_BUF_R";
> +			};
> +		};
> +
> +		i2c4mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +
> +			temp-sensor@48 {
> +				compatible =3D "ti,tmp75";
> +				reg =3D <0x48>;
> +			};
> +
> +			temp-sensor@4a {
> +				compatible =3D "ti,tmp75";
> +				reg =3D <0x4a>;
> +			};
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +
> +			power-monitor@76 {
> +				compatible =3D "infineon,xdpe15284";
> +				reg =3D <0x76>;
> +			};
> +		};
> +
> +		i2c4mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c4mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c4mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c4mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c4mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c4mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	status =3D "okay";
> +
> +	io_expander4: gpio@22 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x22>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"R_COME_THERMTRIP_L", "R_PWRGD_PCH_PWROK",
> +		"PWRGD_P3V3_STBY_D2", "R_H_MEMHOT_OUT_FET_L",
> +		"", "R_FM_SOC_BMC_RST_L",
> +		"", "R_FM_PCHHOT_L",
> +		"R_FM_CPU_ERR0_LVT3_L", "FM_CPU_DIMM_EVENT_COD_BUF",
> +		"R_ISO_FM_USB_OC0_L", "BIOS_DEBUG_MSG_DIS_L",
> +		"R_IRQ_BMC_PCH_SMI_N", "TRAY38_PWRGD_BUF_R",
> +		"TRAY39_PWRGD_BUF_R", "TRAY40_PWRGD_BUF_R";
> +	};
> +
> +	io_expander5: gpio@23 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x23>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"PWRGD_P5V_AUX_R2", "",
> +		"PWRGD_P1V5_AUX_R", "PWRGD_P1V05_AUX_R",
> +		"PWRGD_P52V_HSC_PWROK_R", "PWRGD_P24V_AUX_2_R",
> +		"PWRGD_P24V_AUX_R", "PWRGD_P12V_AUX_R2",
> +		"PWRGD_P12V_SCM_R", "P24V_AUX_INA230_ALERT_N_R",
> +		"P24V_AUX_2_INA230_ALERT_N_R", "PRSNT_CAN1_MCIO_N",
> +		"PRSNT_CAN2_MCIO_N", "PRSNT_AALC_MCIO_N",
> +		"PRSNT_RACKMON_MCIO_N", "PRSNT_RIO_RACKMON_N";
> +	};
> +
> +	temp-sensor@4f {
> +		compatible =3D "ti,tmp75";
> +		reg =3D <0x4f>;
> +	};
> +
> +	eeprom@54 {
> +		compatible =3D "atmel,24c128";
> +		reg =3D <0x54>;
> +	};
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c5mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +		};
> +
> +		i2c5mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +		};
> +
> +		i2c5mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c5mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c5mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c5mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c5mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +
> +		i2c5mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +
> +			eeprom@56 {
> +				compatible =3D "atmel,24c128";
> +				reg =3D <0x56>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status =3D "okay";
> +
> +	// Marvell 88E6393X EEPROM
> +	eeprom@50 {
> +		compatible =3D "atmel,24c64";
> +		reg =3D <0x50>;
> +	};
> +
> +	io_expander0: gpio@20 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x20>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"RST_POE_BMC_N", "POE_DISABLE_BMC_N_R",
> +		"RST_FT4232_1_BMC_N_R", "RST_FT4232_2_BMC_N_R",
> +		"RST_FT4232_3_BMC_N_R", "PRSNT_FANBP_0_PWR_N",
> +		"PRSNT_FANBP_0_SIG_N", "PRSNT_POE_PWR_N",
> +		"PRSNT_POE_SIG_N", "IRQ_POE_BMC_N_R",
> +		"PWRGD_P3V3_ISO_POE_BMC_R", "88E6393X_INT_N_R",
> +		"P48V_HSC_ALERT_N", "SMB_TMC75_TEMP_ALERT_N_R",
> +		"DEV_DIS_N", "PCI_DIS_N";
> +	};
> +
> +	io_expander1: gpio@21 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x21>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"PWRGD_CPU_LVC3_BMC", "R_FM_BIOS_POST_CMPLT_BMC",
> +		"RSVD_GPIO_BMC_B16_R", "",
> +		"R_FM_CPU_ERR1_LVT3_L", "R_FM_CPU_ERR2_LVT3_L",
> +		"", "ISO_FM_BMC_ONCTL_L",
> +		"R_COME_THERM_L", "BMC_RST_BTN_N",
> +		"", "PCIE_SSD1_PRSNT_N",
> +		"", "TRAY23_PWRGD_BUF_R",
> +		"TRAY24_PWRGD_BUF_R", "TRAY29_PWRGD_BUF_R";
> +	};
> +
> +	io_expander2: gpio@22 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x22>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"BOARD_ID_0", "BOARD_ID_1",
> +		"BOARD_ID_2", "BOARD_ID_3",
> +		"SKU_ID_3", "SKU_ID_2",
> +		"SKU_ID_1", "SKU_ID_0",
> +		"FT4232_1_SUSPEND_BMC_N", "FT4232_1_PWREN_BMC_N",
> +		"FT4232_2_SUSPEND_BMC_N", "FT4232_2_PWREN_BMC_N",
> +		"FT4232_3_SUSPEND_BMC_N", "FT4232_3_PWREN_BMC_N",
> +		"P12V_AUX_SMBALERT_R", "P52V_SENSE_ALERT";
> +	};
> +
> +	io_expander7: gpio@23 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x23>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"IOEXP1_INT_N", "IOEXP2_INT_N",
> +		"IOEXP3_INT_N", "IOEXP4_INT_N",
> +		"IOEXP5_INT_N", "IOEXP6_INT_N",
> +		"IOEXP7_INT_N", "",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	rtc@51 {
> +		compatible =3D "nxp,pcf8563";
> +		reg =3D <0x51>;
> +	};
> +};
> +
> +&i2c7 {
> +	status =3D "okay";
> +	bus-frequency =3D <100000>;
> +	multi-master;
> +	aspeed,hw-timeout-ms =3D <1000>;
> +
> +	ipmb@10 {
> +		compatible =3D "ipmb-dev";
> +		reg =3D <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c8 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c8mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c8mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&i2c9 {
> +	status =3D "okay";
> +
> +	temperature-sensor@4b {
> +		compatible =3D "ti,tmp75";
> +		reg =3D <0x4b>;
> +	};
> +
> +	eeprom@50 {
> +		compatible =3D "atmel,24c128";
> +		reg =3D <0x50>;
> +	};
> +
> +	eeprom@51 {
> +		compatible =3D "atmel,24c128";
> +		reg =3D <0x51>;
> +	};
> +
> +	eeprom@56 {
> +		compatible =3D "atmel,24c64";
> +		reg =3D <0x56>;
> +	};
> +};
> +
> +&i2c10 {
> +	status =3D "okay";
> +
> +	power-sensor@41 {
> +		compatible =3D "ti,ina238";
> +		reg =3D <0x41>;
> +		shunt-resistor =3D <20000>;
> +	};
> +
> +	power-sensor@42 {
> +		compatible =3D "ti,ina238";
> +		reg =3D <0x42>;
> +		shunt-resistor =3D <1000>;
> +	};
> +
> +	power-sensor@43 {
> +		compatible =3D "ti,ina238";
> +		reg =3D <0x43>;
> +		shunt-resistor =3D <20000>;
> +	};
> +
> +	power-sensor@46 {
> +		compatible =3D "ti,ina238";
> +		reg =3D <0x46>;
> +		shunt-resistor =3D <1000>;
> +	};
> +
> +	adc@35 {
> +		compatible =3D "maxim,max11617";
> +		reg =3D <0x35>;
> +	};
> +
> +	power-monitor@14 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x14>;
> +	};
> +
> +	power-monitor@44 {
> +		compatible =3D "lltc,ltc4287";
> +		reg =3D <0x44>;
> +	};
> +
> +	power-monitor@40 {
> +		compatible =3D "ti,ina230";
> +		reg =3D <0x40>;
> +		shunt-resistor =3D <1000>;
> +	};
> +
> +	power-monitor@45 {
> +		compatible =3D "ti,ina230";
> +		reg =3D <0x45>;
> +		shunt-resistor =3D <1000>;
> +	};
> +
> +	adc@48 {
> +		compatible =3D "ti,ads1015";
> +		reg =3D <0x48>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +	};
> +
> +	power-monitor@69 {

Please put devices in ascending order of unit address.
> +		compatible =3D "pmbus";
> +		reg =3D <0x69>;
> +	};
> +
> +	temp-sensor@4d {
> +		compatible =3D "ti,tmp75";
> +		reg =3D <0x4d>;
> +	};
> +
> +	temp-sensor@4c {
> +		compatible =3D "ti,tmp75";
> +		reg =3D <0x4c>;
> +	};
> +
> +	temp-sensor@4e {
> +		compatible =3D "ti,tmp75";
> +		reg =3D <0x4e>;
> +	};
> +
> +	legacy_prsnt_io_expander0: gpio@11 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x11>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PRSNT1_N_BUF_R", "TRAY_PRSNT2_N_BUF_R",
> +		"TRAY_PRSNT3_N_BUF_R", "TRAY_PRSNT4_N_BUF_R",
> +		"TRAY_PRSNT5_N_BUF_R", "TRAY_PRSNT6_N_BUF_R",
> +		"TRAY_PRSNT7_N_BUF_R", "TRAY_PRSNT8_N_BUF_R",
> +		"TRAY_PRSNT9_N_BUF_R", "TRAY_PRSNT10_N_BUF_R",
> +		"TRAY_PRSNT11_N_BUF_R", "TRAY_PRSNT12_N_BUF_R",
> +		"TRAY_PRSNT13_N_BUF_R", "TRAY_PRSNT14_N_BUF_R",
> +		"TRAY_PRSNT15_N_BUF_R", "TRAY_PRSNT16_N_BUF_R";
> +	};
> +
> +	legacy_prsnt_io_expander1: gpio@12 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x12>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PRSNT17_N_BUF_R", "TRAY_PRSNT18_N_BUF_R",
> +		"TRAY_PRSNT19_N_BUF_R", "TRAY_PRSNT20_N_BUF_R",
> +		"TRAY_PRSNT21_N_BUF_R", "TRAY_PRSNT22_N_BUF_R",
> +		"TRAY_PRSNT23_N_BUF_R", "TRAY_PRSNT24_N_BUF_R",
> +		"TRAY_PRSNT25_N_BUF_R", "TRAY_PRSNT26_N_BUF_R",
> +		"TRAY_PRSNT27_N_BUF_R", "TRAY_PRSNT28_N_BUF_R",
> +		"TRAY_PRSNT29_N_BUF_R", "TRAY_PRSNT30_N_BUF_R",
> +		"TRAY_PRSNT31_N_BUF_R", "TRAY_PRSNT32_N_BUF_R";
> +	};
> +
> +	legacy_prsnt_io_expander2: gpio@13 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x13>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PRSNT33_N_BUF_R", "TRAY_PRSNT34_N_BUF_R",
> +		"TRAY_PRSNT35_N_BUF_R", "TRAY_PRSNT36_N_BUF_R",
> +		"TRAY_PRSNT37_N_BUF_R", "TRAY_PRSNT38_N_BUF_R",
> +		"TRAY_PRSNT39_N_BUF_R", "TRAY_PRSNT40_N_BUF_R",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	legacy_pwrgd_io_expander0: gpio@28 {

Ascending order.

> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x28>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PWRGD1_N_BUF_R", "TRAY_PWRGD2_N_BUF_R",
> +		"TRAY_PWRGD3_N_BUF_R", "TRAY_PWRGD4_N_BUF_R",
> +		"TRAY_PWRGD5_N_BUF_R", "TRAY_PWRGD6_N_BUF_R",
> +		"TRAY_PWRGD7_N_BUF_R", "TRAY_PWRGD8_N_BUF_R",
> +		"TRAY_PWRGD9_N_BUF_R", "TRAY_PWRGD10_N_BUF_R",
> +		"TRAY_PWRGD11_N_BUF_R", "TRAY_PWRGD12_N_BUF_R",
> +		"TRAY_PWRGD13_N_BUF_R", "TRAY_PWRGD14_N_BUF_R",
> +		"TRAY_PWRGD15_N_BUF_R", "TRAY_PWRGD16_N_BUF_R";
> +	};
> +
> +	legacy_pwrgd_io_expander1: gpio@15 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x15>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PWRGD17_N_BUF_R", "TRAY_PWRGD18_N_BUF_R",
> +		"TRAY_PWRGD19_N_BUF_R", "TRAY_PWRGD20_N_BUF_R",
> +		"TRAY_PWRGD21_N_BUF_R", "TRAY_PWRGD22_N_BUF_R",
> +		"TRAY_PWRGD23_N_BUF_R", "TRAY_PWRGD24_N_BUF_R",
> +		"TRAY_PWRGD25_N_BUF_R", "TRAY_PWRGD26_N_BUF_R",
> +		"TRAY_PWRGD27_N_BUF_R", "TRAY_PWRGD28_N_BUF_R",
> +		"TRAY_PWRGD29_N_BUF_R", "TRAY_PWRGD30_N_BUF_R",
> +		"TRAY_PWRGD31_N_BUF_R", "TRAY_PWRGD32_N_BUF_R";
> +	};
> +
> +	legacy_pwrgd_io_expander2: gpio@16 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x16>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PWRGD33_N_BUF_R", "TRAY_PWRGD34_N_BUF_R",
> +		"TRAY_PWRGD35_N_BUF_R", "TRAY_PWRGD36_N_BUF_R",
> +		"TRAY_PWRGD37_N_BUF_R", "TRAY_PWRGD38_N_BUF_R",
> +		"TRAY_PWRGD39_N_BUF_R", "TRAY_PWRGD40_N_BUF_R",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	legacy_leak_io_expander0: gpio@17 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x17>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_LEAK_DETECT1_N_BUF_R",
> "TRAY_LEAK_DETECT2_N_BUF_R",
> +		"TRAY_LEAK_DETECT3_N_BUF_R",
> "TRAY_LEAK_DETECT4_N_BUF_R",
> +		"TRAY_LEAK_DETECT5_N_BUF_R",
> "TRAY_LEAK_DETECT6_N_BUF_R",
> +		"TRAY_LEAK_DETECT7_N_BUF_R",
> "TRAY_LEAK_DETECT8_N_BUF_R",
> +		"TRAY_LEAK_DETECT9_N_BUF_R",
> "TRAY_LEAK_DETECT10_N_BUF_R",
> +		"TRAY_LEAK_DETECT11_N_BUF_R",
> "TRAY_LEAK_DETECT12_N_BUF_R",
> +		"TRAY_LEAK_DETECT13_N_BUF_R",
> "TRAY_LEAK_DETECT14_N_BUF_R",
> +		"TRAY_LEAK_DETECT15_N_BUF_R",
> "TRAY_LEAK_DETECT16_N_BUF_R";
> +	};
> +
> +	legacy_leak_io_expander1: gpio@18 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x18>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_LEAK_DETECT17_N_BUF_R",
> "TRAY_LEAK_DETECT18_N_BUF_R",
> +		"TRAY_LEAK_DETECT19_N_BUF_R",
> "TRAY_LEAK_DETECT20_N_BUF_R",
> +		"TRAY_LEAK_DETECT21_N_BUF_R",
> "TRAY_LEAK_DETECT22_N_BUF_R",
> +		"TRAY_LEAK_DETECT23_N_BUF_R",
> "TRAY_LEAK_DETECT24_N_BUF_R",
> +		"TRAY_LEAK_DETECT25_N_BUF_R",
> "TRAY_LEAK_DETECT26_N_BUF_R",
> +		"TRAY_LEAK_DETECT27_N_BUF_R",
> "TRAY_LEAK_DETECT28_N_BUF_R",
> +		"TRAY_LEAK_DETECT29_N_BUF_R",
> "TRAY_LEAK_DETECT30_N_BUF_R",
> +		"TRAY_LEAK_DETECT31_N_BUF_R",
> "TRAY_LEAK_DETECT32_N_BUF_R";
> +	};
> +
> +	legacy_leak_io_expander2: gpio@19 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x19>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <46 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_LEAK_DETECT33_N_BUF_R",
> "TRAY_LEAK_DETECT34_N_BUF_R",
> +		"TRAY_LEAK_DETECT35_N_BUF_R",
> "TRAY_LEAK_DETECT36_N_BUF_R",
> +		"TRAY_LEAK_DETECT37_N_BUF_R",
> "TRAY_LEAK_DETECT38_N_BUF_R",
> +		"TRAY_LEAK_DETECT39_N_BUF_R",
> "TRAY_LEAK_DETECT40_N_BUF_R",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	legacy_small_leak_io_expander0: gpio@1a {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x1a>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_SMALL_LEAK1_N_BUF_R",
> "TRAY_SMALL_LEAK2_N_BUF_R",
> +		"TRAY_SMALL_LEAK3_N_BUF_R",
> "TRAY_SMALL_LEAK4_N_BUF_R",
> +		"TRAY_SMALL_LEAK5_N_BUF_R",
> "TRAY_SMALL_LEAK6_N_BUF_R",
> +		"TRAY_SMALL_LEAK7_N_BUF_R",
> "TRAY_SMALL_LEAK8_N_BUF_R",
> +		"TRAY_SMALL_LEAK9_N_BUF_R",
> "TRAY_SMALL_LEAK10_N_BUF_R",
> +		"TRAY_SMALL_LEAK11_N_BUF_R",
> "TRAY_SMALL_LEAK12_N_BUF_R",
> +		"TRAY_SMALL_LEAK13_N_BUF_R",
> "TRAY_SMALL_LEAK14_N_BUF_R",
> +		"TRAY_SMALL_LEAK15_N_BUF_R",
> "TRAY_SMALL_LEAK16_N_BUF_R";
> +	};
> +
> +	legacy_small_leak_io_expander1: gpio@1b {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x1b>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_SMALL_LEAK17_N_BUF_R",
> "TRAY_SMALL_LEAK18_N_BUF_R",
> +		"TRAY_SMALL_LEAK19_N_BUF_R",
> "TRAY_SMALL_LEAK20_N_BUF_R",
> +		"TRAY_SMALL_LEAK21_N_BUF_R",
> "TRAY_SMALL_LEAK22_N_BUF_R",
> +		"TRAY_SMALL_LEAK23_N_BUF_R",
> "TRAY_SMALL_LEAK24_N_BUF_R",
> +		"TRAY_SMALL_LEAK25_N_BUF_R",
> "TRAY_SMALL_LEAK26_N_BUF_R",
> +		"TRAY_SMALL_LEAK27_N_BUF_R",
> "TRAY_SMALL_LEAK28_N_BUF_R",
> +		"TRAY_SMALL_LEAK29_N_BUF_R",
> "TRAY_SMALL_LEAK30_N_BUF_R",
> +		"TRAY_SMALL_LEAK31_N_BUF_R",
> "TRAY_SMALL_LEAK32_N_BUF_R";
> +	};
> +
> +	legacy_small_leak_io_expander2: gpio@1c {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x1c>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <44 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +		"TRAY_SMALL_LEAK33_N_BUF_R",
> "TRAY_SMALL_LEAK34_N_BUF_R",
> +		"TRAY_SMALL_LEAK35_N_BUF_R",
> "TRAY_SMALL_LEAK36_N_BUF_R",
> +		"TRAY_SMALL_LEAK37_N_BUF_R",
> "TRAY_SMALL_LEAK38_N_BUF_R",
> +		"TRAY_SMALL_LEAK39_N_BUF_R",
> "TRAY_SMALL_LEAK40_N_BUF_R",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "";
> +	};
> +
> +	sku_info_io_expander: gpio@61 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x61>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"", "",
> +		"", "",
> +		"", "",
> +		"", "",
> +		"support_miniSAS", "support_CAN_Bus",
> +		"support_AALC", "support_Front_VT1_2",
> +		"support_Front_VT1_3", "support_Rear_VT2",
> +		"", "";
> +	};
> +
> +	fpga_io_expander64: gpio@64 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x64>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"TRAY_PWRGD_TEST", "provision_done",
> +		"", "",
> +		"", "",
> +		"LEAK_CONFIG0", "LEAK_CONFIG1",
> +		"FPGA_PWRGD_P24V_AUX_R", "FPGA_PWRGD_P24V_AUX_2_R",
> +		"FPGA_PWRGD_P12V_SCM_R", "FPGA_PWRGD_P12V_AUX_R2",
> +		"FPGA_PRSNT_FANBP_0_SIG_R_PLD_N",
> "FPGA_PRSNT_FANBP_0_PWR_R_PLD_N",
> +		"FPGA_P24V_AUX_INA230_ALERT_N_R",
> "FPGA_SMB_TMC75_TEMP_ALERT_N_R";
> +	};
> +
> +	fpga_io_expander65: gpio@65 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x65>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"FPGA_PCI_DIS_N", "FPGA_DEV_DIS_N",
> +		"FPGA_PWRGD_P3V3_AUX_R", "FPGA_PWRGD_P5V_AUX_R2",
> +		"FPGA_PWRGD_P1V05_AUX_R", "FPGA_P48V_HSC_ALERT_N",
> +		"FPGA_PWRGD_P1V5_AUX_R",
> "FPGA_PWRGD_P52V_HSC_PWROK_R",
> +		"FPGA_R_COME_THERMTRIP_L",
> "FPGA_PRSNT_POE_SIG_PLD_N",
> +		"FPGA_PRSNT_POE_PWR_PLD_N",
> "FPGA_PRSNT_RIO_RACKMON_N",
> +		"FPGA_PRSNT_CAN2_MCIO_N", "FPGA_PRSNT_CAN1_MCIO_N",
> +		"FPGA_PRSNT_RACKMON_MCIO_N",
> "FPGA_PRSNT_AALC_MCIO_N";
> +	};
> +
> +	fpga_io_expander66: gpio@66 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x66>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"FPGA_R_FM_CPU_ERR0_LVT3_L",
> "FPGA_FPGA_R_FM_PCHHOT_L",
> +		"FPGA_R_FM_BIOS_POST_CMPLT_L",
> "FPGA_R_FM_SOC_BMC_RST_L",
> +		"FPGA_R_CPU_MSMI_CATERR_N",
> "FPGA_R_H_MEMHOT_OUT_FET_L",
> +		"FPGA_R_PWRGD_P3V3_STBY", "FPGA_R_PWRGD_PCH_PWROK",
> +		"FPGA_TRAY23_PWRGD_BUF_R",
> "FPGA_TRAY24_PWRGD_BUF_R",
> +		"FPGA_P24V_AUX_2_INA230_ALERT_N_R",
> "FPGA_R_IRQ_BMC_PCH_SMI_N",
> +		"FPGA_R_FM_CPU_DIMM_EVENT_COD_BUF",
> "FPGA_R_BIOS_MSG_DIS_L",
> +		"FPGA_R_ISO_FM_USB_OC0_L", "FPGA_SPI_LVC_EN";
> +	};
> +
> +	fpga_io_expander67: gpio@67 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x67>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"FPGA_TRAY29_PWRGD_BUF_R",
> "FPGA_TRAY30_PWRGD_BUF_R",
> +		"FPGA_TRAY31_PWRGD_BUF_R",
> "FPGA_TRAY32_PWRGD_BUF_R",
> +		"FPGA_TRAY37_PWRGD_BUF_R",
> "FPGA_TRAY38_PWRGD_BUF_R",
> +		"FPGA_TRAY39_PWRGD_BUF_R",
> "FPGA_TRAY40_PWRGD_BUF_R",
> +		"FPGA_ISO_CARRIER_BOARD_PWR_OK",
> "FPGA_UART_MUX_SEL",
> +		"FPGA_RST_88E1512_PLD", "FPGA_COME_BUF_EN_N",
> +		"", "",
> +		"", "";
> +	};
> +};
> +
> +&i2c11 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c11mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c11mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&i2c12 {
> +	status =3D "okay";
> +	bus-frequency =3D <400000>;
> +};
> +
> +&i2c13 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c13mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c13mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&i2c14 {
> +	status =3D "okay";
> +};
> +
> +&i2c15 {
> +	status =3D "okay";
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9548";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c15mux0ch0: i2c@0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch1: i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <1>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch2: i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <2>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch3: i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <3>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch4: i2c@4 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <4>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch5: i2c@5 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <5>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch6: i2c@6 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <6>;
> +			status =3D "okay";
> +		};
> +
> +		i2c15mux0ch7: i2c@7 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <7>;
> +			status =3D "okay";
> +		};
> +	};
> +};
> +
> +&mac2 {
> +	status =3D "okay";
> +	phy-mode =3D "rmii";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_rmii3_default>;
> +
> +	/*
> +	 * The Marvell 88E6393X is initialized at boot via EEPROM
> +	 * configuration and hardware straps.
> +	 * The BMC connects via an RMII fixed-link; link parameters
> are fixed
> +	 * by board design.
> +	 */
> +	fixed-link {
> +		speed =3D <100>;
> +		full-duplex;
> +	};
> +};
> +
> +&mac3 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_rmii4_default>;
> +	use-ncsi;
> +};
> +
> +&peci0 {
> +	status =3D "okay";
> +};
> +
> +&sgpiom0 {
> +	status =3D "okay";
> +	ngpios =3D <128>;
> +	bus-frequency =3D <2000000>;
> +	gpio-line-names =3D
> +	/*"input pin","output pin"*/
> +	/*A0 - A7*/
> +	"power-chassis-good","FM_PLD_HEARTBEAT_LVC3_R",
> +	"host0-ready","",
> +	"CONTROL_VT2_SUPPLY1_CLOSE","FM_MDIO_SW_SEL_PLD",
> +	"CONTROL_VT2_SUPPLY2_CLOSE","FM_88E6393X_BIN_UPDATE_EN_N",
> +	"CONTROL_VT2_SUPPLY3_CLOSE","Sequence_TransFR_Alert",
> +	"RETURN_CNTL1_FB","WATER_VALVE1_OPEN",
> +	"RETURN_CNTL2_FB","WATER_VALVE2_OPEN",
> +	"RETURN_CNTL3_FB","WATER_VALVE3_OPEN",

Again can you indent these to distinguish the values from the
properties?

> +	/*B0 - B7*/

Also please add a blank line between groups.

Andrew

> +	"IT_STOP_PUMP_R_CPLD","WATER_VALVE1_CLOSE",
> +	"IT_STOP_PUMP_SPARE_R_CPLD","WATER_VALVE2_CLOSE",
> +	"IT_STOP_PUMP_2_R_CPLD","WATER_VALVE3_CLOSE",
> +	"IT_STOP_PUMP_SPARE_2_R_CPLD","REPORT_VT2_SUPPLY1_CLOSE",
> +	"RPU_2_READY_SPARE_PLD_R","REPORT_VT2_SUPPLY2_CLOSE",
> +	"RPU_2_READY_PLD_R","REPORT_VT2_SUPPLY3_CLOSE",
> +	"RPU_READY_SPARE_PLD_R","PCIE_SSD1_PRSNT_N",
> +	"RPU_READY_PLD_R","",
> +	/*C0 - C7*/
> +	"IOEXP8_INT_N","",
> +	"SUPPLY_CNTL1_FB","",
> +	"SUPPLY_CNTL2_FB","",
> +	"SUPPLY_CNTL3_FB","",
> +	"PRSNT_TRAY1_TO_40_R_BUF_N","",
> +	"PWRGD_TRAY1_TO_40_R_BUF","",
> +	"SMALL_LEAK_TRAY1_TO_40_R_BUF_N","",
> +	"LEAK_DETECT_TRAY1_TO_40_R_BUF_N","",
> +	/*D0 - D7*/
> +	"PRSNT_CANBUSP1_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP1_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP1_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP1_TRAY1_TO_32_N","",
> +	"PRSNT_CANBUSP2_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP2_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP2_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP2_TRAY1_TO_32_N","",
> +	/*E0 - E7*/
> +	"PRSNT_CANBUSP3_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP3_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP3_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP3_TRAY1_TO_32_N","",
> +	"PRSNT_CANBUSP4_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP4_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP4_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP4_TRAY1_TO_32_N","",
> +	/*F0 - F7*/
> +	"PRSNT_CANBUSP5_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP5_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP5_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP5_TRAY1_TO_32_N","",
> +	"PRSNT_CANBUSP6_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP6_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP6_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP6_TRAY1_TO_32_N","",
> +	/*G0 - G7*/
> +	"PRSNT_CANBUSP7_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP7_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP7_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP7_TRAY1_TO_32_N","",
> +	"PRSNT_CANBUSP8_TRAY1_TO_32_N","",
> +	"PWRGD_CANBUSP8_TRAY1_TO_32_PWROK","",
> +	"SMALL_LEAK_CANBUSP8_TRAY1_TO_32_N","",
> +	"LEAK_DETECT_CANBUSP8_TRAY1_TO_32_N","",
> +	/*H0 - H7*/
> +	"CHASSIS0_LEAK_Q_N_R","",
> +	"CHASSIS1_LEAK_Q_N_R","",
> +	"CHASSIS2_LEAK_Q_N_R","",
> +	"CHASSIS3_LEAK_Q_N_R","",
> +	"CHASSIS4_LEAK_Q_N_R","",
> +	"CHASSIS5_LEAK_Q_N_R","",
> +	"CHASSIS6_LEAK_Q_N_R","",
> +	"CHASSIS7_LEAK_Q_N_R","",
> +	/*I0 - I7*/
> +	"CHASSIS8_LEAK_Q_N_R","",
> +	"CHASSIS9_LEAK_Q_N_R","",
> +	"CHASSIS10_LEAK_Q_N_R","",
> +	"CHASSIS11_LEAK_Q_N_R","",
> +	"AALC_RPU_READY","",
> +	"","",
> +	"","",
> +	"","",
> +	/*J0 - J7*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*K0 - K7*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*L0 - L7*/
> +	"IT_GEAR_RPU_2_LINK_PRSNT_SPARE_N_R","",
> +	"IT_GEAR_RPU_2_LINK_PRSNT_N_R","",
> +	"IT_GEAR_RPU_LINK_PRSNT_SPARE_N_R","",
> +	"IT_GEAR_RPU_LINK_PRSNT_N_R","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*M0 - M7*/
> +	"","",
> +	"","",
> +	"PRSNT_SENSOR_N","",
> +	"PRSNT3_VT2_PLD_N","",
> +	"PRSNT2_VT2_PLD_N","",
> +	"PRSNT1_VT2_PLD_N","",
> +	"PRSNT3_RETURN_PLD_N","",
> +	"PRSNT2_RETURN_PLD_N","",
> +	/*N0 - N7*/
> +	"PRSNT1_RETURN_PLD_N","",
> +	"PRSNT3_SUPPLY_PLD_N","",
> +	"PRSNT2_SUPPLY_PLD_N","",
> +	"PRSNT1_SUPPLY_PLD_N","",
> +	"PRSNT_LEAK11_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK10_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK9_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK8_SENSOR_R_PLD_N","",
> +	/*O0 - O7*/
> +	"PRSNT_LEAK7_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK6_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK5_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK4_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK3_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK2_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK1_SENSOR_R_PLD_N","",
> +	"PRSNT_LEAK0_SENSOR_R_PLD_N","",
> +	/*P0 - P7*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	"","";
> +};
> +
> +&spi2 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_spi2_default>;
> +
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "pnor";
> +		spi-max-frequency =3D <12000000>;
> +		spi-tx-bus-width =3D <2>;
> +		spi-rx-bus-width =3D <2>;
> +	};
> +};
> +
> +&wdt1 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
> +	aspeed,reset-type =3D "soc";
> +	aspeed,external-signal;
> +	aspeed,ext-push-pull;
> +	aspeed,ext-active-high;
> +	aspeed,ext-pulse-duration =3D <256>;
> +};
> +

