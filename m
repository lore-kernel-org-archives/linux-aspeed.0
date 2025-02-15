Return-Path: <linux-aspeed+bounces-746-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A9BC021A0
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 11:07:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yw5k12J3wz2xk1;
	Sat, 15 Feb 2025 22:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739617673;
	cv=none; b=CRuo7sQ90SlHQUPX8Oo9HJLxAyrESNDh9KjQiRh+Lstj7hpsAI8ySqGO6F3PDT5F0hs4NoaGKied2Z+ucgupyi8AtCS/HReRsOfDfmvpmLnCSvEgDHy4zinyXsQh423lJd3+MaYsZaYQ/F9aAc7DD3ijmsh9UWwlyKONVaeNzc2EIaUt+QOpqlPmi6/mAP5AVTtCIpdoMfzIcD4g3wMjuRuMjh9HIHX19BjW/dVxpCSDdE+PGf0zB8Z+/FzSwla3Lg0wRQsno6FvL0gX1q4zmRCs/OMvA1kfvI6W754Ya651PAmTaxVoB6BpS8sCtQGq1KJqekSmzG5MlDAPSeOtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739617673; c=relaxed/relaxed;
	bh=X+uITPL1MA6j9F7/d6uOb4dkNY7HMIvpcOJUxLgXtLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnEhpLZYYXL08oapS2Md6HwLu6auEuI+bipEA3nFYYciqal7XfYegBGDFR2uENUcERjSJIKf07ZI6YCDUrY+KVoplbqLOafBQg2kW9hjB7ZFlo3/vyHaJ4UlrGSmoq9sr+KT1WO+AYY9GBn3emIuO2xAicZFH9zIZIjx5nzVmmkrCL3V4nBQF3+0xsoUwJ4eaL7cmreXQS5Da3c4VqJum7uSxlrlmG26YU4R5fZhsIi4uXHFFUar2EHDiAlrjTWL8oHT6R5bnutvzU11N0hIxvcI+DglD1Zf0PFgr7/AXlgWpIVo1sSsObtPVsABL/dvf4WEHmMgyzyy1/QTDTKj3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mFW6meLh; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mFW6meLh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yw5jz5czcz2xYr
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 22:07:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EC964A402BE;
	Sat, 15 Feb 2025 11:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89FAC4CEDF;
	Sat, 15 Feb 2025 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739617666;
	bh=aviqrW+4MMM0OACMiFIOXdC21DPQ4amvmUKmI0yVnsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mFW6meLh6335BCBVacv3KLcHO3Lnh6ZpSDXy/9IXWDFgzUwZIW1SxqylwEuTLXAfz
	 3KUwHnvFAv0Qyn3s/p5GVuVygQqlCSSOwxqJQLsnWkCAW/MPD5N7FJs0of2XpXZtTx
	 9NeCIkkRgIEsUcwJHI4t1jq7rpVGJUSoJ7kVH0LfmQ29+1orsNuvbbmE3K38DlkB9W
	 S5u5YdiF+hcNUeMMo5nd9FWUSRkkgjzDuN3DqR44cSohZy4aCheFQr129ouxWqWGyJ
	 xLAUI8BcokmJ1drd4ogMNlJLXZHQThsm7EBDjKwQXbymiosyyIjpdm+C6vaBL2nD0a
	 d+0iZxdlYB2ug==
Message-ID: <87e21b2a-b0f5-41c3-ba6e-960da5c1f836@kernel.org>
Date: Sat, 15 Feb 2025 12:07:39 +0100
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
Subject: Re: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
 define
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250210085004.1898895-1-ryan_chen@aspeedtech.com>
 <20250210085004.1898895-2-ryan_chen@aspeedtech.com>
 <20250211-encouraging-free-aardwolf-0fabb1@krzk-bin>
 <OS8PR06MB7541287BC48C500E50C7C77FF2F92@OS8PR06MB7541.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <OS8PR06MB7541287BC48C500E50C7C77FF2F92@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2025 03:14, Ryan Chen wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Tuesday, February 11, 2025 4:18 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>
>> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>; Joel Stanley
>> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>;
>> linux-clk@vger.kernel.org; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
>> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
>> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v8 1/3] dt-binding: clock: ast2700: modify soc0/1 clock
>> define
>>
>> On Mon, Feb 10, 2025 at 04:50:02PM +0800, Ryan Chen wrote:
>>> remove soc0 clock:
>>
>> Why? Your commit msg must explain why. What is obvious from the diff, isn't
>> it?
> Thank you for your feedback. I will add explanation in next commit patch.
>>
>>>  SOC0_CLK_UART_DIV13
>>>  SOC0_CLK_HPLL_DIV_AHB
>>>  SOC0_CLK_MPLL_DIV_AHB
>>> add soc0 clock:
>>>  SOC0_CLK_AHBMUX
>>>  SOC0_CLK_MPHYSRC
>>>  SOC0_CLK_U2PHY_REFCLKSRC
>>> add soc1 clock:
>>>  SOC1_CLK_I3C
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>>  include/dt-bindings/clock/aspeed,ast2700-scu.h | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h
>>> b/include/dt-bindings/clock/aspeed,ast2700-scu.h
>>> index 63021af3caf5..c7389530629d 100644
>>> --- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
>>> +++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
>>> @@ -13,18 +13,17 @@
>>>  #define SCU0_CLK_24M		1
>>>  #define SCU0_CLK_192M		2
>>>  #define SCU0_CLK_UART		3
>>> -#define SCU0_CLK_UART_DIV13	3
>>
>> NAK, ABI break without any explanation.
> 
> The `SCU0_CLK_UART_DIV13` was originally defined as a separate clock identifier, reviewing the AST2700 clock driver implement, I realized it is no longer necessary.
> The clk-ast2700.c driver I have **integrated the SOC0 UART clock (`soc0_uartclk`) with `ast2700_clk_uart_div_table`**. 
> The UART clock source will get from ast2700_clk_uart_div_table, that will div from source 24M div13 or div1.

Wrap your replies correctly.

So all this means you exported clocks which are not clocks?
How are ABI consumers behaving now?

Anyway, any ABI impact must be clearly justified in commit msg.



Best regards,
Krzysztof

