Return-Path: <linux-aspeed+bounces-1833-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FABC87FCD
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Jul 2025 07:40:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bpKXd3kmMz3bTf;
	Fri, 25 Jul 2025 17:40:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753429217;
	cv=none; b=ekw823YhvQCCvACwQZRjs8z7gP9lzd2o+R4KIxdckF2muYRfR49fFMSA9qEhsKT47V0VsMY+1L4FTl4bQweYEDwDB7waYfJ5g9uXPXrdqSbhcVZjuz431uindA3NNZyY+BCFInTW0/SiWExT4MDxGqQQ+4eQoWOeFL9QtRIDG4gZBITCYjW3A5TaTKukOd+3u1a8btIvu1jOM2P5x0HIhlkamKWey2E3XZ7hBDeTWa+FDceJRaeI9vJk17VFlsOG/ANMHgRNYuXYS72naQnQ9iqr5edWLGBi6tc91UxelRMhtH21U2bAlPOkv0QTjTP5VcMk3vGI3TcX1uWBi3Wkww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753429217; c=relaxed/relaxed;
	bh=zNH/CsduUWCvM5gELuAgq3p7E4AdZC3XhwuB0cWgsv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNgkrrzyycv/nMUf8Lugzi681jahdL/EHOpoEMNZsb6nOwIXrzbzcdeHOq34VUvyoi/2NaMzfNRSHH/NUp6y+NuSDhCSTgrhZO+TS/Lu6NVejFKFDHo5UCMOHn3UiQRWqenJt/M7T9gZXTCLl4NaBB1aoI67LwWj38RsbMjBnuBc1Xrv9biZpJQQ42+zXjrxURfl/L0fPIWOM/d8zIJ/M/SGc/PCuC0026AP2PTSqS6pKaf699SMtV8frW3H0PrAb4ivnjEdVb5uOOjFeRWN7XONxhOINVHEodwESL55gXc70vWi4mH4IPGFe+3svtZz/xQ1iQJxgf+glNa5lcGQBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvLj/ANp; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvLj/ANp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bpKXc5NVTz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Jul 2025 17:40:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9C968A56052;
	Fri, 25 Jul 2025 07:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5CAC4CEE7;
	Fri, 25 Jul 2025 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753429213;
	bh=7VzQscuh58heLqHgPQucnd5aA5ZutPjS50+G0o0BO0Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fvLj/ANpkT2bNwQYRbeyhJMU70oyrqXfxsFj7Mou4iNQBHzz21IOMS24MZA4v65qm
	 wMw8+QYyzq3avcoG94kfAnX2OHP6TVXc+UneLCbFDyPMVI5fR8AV7vjz59D6zatuJc
	 7lTgFRvqsfeGAwzue0TY86lPQ4rtXGE6Zyed2I43w/fQvUTNMXAezuXx/HyXlFbKX+
	 TjhEHkoRzVeSfT0e8RqofNNKSc8KvuQCUyZxSSBO7C2WMCKAtW0ZHkEocRTNSRS6jF
	 FltryL1O+/oslxIaenw3ZSkLhBuSAvznsXbb2x0eQzaXtv3y41z6MAF4s2CphYvGmb
	 oAvjrcKKlIeig==
Message-ID: <384635a3-c6ed-44f8-a54a-2b20e20694cd@kernel.org>
Date: Fri, 25 Jul 2025 09:40:08 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <OS8PR06MB7541F8D3AEE1A618DB31F07BF25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 10:08, Ryan Chen wrote:
>> Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: aspeed: Add
>> parent node compatibles and refine documentation
>>
>> On 22/07/2025 11:51, Ryan Chen wrote:
>>> +  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
>>> +  INTC1 is used to assert INTC0 if interrupt of modules asserted.
>>> +  +-----+   +---------+
>>> +  | GIC |---|  INTC0  |
>>> +  +-----+   +---------+
>>> +            +---------+
>>> +            |         |---module0
>>> +            | INTC0_0 |---module1
>>> +            |         |---...
>>> +            +---------+---module31
>>> +            |---....  |
>>> +            +---------+
>>> +            |         |     +---------+
>>> +            | INTC0_11| +---| INTC1   |
>>> +            |         |     +---------+
>>> +            +---------+     +---------+---module0
>>> +                            | INTC1_0 |---module1
>>> +                            |         |---...
>>> +                            +---------+---module31
>>> +                            ...
>>> +                            +---------+---module0
>>> +                            | INTC1_5 |---module1
>>> +                            |         |---...
>>> +                            +---------+---module31
>>
>> You binding also said intc1 is the parent of intc-ic, so where is here intc-ic?
>>
>> This diagram and new binding do not match at all.
> 
> The corresponded compatible is following.
> 
>   +-----+   +---------+
>   | GIC |---|  INTC0  | -> (parent : aspeed,ast2700-intc0)
>   +-----+   +---------+
>             +---------+
>             |        |---module0
>             | INTC0_0 |---module1
> 			(child : aspeed,ast2700-intc-ic)
>             |        |---...
>             +---------+---module31
>             |---....  |
>             +---------+
>             |         |    					 +---------+
>             | INTC0_11 | +----------------------------	| INTC1   |  -> -> (parent : aspeed,ast2700-intc1)

AGAIN (second time): that's not what your binding said.

Your binding is explicit here, which is what we want in general. It says
that inct1 is one of the parents of intc-ic.

Let me be clear, because you will be dragging this talk with irrelevant
arguments forever - changing this binding is close to no. If you come
with correct arguments, maybe would work. But the main point is that you
probably do not have to even change the binding to achieve proper
hardware description. Work on that.

Best regards,
Krzysztof

