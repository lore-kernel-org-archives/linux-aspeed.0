Return-Path: <linux-aspeed+bounces-2205-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B847CA1016
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 06:29:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMnhh1G69z2yFJ;
	Thu, 11 Sep 2025 16:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757572164;
	cv=none; b=VqhLaz40rApQtpa6TYGMWmmUmzHp+EHGe4A2wErYGLM3rMAeqF/0adFSkjFlRtOCd+/GLKdLnMoGv+Zh3Ajdy9xjM4495gToJubCH5NfnbxAU62qOLCohxDGJA6dWmptViKrTCr4w1aKvDz9lypx8O0XuUrHb5wf/DpCXi/v6DVXXXW80OBbxG7u6IOdIOEbYl6JNt3zcUyx8m6r/VmZa0UBZiczv/Nhso/XGup2WkxIpCXFUSw6Eo/5x62yorC0rzx2I49R5rtw5IccS6uBissczRR/enj6wFqjbfHI9PHE/jfXieWspyTd8ZAo1cWnD4XsHlow7qgnlvisZHW4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757572164; c=relaxed/relaxed;
	bh=DiaSUyghbPGssB7K0Wt4N0CYD158x7Hj+yZIND6YVbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AmGQ1wwlx6kfVCo1tuolMn9yv7EXsbIiioKSWud01BoszJCwptx56cVZSUyMC1HOu3ymQwCy8XENBb/tN0Kvl4F942j9sIqoBfbSOrjRw1qgZgNTv2KtB08RDXZ/WJvy6DengMgnWHAwaqYY7gOn7u/M6keftfUjq7qWdV/kkG3JBL7VotR4csc4ICQ0+LbAWCx2BGTsmv9XAEn2PXETAJaXj4a8N0kb9o0cH4th5aWFEPS4u3yDDQn8DpM1OD09biLjRoE7x1G4hWvHUq7pUFuZvpEqM+g3jutKe+T7Ei+93jUX/5y5kkwsxiA2fZNUbmGwfSAEUZGgX9LnoerHvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E1pKxW5G; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E1pKxW5G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMnhf4CL5z2xnn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Sep 2025 16:29:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A75444082;
	Thu, 11 Sep 2025 06:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFB1C4CEF1;
	Thu, 11 Sep 2025 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757572160;
	bh=3ww/jS1fs9nHT7j3wCS68DaL7+qVCfA7ppHd8n2uUdc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=E1pKxW5GoaZaQISBvQIQBAM789VE3o8LUozMR/afizF4FZtKfNilMWZWF5gfvmzG1
	 JuzdssHiZQlyOJvhDBte4ceKkZp0C+1X2V9Mpoziiv6OemWZszlsU/BwnOx6/BKaSK
	 GkJpftKyTzApRYpb2MwOe2aGrFWuVZhGsJhSxCRxpRbD0iJxyHFR8mKkXyLi27JyhO
	 oT9uTFt7Q81J99/r6qRF2gX0U4GbgajEvd5GVmGfanY92V+pFheOurjajrANiHMh7w
	 /FBKmpbfLYMUDvKgBd0cH/kbEBHg66Zt8n8SvNoPUz4GIKmi9BxpMoGsG3WHX9cUlX
	 gbXI0AYJJJ5rA==
Message-ID: <1e4c65c6-4745-45e2-9e20-9d2e69ae2ea4@kernel.org>
Date: Thu, 11 Sep 2025 08:29:15 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250911051009.4044609-3-rebecca@bsdio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 07:10, Rebecca Cran wrote:
> The ALTRAD8 BMC is an Aspeed AST2500-based BMC for the ASRock Rack
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards.
> 
> Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile                      |   1 +
>  arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts | 647 ++++++++++++++++++++
>  2 files changed, 648 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index aba7451ab749..6bffb7130839 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ampere-mtjefferson.dtb \
>  	aspeed-bmc-ampere-mtmitchell.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
> +	aspeed-bmc-asrock-altrad8.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-e3c256d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> new file mode 100644
> index 000000000000..61f6cf8018c0
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
> @@ -0,0 +1,647 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "ASRock ALTRAD8 BMC";
> +	compatible = "asrock,altrad8-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 = &uart5;
> +		i2c50 = &m2_2;
> +		i2c51 = &pcie4;
> +		i2c52 = &pcie5;
> +		i2c53 = &pcie6;
> +		i2c54 = &pcie7;
> +		i2c55 = &ocu_2;
> +		i2c56 = &ocu_1;
> +		i2c57 = &m2_1;
> +		i2c58 = &slim1_1;
> +		i2c59 = &slim2_1;
> +		i2c60 = &slim3_1;
> +		i2c61 = &slim4_1;
> +		i2c62 = &slim1_2;
> +		i2c63 = &slim2_2;
> +		i2c64 = &slim3_2;
> +		i2c65 = &slim4_2;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "console=ttyS4,115200 earlycon";


Please drop bootargs. Baud rate goes to stdout-path and earlycon is
debugging tool, not suitable for mainline.

> +	};
> +
> +	memory@80000000 {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		vga_memory: framebuffer@9f000000 {
> +			no-map;
> +			reg = <0x9f000000 0x01000000>; /* 16M */
> +		};
> +
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		systemfault {

Never tested.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.


> +			gpios = <&gpio ASPEED_GPIO(G,3) GPIO_ACTIVE_LOW>;
> +			label = "platform:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +
> +		enclosure_identify {
> +			gpios = <&gpio ASPEED_GPIO(G,0) GPIO_ACTIVE_LOW>;
> +			label = "platform:green:indicator";
> +			color = <LED_COLOR_ID_GREEN>;
> +			function = LED_FUNCTION_INDICATOR;
> +		};
> +	};
> +
> +	leds-fanfail {
> +		compatible = "gpio-leds";
> +
> +		fan1 {
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
> +			label = "fan1:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +
> +		fan2 {
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
> +			label = "fan2:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +
> +		fan3 {
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
> +			label = "fan3:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +
> +		fan4 {
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
> +			label = "fan4:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +
> +		fan5{
> +			retain-state-shutdown;
> +			default-state = "off";
> +			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
> +			label = "fan5:red:fault";
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_FAULT;
> +		};
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =	<&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
> +				<&adc 4> ,<&adc 5>, <&adc 6>, <&adc 7>,
> +				<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
> +				<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
> +	};
> +};
> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		label = "bmc";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};
> +
> +&spi1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "pnor";
> +		spi-max-frequency = <100000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			code@400000 {
> +				reg = <0x400000 0x1C00000>;
> +				label = "pnor-code";
> +			};
> +			tfa@400000 {
> +				reg = <0x400000 0x200000>;
> +				label = "pnor-tfa";
> +			};
> +			uefi@600000 {
> +				reg = <0x600000 0x1A00000>;
> +				label = "pnor-uefi";
> +			};
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd1_default
> +			 &pinctrl_rxd1_default
> +			 &pinctrl_ncts1_default
> +			 &pinctrl_nrts1_default>;
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd2_default
> +			 &pinctrl_rxd2_default>;
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd3_default
> +			 &pinctrl_rxd3_default>;
> +};
> +
> +&uart4 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_txd4_default
> +			 &pinctrl_rxd4_default>;
> +};
> +
> +/* The BMC's uart */
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +		 <&syscon ASPEED_CLK_MAC1RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
> +
> +	nvmem-cells = <&eth1_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	bus-frequency = <100000>;
> +
> +	ipmb0@10 {

0 suffix is not generic.

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).


> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	bus-frequency = <100000>;
> +
> +	pca9548@73 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).


> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x73>;
> +		i2c-mux-idle-disconnect;
> +
> +		m2_2: i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +		};
> +
> +		pcie4: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		pcie5: i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <2>;
> +		};
> +
> +		pcie6: i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <3>;
> +		};
> +
> +		pcie7: i2c@4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <4>;
> +		};
> +
> +		ocu_2: i2c@5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <5>;
> +		};
> +
> +		ocu_1: i2c@6 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <6>;
> +		};
> +
> +		m2_1: i2c@7 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <7>;
> +		};
> +	};
> +
> +	pca9548@75 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

... and same comments everywhere else.

Since this wasn't ever tested, I am not doing full review.


Best regards,
Krzysztof

