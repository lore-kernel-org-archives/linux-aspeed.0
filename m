Return-Path: <linux-aspeed+bounces-277-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C94E77183
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 08:07:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCmWB6LDGz2xjQ;
	Wed, 18 Dec 2024 19:07:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734509254;
	cv=none; b=QNpQwzmiTcjwNLtOzAgwDGpx8co3B23plcCD0xia/fiq9Kn/3NjGXjUJEuKFVFCtTD2s5tFOfJ6Pu/gLA8axd5015jT9EHzYw3yrpQmLC/NvpZh0D5c7cWxUbalkzGTyesqmamMH/KJ+6tnmPjuYt0gXbNhoXuxSSQpAIVMmCVp98WBbFhaB4a0/3qmUAbVlAUq2ps3ATSyz/P3RQa6m8JkAYR6/+Hg6j2eeGlU9YJprC7JTH6W6fzgeN2bwDCAIIz1KagHF6wbE9OKbiyD3S26d3Ls72/CU0smBsYycp7lWzHKeIwVOrcDccf6+2mwr1F3K9wf3pDIc7u6CCyHokg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734509254; c=relaxed/relaxed;
	bh=+zvVxg8TjpzTKJeVgAA52MwuzQxHGHAPTbkC5v+VP5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DrOH6jCGxdRisXmjUEyRCa32jGBgnVHtuxl3En75XGy1YHjiB5Khe+xf8x/w0h0MZfSWNLQjOOl0MdWfSzvEisQhAyJxiyrX00qedjEXbpeIA/4N4mouU7g4NkNT6jx1CK+xShHx2Uzy0GXe3YCEk21KMvy2Dzj2F7gfmbT9CEhKfRlR3vzVM8QDtgCWy2k9bI/RmmX05Movxe3Pk5A5uyKUm130lDWIQlCyKjA02tA++dq+47wRfaOuct7IMmBd5nugpaB7yrT+Cc47nZGtTVe0g4msM9MOSas2SnecDOrzqqaoYAloHHZ3tAwR33xmVF1bgNJzliJmScSr9FNCfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iC91Vydm; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iC91Vydm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCmW95sjjz2xfB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 19:07:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A0C3B5C5E45;
	Wed, 18 Dec 2024 08:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CAC4CED0;
	Wed, 18 Dec 2024 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734509249;
	bh=3YQQgFLzWqXSr+8cpiXWMiZeoDJOT88+J0fk3jLp0XI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iC91VydmXNXgoWb0ae+s8i4Yv/Uuaj+T9PnsEknpF3lE/F2GyaVzRXQvUMg0LH3jQ
	 66yHkkV5ex3UMZ5IyFODmkSr4gAhV8BIaP98+MGZNIiDNCH5CRsxxHZj3RhKrXsRXe
	 5rO9Wh4EHSxmPVDaxXbjut6LawLdAHceNlK6jcUz0SQF/+gax2ir+ZgTHa+cYMz7EN
	 OuMeZ87ln3RDhwWQLDNULpsJsM92cGGur5lI/h5SQLqXijqaJHrrQB48Mqbg/Ijbjd
	 D8XuMGzXNAAJQlOKYLuOF6kmxGtnNpUtwjgZ5vm/tqsMIS9uFYtmxfvY4QL3EKdn9U
	 8QEFzrESLeC5Q==
Message-ID: <4ce799f1-e8c6-4a0d-aca5-dfb3dcb0c1d8@kernel.org>
Date: Wed, 18 Dec 2024 09:07:21 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller: Refine
 size/interrupt-cell usage.
To: Kevin Chen <kevin_chen@aspeedtech.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>,
 "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "konradybcio@kernel.org" <konradybcio@kernel.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-3-kevin_chen@aspeedtech.com>
 <11ad5a97-b066-4bea-8829-50e0416cea9d@kernel.org>
 <PSAPR06MB4949CF57BD69B2F7C1D141CD89052@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB4949CF57BD69B2F7C1D141CD89052@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2024 04:04, Kevin Chen wrote:
> Hi Krzk,
> 
>>> 1. Because size-cells is no need to use 2, modify to 1 for use.
>>
>> ???
> So, is it OK that I change the size-cells back to 2 include the aspeed,ast2700-intc.yaml examples and aspeed-g7.dtsi?

No, my total surprise is that I did not understand what it maens. Is
this changelog? Commit msg? Why such change is made?

> 
>>
>>> 2. Add minItems to 1 for interrupts for intc1.
>>
>> ???
> For variable interrupt numbers, I need to fix the below warnings by minItems.
>   DTC [C] arch/arm64/boot/dts/aspeed/ast2700-evb.dtb
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@100: interrupts-extended: [[3, 0, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@110: interrupts-extended: [[3, 1, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@120: interrupts-extended: [[3, 2, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@130: interrupts-extended: [[3, 3, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@140: interrupts-extended: [[3, 4, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> /home/kevin/linux-mainline/arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: interrupt-controller@150: interrupts-extended: [[3, 5, 3844]] is too short
>         from schema $id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
> 
>>
>>> 3. Add 1 interrupt of intc1 example into yaml file.
>>
>>> 4. Add intc1 sub-module of uart12 as example using the intc0 and intc1.
>>
>> What is all this?
>>
>> BTW, there was no such patch in previous version and your changelog is silent
>> about it.
> Agree, I will restore the previous version.
> 
>>
>> Subject: drop all full stops. Subject never ends with full stop.
>>
>>> ---
>>>  .../aspeed,ast2700-intc.yaml                  | 60
>> +++++++++++++++----
>>>  1 file changed, 47 insertions(+), 13 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
>>> 0-intc.yaml
>>> b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
>>> 0-intc.yaml index 55636d06a674..eadfbc45326b 100644
>>> ---
>>> a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast270
>>> 0-intc.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,as
>>> +++ t2700-intc.yaml
>>> @@ -31,6 +31,7 @@ properties:
>>>        type as defined in interrupt.txt in this directory.
>>>
>>>    interrupts:
>>> +    minItems: 1
>>
>> Nope, not explained, not constrained. Your schema is supposed to be
>> constrained.

I still do not understand this commit at all.


Best regards,
Krzysztof

