Return-Path: <linux-aspeed+bounces-5014-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE78EC88E5C
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 09:13:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlCqH4RdMz2xns;
	Wed, 16 Sep 2026 19:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789550011;
	cv=none; b=n2XrrQxyeb6v5feElJh82LQU5ps8LNqW+DezgYjzr4EBKHRKv/PwqZXmJsKbdwjxnybZNMIqStcx/WgbMhN9+H8RUZg/ZgIZf381s9uDNuOLv542Jbo91wWwmfuuPup7PmYlnXR0I1x9Hy5o+ptBeR97cu2o0DTbPNLF1+3kCXXcwN9Rucq97I0t1T59pHDxIt8TUBYXOIGpYkHPmqgGEMihYX4V+u4AgOtoCD9maDFsW1/dRM8z1P61T4d+0gCnpoUcSD7p6PlzwZ1jZmMGL+fSx/eI1WRFw+rE8AT1GwbgkwkOp0uTz4hv9mAlYCFywVec35S6/gCGntF9SZdynw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789550011; c=relaxed/relaxed;
	bh=UtUJCPsoaKTejj6x2QLMIpjL9EPoJFwA0KNqad74re0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JZXKswKXJtgYt2eY83+UYbZ8z5xfpiRSdqL+o+VgSsn4LVwUNTBdIJ75w6cF+70OLIqp4ta6LUaJCgrvmkIK0d+FxOvjQZjjbcKpW9he889H0Z2ZV6w7cOc2mQTDX6KFZZCEhBbBg4vnwqUw7EyRM7h3D4k1xM25qEEnti9bPtK7Zfzkj8uf0YHrh/9WhqGqEtoW7srhBfCOHawWOErjXLpQQLMB0uYZd7mxDwdA+DHq8N6Jxft1hBhwAIuLJG7DRjj/kgbXivL85+HAa/o+fKUVEn8fUi7Mn6GzdaJB2DsnH0pPeZR66QO69rZOwLLHbfIi9jX4tC2Scp4STrCDSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QtXuhZJu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::2a; helo=mail-ed2-x2a.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QtXuhZJu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:33::2a; helo=mail-ed2-x2a.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x2a.google.com (mail-ed2-x2a.google.com [IPv6:2a00:1450:4864:33::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlCqF2XQRz2xlY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 19:13:28 +1000 (AEST)
Received: by mail-ed2-x2a.google.com with SMTP id 4fb4d7f45d1cf-6aa06e51bc3so1088054a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1789550005; x=1790154805; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UtUJCPsoaKTejj6x2QLMIpjL9EPoJFwA0KNqad74re0=;
        b=QtXuhZJusfJ6ZTrqqazeygtrmaOi519rC0TbOXIdv37YwNtd9GOAt3CG8OksaoJAiI
         m6TAyZajjoPfX8BW1MFFUM2uUK99qXi84eePkTsmrIe0ivq6aJ8C6djYYHwPgt9RqsjW
         GhpOsUflqUPJHzIIx93EVTbAnAKOdZzbADpVtbd4uryovQKWKhPaVIZwK7UdvufT4Pjl
         iXcjaTrJCAOZHyzEw9tgdW+zmDaM6TUrS5aS4m84YguVb+KDP+BiotNeMKou1LOBA9xu
         mCct3da/Ha0k2kp/VPOS3F76VyGj0RIVmmAEmY+n5lhnlPHSHP6O98cgb52Us9RMrf3J
         vrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550005; x=1790154805;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtUJCPsoaKTejj6x2QLMIpjL9EPoJFwA0KNqad74re0=;
        b=zzd5b4/iQl3kisVkasK1CXPeZ0u1hJXXN8TE1b7xq6UiRU84LRuwwbVaRDuSedfLY/
         L81g3HdzWMBW498K4T9XPyasbxAvBHh1vFMrsMRx8tzkKud6JFTnRnRZEqqsSS+r/OBQ
         5xfFUMdrcvKMKuyl78f/zM8vrGsIpXHJ3193BoWd6jEKLzy+pjALN50vQNaITbfFk6U7
         he/crBnoJGASfdJXes+9O8ydVOVQzwrttl1aCh5UBz7C3H6xRteUMo79RPu8afb84d2f
         jytjS/ln0Jh9tze3RE8PIE4HBP9d1LfIe8xiodDkIPEkcWi/k3HT5aIyvcHX9umvLAE7
         lWBA==
X-Forwarded-Encrypted: i=1; AKwUvBwyzQ96EuePNkGk25zX6vQ5yt798qqMlq9FKqSJy7ElQ/rL81WTL32/dDsyohmEQmun7zWQX2UqnduNkRc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l77yP7UXlcYYc37IY3qimb6YSCIzSyQ793cQTQiVDzrtrlopkm
	8tIh2nr6fxNd5svB0BbqAyNfvSA9s7GTv2vPwdMIfLTFizb2B7X9mZSl7blNO0TGv4g=
X-Gm-Gg: AYBFou2VwjGcaxJOEq8cRsu/DGk/xo1FVI/xBAQ+aeMnjkCCoO4bsaR9kujc3DVG+xR
	ALD7Y8tNzVNIBjwR4ADm9bKwiCcavp9F6e8Ep6b+4jWOo3IR6kkMBFAp8p8bnKGvpJdwPI+SBpj
	lfjv9/slz2rzY7D3DrfhaKjnMx+17WJwsmdsjAXWeakJFi+Mv/YxzZLbH3M6IpT4YTymznz+H9l
	LiBNNknElFT0MFx7ghg2KcONLBUubk/Ud7emoyzC0BMC9VfyjP1zCOIWJ+rGGgMWZ/KFrGDeavi
	TIsymDtWk76eIpP7HO3ExdvuN43QMHiF+3gJVbF12C4YbdU8v5Csju/d2dav/QQLDkGfdyIjvPB
	NIxmafzORpH7qdSckzAptNZuHkCjdJ/87Wl7JYaWq5ZlMeBh5XuRW2a/+l46g84DXW/AJz6lL3L
	+HL9F7m1rOwDeX/AM7gt8h72kTfZ9WXeqFKwbPs/upgZ/Fq0YgqUquhKsPKEwoS73k40RUaxnzD
	OPE6c8offcrEyQ=
X-Received: by 2002:a05:6402:24c5:b0:6a9:e7eb:f52f with SMTP id 4fb4d7f45d1cf-6aa22418ef3mr1053990a12.28.1789550005374;
        Wed, 16 Sep 2026 02:13:25 -0700 (PDT)
Received: from white-mocha.local ([195.169.148.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2a874esm1148454a12.29.2026.09.16.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:13:25 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
From: Tan Siewert <tan.siewert@9elements.com>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260915013110.4780-3-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-3-prasanth.padarthi10@gmail.com>
Date: Wed, 16 Sep 2026 11:13:14 +0200
Message-Id: <178954999459.14468.3220034594197550391.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789549995; l=5936;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=bPkxAYoE1nt+KRIvjS+PEE9IbJV3hXHoXuLeG8ZhedM=;
 b=cRryfJU6A7jVHO0Nx61Kd8fo8PmCnV1ZH14DLV0RISA+/+nuTe7JNI6y7jUo1FxKFiwHnboWS
 oWWxG1ZTPrBBOHlDo3PTtKo3lC1H5uosZY0hKaAzuzQOVg6ToMR+V/Z
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add the device tree for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> Describe the BMC memory, SPI NOR flash layout, UART console,
> GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
> connected to an RTL8211F Ethernet PHY.
> 
> Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.
> 
> Configure MAC0 to use the RTL8211F in RGMII-ID mode.
> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>

dt-check-style --mode strict reports issues:

    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:8: [property-order] property 'compatible' out of canonical order (should sort before 'model')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:26: [property-order] property 'ranges' out of canonical order (should sort before '#size-cells')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:30: [property-order] property 'alignment' out of canonical order (should sort before 'size')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:31: [property-order] property 'compatible' out of canonical order (should sort before 'alignment')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:39: [property-order] property 'memory-region' out of canonical order (should sort before 'status')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:70: [property-order] property 'spi-max-frequency' out of canonical order (should sort before 'm25p,fast-read')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:72: [required-blank-lines] "status" must be preceded by a blank line
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:80: [property-order] property 'phy-mode' out of canonical order (should sort before 'status')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:81: [property-order] property 'phy-handle' out of canonical order (should sort before 'phy-mode')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:83: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts:85: [property-order] property 'nvmem-cells' out of canonical order (should sort before 'pinctrl-0')

>
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 6b68671f9379..b109491d5c8f 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-ampere-mtmitchell.dtb \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-altrad8.dtb \
> +	aspeed-bmc-asrock-b650d4u.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-e3c256d4i.dtb \
>  	aspeed-bmc-asrock-paul-ipmi-card.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> new file mode 100644
> index 000000000000..6585bda56a4c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +
> +/ {
> +	model = "ASRock Rack B650D4U BMC";
> +	compatible = "asrock,b650d4u-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
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
> +	};
> +};
> +
> +&gfx {
> +	status = "okay";
> +	memory-region = <&gfx_memory>;
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +		/* A0-A7 */	"","","","","","","","",
> +		/* B0-B7 */	"","","","","","","","",
> +		/* C0-C7 */	"","","","","","","","",
> +		/* D0-D7 */	"","","","","","","","",
> +		/* E0-E7 */	"","","","","","","","",
> +		/* F0-F7 */	"","","","","","button-reset-n","","",

How did you confirm this? According to the schematic it should be P0 (P0-P5
have GPIO passthrough functionality).

> +		/* G0-G7 */	"","","","","","","","",
> +		/* H0-H7 */	"","","","","","","","",
> +		/* I0-I7 */	"","","","","","","","",
> +		/* J0-J7 */	"","","","","","","","",
> +		/* K0-K7 */	"","","","","","","","",
> +		/* L0-L7 */	"","","","","","","","",
> +		/* M0-M7 */	"","","","","","","","",
> +		/* N0-N7 */	"","","","","","","","",
> +		/* O0-O7 */	"","","","","","","","",
> +		/* P0-P3 */	"","","","control-power-n";

Personally, I'm not a fan when `gpio-line-names` doesn't match with the amount
of defined `ngpios`, but that doesn't mean it's wrong. Maybe Andrew Jeffrey has
a different opinion on that.

> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		label = "bmc";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		spi-rx-bus-width = <4>;
> +		status = "okay";
> +
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&i2c7 {

Please sort your nodes, as per the device-tree style guideline [0].

[0] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

