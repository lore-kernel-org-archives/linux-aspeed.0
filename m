Return-Path: <linux-aspeed+bounces-3504-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6EEEF0712
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 06:40:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8Zp80jtJz2yFm;
	Mon, 09 Feb 2026 17:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770619248;
	cv=none; b=E6o1ZlI8pBp0P7TnnrrWuERBzb7bE5/8VzbJOu7pf15bdix4h7YDzL9SccEXyDZ405GcnNZBpQ52g12RV7/tYIyMcTNubNsEFB4CwaEXhOsWo6aMK8zWW6mkOzpUX77g8kKca0tcC5nfVBL7++lcMvpCQfiYcdgd1CgXsEhZBMDenO1TBzlnJw3wHEt1za2es8d4aaEVQgj0q1RUvVi8SJsqTC/rfikDmCq8jMt6P5MM7AhqD0JqZjpMqic/BHbz6CQDzW0mHuGFpXJ6nKKdLkzHscRMRSDyyAddCZueBkaWEGHA/reFqzKQLf1KFhKiaMHF7CcJEp7Jl7Tc4Ijagw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770619248; c=relaxed/relaxed;
	bh=rJj1F7xc7iojKAsN+tKnk0FAj0HRh9EWd4iIbq9DEYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMxkmwc+jznBZwn9JYxZhwZizyKlgz/xE7s2lwEP/Mtf18tI+vnEbnqmN1wfEnKxzHnzL7484eFQr8qwOwcN8dwYeS+iTPCR4Kax0jQ71eJFMcUWlKBKPbip+Va9giTnobkQtGDrq7MeUkWiwGUPUkdiB4e8AHoAomnZtL3DSSNCI1xheqTjAMhucuqCSHl8gIdzzI78azWnE9YypDkxCKXlKMzh4k+33nCwH1A5SA6wff2kXio6icfR2KJ+xQnvmHWkwT7Wk1FPUH1bw46MJv3TqmGoY6i8pqF6dLqc4R2KRmqsQ1W2FLRogmn1HDw2uvanHEgc0/uNoPz0TV4TgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=UOpNHFtQ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=UOpNHFtQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8Zp730qLz2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 17:40:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770619246;
	bh=rJj1F7xc7iojKAsN+tKnk0FAj0HRh9EWd4iIbq9DEYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UOpNHFtQSNLbU+3x2Ankanyr6ReGVJEeQM2+pLavsNNS2B9dxyW4GVan5AZtb33tr
	 KjZnHvr9bPOGeQ9xMkIWOkBX3RbC6NPw7fQkRXCarD21Ulu6L6J2lkdrugOcT40N9g
	 5FBALNCnNrMJC56C+jJXlxM6w7vNt7kgLbwaCCUpUCf8dbD8TeVbf5uWKbqEXVNhEt
	 6y6wzt9b+aFvyUKhMsAfW3xXY1uWR4duVBwgknIA2lJkDAiJQ4w6yAy8Qe8lP1Jvpm
	 4gyN/psHfFtaeMLE1h0PG+YGPMfhcL/L6f9p2Rp4+ICdBIR72DiG/osOgCSqw8yCuX
	 tAZbeugNWFobA==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F02CF602DE;
	Mon,  9 Feb 2026 14:40:45 +0800 (AWST)
Message-ID: <d7c03808b09b4cb3994a9de2eff156ec589ab581.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add Meta SanMiguel BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, Potin Lai
	 <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>
Date: Mon, 09 Feb 2026 17:10:45 +1030
In-Reply-To: <20260202-sanmiguel_init_dts-v1-2-c0023ae41899@gmail.com>
References: <20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com>
	 <20260202-sanmiguel_init_dts-v1-2-c0023ae41899@gmail.com>
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

Hi Potin,

Regarding the patch subject, can you please capitalise the start of the
description after '... aspeed:'?

   ARM: dts: aspeed: Add Meta SanMiguel BMC

On Mon, 2026-02-02 at 14:03 +0800, Potin Lai wrote:
> Add linux device tree entry for Meta (Facebook) SanMiguel compute-tray
> BMC using AT2620 SoC.
>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts=C2=A0=C2=A0 | 1163=
 ++++++++++++++++++++
> =C2=A02 files changed, 1164 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index 9adf9278dc94..ab2effc29f6f 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
> =C2=A0	aspeed-bmc-facebook-harma.dtb \
> =C2=A0	aspeed-bmc-facebook-minerva.dtb \
> =C2=A0	aspeed-bmc-facebook-minipack.dtb \
> +	aspeed-bmc-facebook-sanmiguel.dtb \
> =C2=A0	aspeed-bmc-facebook-santabarbara.dtb \
> =C2=A0	aspeed-bmc-facebook-tiogapass.dtb \
> =C2=A0	aspeed-bmc-facebook-wedge40.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> new file mode 100644
> index 000000000000..bcf857835b23
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> @@ -0,0 +1,1163 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright (c) 2025 Facebook Inc.
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/usb/pd.h>
> +#include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model =3D "AST2600 VR NVL144 BMC";
> +	compatible =3D "aspeed,ast2600";

This is missing the platform compatible string defined in the previous
patch.

> +
> +	aliases {
> +		serial0 =3D &uart1;
> +		serial1 =3D &uart2;
> +		serial2 =3D &uart3;
> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		i2c16	=3D &imux16;
> +		i2c17	=3D &imux17;
> +		i2c18	=3D &imux18;
> +		i2c19	=3D &imux19;
> +		i2c20=C2=A0=C2=A0 =3D &i2c20;
> +		i2c21=C2=A0=C2=A0 =3D &i2c21;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial4:57600n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x80000000>;
> +	};
> +
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&adc0 4>, <&adc0 5>, <&adc0 6>;
> +	};
> +
> +	spi2_gpio: spi {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		sck-gpios =3D <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
> +		cs-gpios =3D <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
> +		num-chipselects =3D <1>;
> +
> +		tpm@0 {
> +			compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency =3D <33000000>;
> +			reg =3D <0>;
> +		};
> +	};
> +
> +	standby_power_regulator: standby-power-regulator {
> +		status =3D "okay";
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "standby_power";
> +		gpio =3D <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	scm-leds {
> +		compatible =3D "gpio-leds";
> +		led-0 {
> +			label =3D "bmc_heartbeat_amber";
> +			gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +
> +	fio-leds {
> +		compatible =3D "gpio-leds";
> +		led-0 {
> +			label =3D "power_blue";
> +			gpios =3D <&fio_ioexp 4 GPIO_ACTIVE_HIGH>;
> +		};
> +		led-1 {
> +			label =3D "power_amber";
> +			gpios =3D <&fio_ioexp 5 GPIO_ACTIVE_LOW>;
> +		};
> +		led-2 {
> +			label =3D "id_blue";
> +			gpios =3D <&fio_ioexp 6 GPIO_ACTIVE_HIGH>;
> +		};
> +		led-3 {
> +			label =3D "id_amber";
> +			gpios =3D <&fio_ioexp 7 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fmc {
> +	status =3D "okay";
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "bmc";
> +		spi-max-frequency =3D <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +	flash@1 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "alt-bmc";

Perhaps include the alt layout for 128M as well (which I recently
applied).

> +		spi-max-frequency =3D <50000000>;
> +	};
> +};
> +
> +&uart1 {
> +	status =3D "okay";
> +};
> +
> +&uart3 {
> +	status =3D "okay";
> +};
> +
> +&uart5 {
> +	status =3D "okay";
> +};
> +
> +&uart_routing {
> +	status =3D "okay";
> +};
> +
> +&mdio0 {

The DTS coding style allows label references to be ordered
alphabetically, which is my preference. Can you please fix this
throughout?

> +	status =3D "okay";
> +	ethphy0: ethernet-phy@0 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <0>;
> +	};
> +};
> +
> +&mac0 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	phy-mode =3D "rgmii-rxid";
> +	max-speed =3D <1000>;
> +	phy-handle =3D <&ethphy0>;
> +	pinctrl-0 =3D <&pinctrl_rgmii1_default>;
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +	hub@1 {
> +		reg =3D <1>;
> +		hub@2 {
> +			reg =3D <2>;
> +			hub@1 {
> +				reg =3D <1>;
> +				device@1 {
> +					reg =3D <1>;
> +					cp2112a: interface@1 {
> +						reg =3D <1 1>;
> +
> +						gpio-controller;
> +						interrupt-controller;
> +						#gpio-cells =3D <2>;
> +						#interrupt-cells =3D <2>;
> +
> +						i2c20: i2c {
> +							#address-cells =3D <1>;
> +							#size-cells =3D <0>;
> +						};
> +					};
> +				};
> +				hub@3 {
> +					reg =3D <3>;
> +					cp2112c: device@2 {
> +						reg =3D <2>;
> +						gpio-controller;
> +						#gpio-cells =3D <2>;
> +						interrupt-controller;
> +						#interrupt-cells =3D <2>;
> +
> +						gpio-line-names =3D
> +							"IOB0_MCP_P0_2-B",
> +							"IOB0_MCU_RST_L-O",
> +							"IOB0_MCU_RECOVERY_L-O",
> +							"IOB0_GLOBAL_WP-O",
> +							"IOB0_GLOBAL_ADDR_L_R-O",
> +							"IOB0_GLOBAL_ADDR_U_D-O",
> +							"IOB0_PWR_EN-O",
> +							"IOB0_MCU_READY_STATUS-I";
> +					};
> +				};
> +				hub@4 {
> +					reg =3D <4>;
> +					cp2112d: device@2 {
> +						reg =3D <2>;
> +						gpio-controller;
> +						#gpio-cells =3D <2>;
> +						interrupt-controller;
> +						#interrupt-cells =3D <2>;
> +
> +						gpio-line-names =3D
> +							"IOB1_MCP_P0_2-B",
> +							"IOB1_MCU_RST_L-O",
> +							"IOB1_MCU_RECOVERY_L-O",
> +							"IOB1_GLOBAL_WP-O",
> +							"IOB1_GLOBAL_ADDR_L_R-O",
> +							"IOB1_GLOBAL_ADDR_U_D-O",
> +							"IOB1_PWR_EN-O",
> +							"IOB1_MCU_READY_STATUS-I";
> +					};
> +				};
> +			};
> +			hub@2 {
> +				reg =3D <2>;
> +				device@1 {
> +					reg =3D <1>;
> +					cp2112b: interface@1 {
> +						reg =3D <1 1>;
> +
> +						gpio-controller;
> +						interrupt-controller;
> +						#gpio-cells =3D <2>;
> +						#interrupt-cells =3D <2>;
> +
> +						i2c21: i2c {
> +							#address-cells =3D <1>;
> +							#size-cells =3D <0>;
> +						};
> +					};
> +				};
> +				hub@3 {
> +					reg =3D <3>;
> +					cp2112e: device@2 {
> +						reg =3D <2>;
> +						gpio-controller;
> +						#gpio-cells =3D <2>;
> +						interrupt-controller;
> +						#interrupt-cells =3D <2>;
> +
> +						gpio-line-names =3D
> +							"IOB2_MCP_P0_2-B",
> +							"IOB2_MCU_RST_L-O",
> +							"IOB2_MCU_RECOVERY_L-O",
> +							"IOB2_GLOBAL_WP-O",
> +							"IOB2_GLOBAL_ADDR_L_R-O",
> +							"IOB2_GLOBAL_ADDR_U_D-O",
> +							"IOB2_PWR_EN-O",
> +							"IOB2_MCU_READY_STATUS-I";
> +					};
> +				};
> +				hub@4 {
> +					reg =3D <4>;
> +					cp2112f: device@2 {
> +						reg =3D <2>;
> +						gpio-controller;
> +						#gpio-cells =3D <2>;
> +						interrupt-controller;
> +						#interrupt-cells =3D <2>;
> +
> +						gpio-line-names =3D
> +							"IOB3_MCP_P0_2-B",
> +							"IOB3_MCU_RST_L-O",
> +							"IOB3_MCU_RECOVERY_L-O",
> +							"IOB3_GLOBAL_WP-O",
> +							"IOB3_GLOBAL_ADDR_L_R-O",
> +							"IOB3_GLOBAL_ADDR_U_D-O",
> +							"IOB3_PWR_EN-O",
> +							"IOB3_MCU_READY_STATUS-I";
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&adc0 {
> +	aspeed,int-vref-microvolt =3D <2500000>;
> +	status =3D "okay";
> +
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default>;
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
> +&i2c0 {
> +	status =3D "okay";
> +	aspeed,enable-byte;
>=20

... Have you run `make dtbs_check`? A quick grep suggests this isn't a
valid property.

> +
> +	ssif-bmc@10 {
> +		compatible =3D "ssif-bmc";
> +		reg =3D <0x10>;
> +		alert-gpios =3D <&gpio1 ASPEED_GPIO(D, 7) GPIO_ACTIVE_LOW>;
> +		timeout-ms =3D <5000>;
> +	};
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +
> +	hpm0_ioexp_20: gpio@20 {
> +		compatible =3D "nxp,pca9555";

Is this a true nxp,pca9555, or a CPLD-based reimplementation? Same
query for other instances...

Andrew

