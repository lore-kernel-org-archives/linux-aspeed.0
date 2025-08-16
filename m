Return-Path: <linux-aspeed+bounces-1995-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C91CA0EE6
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 08:17:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3sKt2bK7z3cmP;
	Sat, 16 Aug 2025 18:17:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755332274;
	cv=none; b=M45WM647fzO2XIxvP8tPUQf9o9mq7zSwSrYcGwsFKKYSlTliiaYUl+5IrZ9Wsgdx0eXYZnUpImd8TF1jLMWeSAISHCgTlhoN3u0RQKe+u1Gc74EkTy0n+konMsZnLF2Re2f5C3YnMTbB9jrkqz0MziS4ZYt5Of7lxuhkPwVbNLDxDk8+RyA0VlmZ5fezsQlXra6L5IacImlDf2hSvv+7p3hkeL6Y8X2iZzU3ynOAmG7PObp85++HV4jTm/kFaymS6bo13AxDdU7yYIVLtaIPCAoXTUYkAi4Ci4APzS47TXkloGphp0Xrj+t8jGH/7mJuVUobEQJetF/viMAB7tyJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755332274; c=relaxed/relaxed;
	bh=LCLW+N0+WhmOZ8Vs8rffq/hY58zFhL1RWdKRsiIoYJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlgSavEdnz+FM2fK6D2Abh9+bFZ1VBqmiXW/TAIv5atBgjrGWgTkZAtdMMb/8Sahg6dkvRpJtPIecJ2TwVb4h6kj+Is16iY3B6NXkwFsyQ2g82CXK9oWihkcah8YFeJA5/csh9+tabUYZ1O8d7Z79HE6yxumHB9RbN6tOA5i0xNNTPWvL8X6x5j2JAZxO/3I8TwSqZNPkxKRBMcWRgkzkzjAbtrVgvvmBOn6Dz7VFVfP7UftvSUJJtBJa67/fPjRIErtKCH8mLTBPkaZB0Zklbyo3mF006FoLfh2tsPA6/I8OeG0p+NlzlN4Ie2Wsgs1kiJkiadypOCXACvxxjDegQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQ+K5Dz8; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RQ+K5Dz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3sKs3fMjz3clq
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 18:17:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0DCC15C3E76;
	Sat, 16 Aug 2025 08:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD4C4CEEF;
	Sat, 16 Aug 2025 08:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755332270;
	bh=dkxFSzv5jF+G3mSFmT1qV2yVSNHcZO+E82VDG6eatdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQ+K5Dz8TMWd64i5J2al719z7VrWVfpV5Cy5JUC+hIjbSSXpxYjr6JBYPhuJROyau
	 IbZF/9nEP1oXDfoBJe6Qizm6jzpaxLMib5jya7SRY7pG7hi/I0/CS4ltlpebnZCsvZ
	 A37BAbfGPSOufeIea59aTNWqXBWSC7O0wP9btDxRMXI5qqVrgWZZWCJCRJm2i1j+4q
	 6paWGXciBx92QvEiJFvK/SFHaVkbWEwmQq0SmglXvJcexNeGuoqPBNMO+fR+OMUfGS
	 f0+yFqKfdLZq3OOOOEWM9kJY5Gz/rzlFBwWSzRS91CwpOWNUCwN+sw+oatSlVEdns1
	 2Uq7boKEKG7jw==
Message-ID: <533e305d-7659-4343-b2e8-ee40391bfa84@kernel.org>
Date: Sat, 16 Aug 2025 10:17:46 +0200
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
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for mgx4u BMC
To: Marc Olberding <molberding@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
 <20250815-mgx4u_devicetree-v1-3-66db6fa5a7e4@nvidia.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250815-mgx4u_devicetree-v1-3-66db6fa5a7e4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 21:45, Marc Olberding wrote:
> +		i2c69 = &i2c9_mux_6;
> +		i2c70 = &i2c9_mux_7;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS4,115200n8";

No, use stdout.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
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
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&emmc_controller {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	non-removable;
> +	bus-width = <4>;
> +	max-frequency = <100000000>;
> +	clk-phase-mmc-hs200 = <9>, <225>;
> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-128.dtsi"
> +	};
> +};
> +
> +&gfx {
> +	memory-region = <&gfx_memory>;
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +	/*A0-A7*/ "","","","","","","","",
> +	/*B0-B7*/ "","","","","","","","RST_BMC_8211F_N",
> +	/*C0-C7*/ "","","","","","","","",
> +	/*D0-D7*/ "","","","","","","","",
> +	/*E0-E7*/ "","","","","","","","",
> +	/*F0-F7*/ "","RST_BIOSROM_1_BMC_N","","RST_SPI_PFRM1_R_N","","","SPI_BIOS_MUX_SEL","",
> +	/*G0-G7*/ "","","","","","","","",
> +	/*H0-H7*/ "","","","","","","","",
> +	/*I0-I7*/ "","","","","","","","",
> +	/*J0-J7*/ "","","","","","","","",
> +	/*K0-K7*/ "","","","","","","","",
> +	/*L0-L7*/ "","","","","","","","",
> +	/*M0-M7*/ "","","","","","","","",
> +	/*N0-N7*/ "","","","","","","","",
> +	/*O0-O7*/ "","","","","","","","",
> +	/*P0-P7*/ "","","","","","","","",
> +	/*Q0-Q7*/ "","","","","","","","",
> +	/*R0-R7*/ "","","","","","","","",
> +	/*S0-S7*/ "","","","","","","","",
> +	/*T0-T7*/ "","","","","","","","",
> +	/*U0-U7*/ "","","","","","","","",
> +	/*V0-V7*/ "","","SCM_HPM_STBY_RST_N","","SCM_HPM_STBY_EN","","","",
> +	/*W0-W7*/ "","","","","","","","",
> +	/*X0-X7*/ "","","","","","","","",
> +	/*Y0-Y7*/ "","","","","","","","",
> +	/*Z0-Z7*/ "","","","","","","","";
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	gpio-line-names =
> +	/*18A0-18A7*/ "","","","","","","","",
> +	/*18B0-18B7*/ "","","","","SW_MAIN_EN","HOST_GLOBAL_WP_N","","",
> +	/*18C0-18C7*/ "","","","","","","","",
> +	/*18D0-18D7*/ "","","","","","","","",
> +	/*18E0-18E3*/ "","","","";
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	i2c-mux@73 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x73>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c0_mux_0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_mux_1: i2c@1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +		};
> +
> +		i2c0_mux_2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_mux_3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			eeprom@51 {
> +				compatible = "atmel,24c02";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		i2c0_mux_4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_mux_5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_mux_6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			tmp75@4c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "ti,tmp75";
> +				reg = <0x4c>;
> +			};
> +		};
> +
> +		i2c0_mux_7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	i2c-mux@77 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c0_1_mux_0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c0_1_mux_7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&i2c3 {
> +	status = "okay";
> +
> +	i2c-mux@72 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x72>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c3_mux_6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c3_mux_7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	status = "okay";
> +
> +	i2c-mux@77 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c5_mux_0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c5_mux_7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&i2c6 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		reg = <0x70>;
> +		compatible = "nxp,pca9548";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c6_mux_0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			tmp75@4a {
> +				compatible = "ti,tmp75";
> +				reg = <0x4a>;
> +			};
> +
> +			tmp75@4b {
> +				compatible = "ti,tmp75";
> +				reg = <0x4b>;
> +			};
> +
> +			eeprom@51 {
> +				compatible = "atmel,24c64";
> +				reg = <0x51>;
> +				pagesize = <32>;
> +			};
> +		};
> +
> +		i2c6_mux_1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/*fan controller 0*/
> +			max31790@20 {
> +				compatible = "maxim,max31790";
> +				reg = <0x20>;
> +			};
> +
> +			/*fan controller 1*/
> +			max31790@21 {
> +				compatible = "maxim,max31790";
> +				reg = <0x21>;
> +			};
> +
> +			eeprom@57 {
> +				compatible = "atmel,24c64";
> +				reg = <0x57>;
> +				pagesize = <32>;
> +			};
> +
> +			hpmfanio: pca9555@27 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +				compatible = "nxp,pca9555";
> +				reg = <0x27>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupt-parent = <&gpio0>;
> +				interrupts = <11 0>;
> +				gpio-line-names =
> +						"HPM_FAN1_INSTALL", "HPM_FAN2_INSTALL",
> +						"HPM_FAN3_INSTALL", "HPM_FAN4_INSTALL",
> +						"HPM_FAN5_INSTALL", "",
> +						"","";
> +			};
> +		 };
> +
> +		 i2c6_mux_2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		 };
> +
> +		 i2c6_mux_3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* 4056 fan board_EEPROM*/
> +			eeprom@57 {
> +				compatible = "atmel,24c64";
> +				reg = <0x57>;
> +				pagesize = <32>;
> +			};
> +
> +			/*fan controller 0*/
> +			max31790@20 {
> +				compatible = "maxim,max31790";
> +				reg = <0x20>;
> +			};
> +			/*fan controller 1*/
> +			max31790@21 {
> +				compatible = "maxim,max31790";
> +				reg = <0x21>;
> +			};
> +
> +			gpufanio: pca9555@27 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x27>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupt-parent = <&gpio0>;
> +				interrupts = <11 0>;
> +				gpio-line-names =
> +						"GPU_FAN1_INSTALL", "GPU_FAN2_INSTALL",
> +						"GPU_FAN3_INSTALL", "GPU_FAN4_INSTALL",
> +						"GPU_FAN5_INSTALL", "",
> +						"","";
> +			};
> +		 };
> +
> +		i2c6_mux_4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* IO board EEPROM*/
> +			eeprom@57 {
> +				compatible = "atmel,24c64";
> +				reg = <0x57>;
> +				pagesize = <32>;
> +			};
> +		};
> +
> +		i2c6_mux_5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c6_mux_6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c6_mux_7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +&i2c7 {
> +	multi-master;
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c7_mux_0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c7_mux_1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			i2c-mux@71 {
> +				compatible = "nxp,pca9545";
> +				reg = <0x71>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				i2c7_1_mux_0: i2c@0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +
> +				i2c7_1_mux_1: i2c@1 {
> +					reg = <1>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					eeprom@55 {
> +						compatible = "atmel,24c64";
> +						reg = <0x55>;
> +						pagesize = <32>;
> +					};
> +
> +					eeprom@50 {
> +						compatible = "atmel,24c02";
> +						reg = <0x50>;
> +						pagesize = <32>;
> +					};
> +
> +					eeprom@53 {
> +						compatible = "atmel,24c02";
> +						reg = <0x53>;
> +						pagesize = <32>;
> +					};
> +				};
> +
> +				i2c7_1_mux_2: i2c@2 {
> +					reg = <2>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +
> +				i2c7_1_mux_3: i2c@3 {
> +					reg = <3>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +				};
> +			};
> +		};
> +
> +		i2c7_mux_2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c7_mux_3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* XDPE19284B - CPU0 PVCCIN VR */
> +			xdpe152c4@60 {
> +				compatible = "infineon,xdpe152c4";
> +				reg = <0x60>;
> +			};
> +
> +			/* XDPE19284B - CPU0 PVCCFA EHV FIVRA / PVCCINF_VR*/
> +			xdpe152c4@62 {
> +				compatible = "infineon,xdpe152c4";
> +				reg = <0x62>;
> +			};
> +
> +			/* XDPE19284B - CPU0 PVCCA EHV PVCCIN VR */
> +			xdpe152c4@74 {
> +				compatible = "infineon,xdpe152c4";
> +				reg = <0x74>;
> +			};
> +
> +			/* XDPE19284B - CPU0 PVVCCD0 & D1 VR */
> +			xdpe152c4@76 {
> +				compatible = "infineon,xdpe152c4";
> +				reg = <0x76>;
> +			};
> +		};
> +
> +		i2c7_mux_4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* XDPE19284B - CPU1 PVCCIN VR */
> +			xdpe152c4@60 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation




Best regards,
Krzysztof

