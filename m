Return-Path: <linux-aspeed+bounces-2906-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABE9CDE00A
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 04:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d73zx4Ykjz2yvX;
	Fri, 14 Nov 2025 15:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763094525;
	cv=none; b=QCS3+jqt7r5/vYolUpd36bESgHflSlaFMkdzP9TPuGR23euWTMHLt1v7LeT2K7G9jDsn5Du5FHQJIm5arJzTlx5neRF+8cxCVaG3e+2NrRAJeesm3Nw0HCvRmtm40WSVc3WgHOwEiKR+h0K3tZA4xnZ/Xq12zuLOqNbcPqSxeE1VZo0+n360tciwrAQQ2UIyTwrU4ca40AXgcuKt+RyQDcIo/ikM/iy21/FyYkuMtxfGrkhsjLeW2SUkypbJJfXuoHmlv5l7CtttHeyNyDttPmNQ9cA02e8ft4g+cuioZ5rkh5uk2xcuQYmje2X5cEXqntK19CCVab/RlBiO3mtjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763094525; c=relaxed/relaxed;
	bh=jblTHLUiY2AXGGbzy5NAcPX1cicQXWAnpTpnfBI21To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjXSvQMVQWAmn8UvtI85Lfnpv2blfLyQyZlYcVMmOwtPwin0thO75K/kFZ6o00/vpDuOp80IZ9SSgkQ00ymnKW3uUotu6aWXDMajXdphE/Z7SaPl9wIpoZL2WukuOF07JphxjxEmzBXKPY89RdUATuFzp1cVVJ6CYs7jJsSOWj6MlDhbNYMr0RXK95YbapkOXjF/KHmpCmYkh7A7JaFZrA6NugoajZAxbt9p6Nv3GKY3UIuXNdu4iuIOmXCuELKdX2fg8jdm5ocBAAQQCvG+Ak1h/wLSD6w29vJxRygr/PHgYkELgPsA+mx3lrr/qp8Y64j9CoGNm174Qjq9IVrSmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LhNtoRrM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LhNtoRrM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d73zx1FCsz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 15:28:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763094524;
	bh=jblTHLUiY2AXGGbzy5NAcPX1cicQXWAnpTpnfBI21To=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LhNtoRrMyi8IvtMRMwCB/6XW4hG6SFlZBxOF1nG8JtvErFDSnOFAcP7+Cfl+1v01F
	 s0A0nDW9jWVPC1zyK0RxmgaiN/srsIH7Xi1zmusZZM+jNfwwhTQFnWKv8eJ9RW9c4m
	 kiNr2NX8GUaHMVKT1h83sfiJAWBLKKohpRjS10dwlnz073Wceb+L315BL41L87rKI2
	 FgQDfhnOhCvyGnE7aehbuM1FuW3CLt1szyb/m+lv9//bq4xyJ5BKJcCz9inLA4gGeH
	 pz6hPjcQ3Pxmv4qaitP8oG5c3pIYPrxtZmjDur2wUwHv7mpwfIPkr6z7jeIvYS0qah
	 w4tK9KQw/LfiA==
Received: from [192.168.68.115] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 044E1783DF;
	Fri, 14 Nov 2025 12:28:43 +0800 (AWST)
Message-ID: <06c1f0e3a42adc435f753bd2c1cf8ea6416109e7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Shen <sjg168@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org,
 peter.shen@amd.com, Krzysztof Kozlowski	 <krzk@kernel.org>
Date: Fri, 14 Nov 2025 14:58:43 +1030
In-Reply-To: <20251112211248.3711889-3-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
	 <20251112211248.3711889-3-sjg168@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Thu, 2025-11-13 at 05:12 +0800, Peter Shen wrote:
> Add the initial device tree source file for the Facebook Anacapa BMC
> platform, based on the Aspeed AST2600 SoC.
>=20
> This device tree configures the platform-specific peripherals and
> aliases for OpenBMC usage.
>=20
> Signed-off-by: Peter Shen <sjg168@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa.dts=C2=A0=C2=A0=C2=A0 | 1223=
 +++++++++++++++++
> =C2=A02 files changed, 1224 insertions(+)
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
> index 000000000000..e55069a199c8
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
> @@ -0,0 +1,1223 @@
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
> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		i2c16 =3D &i2c0mux0ch0;
> +		i2c17 =3D &i2c0mux0ch1;
> +		i2c18 =3D &i2c0mux0ch2;
> +		i2c19 =3D &i2c0mux0ch3;
> +		i2c20 =3D &i2c1mux0ch0;
> +		i2c21 =3D &i2c1mux0ch1;
> +		i2c22 =3D &i2c1mux0ch2;
> +		i2c23 =3D &i2c1mux0ch3;
> +		i2c24 =3D &i2c4mux0ch0;
> +		i2c25 =3D &i2c4mux0ch1;
> +		i2c26 =3D &i2c4mux0ch2;
> +		i2c27 =3D &i2c4mux0ch3;
> +		i2c28 =3D &i2c4mux0ch4;
> +		i2c29 =3D &i2c4mux0ch5;
> +		i2c30 =3D &i2c4mux0ch6;
> +		i2c31 =3D &i2c4mux0ch7;
> +		i2c32 =3D &i2c8mux0ch0;
> +		i2c33 =3D &i2c8mux0ch1;
> +		i2c34 =3D &i2c8mux0ch2;
> +		i2c35 =3D &i2c8mux0ch3;
> +		i2c36 =3D &i2c10mux0ch0;
> +		i2c37 =3D &i2c10mux0ch1;
> +		i2c38 =3D &i2c10mux0ch2;
> +		i2c39 =3D &i2c10mux0ch3;
> +		i2c40 =3D &i2c10mux0ch4;
> +		i2c41 =3D &i2c10mux0ch5;
> +		i2c42 =3D &i2c10mux0ch6;
> +		i2c43 =3D &i2c10mux0ch7;
> +		i2c44 =3D &i2c11mux0ch0;
> +		i2c45 =3D &i2c11mux0ch1;
> +		i2c46 =3D &i2c11mux0ch2;
> +		i2c47 =3D &i2c11mux0ch3;
> +		i2c48 =3D &i2c11mux0ch4;
> +		i2c49 =3D &i2c11mux0ch5;
> +		i2c50 =3D &i2c11mux0ch6;
> +		i2c51 =3D &i2c11mux0ch7;
> +		i2c52 =3D &i2c13mux0ch0;
> +		i2c53 =3D &i2c13mux0ch1;
> +		i2c54 =3D &i2c13mux0ch2;
> +		i2c55 =3D &i2c13mux0ch3;
> +		i2c56 =3D &i2c13mux0ch4;
> +		i2c57 =3D &i2c13mux0ch5;
> +		i2c58 =3D &i2c13mux0ch6;
> +		i2c59 =3D &i2c13mux0ch7;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial4:57600n8";
> +	};
> +
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +				=C2=A0 <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +				=C2=A0 <&adc1 2>;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led-0 {
> +			label =3D "bmc_heartbeat_amber";
> +			gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +
> +		led-1 {
> +			label =3D "fp_id_amber";
> +			default-state =3D "off";
> +			gpios =3D <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label =3D "power_blue";
> +			default-state =3D "off";
> +			gpios =3D <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size =3D <0x02c00000>;
> +			alignment =3D <0x00100000>;
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		gfx_memory: framebuffer {
> +			size =3D <0x01000000>;
> +			alignment =3D <0x01000000>;
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		pcc_memory: pccbuffer {

Drop this, it's unused?

> +			no-map;
> +			reg =3D <0xE0000000 0x00001000>; /* 4K */
> +		};
> +	};
> +
> +	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "p3v3_bmc_aux";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	spi_gpio: spi {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		sck-gpios =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects =3D <1>;

Bit of a nitpick, but I'd prefer all the relevant -gpios properties be
grouped together (i.e. put num-chipselects below cs-gpios).

> +		cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +		status =3D "okay";
> +
> +		tpm@0 {
> +			compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency =3D <33000000>;
> +			reg =3D <0>;
> +		};
> +	};
> +};
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
> +&gpio0 {
> +	gpio-line-names =3D
> +
> +	/*
> +	 * A0-A7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SMB_BMC_MM11_SCL", "SMB_BMC_MM11_SDA",
> +	"SMB_BMC_MM12_SCL", "SMB_BMC_MM12_SDA",
> +	"SMB_BMC_MM13_SCL", "SMB_BMC_MM13_SDA",
> +	"SMB_BMC_MM14_SCL", "SMB_BMC_MM14_SDA",
> +
> +	/*
> +	 * B0-B7: "rtc-battery-voltage-read-enable", "", "", "BMC_READY", "",
> +	 * =C2=A0 =C2=A0 =C2=A0 =C2=A0"led-identify", "", ""
> +	 */
> +	"BATTERY_DETECT","BMC_GPIOB1",
> +	"BMC_I2C1_FPGA_ALERT","BMC_READY",
> +	"IOEXP_INT_3V3","FM_ID_LED",
> +	"UART_BMC_4_TXD","UART_BMC_4_RXD",

Why are you naming GPIOs after other pinctrl functions on the pin? That
seems odd? There seems to be a fair bit of this going on (below) too.

> +
> +
> +	/*
> +	 * C0-C7: "", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_GPIOC0", "NCSI0_SCM_HPM_TX_EN",
> +	"NCSI0_SCM_HPM_D0", "NCSI0_SCM_HPM_D1",
> +	"PMBUS_REQ_N", "PSU_FW_UPDATE_REQ_N",
> +	"NCSI0_HPM_SCM_CLK", "BMC_I2C_SSIF_ALERT",
> +
> +	/*
> +	 * D0-D7: "", "", "", "", "", "", "", ""
> +	 */
> +	"NCSI0_HPM_SCM_D0", "NCSI0_HPM_SCM_D1",
> +	"NCSI0_HPM_SCM_CRS_DV", "NCSI0_RXER",
> +	"BMC_GPIOD4", "BMC_GPIOD5",
> +	"BMC_GPIOD6", "BMC_GPIOD7",
> +
> +	/*
> +	 * E0-E7: "", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_GPIOE0", "BMC_GPIOE1",
> +	"BMC_GPIOE1", "PD_RGMII4_RXCTL",
> +	"BMC_GPIOE1", "BMC_GPIOE1",
> +	"BMC_GPIOE1", "NCSI1_RXER",
> +
> +	/*
> +	 * F0-F7: "", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_EMMC_CLK", "BMC_EMMC_CMD",
> +	"BMC_EMMC_DT0", "BMC_EMMC_DT1",
> +	"BMC_EMMC_DT2", "BMC_EMMC_DT3",
> +	"BMC_EMMC_CD_N", "BMC_EMMC_WP_N",
> +
> +	/*
> +	 * G0-G7: "FM_MUX1_SEL_R", "", "", "", "", "", "", ""
> +	 */
> +	"FM_MUX1_SEL", "BMC_GPIOG1",
> +	"BMC_EMMC_DT4", "BMC_EMMC_DT5",
> +	"BMC_EMMC_DT6", "BMC_EMMC_DT7",
> +	"FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
> +
> +	/*
> +	 * H0-H7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SGPIO_CLK_1", "SGPIO_LD_1",
> +	"SGPIO_DO_1", "SGPIO_DI_1",
> +	"SMB_BMC_MM15_SCL", "SMB_BMC_MM15_SDA",
> +	"SMB_BMC_MM16_SCL", "SMB_BMC_MM16_SDA",
> +
> +	/*
> +	 * I0-I7: "", "", "", "", "", "", "", ""
> +	 */
> +	"JTAG_1_BMC_TRST", "JTAG_1_BMC_TCK",
> +	"JTAG_1_BMC_TMS", "JTAG_1_BMC_TDI",
> +	"JTAG_1_BMC_TDO", "FLASH_WP_STATUS",
> +	"BMC_JTAG_MUX_SEL", "BMC_GPIOI7",
> +
> +	/*
> +	 * J0-J7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SMB_BMC_MM1_SCL", "SMB_BMC_MM1_SDA",
> +	"SMB_BMC_MM2_SCL", "SMB_BMC_MM2_SDA",
> +	"I3C_5_HV18_SCL", "I3C_5_HV18_SDA",
> +	"I3C_6_HV18_SCL", "I3C_6_HV18_SDA",
> +
> +	/*
> +	 * K0-K7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SMB_BMC_MM5_SCL", "SMB_BMC_MM5_SDA",
> +	"SMB_BMC_MM6_SCL", "SMB_BMC_MM6_SDA",
> +	"SMB_BMC_MM7_SCL", "SMB_BMC_MM7_SDA",
> +	"SMB_BMC_MM8_SCL", "SMB_BMC_MM8_SDA",
> +
> +	/*
> +	 * L0-L7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SMB_BMC_MM9_SCL", "SMB_BMC_MM9_SDA",
> +	"SMB_BMC_MM10_SCL", "SMB_BMC_MM10_SDA",
> +	"UART_BMC_3_TXD", "UART_BMC_3_RXD",
> +	"V_VGAHS", "V_VGAVS",
> +
> +	/*
> +	 * M0-M7: "", "", "", "", "", "", "", ""
> +	 */
> +	"PCIE_EP_RST_EN", "BMC_FRU_WP",
> +	"SCM_HPM_STBY_RST_N", "SCM_HPM_STBY_EN",
> +	"STBY_POWER_PG_3V3", "TH500_SHDN_OK",
> +	"UART_BMC_1_TXD", "UART_BMC_1_RXD",
> +
> +	/*
> +	 * N0-N7: "led-postcode-0", "led-postcode-1", "led-postcode-2", "led-po=
stcode-3",
> +	 * =C2=A0 =C2=A0 =C2=A0=C2=A0 "led-postcode-4", "led-postcode-5", "led-=
postcode-6", "led-postcode-7"
> +	 */
> +	"LED_POSTCODE_0", "LED_POSTCODE_1",
> +	"LED_POSTCODE_2", "LED_POSTCODE_3",
> +	"LED_POSTCODE_4", "LED_POSTCODE_5",
> +	"LED_POSTCODE_6", "LED_POSTCODE_7",
> +
> +	/*
> +	 * O0-O7: "", "", "", "", "", "", "", ""
> +	 */
> +	"RUN_POWER_PG", "PWR_BRAKE",
> +	"CHASSIS_AC_LOSS", "BSM_PRSNT_N",
> +	"PSU_SMB_ALERT", "FM_TPM_PRSNT_0_N",
> +	"PSU_FW_UPDATING_N", "BMC_GPIOO7",
> +
> +	/*
> +	 * P0-P7: "power-button", "", "reset-button", "", "led-power", "", "", =
""
> +	 */
> +	"PWR_BTN_BMC_BUF_N", "IPEX_CABLE_PRSNT",
> +	"ID_RST_BTN_BMC_N", "RST_BMC_RSTBTN_OUT_N",
> +	"PWR_LED", "RUN_POWER_EN",
> +	"SHDN_FORCE", "BMC_HEARTBEAT_N",
> +
> +	/*
> +	 * Q0-Q7: "", "", "", "", "", "", "", ""
> +	 */
> +	"IRQ_PCH_TPM_SPI_LV3_N", "USB_OC0_REAR_N",
> +	"UART_MUX_SEL", "I2C_MUX_RESET",
> +	"RSVD_NV_PLT_DETECT", "SPI_TPM_INT",
> +	"CPU_JTAG_MUX_SELECT", "THERM_BB_OVERT",
> +
> +	/*
> +	 * R0-R7: "", "", "", "", "", "", "", ""
> +	 */
> +	"THERM_BB_WARN", "SPI_BMC_FPGA_INT",
> +	"CPU_BOOT_DONE", "PMBUS_GNT",
> +	"CHASSIS_PWR_BRK", "PCIE_WAKE",
> +	"PDB_THERM_OVERT", "SHDN_REQ",
> +
> +	/*
> +	 * S0-S7: "", "", "power-host-control", "", "", "", "", ""
> +	 */
> +	"MDC1_BMC", "MDIO1_BMC",
> +	"SYS_BMC_PWRBTN_N", "FM_TPM_PRSNT_1_N",
> +	"FM_BMC_DEBUG_SW_N", "UID_LED_N",
> +	"SYS_FAULT_LED_N", "RUN_POWER_FAULT",
> +
> +	/*
> +	 * T0-T7: "", "", "", "", "", "", "", ""
> +	 */
> +	"", "", "", "", "", "", "", "",
> +
> +	/*
> +	 * U0-U7: "", "", "", "", "", "", "", ""
> +	 */
> +	"", "", "", "", "", "", "", "",
> +
> +	/*
> +	 * V0-V7: "", "", "", "", "", "", "", ""
> +	 */
> +	"L2_RST_REQ_OUT", "L0L1_RST_REQ_OUT",
> +	"BMC_ID_BEEP_SEL", "BMC_I2C0_FPGA_ALERT",
> +	"SMB_BMC_TMP_ALERT", "PWR_LED_N",
> +	"SYS_RST_OUT", "IRQ_TPM_SPI_N",
> +
> +	/*
> +	 * W0-W7: "", "", "", "", "", "", "", ""
> +	 */
> +	"ESPI_LPC_D0_IO0", "ESPI_LPC_D1_IO1",
> +	"ESPI_LPC_D2_IO2", "ESPI_LPC_D3_IO3",
> +	"ESPI_HOST_LPC_BMC_CLK",
> +	"ESPI_HOST_LPC_BMC_LFRAME_N",
> +	"IRQ_ESPI_LPC_SERIRQ_ALERT0_N",
> +	"RST_ESPI_LPC_BMC_N",
> +
> +	/*
> +	 * X0-X7: "", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_GPIOX0", "BMC_GPIOX1",
> +	"BMC_GPIOX2", "SPI_BMC_OOB_0_CLK",
> +	"SPI_BMC_OOB_0_IO0", "SPI_BMC_OOB_0_IO1",
> +	"SPI_BMC_OOB_0_IO2", "SPI_BMC_OOB_0_IO3",
> +
> +	/*
> +	 * Y0-Y7: "", "", "", "", "", "", "", ""
> +	 */
> +	"RST_WDTRST_PLD_N", "RST_BMC_SELF_HW",
> +	"FM_FLASH_LATCH_N", "BMC_EMMC_RST_N",
> +	"BMC_GPIOY4", "BMC_GPIOY5",
> +	"PU_BMC_FWSPIABR_N", "PU_FWSPIWP_N",
> +
> +	/*
> +	 * Z0-Z7: "", "", "", "", "", "", "", ""
> +	 */
> +	"SPI_BMC_TPM_CS2_N", "PU_SPI1ABR",
> +	"PU_SPI1WP_N", "SPI_BMC_TPM_CLK",
> +	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO",
> +	"BMC_GPIOZ6", "BMC_GPIOZ7",
> +};
> +
> +&gpio1 {
> +	gpio-line-names =3D
> +	/*
> +	 * 18A0-18A7: "", "", "", "", "", "", "", ""
> +	 */
> +	"RGMII1TXCK", "RGMII1TXCTL",
> +	"RGMII1TXD0", "RGMII1TXD1",
> +	"RGMII1TXD2", "RGMII1TXD3",
> +	"RGMII1RXCK", "RGMII1RXCTL",
> +
> +	/*
> +	 * 18B0-18B7: "", "", "", "", "FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV=
_ID1",
> +	 * "FM_BOARD_BMC_REV_ID2", ""
> +	 */
> +	"RGMII1RXD0", "RGMII1RXD1",
> +	"RGMII1RXD2", "RGMII1RXD3",
> +	"FM_BOARD_BMC_REV_ID0", "FM_BOARD_BMC_REV_ID1",
> +	"FM_BOARD_BMC_REV_ID2", "BMC_GPIO18B7",
> +
> +	/*
> +	 * 18C0-18C7: "SPI_BMC_BIOS_ROM_IRQ0_R_N", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_GPIO18C0", "BMC_GPIO18C1",
> +	"SPI_BMC_BIOS_ROM_IRQ0_N", "BMC_GPIO18C3",
> +	"BMC_GPIO18C4", "BMC_GPIO18C5",
> +	"BMC_GPIO18C6", "BMC_GPIO18C7",
> +
> +	/*
> +	 * 18D0-18D7: "", "", "", "", "", "", "", ""
> +	 */
> +	"BMC_GPIO18D0", "BMC_GPIO18D1",
> +	"BMC_GPIO18D2", "BMC_GPIO18D3",
> +	"BMC_GPIO18D4", "BMC_GPIO18D5",
> +	"BMC_GPIO18D6", "BMC_GPIO18D7",
> +
> +	/*
> +	 * 18E0-18E3: "FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_R_N", "", ""
> +	 */
> +	"FM_BMC_PROT_LS_EN", "AC_PWR_BMC_BTN_N",
> +	"BMC_GPIO18E2", "BMC_GPIO18E3"
> +};
> +
> +// L Bridge Board
> +&i2c0 {
> +	status =3D "okay";
> +
> +	i2c-mux@70 {
> +		compatible =3D "nxp,pca9546";
> +		reg =3D <0x70>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c0mux0ch0: i2c@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +		i2c0mux0ch1: i2c@1 {
> +			reg =3D <1>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +		i2c0mux0ch2: i2c@2 {
> +			reg =3D <2>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +		i2c0mux0ch3: i2c@3 {
> +			reg =3D <3>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +	};
> +};
> +

*snip*

> +
> +&pinctrl {
> +	pinctrl_ncsi3_default: ncsi3_default {
> +		function =3D "RMII3";
> +		groups =3D "NCSI3";
> +	};

Can you rather add this to the DTSI so other platforms can make use of
it?

> +};
> +
> +&mac2 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_ncsi3_default>;
> +	use-ncsi;
> +};
> +
> +&sgpiom0 {
> +	ngpios =3D <128>;
> +	bus-frequency =3D <2000000>;
> +	gpio-line-names =3D
> +	/*in - out - in - out */
> +	/*A0-A3 line 0-7*/
> +	"","FM_CPU0_SYS_RESET_N",
> +	"","CPU0_KBRST_N",
> +	"","FM_CPU0_PROCHOT_trigger_N",

What drives the choice of mixed case names throughout?

Andrew

> +	"","FM_CLR_CMOS_R_P0",
> +	/*A4-A7 line 8-15*/
> +	"","Force_I3C_SEL",
> +	"","SYSTEM_Force_Run_AC_Cycle",
> +	"","",
> +	"","",
> +	/*B0-B3 line 16-23*/
> +	"Channel0_leakage_EAM3","FM_CPU_FPGA_JTAG_MUX_SEL",
> +	"Channel1_leakage_EAM0","FM_SCM_JTAG_MUX_SEL",
> +	"Channel2_leakage_Manifold1","FM_BRIDGE_JTAG_MUX_SEL",
> +	"Channel3_leakage","FM_CPU0_NMI_SYNC_FLOOD_N",
> +	/*B4-B7 line 24-31*/
> +	"Channel4_leakage_Manifold2","",
> +	"Channel5_leakage_EAM1","",
> +	"Channel6_leakage_CPU_DIMM","",
> +	"Channel7_leakage_EAM2","",
> +	/*C0-C3 line 32-39*/
> +	"RSVD_RMC_GPIO3","",
> +	"LEAK_DETECT_RMC_N","",
> +	"","",
> +	"","",
> +	/*C4-C7 line 40-47*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*D0-D3 line 48-55*/
> +	"PWRGD_PDB_EAMHSC0_CPLD_PG_R","",
> +	"PWRGD_PDB_EAMHSC1_CPLD_PG_R","",
> +	"PWRGD_PDB_EAMHSC2_CPLD_PG_R","",
> +	"PWRGD_PDB_EAMHSC3_CPLD_PG_R","",
> +	/*D4-D7 line 56-63*/
> +	"AMC_BRD_PRSNT_CPLD_L","",
> +	"","",
> +	"","",
> +	"","",
> +	/*E0-E3 line 64-71*/
> +	"AMC_PDB_EAMHSC0_CPLD_EN_R","",
> +	"AMC_PDB_EAMHSC1_CPLD_EN_R","",
> +	"AMC_PDB_EAMHSC2_CPLD_EN_R","",
> +	"AMC_PDB_EAMHSC3_CPLD_EN_R","",
> +	/*E4-E7 line 72-79*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*F0-F3 line 80-87*/
> +	"PWRGD_PVDDCR_CPU1_P0","SGPIO_READY",
> +	"PWRGD_PVDDCR_CPU0_P0","",
> +	"","",
> +	"","",
> +	/*F4-F7 line 88-95*/
> +	"","",
> +	"","",
> +	"","",
> +	"","",
> +	/*G0-G3 line 96-103*/
> +	"PWRGD_PVDDCR_SOC_P0","",
> +	"PWRGD_PVDDIO_P0","",
> +	"PWRGD_PVDDIO_MEM_S3_P0","",
> +	"PWRGD_CHMP_CPU0_FPGA","",
> +	/*G4-G7 line 104-111*/
> +	"PWRGD_CHIL_CPU0_FPGA","",
> +	"PWRGD_CHEH_CPU0_FPGA","",
> +	"PWRGD_CHAD_CPU0_FPGA","FM_BMC_READY_PLD",
> +	"","",
> +	/*H0-H3 line 112-119*/
> +	"PWRGD_P3V3","",
> +	"P12V_DDR_IP_PWRGD_R","",
> +	"P12V_DDR_AH_PWRGD_R","",
> +	"PWRGD_P12V_VRM1_CPLD_PG_R","",
> +	/*H4-H7 line 120-127*/
> +	"PWRGD_P12V_VRM0_CPLD_PG_R","",
> +	"PWRGD_PDB_HSC4_CPLD_PG_R","",
> +	"PWRGD_PVDD18_S5_P0_PG","",
> +	"PWRGD_PVDD33_S5_P0_PG","",
> +	/*I0-I3 line 128-135*/
> +	"EAM0_BRD_PRSNT_R_L","",
> +	"EAM1_BRD_PRSNT_R_L","",
> +	"EAM2_BRD_PRSNT_R_L","",
> +	"EAM3_BRD_PRSNT_R_L","",
> +	/*I4-I7 line 136-143*/
> +	"EAM0_CPU_MOD_PWR_GD_R","",
> +	"EAM1_CPU_MOD_PWR_GD_R","",
> +	"EAM2_CPU_MOD_PWR_GD_R","",
> +	"EAM3_CPU_MOD_PWR_GD_R","",
> +	/*J0-J3 line 144-151*/
> +	"PRSNT_L_BIRDGE_R","",
> +	"PRSNT_R_BIRDGE_R","",
> +	"BRIDGE_L_MAIN_PG_R","",
> +	"BRIDGE_R_MAIN_PG_R","",
> +	/*J4-J7 line 152-159*/
> +	"BRIDGE_L_STBY_PG_R","",
> +	"BRIDGE_R_STBY_PG_R","",
> +	"","",
> +	"","",
> +	/*K0-K3 line 160-167*/
> +	"ADC_I2C_ALERT_N","",
> +	"TEMP_I2C_ALERT_R_L","",
> +	"CPU0_VR_SMB_ALERT_CPLD_N","",
> +	"COVER_INTRUDER_R_N","",
> +	/*K4-K7 line 168-175*/
> +	"HANDLE_INTRUDER_CPLD_N","",
> +	"IRQ_MCIO_CPLD_WAKE_R_N","",
> +	"APML_CPU0_ALERT_R_N","",
> +	"PDB_ALERT_R_N","",
> +	/*L0-L3 line 176-183*/
> +	"CPU0_SP7R1","",
> +	"CPU0_SP7R2","",
> +	"CPU0_SP7R3","",
> +	"CPU0_SP7R4","",
> +	/*L4-L7 line 184-191*/
> +	"CPU0_CORETYPE0","",
> +	"CPU0_CORETYPE1","",
> +	"CPU0_CORETYPE2","",
> +	"FM_BIOS_POST_CMPLT_R_N","",
> +	/*M0-M3 line 192-199*/
> +	"EAM0_SMERR_CPLD_R_L","",
> +	"EAM1_SMERR_CPLD_R_L","",
> +	"EAM2_SMERR_CPLD_R_L","",
> +	"EAM3_SMERR_CPLD_R_L","",
> +	/*M4-M7 line 200-207*/
> +	"CPU0_SMERR_N_R","",
> +	"CPU0_NV_SAVE_N_R","",
> +	"PDB_PWR_LOSS_CPLD_N","",
> +	"IRQ_BMC_SMI_ACTIVE_R_N","",
> +	/*N0-N3 line 208-215*/
> +	"AMCROT_BMC_S5_RDY_R","",
> +	"AMC_RDY_R","",
> +	"AMC_STBY_PGOOD_R","",
> +	"CPU_AMC_SLP_S5_R_L","",
> +	/*N4-N7 line 216-223*/
> +	"AMC_CPU_EAMPG_R","",
> +	"","",
> +	"","",
> +	"","",
> +	/*O0-O3 line 224-231*/
> +	"HPM_PWR_FAIL","Port80_b0",
> +	"FM_DIMM_IP_FAIL","Port80_b1",
> +	"FM_DIMM_AH_FAIL","Port80_b2",
> +	"HPM_AMC_THERMTRIP_R_L","Port80_b3",
> +	/*O4-O7 line 232-239*/
> +	"FM_CPU0_THERMTRIP_N","Port80_b4",
> +	"PVDDCR_SOC_P0_OCP_L","Port80_b5",
> +	"CPLD_SGPIO_RDY","Port80_b6",
> +	"","Port80_b7",
> +	/*P0-P3 line 240-247*/
> +	"CPU0_SLP_S5_N_R","NFC_VEN",
> +	"CPU0_SLP_S3_N_R","",
> +	"FM_CPU0_PWRGD","",
> +	"PWRGD_RMC","",
> +	/*P4-P7 line 248-255*/
> +	"FM_RST_CPU0_RESET_N","",
> +	"FM_PWRGD_CPU0_PWROK","",
> +	"wS5_PWR_Ready","",
> +	"wS0_ON_N","PWRGD_P1V0_AUX";
> +	status =3D "okay";
> +};
> +

