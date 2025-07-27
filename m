Return-Path: <linux-aspeed+bounces-1838-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF5C87FCE
	for <linux-aspeed@archiver.kernel.org>; Sun, 27 Jul 2025 09:36:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bqc1r4q2Zz2y2B;
	Sun, 27 Jul 2025 19:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753608992;
	cv=none; b=hIAVvZGe9qVXRrhgCHClW06D/HMUllJ2JvIVbYX8M2UVIxbFFeECo+x12hUYC7+l7SZXYM66Sskz13lyfeV6gffXSAX+plF8hVPKYhCzj47RprZ/9Z/DJJCot3qxNoCPslP3Ptrgb5+fPEzb4Oa2kzFARZAjZEJZT+3U/7QB/7R2HK0M3lP92bo/ysnJn++7ayL+FNQPBK3hmWj3C7tRoElViJyhVCqudMQXjilEIAIlUWJP28jEDTwbxBM38oHnBtupZyoX/M9XDzOFpOMFCBKW8R/5uVkk2OhC5GhbP+LRK4uXd0M0D+cFDC0wIp61a7ILGUmOFTtOSpNcG1Bfug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753608992; c=relaxed/relaxed;
	bh=RXO7j/EW0YZHZmrgrDHnxMJbXeUhG4A5t7N4/mNJ/U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hf5bcvFO6fsxxfWVZsoZAH3CXhs9ayDmb+/Q5zja+E0qL9Ttt117Y/sFHwoS4U9uEtAUARuFXMcSdN2wa6KaMyzcJ8xPZNttezcaL7FtBQ85E9umzDNw7TC/h85a3dXcBQ+oDa6XgWgF0NE5nVsdk2ZaF5I6vK3VYhccTeTQS+dNzeTzNasTaFQmFfo9HiUO/C0gHuYfCg9SbIeOpSeOl4eT4fIqgP8ta9AhhzOVg7rHTjzCcx7g53HYJdRG5/zrjQv0Fzj+3IXw2pc9I1Ol90XlBhXY655J3Tw8mrY+EGgWBBTtMlQ8TgWF51Wokn0CxKEe2ZP11XZHKaARrz6Jvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CleSKY6o; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CleSKY6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bqc1p5bVkz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 19:36:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B3D3643F3D;
	Sun, 27 Jul 2025 09:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F0FC4CEEB;
	Sun, 27 Jul 2025 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753608987;
	bh=3KwHDBXWQOpr86hh/WgXBV9m9JGz7kpYAsJ27ibYkBc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CleSKY6oYIOqUNNodUPeJS3HEm1Cv7ET2XDHb9qBTv6RGO+5Yr8v4eGzHmMUbsQOv
	 KnEG9Y+kBRcXsgUGzPbgazE/Ro7TV5N520M3eFXqib0dd/jbn3rfhclfK1VstmRkzn
	 IC0BDYxMawwO/SREWuVmP5qmJzaUMoAvTDKXk+mfs7JdyKObpTG74RMqaVNPT1EKaO
	 jMs/ZarvFq50IN5/GNPZYnMr8dkoL9RilmsfWBT4UBSddoFOK08SzZnj6Xxy+M+5hY
	 8ez8LzAEeiAlsCk7b3CQjpLGijkqtTdtGWN/fDo4+6QcMCk1NY8lbDX62emxhIV9P0
	 6hIRJVdwg+FPA==
Message-ID: <b8e570ab-313f-4f20-bedb-a1191c672435@kernel.org>
Date: Sun, 27 Jul 2025 11:36:23 +0200
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
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
 parent node compatibles and refine documentation
To: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-2-ryan_chen@aspeedtech.com>
 <001d37c7-f704-4554-a4db-0cc130e07dd6@kernel.org>
 <OS8PR06MB7541F8D3AEE1A618DB31F07BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <384635a3-c6ed-44f8-a54a-2b20e20694cd@kernel.org>
 <OS8PR06MB75418BD29DCD6E93F2A44903F25BA@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <OS8PR06MB75418BD29DCD6E93F2A44903F25BA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2025 03:47, Ryan Chen wrote:
>> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add parent
>> node compatibles and refine documentation
>>
>> On 23/07/2025 10:08, Ryan Chen wrote:
>>>> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller:
>>>> aspeed: Add parent node compatibles and refine documentation
>>>>
>>>> On 22/07/2025 11:51, Ryan Chen wrote:
>>>>> +  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
>>>>> +  INTC1 is used to assert INTC0 if interrupt of modules asserted.
>>>>> +  +-----+   +---------+
>>>>> +  | GIC |---|  INTC0  |
>>>>> +  +-----+   +---------+
>>>>> +            +---------+
>>>>> +            |         |---module0
>>>>> +            | INTC0_0 |---module1
>>>>> +            |         |---...
>>>>> +            +---------+---module31
>>>>> +            |---....  |
>>>>> +            +---------+
>>>>> +            |         |     +---------+
>>>>> +            | INTC0_11| +---| INTC1   |
>>>>> +            |         |     +---------+
>>>>> +            +---------+     +---------+---module0
>>>>> +                            | INTC1_0 |---module1
>>>>> +                            |         |---...
>>>>> +                            +---------+---module31
>>>>> +                            ...
>>>>> +                            +---------+---module0
>>>>> +                            | INTC1_5 |---module1
>>>>> +                            |         |---...
>>>>> +                            +---------+---module31
>>>>
>>>> You binding also said intc1 is the parent of intc-ic, so where is here intc-ic?
>>>>
>>>> This diagram and new binding do not match at all.
>>>
>>> The corresponded compatible is following.
>>>
>>>   +-----+   +---------+
>>>   | GIC |---|  INTC0  | -> (parent : aspeed,ast2700-intc0)
>>>   +-----+   +---------+
>>>             +---------+
>>>             |        |---module0
>>>             | INTC0_0 |---module1
>>> 			(child : aspeed,ast2700-intc-ic)
>>>             |        |---...
>>>             +---------+---module31
>>>             |---....  |
>>>             +---------+
>>>             |         |    					 +---------+
>>>             | INTC0_11 | +----------------------------	| INTC1   |  -> ->
>> (parent : aspeed,ast2700-intc1)
>>
>> AGAIN (second time): that's not what your binding said.
>>
>> Your binding is explicit here, which is what we want in general. It says that inct1 is
>> one of the parents of intc-ic.

... and you never addressed that. :/

>>
>> Let me be clear, because you will be dragging this talk with irrelevant arguments
>> forever - changing this binding is close to no. If you come with correct arguments,
>> maybe would work. But the main point is that you probably do not have to even
>> change the binding to achieve proper hardware description. Work on that.
>>
> 
> If I do not change the binding, I think the yaml and dts can still fit the interrupt
> nesting architecture by using both interrupts and interrupts-extended.
> 
> For first-level controllers, use the standard interrupts property
> (e.g. with the GIC as the parent).
> 
> For second-level INTC-IC instances, use interrupts-extended to refer to the
> first-level INTC-IC, following common Linux practice for stacked interrupt controllers.
> For example:
> dts
> // First level
> intc0_11: interrupt-controller@12101b00 {
>     compatible = "aspeed,ast2700-intc-ic";
>     reg = <...>;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>     interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, ...;
> };
> 
> // Second level, cascaded
> intc1_0: interrupt-controller@14c18100 {
>     compatible = "aspeed,ast2700-intc-ic";
>     reg = <...>;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>     interrupts-extended = <&intc0_11 0 IRQ_TYPE_LEVEL_HIGH>;

This looks like changing the meaning of the interrupt. What was the
interrupt here before? What interrupt is here now?

> };
> In yaml, I can use:
> oneOf:
>   - required: [interrupts]
>   - required: [interrupts-extended]
> This allows both cases to be valid.


Hm? Since when you need both cases?


Best regards,
Krzysztof

