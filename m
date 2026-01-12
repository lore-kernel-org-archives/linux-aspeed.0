Return-Path: <linux-aspeed+bounces-3287-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248C5C9EC7B
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 11:48:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqVy33xTmz3050;
	Mon, 12 Jan 2026 22:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768218507;
	cv=none; b=dj2hU5v/mGHO6XU0XeP/9QqcytU/kGxiPdAG3gx4A5oOsXlQWZ8KoxF4W6mfBmF8RTVTngYrznAX9u1rYrtszA5NjFMjaXPfdPfp5PQFcGEwnrw+cfmMlUshjDlgggCgX2T8TKKOl5HDphqS/6lLqvMcQ11G+Vvafbi6c5SrxIZ7weVqmWzveVLcjEAZN/QRrsbH8lCrTCiezFkFWpuqkcEGxeTNKc6FyeJjqRnr4xTNl0v2IM4MXH8z4bxgd5zgefyJexOr9brYQLWb3rMBX6o1fpr6mCxLQyIUJo2oUG8KbQe3lFtiEFhA6HP3BNL2law1tRM8wWrwcXQLOY385g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768218507; c=relaxed/relaxed;
	bh=wDvjeCxmeHvlZ9VVx01hx9d17Spsbg7HFQEHfiqAH8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2bT4f9Z/OWb4MgrZTW85lDI39iu58E+KPmwt7bVhxrjJ44QAQeuftsbFX3AukrnJA+24c4CAkOI0CqGg7/cP095wPBJcHsgqcje7n/0/63SX09P5ol9GeLX2wEDdb8XGUewYr3tLON80/xev2CI8gIY9P5NQeu3dR/hGPZ4nIumEQKhZle/1P0bnP13ynoFLbaCFzrDpVABnf/k2zpEMXsbXzaOHbyLF7+tDrPm7RgI/uLyF8dAJ/97FJSgqcMo7odaJP5xtZLA036JncqkRGlRrsNMqvVI+tBexAnYttHoAa31vf/Yjji3yvojp4tWCnP5QJmhex6Ohj8etsfqnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cRdLqqmk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cRdLqqmk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqVy25VL3z2ynn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 22:48:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D0FD06001D;
	Mon, 12 Jan 2026 11:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04067C16AAE;
	Mon, 12 Jan 2026 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768218504;
	bh=URDluMm2oQAGrABVnCxy8FFxRYxGizv+hrewS1N56j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRdLqqmkPFRspZ/V5pmAzefvbhoMTp69aXHe94XB9hlP26X/Q560gdoGe5WtaHqN9
	 2lyRZ4RqBvpFsbOq57qa1xLl70Kxefkzjj1vv85Kdf/nPTo/uQJXNyVSTDY1YSFm36
	 nsvdHPdwaK7P6xEcyZdmiBzTvsdJZcL4goRAKqApa5T0CVHFDaNdamchF2IPw2mDqf
	 M+TFPOMB6gN9jZ3DSMIDO5bKMM9YzQqk7zHjE7hrw5TywWdpXcK42KU077Zrwb7HoZ
	 zC+5R3G53xBx5knYNveWEElodIzbh3urfSz7Y5tRWbZb1XVLamUnN7M6BeulZRFUhz
	 C0GChan0K58Vw==
Date: Mon, 12 Jan 2026 12:48:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
Message-ID: <20260112-upbeat-gay-chachalaca-ecb74c@quoll>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-3-anirudhsriniv@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260111201040.162880-3-anirudhsriniv@gmail.com>

On Sun, Jan 11, 2026 at 02:10:32PM -0600, Anirudh Srinivasan wrote:
> Add device tree for Asus IPMI card, an AST2600 BMC PCIe card
> 
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asus-ipmi-card.dts  | 136 ++++++++++++++++++
>  2 files changed, 137 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 9adf9278dc94..ff40d9ab88b7 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-asrock-spc621d8hm3.dtb \
>  	aspeed-bmc-asrock-x570d4u.dtb \
>  	aspeed-bmc-asus-x4tf.dtb \
> +	aspeed-bmc-asus-ipmi-card.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-delta-ahe50dc.dtb \
>  	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
> new file mode 100644
> index 000000000000..fea94360245c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2025 Anirudh Srinivasan
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "ASUS IPMI Card BMC";
> +	compatible = "asus,ipmi-card-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial4:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-fault {
> +			gpios = <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_HIGH>;
> +			panic-indicator;
> +			default-state = "off";

Missing color and function. Or at least label.

> +		};
> +
> +		led-heartbeat {
> +			gpios = <&gpio0 ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +

Drop redundant blank lines.

> +	};
> +};
> +
> +&mdio2 {
> +	status = "okay";
> +
> +	ethphy2: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac2 {
> +	status = "okay";
> +
> +	/* Bootloader sets up the MAC to insert delay */
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy2>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii3_default>;
> +};
> +
> +

Like this as well. It's a sign of sloppy coding.

> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};

Best regards,
Krzysztof


