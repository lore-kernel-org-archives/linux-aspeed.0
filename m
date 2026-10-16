Return-Path: <linux-aspeed+bounces-5218-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33930CCA46C
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 14:31:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5nSm5jCTz3bsm;
	Sat, 17 Oct 2026 01:31:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792161112;
	cv=none; b=GpI0r6yv0BqzHxZKOMWzgHXdECn5zFXFtIshDtr5rQVr2ehvxYMSpdAjw7Bfa5rBXH+3DYHbjoz4m10TtnELpn4tf4hON/iNdSSSTK4Vs5405I1ljInnzAWkXvdtduBKxAJIG7veNJijbboq6UPdByHJDr0syVYynFOSoMatvS0XTuHsZKu+qi3QRy64buSziBaXbFaEihXkDfDGs3j0Q/h2en0ZttNaE62z6PEC9WiKzuVfuRmjzQP6gEDmH8lxxGT++8H9005WrdzYY4BauqdSCt+ZdGlNemDKtnO8jiezjJHDESDL60D0sU65WfjdYXIU+tL917xYGsmkh70Eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792161112; c=relaxed/relaxed;
	bh=Hj1KH8boNQyeqb0RG6bTHrI9yRinPTXtodZqXvdAi2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUfPu4UXOfbPSVLXkAifVL7418oagXEDr07VFni0LfrGzR+9r+pNy1mo51XHHqgMxN17uDKq/1hcWdPMhbIzI4SWiHcGIXxoE9vCiXCs9HFy3Z7CcEL3rSnlnA2hPvYfOdVeTxxoNdEaTzOyf39jsyjL1n3endxv86cYuysgLU3zUztw/IkV36kmKYVFAhv/t7uUEifx174HlpAG9KN7W/l6b3mn+fXEqEoKTjSCRcj7QCDbAq4BRvsN/IsTzUKmC4kIXBCxKpYTs1Rbx7jvjajliwyNtW8jpGYT3QPXReFVRzKPkoHd1tuUahy3WsFoTnsB+6wnHTE9IY8l0LtInQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d/9lK3cl; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d/9lK3cl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5nSj3lpyz30HB
	for <linux-aspeed@lists.ozlabs.org>; Sat, 17 Oct 2026 01:31:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792161110; x=1823697110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dt+a4a6W70jAxDMgMbHMH1fPbQ/npH5no4bHOhmOJ1Q=;
  b=d/9lK3clbVUDAgL2gQLsLXmTwOfG7uzxBRCi5uLqOSWlXPu+DRN90xE2
   XOjU3i4IEQNk/RtINrXbJKNLyFZ0zpkk+GG/2HQQSMIqbF1pWpLVw8QAe
   jFddoWKlmDCrtiqNJ4+3kuxLTnVvb8dYstmggHlM9tKZubawurjSn/Sp2
   1JLS9AgnbBAKxLBgZEDp6AW8b1LUkCREkdBmVpcoXppDBDxePfogWQQ81
   fCoLeByAuUovjKP7KgPk7Laa66bHayX9YGQ0ho1ylZ19oV4ssA6lAD5aa
   uQgdc2k6RcF0l6uJDXhgIG1YfIEH7/qIeKKxnrNXHtcd2b78C6A6OkTTb
   Q==;
X-CSE-ConnectionGUID: 44o2Q4QjQ/6SfKmJtyIlYA==
X-CSE-MsgGUID: i7KBJ5qnT0SUluT2+ck13Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="950271"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="950271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 07:31:43 -0700
X-CSE-ConnectionGUID: mRWJKeS1S0+qnz5vjEKOLw==
X-CSE-MsgGUID: 52fbFazJTpmxta21tS5qsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1954568"
Received: from dawidgla-mobl.ger.corp.intel.com (HELO [10.94.249.157]) ([10.94.249.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 07:31:41 -0700
Message-ID: <f7c98fbe-2880-4769-bf09-53134cdfc63d@linux.intel.com>
Date: Fri, 16 Oct 2026 16:31:33 +0200
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
To: Tan Siewert <tan.siewert@9elements.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maciej.lawniczak@intel.com
References: <cover.1791825961.git.dawid.glazik@linux.intel.com>
 <12f8124fea31a6c6b1401d6aee640842c8d896a7.1791825961.git.dawid.glazik@linux.intel.com>
 <7d703c43-e462-41d6-a488-87342fd139a2@9elements.com>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <7d703c43-e462-41d6-a488-87342fd139a2@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/2026 7:19 PM, Tan Siewert wrote:
> On 10/12/26 7:39 PM, Dawid Glazik wrote:
>> Add the initial AST2600 device tree for the Intel AVCRP BMC platform.
>>
>> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
> 
> You got Review trailers from Andrew Lunn in v1. Unless you think Andrew 
> has to re-review it (which should be then reasoned), please keep them in 
> new revisions.
> 
>  From the kernel docs [0]:
> 
> "Both Tested-by and Reviewed-by tags, once received on mailing list from 
> tester or reviewer, should be added by author to the applicable patches 
> when sending next versions. However if the patch has changed 
> substantially in following version, these tags might not be applicable 
> anymore and thus should be removed. Usually removal of someone’s Acked- 
> by, Tested-by or Reviewed-by tags should be mentioned in the patch 
> changelog with an explanation (after the ‘---’ separator)."
> 
>> ---
>> v2:
>>   - Replace bootargs console=ttyS4,115200n8 with stdout-path = &uart5
>>   - Remove the unreferenced video_memory reserved-memory node
>> ---
>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>   .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 315 ++++++++++++++++++
>>   2 files changed, 316 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
>>
>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/ 
>> aspeed/Makefile
>> index 767f7c7652d5..ea4645ef9872 100644
>> --- a/arch/arm/boot/dts/aspeed/Makefile
>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>> @@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>       aspeed-bmc-ibm-rainier-4u.dtb \
>>       aspeed-bmc-ibm-sbp1.dtb \
>>       aspeed-bmc-ibm-system1.dtb \
>> +    aspeed-bmc-intel-avcrp.dtb \
>>       aspeed-bmc-intel-s2600wf.dtb \
>>       aspeed-bmc-inspur-fp5280g2.dtb \
>>       aspeed-bmc-inspur-nf5280m6.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts b/ 
>> arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
>> new file mode 100644
>> index 000000000000..7c088c89d417
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +// Copyright 2026 Intel Corporation
>> +
>> +/dts-v1/;
>> +
>> +#include "aspeed-g6.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +    model = "Intel AVCRP BMC";
>> +    compatible = "intel,avcrp-bmc", "aspeed,ast2600";
>> +
>> +    aliases {
>> +        serial4 = &uart5;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = &uart5;
>> +        bootargs = "earlycon";
>> +    };
>> +
>> +    memory@80000000 {
>> +        device_type = "memory";
>> +        reg = <0x80000000 0x40000000>;
>> +    };
>> +
>> +    reserved-memory {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +
>> +        video_engine_memory: jpegbuffer {
>> +            size = <0x02000000>; /* 32M */
>> +            alignment = <0x01000000>;
>> +            compatible = "shared-dma-pool";
>> +            reusable;
>> +        };
>> +    };
>> +
>> +};
>> +
>> +&rtc {
>> +    status = "okay";
>> +};
> 
> Please sort your nodes, as described in the device tree design guideline 
> [1]. There's also a tool called `scripts/dtc/dt-check-style` that can 
> help with this.
> Note on that: we usually run `--mode strict` but it is known to report 
> false-positives, so please check any reported errors twice ^^
> 
>> +
>> +&fmc {
>> +    status = "okay";
>> +    flash@0 {
>> +        status = "okay";
>> +        m25p,fast-read;
>> +        label = "bmc";
>> +        spi-rx-bus-width = <4>;
>> +        spi-max-frequency = <50000000>;
>> +#include "openbmc-flash-layout-64.dtsi"
>> +    };
>> +};
>> +
>> +&uart1 {
>> +    status = "okay";
>> +};
>> +
>> +&uart3 {
>> +    status = "okay";
>> +};
>> +
>> +&uart4 {
>> +    status = "okay";
>> +};
>> +
>> +&uart5 {
>> +    status = "okay";
>> +};
>> +
>> +&uart_routing {
>> +    status = "okay";
>> +};
>> +
>> +&mdio1 {
>> +    status = "okay";
>> +
>> +    ethphy1: ethernet-phy@0 {
>> +        compatible = "ethernet-phy-id001c.c916";
>> +        reg = <0>;
>> +        reset-gpios = <&gpio0 ASPEED_GPIO(C, 1) GPIO_ACTIVE_LOW>;
>> +        reset-assert-us = <10000>;
>> +        reset-deassert-us = <50000>;
>> +    };
>> +};
>> +
>> +&mac1 {
>> +    status = "okay";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&pinctrl_rgmii2_default>;
>> +    clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>,
>> +         <&syscon ASPEED_CLK_MAC2RCLK>;
>> +    clock-names = "MACCLK", "RCLK";
>> +    phy-mode = "rgmii-id";
>> +    phy-handle = <&ethphy1>;
>> +};
>> +
>> +&lpc {
>> +    lpc_snoop: lpc-snoop@80 {
>> +        snoop-ports = <0x80>;
>> +        status = "okay";
>> +    };
> 
> Why's this named if you don't use it as reference anywhere.
> 
>> +};
>> +
>> +&i3c_global {
>> +    status = "okay";
>> +};
> 
> That's enabled by default.
> 
>> +
>> +&vhub {
>> +    status = "okay";
>> +};
>> +
>> +&video {
>> +    status = "okay";
>> +    memory-region = <&video_engine_memory>;
>> +};
>> +
>> +&gpio0 {
>> +    gpio-line-names =
>> +        /*A0-A7*/ "", "", "", "", "SMB_CPU_PIROM_SCL", 
>> "SMB_CPU_PIROM_SDA",
>> +                "SMB_IPMB_STBY_LVC3_SCL", "SMB_IPMB_STBY_LVC3_SDA",
>> +        /*B0-B7*/ "", "", "", "FM_CPU1_ERR2_LVT3_N",
>> +                "RGMII_BMC_RMM4_LVC3_R_MDC", 
>> "RGMII_BMC_RMM4_LVC3_R_MDIO",
> 
> Why do you name reserved GPIO lines (in this case the RGMII lines)? 
> They're used by the kernel anyways.
> 
> Tan
> 
> [0] https://docs.kernel.org/process/submitting-patches.html#using- 
> reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> [1] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
Hi Tan,

Thanks for the instructions. I'll implement them in the new revision

Dawid

