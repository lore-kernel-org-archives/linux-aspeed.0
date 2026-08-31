Return-Path: <linux-aspeed+bounces-4883-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908D0C61DD3
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 12:37:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYT5b6WcZz2xpn;
	Mon, 31 Aug 2026 22:37:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788179827;
	cv=none; b=gf2d/lL+WUdokAFiV8LaSkG/eL82E4GfFPZaKdp3m5KnqXOgrp35yqnnrK8m9oaZ6FIcXF2kxOXe8u3N2n8aIx9XI3scIJ400n+uIp1uqO8sQ2gHpF4A/WQyJSdFsztelsCV/ugz4ajUuqvDcIHeHtlwQfY9c3ekVcP2NT/teBl2BHXwRY6WSy9yY3v85W5017vQIamukMnX9T5Q+DcD1EXQ5tYwBbtQxRCHJ5Hd2lmx0xe4kLLo6v1rU3t0MPC2ILbVjMe3hqB6Y3u8/TmffEqfnJ9dvru3TUMC4WxECiUxykjn91uvoVwH9MZzOHb9hFf9QhtpKzhd+9Wu8SQ40g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788179827; c=relaxed/relaxed;
	bh=v+j/HMcDeeoZ1SxGQJxVLKBNJDgbVV4ZRTow/yvavFk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kT1LhuQIhnb3V1NyyFPwcMMsssu658sLKkTyATtrxr5dX5f9R//+HiZ1u+aCcYtkkXSCT6/dwcYKA7ylHcB0xH3L6yMblZ8qgUZ+rXSBdnErRFk+nFxSS+Kd8RHDngxbTCBSrpr2P2/KqPZ3/qNzgjdHxePtbawc8QmsQ+AXeUxpM3dMmk4/y4YFaknYl4fWgnOT740I4adYiI9KNYDF5r8YeOUYvVYoLwPuyxcEOzNzpQ0c3bE+rQzaOrDh46Hx4Bua5touuNC98NlghJ7mBum+PcE9VxcZVatp6AN7J8iE387pXKlt07afCmFh0mlAT1t9kp3J6uzsVQq9t3P1Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QEEx4/63; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QEEx4/63;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYT5Z240Wz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 22:37:06 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-482e2fdf6ebso2871158f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1788179823; x=1788784623; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+j/HMcDeeoZ1SxGQJxVLKBNJDgbVV4ZRTow/yvavFk=;
        b=QEEx4/63XmvxhSQXu6dd67oiAikb83X0dknvW7ziSomEDQzSLY+iaR1uqxV39CFvMf
         aAbTFC42nSjEuqTCWAqUwFSEnf1A9oPeKONDEtf1r/Grja5EyAoM387B6dTQ/eEoZyIg
         i97Wssdj89wx96ZGJ0jjV+rYiLZH/Apa8J5OVbfku/9eDXtGSUYKCpp6NzG2Jeo+8sb+
         CAQNQdslR+hWm88dPRhjgTEkvjHduI20T3NYhvmca1QHi4pVyiuveawhHDbzAdF8UfUr
         mZGnFEQb8oWkUfqKs6HHj/B+nLmFhDKZK39qWrKvWiS053oOvqigHJV7HbLe38buvQNC
         GL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179823; x=1788784623;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+j/HMcDeeoZ1SxGQJxVLKBNJDgbVV4ZRTow/yvavFk=;
        b=dBZSn9oVm0QbTGRhL8/EVJM94ECdB8f5GB/cItb5mHipkBbeum9c/qpo5IyAczvUFE
         FAQ9QkMUp37ieE8qJ2JXDHW0LBNkPf52qiTRn/qJUfQR9Xd9+QvzwSS0eqdZfID5fqWU
         XqcP/y4SwdAGKlPdgMOOL5VdW0+lj3nnElO/R56SkM0XDz4uQexfACnWm0Q5aVJ47z2A
         1bm2iyxRF0WgXE0Trsipf8f1wOhWa2zXkvfkIoNKKv+83h3leRcZPGZtGtXQnneEDGuj
         UBt0TxMBdONLjj5Pyx2r2EtMoOSwcGbleGOMRMwidJug9pFPCWUZXRxSeF7rf2QPdNXI
         jvRw==
X-Forwarded-Encrypted: i=1; AKwUvBz5qxJRJZvbNsd9d2agUZBA0UuO41wV401KNuWQ1F2Dxq46uNP325WdUFGeIvUOSUFcbmBWF97a50Q05dQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mb/hVo7MEUj96IoNNRu4syaYz5+VuYUUGnlJZogKvz8RW5swq0
	GL0y1tinC1C7A5u2z+XxDosZB4MUBS3M0DaojYbeV4WUvFS9QTZYvzfl/3+JI2FjpM0=
X-Gm-Gg: AYBFou2BgqYD517vES91U3CfHqCAhv4bSlfpnfE4fTJl5Ax7Ne89U5t8GhOQ/k4cdhz
	uEii/YqE3GiA95kBMwvYzqefVZeC0n+D3DfZ6wJb+X3B0QnEnzrAnTXYJx7HXfwtSgwZnltS7B0
	K5OFtxS0UAX7PPHJ4oIDLP8f8RVsHwz8NRdHngwaL9sCMYpmu0IEnHfkrnTE2S+WCOV1rSh/41L
	kd9l3zcF8LKOitI5JfVq13/zRJpGjQhpKFmIwm9oj8sh8bj4WoFBWkRigPs2yxQCIWK+mOVXJRc
	gxI0OWjnKylpP60Bh9tMSGJnLyVd3RqSG5TrbIuL1anrnrqa2+b0agU/KOjYi2Ze73aSAr9OFmd
	6mImgswsDrfRKCKhYreSVhwxf1cuVILKYgYdjNLvYCpOgbb6adGbPDAAtfpRfOcWRPoc7UmTrNa
	/FoCNp9NoLBRkHau2QXe4XUQGRLwkw8Gqhcvguds6WdUyZCB/cAq1n0n9D6/Qc0ObscX8wsXGHl
	ZtQcNmSrLRUQPPb67Y7MuhE0HEr6eCFGkZtfPsEiPL9vIvyAPjKAa3mUZdcwyfn6+wO
X-Received: by 2002:adf:e014:0:20b0:47f:7129:6e2d with SMTP id ffacd0b85a97d-48441010765mr717293f8f.17.1788179822646;
        Mon, 31 Aug 2026 05:37:02 -0700 (PDT)
Received: from white-mocha.local (p200300e66714e500cb5f91bd76cb96be.dip0.t-ipconnect.de. [2003:e6:6714:e500:cb5f:91bd:76cb:96be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843dcc00a6sm4540003f8f.33.2026.08.31.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:37:02 -0700 (PDT)
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
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
From: Tan Siewert <tan.siewert@9elements.com>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260830182036.284736-3-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260830182036.284736-3-prasanth.padarthi10@gmail.com>
Date: Mon, 31 Aug 2026 14:36:34 +0200
Message-Id: <178817979463.20922.10263529532171804189.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788179813; l=4261;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=rxafdNkhfDfqTybQYvBD6c3YqwB52Q+nzoEnzCYqAtc=;
 b=t8LGYUPo6IQisrHMFR86MLJkpE4vyOvF+mup7Ma3JedRI7oe9cjXkFGqlpW4+NEa7i1H4cjuu
 KqDrGxOVrRaAPCrbQic/6SFFZLmVlk7lX/4SH0QIWnf7fDdf0cciMtA
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi Prasanth,

On 8/30/26 8:20 PM, Prasanth Kumar Padarthi wrote:
> Add the device tree for the ASRock Rack B650D4U BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> Describe the BMC memory, SPI NOR flash layout, UART console, and
> MAC0 connected to an RTL8211F Ethernet PHY.

Why no GPIOs? Why no I2C buses? You'd need at least i2c7 with an at24c128 to
populate the MAC address on MAC0.

> 
> The MAC0 RGMII RX delay configuration was validated on hardware.
> The RTL8211F requires its internal RX delay for reliable operation,
> while an additional TX delay is not required.

No, it does not. The traces have the same length and don't require special
delays. If you use u-boot/next, then it might be true because it still misses
the correct SoC-specific delays. This is, however, fixed in openbmc/u-boot.

I know that this is not optimal. I'm already working on getting this fixed in
upstream U-Boot too.

> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
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
> index 000000000000..aa623f0ca36c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> @@ -0,0 +1,95 @@
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

Where's the reservation for video?

> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;

That's already defined in aspeed-g6.dtsi

> +		label = "bmc";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		spi-rx-bus-width = <4>;
> +		status = "okay";
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			u-boot@0 {
> +				reg = <0x00000000 0x000e0000>;
> +				label = "u-boot";
> +				read-only;
> +			};
> +
> +			u-boot-env@e0000 {
> +				reg = <0x000e0000 0x00020000>;
> +				label = "u-boot-env";
> +			};
> +
> +			kernel@200000 {
> +				reg = <0x00200000 0x00800000>;
> +				label = "kernel";
> +			};
> +
> +			rofs@a00000 {
> +				reg = <0x00a00000 0x02000000>;
> +				label = "rofs";
> +				read-only;
> +			};
> +
> +			rwfs@2a00000 {
> +				reg = <0x02a00000 0x01600000>;
> +				label = "rwfs";
> +			};

No. Include the partitions via `#include openbmc-flash-layout-64.dtsi`.

> +		};
> +	};
> +};
> +
> +&mac0 {
> +	status = "okay";
> +
> +	/*
> +	 * The RTL8211F provides the required RGMII RX delay. No additional
> +	 * TX delay is required for this board.
> +	 */

No? I do have this board myself with a custom BMC ROM and I can tell you that
you don't have to set delays other than the described SoC-specific delays, but
this is, as mentioned, already done in the BSP. (And no, I haven't upstreamed
my DTS yet bc I haven't had the time to do it.)

> +	phy-mode = "rgmii-rxid";

`rgmii-id`

> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;

No nvmem cell to set the MAC address? i2c7@57 offset 0x3f80? Please see the
other device-trees for ASRock Rack mainboards.

For me, it is a:

NACKed-by: Tan Siewert <tan.siewert@9elements.com>

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

