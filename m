Return-Path: <linux-aspeed+bounces-2422-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E47DCCD184
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Oct 2025 03:03:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cklfV56kmz2yrt;
	Sun, 12 Oct 2025 14:03:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760238194;
	cv=none; b=I4VRRmJslpAQQ71puT1LAwRW5FNGA39GmF8Vz03SV7wVme7OustuZPX2xN1Np1osBBJ0s3R6ij+JSlr9xZKFBmZqYLuQXLMLp2/zzIXbtMOkNEojgozWnPHLk3a2v/ZxLPAizAyd75KTfQEt/DJ46OaSKJr30JCnnzvWGoahEklRf0YL6R8C/4Jg1rfFexciMc+sbDknUp6fBYuVWeILlJD0+SsZy3X9RJVaoCnkw9FIocYJJpGhHBhUuTbNaUCaVWzwbvVHPk5DQ3wAgrY2ZO//4XomFWGf4yxbsZr5qmW0gwRKvsO3wCk2r1ZklaP5ueTE/vdYrSv+ypRhORVOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760238194; c=relaxed/relaxed;
	bh=giHqp9du718WZTvmAfvZwzSYFMHZ3RlJ/FBXHJxcbX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfJyuP5xm/QCJSCLmFx8RHU0745w9ZQM2yl8G1RAiWGOQZTi+JZ9HEs8+KdqC129hX/jHNscSElyAHwLD1fuknyBwe2jYRmqiXA0TefTle87KLFnrSKoLS6JndPpyuD4J4LwF6DMc0DXXWNoKEc+fOjHRFitIpCbrEpG5ygAwhiXt3vct/729xRT+1MSrlQJ3iHH9FhvobSvnMb62yf76V6LLK21Hz/6sgkTk1xIrjJ4SII/rulWhaqfX3Zr9SLQtEfdvDxdtOVgZwXMXFuqB9w/oaqcdfKZm7t4cItfwmxIPyyTsfmEzL8nQQDpswQK1QdI3CuQpAp2D1E2aFZASg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nRFy+Ts8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nRFy+Ts8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cklfT56Zmz2yMh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Oct 2025 14:03:13 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CC36435BA;
	Sun, 12 Oct 2025 03:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88891C4CEF9;
	Sun, 12 Oct 2025 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760238188;
	bh=VPTtgaMr5euPlgimNxDzHmFqZLDuqJfISHa3mZ914p0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nRFy+Ts8RZPvY9kCY2/cWW9YyyFrMAmLUdWCm23AahcdyQz26pVANgV2VbOzNTzoS
	 +efHYTYwLH4ApNJ8D4CgpT3fkpMEsEqkOwE68kAWAA43cBfGUbxrFkVFGOqaoH5EmS
	 Y6hQp3PqosU4xm58DcS1IvVJ7iJ4coVi9PY4ucGSpoearDmnkCNcAnGYB/Bro8ol6s
	 KtnAMm7bmvZbMl8vakjWDR9S9lIB4ZrcdIE3wqdN5HPCc7bWjW7gyx1adBT5iOrZ+q
	 XAAoIEcrDO3ucJo585mIfN/2OT+zIcckrxuiwgfDbslUW8ssy/rmJe1U6zeYgb2x/y
	 7Z2EYPGthBofQ==
Message-ID: <5faef61e-a746-4a8f-b147-ce2106c33620@kernel.org>
Date: Sun, 12 Oct 2025 05:03:02 +0200
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
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
To: Tan Siewert <tan@siewert.io>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250919185621.6647-1-tan@siewert.io>
 <20250919185621.6647-3-tan@siewert.io>
 <20250922200738.GA1124791-robh@kernel.org>
 <0c7a28b7-8d6d-4f91-ac6c-8cf37e128139@siewert.io>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <0c7a28b7-8d6d-4f91-ac6c-8cf37e128139@siewert.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2025 16:48, Tan Siewert wrote:
> On 22.09.25 22:07, Rob Herring wrote:
>> On Fri, Sep 19, 2025 at 08:56:18PM +0200, Tan Siewert wrote:
>>> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>>> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>>> 64MB SPI flash.
>>>
>>> This mainboard exists in three known "flavors" which only differ in the
>>> used host NIC, the BMC SPI size and some parts that may be un-populated.
>>>
>>> To keep the complexity low with the BMC SPI, use the 32MB layout
>>> regardless of the used SPI or mainboard flavor.
>>>
>>> Signed-off-by: Tan Siewert <tan@siewert.io>
>>> ---
>>>   arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>>   .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 345 ++++++++++++++++++
>>>   2 files changed, 346 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>>> index aba7451ab749..fae97b5183e5 100644
>>> --- a/arch/arm/boot/dts/aspeed/Makefile
>>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>>> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>   	aspeed-bmc-asrock-e3c256d4i.dtb \
>>>   	aspeed-bmc-asrock-romed8hm3.dtb \
>>>   	aspeed-bmc-asrock-spc621d8hm3.dtb \
>>> +	aspeed-bmc-asrock-x470d4u.dtb \
>>>   	aspeed-bmc-asrock-x570d4u.dtb \
>>>   	aspeed-bmc-asus-x4tf.dtb \
>>>   	aspeed-bmc-bytedance-g220a.dtb \
>>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>>> new file mode 100644
>>> index 000000000000..bae2b521f708
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>>> @@ -0,0 +1,345 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/dts-v1/;
>>> +
>>> +#include "aspeed-g5.dtsi"
>>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>>> +#include <dt-bindings/leds/common.h>
>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +/ {
>>> +	model = "Asrock Rack X470D4U-series BMC";
>>> +	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
>>> +
>>> +	aliases {
>>> +		serial4 = &uart5;
>>> +	};
>>> +
>>> +	chosen {
>>> +		stdout-path = &uart5;
>>> +	};
>>> +
>>> +	iio-hwmon {
>>> +		compatible = "iio-hwmon";
>>> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
>>> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
>>> +			<&adc 10>, <&adc 11>, <&adc 12>;
>>> +	};
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +
>>> +		heartbeat {
>>
>> led-0
> 
> I guess `led-heartbeat` would be fine too, right?
> 
>>
>> This should have given you a warning. You did run "make dtbs_check"
>> check the warnings, right?
> 
> I did and there were no warnings, even after a full clean. The full 
> command I ran before submitting was `make dtbs_check W=1 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml`

This is not the command to run. You run `make dtbs_check W=1`. See my
slides from OSSEU for introduction to Devicetree.
Best regards,
Krzysztof

