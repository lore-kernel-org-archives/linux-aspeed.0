Return-Path: <linux-aspeed+bounces-1834-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6A2C83F26
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 07:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpKZY414kz3bV6;
	Fri, 25 Jul 2025 17:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753429317;
	cv=none; b=Xroaa8zm0OuQDyp6wfnsStLZSYWmayR0wHj0IXy7WFLf6mGjg2jqQRGL1NJgPf6HziDF9I0Bk28JkbzypNlfWwlrjT/MW+h+Yd/3dTBAPs6Pe2tmUfLifJvSSCOVrY8d7MXG3B+osBw5e9xJP5y3Hg2//vqiVGO08ILTyoBbHnO4irONoCWeOBDQiBYbCBKJMikifNIUQ/Aeo300m7TDQilORJhe1q+OfHokUAeZGrad9GSmLanK3THw+vksdPuGDbqwSqF1SXPCrctOFlu/NK/bzmHQ+e3Ru8MgAtiF9iaEM8DkxnOXaul/mLOQjJHJAi17zuQNZAQtnhxbIqLtPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753429317; c=relaxed/relaxed;
	bh=6ZGxjiEdwRsMG9Q2E2qjJEU3/ioErAZD+Vn9eIyQP6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=beZ5Wthmi1BVsZR5VdlclHbYgVBvm6SV+1/AiqVcXLC2apLdz+U7UKeJv9SdYBCWRLV9v2ksBtZnHKl/+8HPCp2ux2dX1Uq65t0e8bXk5bI/3tv7CEN11wP00J1nyiVKPM+I3laBE/Pap5WQJwVfNS/2yFPLE0gyAjnu13xqZ8TrN0ZeA/WV1FDQEG28+v4Ro6qMkcK5nFwj4EZCjopi8PdhLGHoUCd2hrScHm6iBgeIOCsYMB5G2NPNrHBKC0ACxDDDsw71YWzaEnVN5yYn02NiT41ij4Yps5sfXjklzGKymSdRoMf9+FHz/j6VkJ7Plt4rbFXjnvHlfG5Q5clNbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OqcWCYGk; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OqcWCYGk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpKZX5bRfz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 17:41:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DFF246831;
	Fri, 25 Jul 2025 07:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA54C4CEE7;
	Fri, 25 Jul 2025 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753429314;
	bh=+oqH1MFh0BVgLR6cjPHsZ04ng4bYIfUcQCNQ4tKmWi4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OqcWCYGkZZjKAXS0oyQgUnyxOiO5YSu7EEyvEwzY0aFdXeonUNISxbTwyT8zG2f/J
	 VO6lec445cOUHa9UF2myCCnl3vxSPv1Xr8qDDjgcngt1Rwp+zZ14SQipD+/IrTer6J
	 Mj8oFL3cQINUMxpvC9TLtoYX+ZQNbWA6u5xFe/nN8UvmyBPZhTcbASae9uf5iJjVGh
	 uXxOiDpwnbomzV5mUj4I8TKoRWex6SDdOu1TqW6aFd3cO+df9LoCAPCe9LXw6/u+EQ
	 V8JViaZIU7tDLwwVF1ZkJTzBas0tqrna01soWBYkUtJR5L4RygSHCC4TfrYRSxJ7mX
	 kT39XLIdOHE5g==
Message-ID: <3c2ce865-0f9b-4b8b-a4c7-d869c6a4f717@kernel.org>
Date: Fri, 25 Jul 2025 09:41:49 +0200
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
 <a9294387-ce7f-482e-89e1-7c85feaeeee9@kernel.org>
 <OS8PR06MB754125722911782DBB3CFEFCF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB75418DB8CDD04D506EB13215F259A@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <OS8PR06MB75418DB8CDD04D506EB13215F259A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/07/2025 09:18, Ryan Chen wrote:
> 
>> Subject: RE: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add parent
>> node compatibles and refine documentation
>>
>>> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed:
>>> Add parent node compatibles and refine documentation
>>>
>>> On 22/07/2025 11:51, Ryan Chen wrote:
>>>> The AST2700 SoC contains two independent top-level interrupt
>>>> controllers
>>>> (INTC0 and INTC1), each responsible for handling different
>>>> peripheral groups and occupying separate register spaces. Above
>>>> them, PSP(CA35) GIC controller acts as the root interrupt
>>>> aggregator. Accurately describing this hierarchical hardware
>>>> structure in the device tree requires distinct compatible strings for the parent
>> nodes of INTC0 and INTC1.
>>>>
>>>> - Adds 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
>>>> strings for parent interrupt controller nodes. (in addition to the
>>>> existing 'aspeed,ast2700-intc-ic' for child nodes)
>>>
>>> I don't understand how this solves your problem at all. Look at old
>>> diagram - is it correct? If not, what makes you think that new diagram is
>> correct?
>>>
>>> What is the meaning of existing binding and existing intc-ic compatible?
>>>
>> The new parent nodes (aspeed,ast2700-intc0/intc1) make the device tree layout
>> match the actual hardware separation shown in the SoC datasheet.
>> This allows us to register the full resource region, allocate platform resources
>> properly, and cleanly extend/debug in the future.
>>
>> The previous "aspeed,ast2700-intc-ic" compatible only describes the interrupt
>> controller instance, not the full register block. In practice, with only a single child
>> node, there is no way to:
>> map and manage the entire address space for each INTC block (0x12100000 and
>> 0x14c18000), or cleanly expose debug features that must access
>> routing/protection registers outside the intc-ic range.
>>
>> The old diagram was incomplete, since it implied that the interrupt controller
>> block had only the intc-ic instance, but in hardware each INTC region contains
>> multiple functions and register ranges.
>>
>> This binding change is mainly for clarity and correctness, aligning DT and driver
>> with the real SoC register map and future-proofing for debug/maintenance.
>>>
>>>> - Clarifies the relationship and function of INTC0 parent
>>>>  (intc0_0~x: child), INTC1 parent (intc1_0~x: child), and the GIC
>>>> in the documentation.
>>>> - Updates block diagrams and device tree examples to illustrate  the
>>>> hierarchy and compatible usage.
>>>> - Refines documentation and example formatting.
>>>>
>>>> This change allows the device tree and driver to distinguish between
>>>> parent (top-level) and child (group) interrupt controller nodes,
>>>> enabling more precise driver matching SOC register space allocation.
>>>
>>> And how it was not possible before? That's poor argument especially
>>> that DT does not have to ever distinguish that.
>>>
> 
> Hi Krzysztof,
> 
> I wanted to follow up on my previous explanation about separating parent and child nodes for AST2700 INTC in the device tree.
> There is other SoCs, such as Marvell’s CP110 ICU, also use a similar approach to separate parent controller and functional child nodes in the device tree, as shown here:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/interrupt-controller/marvell%2Ccp110-icu.yaml#L74-L98
> Do you need me to provide further details or additional about our SOC design information?
> Or is there anything specific you’d like clarified regarding the motivation or the binding structure?

Start properly wrapping your email responses. All of them are
misformatted, all the time!

You got replies from two DT binding maintainers. Work with that.

Best regards,
Krzysztof

