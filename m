Return-Path: <linux-aspeed+bounces-500-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FDC02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 14:27:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYlZJ4vG5z3cbl;
	Fri, 17 Jan 2025 01:27:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737037656;
	cv=none; b=daUEy4+ZShO5qyAvb8mFytPniN70+CeKOuuUDIGkMKS65gOmvFET3kJoGMKb8gyAKGOxYodV0vmDEPO1g7Pq7JD2ZEl/d5T5XnhkqOu9aDImS0Sox3ax3JqV7fGo6WkP0W3wS2Hx+2mE1/YNAk08sI7jBKwgLk/xca4sgtGeSV5l+dDDT3PSlIaCuz0dRsf+2Tj6YPHEOF+KgTJxG/EA+kySw4+IyLKyl0OH0GXdMgvf/pIwEuQvrK6PoDueyRU5QQ2K/gNQBStRySKUGV3pL19SVBxDDB+Y9vFFgWaysmmpgD0scw8hff/q3UvbYp/8Wjynh3sFnh0unznUSEHFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737037656; c=relaxed/relaxed;
	bh=WGGHQt362qFxLIPdjCsZ5vAbXoXVOt84VTc31ozsZVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CnKQt3gyB19i3vAG2tIkb4T1uWSTA5oYaXJjwYTYr5CVbnxINaiPUTRYRzzp74dfuKoQ63gfuDadF5nHI3YejAU8DAhUOZmFT0QLrXMsQ7wD18MrytobLcmLps5vWTQCD/WGbimz2plulE2kIhnOoLtsGJBwZ0vdjTnRXOknsNo3qnfjq+DPtKGtYeonGYOU9HxCPjvGsQ/iu7VYQJIyTgPjJYlvulyKEl5K78i6qB5RlCEZ8t/9f1AD+YuJgagpqaanAt1+25Mj1dWhHonfgvXEdKK3RHd2EnzojbD8/b1sQBivpnGJFT83FLcRcLnosWy1cYhN4bd7LsMaQ3Rg/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sqJe4417; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sqJe4417;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYlZH5TP9z3bhD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 01:27:35 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4361f09be37so1257095e9.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 06:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737037650; x=1737642450; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGGHQt362qFxLIPdjCsZ5vAbXoXVOt84VTc31ozsZVY=;
        b=sqJe4417BBd6NVFPq1Hy0Cd4PComsqLH72A9eSDRq0PK+kpc843JDFrqT//FFdjRbl
         gLiasgDDiYm1hskv7kByRZw6JsN6qZFE3n+wGCMcMwK9yNedSnGhuk4PKP6fc1tOusc3
         tSg70Cyph4JxHfKWQO8RCKZQDbvgnupLjTsqaE1A9O/VZXRBUqvkD8ONrWTmrQ/S0ENt
         /0N2a5o74JeH2nP9+fRsnVS68P19RIlGb3/riACpFuad/91hLiEuH+h+bSFs77b4dP8Z
         xlzXeYJ1SsT6KnrbDVGIBYEx3ZaHT63ZZFz+E14a5lery6BCsDbzhqi/ZN2dkmAcKd8g
         yhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037650; x=1737642450;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGGHQt362qFxLIPdjCsZ5vAbXoXVOt84VTc31ozsZVY=;
        b=KMb6gJDtRmRvFy0B/v+OHRVRRrF5u9/Sx/ut8E5pLG/+p5ysO6bDLQ0E+4YASx/o6P
         X5aKvxnfJ5dzNhnSWPFu6wSpBrXiF9ToKnpdhoy2ry+NAetZvw5ynOwoqgKeKVm1FnUy
         +KS8ajD8gSfaDeWr/EC8eq6Q5ukp50dpOP8PM+NvKt+NT5AXmW/jEPujUc8QzQCJqY68
         MRgNe7qc1JC5CiOLfAHp84MkFco+kBlpV1Vd3J8DRSDUE2VM3AcvpsQJBoP9NBQf7HhE
         o0KCod3VvYoB9yh/j5EBUZOSKnYm18d110BJkYacVxNxBY7RllX0kE2QZFnTyQGDsx1v
         NiTw==
X-Forwarded-Encrypted: i=1; AJvYcCXykLXqSNCa1EtlqLxr8CBYSyTKUetkzJ6l8vdXcHQQShn+zXii0lWbTim0+GrlIDMVWzwhLP8zFNC5uDA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwamutECsm1wRG7PS9C3nCmITUEKLtxGhuBqxJEzPkq/FV1ZmNv
	kjhtdAmTaUqmcbq6vptqqoFGqzNASyzGLrwhEckNn4d/zxP9zsX/lN5CV+pIPRg=
X-Gm-Gg: ASbGnctdIvOpRdgwQPBv2S67Mip51b7AIxgSvb8I6pkf8sMQa/2EkgQPqSth8u18Bb8
	BVN0yfuVFVmSSnIVlc5b0HU9O+ly5pXxusb3rerr4kvGO5WH1YsduKIqbOM0aPd210SLmb3kS9/
	brZZzLNkmkU2IdAu8noI055NjLfye8jDkbS/93b6u0spGidIi5zYaMaJ2nxuRQFbP4qfvZhtIIm
	5rK3gGo6WK+LI8N3wZAasyPo8lFvdStSsggfs9+CKtE5Hw+SObzp60AJfRGxn2LL9RN6hsdcP0H
X-Google-Smtp-Source: AGHT+IGI+9xN5JoVEowoewOfn71ULXmevSitFHnb9tteb6cVjNRGhpgrOwqSBnKP+yMsG2Bh+cLzQQ==
X-Received: by 2002:a05:600c:3554:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-436e26ffdecmr131841165e9.7.1737037649894;
        Thu, 16 Jan 2025 06:27:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm64114495e9.0.2025.01.16.06.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 06:27:29 -0800 (PST)
Message-ID: <8129b52c-f41f-4149-a3e8-8b739db9b991@linaro.org>
Date: Thu, 16 Jan 2025 15:27:27 +0100
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
Subject: Re: [PATCH] ARM: dts: aspeed: Align GPIO hog name with bindings
To: Ninad Palsule <ninad@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
 <cba3c5e0-624b-40a2-8b52-8d07604676a1@linux.ibm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cba3c5e0-624b-40a2-8b52-8d07604676a1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2025 15:18, Ninad Palsule wrote:
> 
> On 1/16/25 03:00, Krzysztof Kozlowski wrote:
>> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
>> to fix dtbs_check warnings like:
>>
>>    aspeed-bmc-lenovo-hr630.dtb: pin_gpio_b5: $nodename:0: 'pin_gpio_b5' does not match '^.+-hog(-[0-9]+)?$'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  2 +-
>>   .../aspeed-bmc-arm-stardragon4800-rep2.dts    |  4 +-
>>   .../aspeed/aspeed-bmc-asrock-e3c246d4i.dts    |  2 +-
>>   .../dts/aspeed/aspeed-bmc-bytedance-g220a.dts |  4 +-
>>   .../dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  4 +-
>>   .../dts/aspeed/aspeed-bmc-lenovo-hr630.dts    | 46 ++++++-------
>>   .../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts | 68 +++++++++----------
>>   .../dts/aspeed/aspeed-bmc-opp-lanyang.dts     | 14 ++--
>>   .../boot/dts/aspeed/aspeed-bmc-opp-nicole.dts | 10 +--
>>   .../dts/aspeed/aspeed-bmc-opp-palmetto.dts    | 40 +++++------
>>   .../dts/aspeed/aspeed-bmc-opp-romulus.dts     |  6 +-
>>   .../boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  8 +--
>>   15 files changed, 107 insertions(+), 107 deletions(-)

Please kindly trim the replies from unnecessary context. It makes it
much easier to find new content.

I was scrolling and scrolling and did not find any comment, but I
stopped in the middle, so if there is something to fix, please send
again with trimmed context.

Best regards,
Krzysztof

