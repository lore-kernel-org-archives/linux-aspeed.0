Return-Path: <linux-aspeed+bounces-2015-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7D1CA0EDC
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Aug 2025 06:31:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c6tkN2Fssz2yhD;
	Thu, 21 Aug 2025 16:31:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755757868;
	cv=none; b=Trd9dKosicnDPGsftlDthTglbdosXFev5yTakMd3tfqAOsMhWRI0Bkqd4ZxWyMSpO0/x71BdWbqK5nFLFt0mCcUimhb1N5k2dAtNUletqbHA3H+pMmd6I+iwdpN78q3hojT8fgUf55rSf7dccIe0WLN3rtYHTFzCO97b3W/iEJe1QpnkrgvPnE57rFUCsK85dGo6dCYr0FqtrO1e/hhBiCmeJuDbpqneKJo7yxXft3JO72PJRzuagDqvNc+kpxxPvuIbtirURnw9y5s+3lBWmo8o+anMC3SnLnpA/gNyc/rbtAAHSJ5rR7iqg9vviWpiQlN5ItbCIJp6RjVgwUP0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755757868; c=relaxed/relaxed;
	bh=S6Obwiyfp51/qWx9gtgncP3jlpkOE1vHO+YI4MF+c6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PP141+I9maz78ot5X9cVptxzauMwlCT57rtioOuNligHoAjZtF4JyF0wQ1lwX2EAqLjIdg5zJNeXH8SRWa1FELKrQmf7OAtKp63ZGNZZR9yTn7s57ZBwXelQbOrkzM9ZSIr94G5b12g6rcs/WLbPeDcrJXNDZoiVnwZEaqmsfsnMZtUpyYxmm9pH6nUAJ75HMlwdsXtUA1RK0B5GBIAyISiYMIg+UwXym20Eq1O8jkJAOWO59bKmkpePwqMG5H1NKfpr++sAEwKhr9G0u/O0moYcxvJDr6KIfpNkYV0PEdTFAwzeHWZpq0ejJjO7EXeq2+1tQae56y2031sETqU0AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ahlmc3VE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ahlmc3VE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c6tkL6dNrz2yCL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Aug 2025 16:31:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 852E743FCA;
	Thu, 21 Aug 2025 06:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C70EC4CEED;
	Thu, 21 Aug 2025 06:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755757864;
	bh=8gidM6G9cAD1gbH9lRLRqrEdyStqaXcALxwsVA8/3Sg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ahlmc3VEQxY2P1AxB8ORK+XkWtx510+u7bIIebercr9bed69mAV1Wnz5MmIzaQiBT
	 /385CBHk6FYVoK7no1/VabWd5p2dSSdjiicPUjOk/A3HPxhfynw6amOARLtGL5pps2
	 ttn4NGZJcTLpiZw9cTGKjhSGb1HaMKty8lkHuXCZjq1v8shqwb4AtRzChKTnkiGN9o
	 2IKeJPPTw8dQKzKS5esomAC237CyZcRvZbcuTMEfb7t05QNAwz3AjlRevRk/yFDhXz
	 I6bpVYl236UQ32J/Umue9mh80UrD2m3Z6iuvpaA1MVbkaOj9W5Rw3DpO8CdZwluPau
	 BXe8DebnKnN1g==
Message-ID: <c288db22-7a80-4dc1-abb5-fb5adb2f5669@kernel.org>
Date: Thu, 21 Aug 2025 08:30:59 +0200
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
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW25ldF0gQVJNOiBkdHM6IGFzcGVlZDogYXN0MjYw?=
 =?UTF-8?Q?0-evb=3A_Correct_phy-mode_to_rgmii-id?=
To: Jacky Chou <jacky_chou@aspeedtech.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, Z-Howard Chiu <howard_chiu@aspeedtech.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250821052555.298860-1-jacky_chou@aspeedtech.com>
 <80723310-97e6-45ea-8154-c48de40e14aa@kernel.org>
 <SEYPR06MB5134106F024EB9EC32472A329D32A@SEYPR06MB5134.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <SEYPR06MB5134106F024EB9EC32472A329D32A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 08:17, Jacky Chou wrote:
> Hi Krzysztof,
> 
> Thank you for your reply.
> 
>>> According to the latest ethernet-controller.yaml.
>>> Since there is no RGMII delay on AST2600 EVB, the phy-mode property of
>>> all MACs change to "rgmii-id" mode.
>>>
>>> Fixes: 4d338ee40ba8 ("ARM: dts: aspeed: ast2600-evb: Enable RX delay
>>> for MAC0/MAC1")
>>> Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
>>> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
>>> ---
>>>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 8 ++++----
>>
>> No, DTS cannot go to net. Why do you propose that?
>>
> 
> If there is a series of patches to add or fix about networking and this series
> Includes dts or dt-binding, I send it to net or net-next.

No. That's really irrelevant. And if you change there I2C you send to
I2C maintainers? That makes no sense.

You send it to respective maintainers. networking things go to netdev.
SoC (so DTS) goes to SoC.


> So, this is just changing the DTS settings, even if it is for MAC,
> wouldn't it be sent to net?

You must follow what MAINTAINERS tell you. Don't invent your own rules.

Best regards,
Krzysztof

