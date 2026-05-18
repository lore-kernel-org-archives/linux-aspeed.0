Return-Path: <linux-aspeed+bounces-4052-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B458CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 07:18:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJq0b6tT4z3c4P;
	Mon, 18 May 2026 17:18:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779088719;
	cv=none; b=EopW1wQQ6rfHQC2guNkbH6owx7JqGh1DAvJxG1R3O8ZGz7ztCtiNCipVbMmZOMcGKSLvbrF4j5gr7INF5IG0TodMdJIkB4+pbB+IIRDyq1RxZI04dIXYGEs6V0UEJdvl7HdPyGZ1Wb/kVJx+g1lENhtbKcQwIEmt3JvYU6oD3cjhhzDP6gzR1hllzNOGLvPFOQ0I6EV1J1A+cFS5FnuBpVG0Me1LU2Jein038kOGOdEvOQfW3PzkabylZhMt3mukkhg+bhQopZ3ZiUYPAM1GS8+HzsBgz9nZkXsgKd3Wd/hwLcxsXybHWZjKLBgaB/MhO4OiJe2U92FInWWD8RlhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779088719; c=relaxed/relaxed;
	bh=NBatxZ7rLnoE7+1Q0P79q/wyf+V1W3H6ZFP+TdJvcUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7Bd/E9mMuRZBHnWj8kfXS8hNdUAsHLAL9in/AbpEZ1skS3nfJAI8bIH3RQ0HcVg4RcH86DNSwlCB4ST9T9/UkWcAEdYXKy1ZmZnfcpuhor1VyxZUsrBmj7eTWtwK7Xb7AtM6kZNHnyvg7sG3mDr+BxE4oIpVox86l2EpdgQ701Glu7Y/FkBAyOSerNnGjKc9TjTqgRAuZYmEiqDu2YUJDvxwv4jIYTCO5Qxq7YezGRrhtwBZkRFWNae7MpLzdektEsMZ9MyMq2QdBOhRB7jyDh02Gz7Z0pVVuJUUt/8xOHT5XaBepKjlnD2G8SzH9N2TlIgGMc0pEK1DBCY/FPcGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JE4ggE5l; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JE4ggE5l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJq0Z22hWz3c2q
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 17:18:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779088717;
	bh=NBatxZ7rLnoE7+1Q0P79q/wyf+V1W3H6ZFP+TdJvcUw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JE4ggE5lkow4d55Twm2ryEHyY5CUc74EIJJLkQoT3K3HEeE9tJ82zBPEmZF1t1uzn
	 YLDQCOFReJGREX8XWUxUyJdd1d8hr/TbZVskiTkOpKr8rMPlfyFaHckU03vEB+B6no
	 ZGav6mClT2OjBe5p2FjnaBytwK2sqMFM3fKLmKGIHUfOHQrOw5pXEha0zDH7GjRvSh
	 aWcuzaMyGv20fbfsJasgY+8hn2GJwA8AaZkAVEiFqPuBkagj5hoJgmHvFmiDE5VrGf
	 XCd5jlkLylgw+a4X33JELrSBGr+rjurP9HRLs2uTo1nA32mY5UdwP8IZG4am3xN9K+
	 9w6WdBg2yUbHg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 39B2B6025D;
	Mon, 18 May 2026 15:18:37 +0800 (AWST)
Message-ID: <39b9a80fe4f49d72cefb8d3f8f1bb3776b9c4226.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 16:48:36 +0930
In-Reply-To: <20260424-ventura2_initial_dts-v4-2-806b00ea4314@gmail.com>
References: <20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com>
	 <20260424-ventura2_initial_dts-v4-2-806b00ea4314@gmail.com>
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

Firstly, are you trying to represent multiple revisions of the hardware
design in this devicetree? I'm curious due to the 'legacy' labels
below.

On Fri, 2026-04-24 at 17:30 +0800, Kyle Hsieh wrote:
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
 2925 ++++++++++++++++++++
> =C2=A02 files changed, 2926 insertions(+)
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
> index 000000000000..8d4ddb473862
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> @@ -0,0 +1,2925 @@
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
> +	aliases {
> +		serial2 =3D &uart3;
> +		serial4 =3D &uart5;
> +
> +		/*
> +		 * i2c switch 0-0077, pca9548, 8 child channels assigned
> +		 * with bus number 16-23.
> +		 */
> +		i2c16 =3D &i2c0mux0ch0;
> +		i2c17 =3D &i2c0mux0ch1;
> +		i2c18 =3D &i2c0mux0ch2;
> +		i2c19 =3D &i2c0mux0ch3;
> +		i2c20 =3D &i2c0mux0ch4;
> +		i2c21 =3D &i2c0mux0ch5;
> +		i2c22 =3D &i2c0mux0ch6;
> +		i2c23 =3D &i2c0mux0ch7;
> +
> +		/*
> +		 * i2c switch 1-0077, pca9548, 8 child channels assigned
> +		 * with bus number 24-31.
> +		 */
> +		i2c24 =3D &i2c1mux0ch0;
> +		i2c25 =3D &i2c1mux0ch1;
> +		i2c26 =3D &i2c1mux0ch2;
> +		i2c27 =3D &i2c1mux0ch3;
> +		i2c28 =3D &i2c1mux0ch4;
> +		i2c29 =3D &i2c1mux0ch5;
> +		i2c30 =3D &i2c1mux0ch6;
> +		i2c31 =3D &i2c1mux0ch7;
> +
> +		/*
> +		 * i2c switch 4-0077, pca9548, 8 child channels assigned
> +		 * with bus number 32-39.
> +		 */
> +		i2c32 =3D &i2c4mux0ch0;
> +		i2c33 =3D &i2c4mux0ch1;
> +		i2c34 =3D &i2c4mux0ch2;
> +		i2c35 =3D &i2c4mux0ch3;
> +		i2c36 =3D &i2c4mux0ch4;
> +		i2c37 =3D &i2c4mux0ch5;
> +		i2c38 =3D &i2c4mux0ch6;
> +		i2c39 =3D &i2c4mux0ch7;
> +
> +		/*
> +		 * i2c switch 5-0077, pca9548, 8 child channels assigned
> +		 * with bus number 40-47.
> +		 */
> +		i2c40 =3D &i2c5mux0ch0;
> +		i2c41 =3D &i2c5mux0ch1;
> +		i2c42 =3D &i2c5mux0ch2;
> +		i2c43 =3D &i2c5mux0ch3;
> +		i2c44 =3D &i2c5mux0ch4;
> +		i2c45 =3D &i2c5mux0ch5;
> +		i2c46 =3D &i2c5mux0ch6;
> +		i2c47 =3D &i2c5mux0ch7;
> +
> +		/*
> +		 * i2c switch 8-0077, pca9548, 8 child channels assigned
> +		 * with bus number 48-55.
> +		 */
> +		i2c48 =3D &i2c8mux0ch0;
> +		i2c49 =3D &i2c8mux0ch1;
> +		i2c50 =3D &i2c8mux0ch2;
> +		i2c51 =3D &i2c8mux0ch3;
> +		i2c52 =3D &i2c8mux0ch4;
> +		i2c53 =3D &i2c8mux0ch5;
> +		i2c54 =3D &i2c8mux0ch6;
> +		i2c55 =3D &i2c8mux0ch7;
> +
> +		/*
> +		 * i2c switch 11-0077, pca9548, 8 child channels assigned
> +		 * with bus number 56-63.
> +		 */
> +		i2c56 =3D &i2c11mux0ch0;
> +		i2c57 =3D &i2c11mux0ch1;
> +		i2c58 =3D &i2c11mux0ch2;
> +		i2c59 =3D &i2c11mux0ch3;
> +		i2c60 =3D &i2c11mux0ch4;
> +		i2c61 =3D &i2c11mux0ch5;
> +		i2c62 =3D &i2c11mux0ch6;
> +		i2c63 =3D &i2c11mux0ch7;
> +
> +		/*
> +		 * i2c switch 13-0077, pca9548, 8 child channels assigned
> +		 * with bus number 64-71.
> +		 */
> +		i2c64 =3D &i2c13mux0ch0;
> +		i2c65 =3D &i2c13mux0ch1;
> +		i2c66 =3D &i2c13mux0ch2;
> +		i2c67 =3D &i2c13mux0ch3;
> +		i2c68 =3D &i2c13mux0ch4;
> +		i2c69 =3D &i2c13mux0ch5;
> +		i2c70 =3D &i2c13mux0ch6;
> +		i2c71 =3D &i2c13mux0ch7;
> +
> +		/*
> +		 * i2c switch 15-0077, pca9548, 8 child channels assigned
> +		 * with bus number 72-79.
> +		 */
> +		i2c72 =3D &i2c15mux0ch0;
> +		i2c73 =3D &i2c15mux0ch1;
> +		i2c74 =3D &i2c15mux0ch2;
> +		i2c75 =3D &i2c15mux0ch3;
> +		i2c76 =3D &i2c15mux0ch4;
> +		i2c77 =3D &i2c15mux0ch5;
> +		i2c78 =3D &i2c15mux0ch6;
> +		i2c79 =3D &i2c15mux0ch7;

Can you please add comments justifying why all of these aliases are
necessary given a number of them are for busses with no devices
described under them?

> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial4:57600n8";
> +	};
> +
> +	fan_leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-0 {
> +			label =3D "fcb0fan0_ledd1_blue";

Given the labels are exposed to userspace and is something applications
likely consume, is the double 'd' in led intentional?

> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander0 0 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			label =3D "fcb0fan1_ledd2_blue";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander0 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-2 {
> +			label =3D "fcb0fan2_ledd3_blue";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander1 0 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-3 {
> +			label =3D "fcb0fan3_ledd4_blue";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander1 1 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-4 {
> +			label =3D "fcb0fan0_ledd1_amber";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander0 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-5 {
> +			label =3D "fcb0fan1_ledd2_amber";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander0 5 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-6 {
> +			label =3D "fcb0fan2_ledd3_amber";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander1 4 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-7 {
> +			label =3D "fcb0fan3_ledd4_amber";
> +			default-state =3D "off";
> +			gpios =3D <&fan_io_expander1 5 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +

...

> +
> +&fmc {
> +	status =3D "okay";
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "bmc";
> +		spi-max-frequency =3D <50000000>;
> +		#include "openbmc-flash-layout-128.dtsi"
> +	};
> +	flash@1 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "alt-bmc";
> +		spi-max-frequency =3D <50000000>;

Perhaps include the alternate flash layout dtsi here?

> +	};
> +};
> +
> +&peci0 {

Can you please order the nodes alphabetically. P is not between F and
G.

> +	status =3D "okay";
> +};
> +
>=20

...

> +
> +&i2c10 {
> +	status =3D "okay";
> +
> +	legacy_prsnt_io_expander0: gpio@11 {

Why 'legacy'?

> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x11>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <40 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +			"TRAY_PRSNT1_N_BUF_R", "TRAY_PRSNT2_N_BUF_R",
> +			"TRAY_PRSNT3_N_BUF_R", "TRAY_PRSNT4_N_BUF_R",
> +			"TRAY_PRSNT5_N_BUF_R", "TRAY_PRSNT6_N_BUF_R",
> +			"TRAY_PRSNT7_N_BUF_R", "TRAY_PRSNT8_N_BUF_R",
> +			"TRAY_PRSNT9_N_BUF_R", "TRAY_PRSNT10_N_BUF_R",
> +			"TRAY_PRSNT11_N_BUF_R", "TRAY_PRSNT12_N_BUF_R",
> +			"TRAY_PRSNT13_N_BUF_R", "TRAY_PRSNT14_N_BUF_R",
> +			"TRAY_PRSNT15_N_BUF_R", "TRAY_PRSNT16_N_BUF_R";
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
> +			"TRAY_PRSNT17_N_BUF_R", "TRAY_PRSNT18_N_BUF_R",
> +			"TRAY_PRSNT19_N_BUF_R", "TRAY_PRSNT20_N_BUF_R",
> +			"TRAY_PRSNT21_N_BUF_R", "TRAY_PRSNT22_N_BUF_R",
> +			"TRAY_PRSNT23_N_BUF_R", "TRAY_PRSNT24_N_BUF_R",
> +			"TRAY_PRSNT25_N_BUF_R", "TRAY_PRSNT26_N_BUF_R",
> +			"TRAY_PRSNT27_N_BUF_R", "TRAY_PRSNT28_N_BUF_R",
> +			"TRAY_PRSNT29_N_BUF_R", "TRAY_PRSNT30_N_BUF_R",
> +			"TRAY_PRSNT31_N_BUF_R", "TRAY_PRSNT32_N_BUF_R";
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
> +			"TRAY_PRSNT33_N_BUF_R", "TRAY_PRSNT34_N_BUF_R",
> +			"TRAY_PRSNT35_N_BUF_R", "TRAY_PRSNT36_N_BUF_R",
> +			"TRAY_PRSNT37_N_BUF_R", "TRAY_PRSNT38_N_BUF_R",
> +			"TRAY_PRSNT39_N_BUF_R", "TRAY_PRSNT40_N_BUF_R",
> +			"", "",
> +			"", "",
> +			"", "",
> +			"", "";
> +	};
> +
> +	power-monitor@14 {
> +		compatible =3D "infineon,xdp710";
> +		reg =3D <0x14>;
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
> +			"TRAY_PWRGD17_N_BUF_R", "TRAY_PWRGD18_N_BUF_R",
> +			"TRAY_PWRGD19_N_BUF_R", "TRAY_PWRGD20_N_BUF_R",
> +			"TRAY_PWRGD21_N_BUF_R", "TRAY_PWRGD22_N_BUF_R",
> +			"TRAY_PWRGD23_N_BUF_R", "TRAY_PWRGD24_N_BUF_R",
> +			"TRAY_PWRGD25_N_BUF_R", "TRAY_PWRGD26_N_BUF_R",
> +			"TRAY_PWRGD27_N_BUF_R", "TRAY_PWRGD28_N_BUF_R",
> +			"TRAY_PWRGD29_N_BUF_R", "TRAY_PWRGD30_N_BUF_R",
> +			"TRAY_PWRGD31_N_BUF_R", "TRAY_PWRGD32_N_BUF_R";
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
> +			"TRAY_PWRGD33_N_BUF_R", "TRAY_PWRGD34_N_BUF_R",
> +			"TRAY_PWRGD35_N_BUF_R", "TRAY_PWRGD36_N_BUF_R",
> +			"TRAY_PWRGD37_N_BUF_R", "TRAY_PWRGD38_N_BUF_R",
> +			"TRAY_PWRGD39_N_BUF_R", "TRAY_PWRGD40_N_BUF_R",
> +			"", "",
> +			"", "",
> +			"", "",
> +			"", "";
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
> +			"TRAY_LEAK_DETECT1_N_BUF_R", "TRAY_LEAK_DETECT2_N_BUF_R",
> +			"TRAY_LEAK_DETECT3_N_BUF_R", "TRAY_LEAK_DETECT4_N_BUF_R",
> +			"TRAY_LEAK_DETECT5_N_BUF_R", "TRAY_LEAK_DETECT6_N_BUF_R",
> +			"TRAY_LEAK_DETECT7_N_BUF_R", "TRAY_LEAK_DETECT8_N_BUF_R",
> +			"TRAY_LEAK_DETECT9_N_BUF_R", "TRAY_LEAK_DETECT10_N_BUF_R",
> +			"TRAY_LEAK_DETECT11_N_BUF_R", "TRAY_LEAK_DETECT12_N_BUF_R",
> +			"TRAY_LEAK_DETECT13_N_BUF_R", "TRAY_LEAK_DETECT14_N_BUF_R",
> +			"TRAY_LEAK_DETECT15_N_BUF_R", "TRAY_LEAK_DETECT16_N_BUF_R";
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
> +			"TRAY_LEAK_DETECT17_N_BUF_R", "TRAY_LEAK_DETECT18_N_BUF_R",
> +			"TRAY_LEAK_DETECT19_N_BUF_R", "TRAY_LEAK_DETECT20_N_BUF_R",
> +			"TRAY_LEAK_DETECT21_N_BUF_R", "TRAY_LEAK_DETECT22_N_BUF_R",
> +			"TRAY_LEAK_DETECT23_N_BUF_R", "TRAY_LEAK_DETECT24_N_BUF_R",
> +			"TRAY_LEAK_DETECT25_N_BUF_R", "TRAY_LEAK_DETECT26_N_BUF_R",
> +			"TRAY_LEAK_DETECT27_N_BUF_R", "TRAY_LEAK_DETECT28_N_BUF_R",
> +			"TRAY_LEAK_DETECT29_N_BUF_R", "TRAY_LEAK_DETECT30_N_BUF_R",
> +			"TRAY_LEAK_DETECT31_N_BUF_R", "TRAY_LEAK_DETECT32_N_BUF_R";
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
> +			"TRAY_LEAK_DETECT33_N_BUF_R", "TRAY_LEAK_DETECT34_N_BUF_R",
> +			"TRAY_LEAK_DETECT35_N_BUF_R", "TRAY_LEAK_DETECT36_N_BUF_R",
> +			"TRAY_LEAK_DETECT37_N_BUF_R", "TRAY_LEAK_DETECT38_N_BUF_R",
> +			"TRAY_LEAK_DETECT39_N_BUF_R", "TRAY_LEAK_DETECT40_N_BUF_R",
> +			"", "",
> +			"", "",
> +			"", "",
> +			"", "";
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
> +			"TRAY_SMALL_LEAK1_N_BUF_R", "TRAY_SMALL_LEAK2_N_BUF_R",
> +			"TRAY_SMALL_LEAK3_N_BUF_R", "TRAY_SMALL_LEAK4_N_BUF_R",
> +			"TRAY_SMALL_LEAK5_N_BUF_R", "TRAY_SMALL_LEAK6_N_BUF_R",
> +			"TRAY_SMALL_LEAK7_N_BUF_R", "TRAY_SMALL_LEAK8_N_BUF_R",
> +			"TRAY_SMALL_LEAK9_N_BUF_R", "TRAY_SMALL_LEAK10_N_BUF_R",
> +			"TRAY_SMALL_LEAK11_N_BUF_R", "TRAY_SMALL_LEAK12_N_BUF_R",
> +			"TRAY_SMALL_LEAK13_N_BUF_R", "TRAY_SMALL_LEAK14_N_BUF_R",
> +			"TRAY_SMALL_LEAK15_N_BUF_R", "TRAY_SMALL_LEAK16_N_BUF_R";
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
> +			"TRAY_SMALL_LEAK17_N_BUF_R", "TRAY_SMALL_LEAK18_N_BUF_R",
> +			"TRAY_SMALL_LEAK19_N_BUF_R", "TRAY_SMALL_LEAK20_N_BUF_R",
> +			"TRAY_SMALL_LEAK21_N_BUF_R", "TRAY_SMALL_LEAK22_N_BUF_R",
> +			"TRAY_SMALL_LEAK23_N_BUF_R", "TRAY_SMALL_LEAK24_N_BUF_R",
> +			"TRAY_SMALL_LEAK25_N_BUF_R", "TRAY_SMALL_LEAK26_N_BUF_R",
> +			"TRAY_SMALL_LEAK27_N_BUF_R", "TRAY_SMALL_LEAK28_N_BUF_R",
> +			"TRAY_SMALL_LEAK29_N_BUF_R", "TRAY_SMALL_LEAK30_N_BUF_R",
> +			"TRAY_SMALL_LEAK31_N_BUF_R", "TRAY_SMALL_LEAK32_N_BUF_R";
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
> +			"TRAY_SMALL_LEAK33_N_BUF_R", "TRAY_SMALL_LEAK34_N_BUF_R",
> +			"TRAY_SMALL_LEAK35_N_BUF_R", "TRAY_SMALL_LEAK36_N_BUF_R",
> +			"TRAY_SMALL_LEAK37_N_BUF_R", "TRAY_SMALL_LEAK38_N_BUF_R",
> +			"TRAY_SMALL_LEAK39_N_BUF_R", "TRAY_SMALL_LEAK40_N_BUF_R",
> +			"", "",
> +			"", "",
> +			"", "",
> +			"", "";
> +	};
> +
> +	legacy_pwrgd_io_expander0: gpio@28 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x28>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		interrupt-parent =3D <&sgpiom0>;
> +		interrupts =3D <42 IRQ_TYPE_LEVEL_LOW>;
> +
> +		gpio-line-names =3D
> +			"TRAY_PWRGD1_N_BUF_R", "TRAY_PWRGD2_N_BUF_R",
> +			"TRAY_PWRGD3_N_BUF_R", "TRAY_PWRGD4_N_BUF_R",
> +			"TRAY_PWRGD5_N_BUF_R", "TRAY_PWRGD6_N_BUF_R",
> +			"TRAY_PWRGD7_N_BUF_R", "TRAY_PWRGD8_N_BUF_R",
> +			"TRAY_PWRGD9_N_BUF_R", "TRAY_PWRGD10_N_BUF_R",
> +			"TRAY_PWRGD11_N_BUF_R", "TRAY_PWRGD12_N_BUF_R",
> +			"TRAY_PWRGD13_N_BUF_R", "TRAY_PWRGD14_N_BUF_R",
> +			"TRAY_PWRGD15_N_BUF_R", "TRAY_PWRGD16_N_BUF_R";
> +	};
> +

...

> +
> +&mdio0 {
> +	status =3D "okay";
> +};
> +
> +&peci0 {
> +	status =3D "okay";
> +};

Ah, so the earlier peci node is redundant. Can you please remove it?

Andrew

