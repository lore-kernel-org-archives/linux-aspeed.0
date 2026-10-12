Return-Path: <linux-aspeed+bounces-5174-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F67CA9ED0
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Oct 2026 17:19:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3PMw0F2Cz30St;
	Tue, 13 Oct 2026 04:19:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791825563;
	cv=none; b=N/u39qFgKlwX3sHF63Rz/9f5NpEcZ4oDTcDlgqPfDFKrZ4s/aAwd21bwkG5Rlh4180NsQK+j79L5vhao6DxRxYezs80uCCWczKa8jjsvlhpEtSNAWXwQafCoSBaVM0jqis/PdFc5MJ7rxjijuYbFaDUjsdq7gduEwXcMP+zknJ9peGElHu6JIKvaIjalrhJ3KRx6cj+Wg/hkvUEnYKO1hRGoc/ZL12QzQwvU6z/C1KXFFhWa9cUB2IU/2GuxX183g99uVBiQkLbgsVdKFJ6Nm9h7Pd73TPqeo0bvFmUpkto7c1XZ7FBtTt/v5QnJRKbB49KYlg4m1XAcbnKjOP0GQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791825563; c=relaxed/relaxed;
	bh=fmWhe9edetnI1XYoSUk/a0gFm8QWgHCjQdahFD9uVho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leyPQiD5dCaZxQyP5zI83TggAZUVQUEhOMjzEz76p/8+HMwikR2IUoBO5cJBL1wbOIPJB+XHjL7HrXg73/JqVldxKhyXqBwV+wP3Q6zmGHZWEDl41CGERO8c29Yq7KfN8PU3bZh7ULsur8Vy1f8HnW+/su/lshyAn7nh65mXawUvI332Pqqd7DPm/oKcxJW21hny9OPMxhNmjVEVbHEzbplkzuYvcSrSeWzG4g0JO1hfdzR1wuU2fETMRRRY7nCSttYEOLp/O8E20apYIt+7mb+mjgBmW6sokDRV9m0o+MUYYAjW0nlw3Y4Y1Xgs52wKQorEB5oBvbsfVyoZl8rnPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ObVYf22J; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ObVYf22J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3PMt2D0Fz2yS4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 04:19:20 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1967237f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Oct 2026 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1791825557; x=1792430357; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fmWhe9edetnI1XYoSUk/a0gFm8QWgHCjQdahFD9uVho=;
        b=ObVYf22JaSKNATsF41DFk6An+8Z4/lqVFXyCuI7tmChNfo2XTS4U97VIIdQQzQRkIW
         CIG00pSNhCpzTUoSETV7sCjSPILl0MOKGHdC1ij/XyxuBli4+mMpsE17ofNXd20LgeKT
         x2SuU8uKMEhRn7Nbay41IslEZlE8vOz1QUDMV4okHb085vK/L5dZpy1SkC5dzbrKV88B
         dWW76zbt//C9f9bg/0evzDnLk0S697nqF674+l+l7E4WXvZMRcowupjxq5BXPc9e+9ST
         Kk1thB+gZUhEylPHCklkj5GY9LkE+3iK4bPmOp/Mf/DG58vEH85iZfFADbSGR+Qyic1U
         3X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825557; x=1792430357;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmWhe9edetnI1XYoSUk/a0gFm8QWgHCjQdahFD9uVho=;
        b=TvPC5x5W//2CRhhJaunPoWGplrSltBYen9pszTq0f+YEM7MbTafLXSVEl72ODL3dWW
         iWauUjJPjamUY8VPhHnEcXf+KLh2hqNXoSe6ae9F2/EoX073eEEIAreMmezNsjGCxSdw
         pewbk4SJbiIVZ6DyNfWuYq/9F8aEjMBYAWs/tSLI6AbGMq+oEsgVzGyGJkGt8b0t5lxb
         hqrfKLpfXaXzpLg/P0JNdC6x9XJoHEo8PkrjJVnBw/0Mk7AmSFmMZYl4z4UVXa84P5Ug
         ka/nkpcMIqut6WvwWqfV3p9aZJt22GcMpy/nY4kzNwlJuTKLl4CD5UrcYFZ0yAILOFec
         M/0Q==
X-Forwarded-Encrypted: i=1; AKwUvBz9Ri11AYqYdxOrLW8emmteUAINbD10lUq8qoCWb/6AoPINR2cpQ6y90ZCwXuO9GXyATrGXiw0o/jJ7V9s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIpubov4c3cow7ngwOvQgMNrC9pfj7FVRX2gM4m8Odz0igeUX/s
	U833SzSXbH/9thUNdImP2zGbYx6imRsxMWglmduMxkkQzRFRcQC66z4wpp15CYSnixo=
X-Gm-Gg: AYBFou1rdLaRhMJJ+hxTLUQ9yehU+CBMbWLwLLKCgdueM0PobyDL3fc0Dxr7gdSyKDF
	EfeTfZrPXVAfwSzqbrax8UWGdfgs8xKmZD97JMOdSXYLT+jEG//kD48CoRFPxd6AoD5vMT0s7qV
	466cq12TRY+JOhy0rbzWGMLwiXtXuUjBuywz22Pj5Aq/T6HWTdnbhR17uzUG9etAt39kBqC29R1
	yFR+EqEhyWqKzd257v8o3PcmYsVZl+nYKxA3FQEoEzJtLh2rMTiG1hjdMOMA1gk8mCOGIMaS4j3
	HQrG8+RaXLzFO1SF+so1AOVP5RlsmrcgvKdD7/w6h4RCMMTP794sSCUkU/OitF4cTd1weIuapT7
	IRJyOKHf6/immDR/O8wYjoWh7NmGAwp6bqjsIjD9yBDMrtmpv8JVcOHq2O/YZSdGO46XhLa0cY0
	ltFwS6sPTD9a9TuE2/ma7E/0hGnWnAs7ckOSbg0lc3hm2yUBT4vhL4bFvRM8paGs+wyPjP7Ienf
	k07hkhOCMjW2BCEVS24XP50xqt1TjtLdRhZSt3dvpbRBYI4r3RlMvbeHa6mya8=
X-Received: by 2002:a5d:5291:0:b0:486:f3db:e0f2 with SMTP id ffacd0b85a97d-48dbaade0b3mr13920551f8f.14.1791825555359;
        Mon, 12 Oct 2026 10:19:15 -0700 (PDT)
Received: from ?IPV6:2a01:599:840:e202:6f88:7a35:3ae9:6d10? ([2a01:599:840:e202:6f88:7a35:3ae9:6d10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc4ec6sm437267f8f.48.2026.10.12.10.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 10:19:15 -0700 (PDT)
Message-ID: <7d703c43-e462-41d6-a488-87342fd139a2@9elements.com>
Date: Mon, 12 Oct 2026 19:19:13 +0200
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
Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: add Intel AVCRP BMC
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maciej.lawniczak@intel.com
References: <cover.1791825961.git.dawid.glazik@linux.intel.com>
 <12f8124fea31a6c6b1401d6aee640842c8d896a7.1791825961.git.dawid.glazik@linux.intel.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <12f8124fea31a6c6b1401d6aee640842c8d896a7.1791825961.git.dawid.glazik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 7:39 PM, Dawid Glazik wrote:
> Add the initial AST2600 device tree for the Intel AVCRP BMC platform.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>

You got Review trailers from Andrew Lunn in v1. Unless you think Andrew 
has to re-review it (which should be then reasoned), please keep them in 
new revisions.

 From the kernel docs [0]:

"Both Tested-by and Reviewed-by tags, once received on mailing list from 
tester or reviewer, should be added by author to the applicable patches 
when sending next versions. However if the patch has changed 
substantially in following version, these tags might not be applicable 
anymore and thus should be removed. Usually removal of someone’s 
Acked-by, Tested-by or Reviewed-by tags should be mentioned in the patch 
changelog with an explanation (after the ‘---’ separator)."

> ---
> v2:
>   - Replace bootargs console=ttyS4,115200n8 with stdout-path = &uart5
>   - Remove the unreferenced video_memory reserved-memory node
> ---
>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>   .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 315 ++++++++++++++++++
>   2 files changed, 316 insertions(+)
>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index 767f7c7652d5..ea4645ef9872 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>   	aspeed-bmc-ibm-rainier-4u.dtb \
>   	aspeed-bmc-ibm-sbp1.dtb \
>   	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-intel-avcrp.dtb \
>   	aspeed-bmc-intel-s2600wf.dtb \
>   	aspeed-bmc-inspur-fp5280g2.dtb \
>   	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> new file mode 100644
> index 000000000000..7c088c89d417
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2026 Intel Corporation
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	model = "Intel AVCRP BMC";
> +	compatible = "intel,avcrp-bmc", "aspeed,ast2600";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +		bootargs = "earlycon";
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
> +		video_engine_memory: jpegbuffer {
> +			size = <0x02000000>; /* 32M */
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +};
> +
> +&rtc {
> +	status = "okay";
> +};

Please sort your nodes, as described in the device tree design guideline 
[1]. There's also a tool called `scripts/dtc/dt-check-style` that can 
help with this.
Note on that: we usually run `--mode strict` but it is known to report 
false-positives, so please check any reported errors twice ^^

> +
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		status = "okay";
> +		m25p,fast-read;
> +		label = "bmc";
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&uart_routing {
> +	status = "okay";
> +};
> +
> +&mdio1 {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy@0 {
> +		compatible = "ethernet-phy-id001c.c916";
> +		reg = <0>;
> +		reset-gpios = <&gpio0 ASPEED_GPIO(C, 1) GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <10000>;
> +		reset-deassert-us = <50000>;
> +	};
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii2_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>,
> +		 <&syscon ASPEED_CLK_MAC2RCLK>;
> +	clock-names = "MACCLK", "RCLK";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +};
> +
> +&lpc {
> +	lpc_snoop: lpc-snoop@80 {
> +		snoop-ports = <0x80>;
> +		status = "okay";
> +	};

Why's this named if you don't use it as reference anywhere.

> +};
> +
> +&i3c_global {
> +	status = "okay";
> +};

That's enabled by default.

> +
> +&vhub {
> +	status = "okay";
> +};
> +
> +&video {
> +	status = "okay";
> +	memory-region = <&video_engine_memory>;
> +};
> +
> +&gpio0 {
> +	gpio-line-names =
> +		/*A0-A7*/ "", "", "", "", "SMB_CPU_PIROM_SCL", "SMB_CPU_PIROM_SDA",
> +				"SMB_IPMB_STBY_LVC3_SCL", "SMB_IPMB_STBY_LVC3_SDA",
> +		/*B0-B7*/ "", "", "", "FM_CPU1_ERR2_LVT3_N",
> +				"RGMII_BMC_RMM4_LVC3_R_MDC", "RGMII_BMC_RMM4_LVC3_R_MDIO",

Why do you name reserved GPIO lines (in this case the RGMII lines)? 
They're used by the kernel anyways.

Tan

[0] 
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
[1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

