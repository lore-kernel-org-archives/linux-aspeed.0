Return-Path: <linux-aspeed+bounces-4578-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF435C54F4C
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Jul 2026 14:39:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8dR23YWJz2xyh;
	Wed, 29 Jul 2026 00:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785249598;
	cv=none; b=Jp13fbIkH1xeH/ooR1wa+/RmYp50MWO3MiMpoXiiFv7u2kacohVQaS7iFoOHMGX5KrefBdX7RFReas4cunuZ883EleLHCy5NUFJ7A6vxC2z8XPH4GoJFs13Hb1XDbTmsFw83Ot7Mzi+zLYXzT9CuIuSH+QhJV5JkBsZWPeTpKqnvcqE1AmHNnlXvG1mfSOE2VIH0In/mHodT3S1NHIDaTR7AmclJ5TRlZiiXNO7YXA4A565X/G2zjm65Y2DkWqRFUuzwmtiqQfd642L5aqLFBvut0+Tre0vQOadbWOLl+0Bn8Ekhw69o7X5orXRa0zqKpHiZbtM6lAXvZBOlwBqaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785249598; c=relaxed/relaxed;
	bh=6NAYFFRdO0dAvQU4kkEvVp93IHO9/hVJijDurWj3G7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPR2kem22el3ud3ZffC3jZs1rH49cSmi4se7oAhf0kSy+DO8iyzopSYW00qCvUNSBfEuaIfkq/Mufnr09e/XOJvRL4+ib+3YkBZGtBrjaSiAK/s0XivfxqZKlLwB7Z4SvMwXNYk8wGoWOKogaiRYPg1LBouA5XM7pMCEABrNUn0m83UBEPnGvG2WDzFTUW6XmxdCYxMiAbtSecYjRqAAbNQ9qeUJqFVFnRwFtLTTExMM7JXygYDlDmPCv0EvGTedZa2a/6GbMZE+ZwjPZFX0S9VK4ezmlzTGlSRRrJbdWoAuj67D6/M7E5bOweHYYPkrZtq50SKrx61/4+8A+OgVwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDtOR8Xg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDtOR8Xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8dR11kSgz2xYg;
	Wed, 29 Jul 2026 00:39:57 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2980D600FC;
	Tue, 28 Jul 2026 14:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A461F000E9;
	Tue, 28 Jul 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785249593;
	bh=6NAYFFRdO0dAvQU4kkEvVp93IHO9/hVJijDurWj3G7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FDtOR8XgwtsvtDPgyZjoHGVrcCiPkPncghk5Cjc9D5pj9ucIjOZ4kK6fpU3iv5Mke
	 3HVAa1da0Zi/Fqki63FpSMzCwRqwVL5sjW+yBjYlHWvWvxRRsPaGiqq1GRs86wxubb
	 bfe3WYU+1vVS/YO82IQcS3WpK1uL+uO4VgJYq16partyMmXC8dnaSkqEqAlNNF0kX/
	 x6lyx2p5+LuneRsJRiGRxybQgFoR/P3/L9y96D8dVLPeXrCKn+TzRJGVIF+/cpeDjl
	 qeid7XEkdJbVR441KDQBmbPn5o/o+GpXzLLwuXhZycf5WQZPxwoHde4w4MfAUlGFjb
	 deHwzg3KaX2FA==
Date: Tue, 28 Jul 2026 09:39:52 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au,
	krzysztof.kozlowski@oss.qualcomm.com, conor+dt@kernel.org,
	andrew@lunn.ch, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Message-ID: <20260728143952.GA2121505-robh@kernel.org>
References: <20260728085640.1001890-1-jackyhuang@nvidia.com>
 <20260728085640.1001890-3-jackyhuang@nvidia.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728085640.1001890-3-jackyhuang@nvidia.com>

On Tue, Jul 28, 2026 at 05:55:10PM +0900, Jacky Huang wrote:
> Add the device tree for the Aspeed AST2600 BMC for NVIDIA's Vera
> Rubin NVL compute platform.
> 
> MAC0 uses phy-mode = "rgmii-id" because the on-board PHY supplies
> both RGMII internal delays. The matching U-Boot device tree does not
> enable SoC-side MAC clock delays, leaving the MAC internal delay at
> zero so the PHY-provided delay is not doubled by the MAC controller.
> 
> The corresponding U-Boot change has been submitted to openbmc/u-boot:
> Link: https://lore.kernel.org/all/20260629105202.1417679-1-jackyhuang@nvidia.com/
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
> ---
> v4: address dt-check-style findings for property and child node ordering,
>     required blank lines, and line length. Retain 8 conventional multi-line
>     block comments with mixed-indent and 22 meaningful unused labels for
>     source readability and future references. They can be removed if
>     preferred.
> 
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts   | 923 ++++++++++++++++++
>  2 files changed, 924 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 6b68671f9379..07e10083a8bd 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -65,6 +65,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-microsoft-olympus.dtb \
>  	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
>  	aspeed-bmc-nvidia-msx4-bmc.dtb \
> +	aspeed-bmc-nvidia-vr-nvl-bmc.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-mowgli.dtb \
>  	aspeed-bmc-opp-nicole.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
> new file mode 100644
> index 000000000000..1c04fd3e627c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
> @@ -0,0 +1,923 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2026 NVIDIA Corporation


> +&ehci1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	status = "okay";
> +
> +	hub@1 {
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		hub@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hub@4 {
> +				reg = <4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* port 1: BlueField-4 SMA mgmt */
> +				device@1 {
> +					reg = <1>;
> +					#address-cells = <2>;
> +					#size-cells = <0>;
> +
> +					interface@1 {
> +						reg = <1 1>;
> +					};
> +				};
> +
> +				cp2112g: device@2 {

This and other devices should have a compatible string and associated 
schema. The hub probably should too.

> +					reg = <2>;
> +					#gpio-cells = <2>;
> +					gpio-controller;
> +					gpio-line-names =
> +						"BF4_USB_MCU_RECOVERY_L",
> +						"BF4_USB_MCU_RST_L",
> +						"BF4_USB_FORCE_FNP_L",
> +						"BF4_GLOBAL_WP",
> +						"BF4_FORCE_POR_L",
> +						"BF4_BMC_EROT_RST_L",
> +						"BF4_BMC_EROT_RECOVERY_L",
> +						"BF4_THERM_SHUTDOWN";
> +					#interrupt-cells = <2>;
> +					interrupt-controller;
> +				};
> +			};
> +		};
> +

> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {

Needs a compatible.

> +		label = "bmc";
> +
> +		status = "okay";

okay is the default, so not needed.

> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				reg = <0x0 0xe0000>;		/* 896 KiB */
> +				label = "u-boot";
> +			};
> +
> +			partition@100000 {
> +				reg = <0x100000 0x900000>;	/* 9 MiB */
> +				label = "kernel";
> +			};
> +
> +			partition@a00000 {
> +				/*
> +				 * extends to end of 64 MiB - 4 KiB; last
> +				 * 4 KiB reserved for EROT image
> +				 */
> +				reg = <0xa00000 0x35ff000>;
> +				label = "rofs";
> +			};
> +		};
> +	};
> +};


> +&spi2 {
> +	pinctrl-0 = <&pinctrl_spi2_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	flash@0 {
> +		label = "config";

Needs a compatible.

> +
> +		status = "okay";

Drop

> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				reg = <0x0 0x40000>;	/* 256 KiB */
> +				label = "u-boot-env";
> +			};
> +
> +			partition@40000 {
> +				reg = <0x40000 0x1000000>;	/* 16 MiB */
> +				label = "rwfs";
> +			};
> +
> +			partition@1040000 {
> +				reg = <0x1040000 0x2800000>;	/* 40 MiB */
> +				label = "log";
> +			};
> +		};
> +	};
> +};

