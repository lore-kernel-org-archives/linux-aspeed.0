Return-Path: <linux-aspeed+bounces-777-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B5BC021AA
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 06:07:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyQsT08V7z2ym2;
	Wed, 19 Feb 2025 17:07:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739945244;
	cv=none; b=THkCP1yV07Wq9Aqb3kgmqsUIPVD/lJg73Xtga3FdotzTIs2bidgsBcYwZzAFZYc/RwS5PF/KoqHTx3E+ZHoc2VdtlHyhYJ9GGrspZGjC86TD3ebekAbsLYav/cCR8lMwUKcdGAIgJjSaR2MSWxI5AFqGXi4Bk2HUJvAlh9KWqatF8JfVwar5RoPPEfAcKkmvUd1lard9QcC5Ty4j4W1C5tetGxQFLMZsouSSOu/BCTSCF/6++QNXl2lyQQTEonDgNFEwEOHGtiJqD1MFbcZkHoaZCWbgY9UKi6Hf30dwd/Wj7Nlf6rJGtnADhrbPApxCjKlzCfK+G9OTT6EV/UMvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739945244; c=relaxed/relaxed;
	bh=MMweWeNSzeI1MWtj+pEFAXNqqqyma+C3FI/z06gKBZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqQn4T76RwiauMqjdKm546+HSGOQPcaKRApyTeE+cKNHmYLUUpPvf21DGAg0u4NBEvG3Gs5fn+kIjtv989M2QiUI1a5JCpLMtQo/tpbhVPXFHXH48qkquJgF/oGUq/7pGUFgUwF0jvzxC94RVBMe1WA7Pgh39q3f+ZdUwER15ImkfMcSBPY9u4mIjY61yZpBdT89H0T5aK3xGOQtldZJZw8FXYFx2QSsZu/6meIlGHJtrzHBHV1oFZR91wWMfETJCdz5pt3Bz677sGXl+IX3HVeGeobG84WOJkBwUyFnd+jC/ewSDmg8IR9R8e4Gt8GVYD91l2h3X9YNmyA+wqun4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hktB7jBr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hktB7jBr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyQsR1kDPz2ykZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 17:07:22 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-220c92c857aso8548255ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 22:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739945239; x=1740550039; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MMweWeNSzeI1MWtj+pEFAXNqqqyma+C3FI/z06gKBZ4=;
        b=hktB7jBrc2rnW1iG9RURiqAs03Ijz1Mbpdgt63e33kh00XimocH0K+yXSODrlfNK09
         L2m+Ya0XzZNJ4+QOw5sfrURP7IFdy9N2rL8chK/CPQUNoQV9dSaBSO5Kabtsf76yaGUP
         icarwC4XayA1xne9cv08vOryAbYRpU09exAy6cLOZAJAUDw8QoZNqK5r1iX84+UborxE
         r8hRG1Lx2dVky9IYJi8corIhxNPnu4R7FSZOF3hEm7nPiOptFqvRocViBerm/JGaF5GU
         tWLgThsJAXrJLPszhch0GMxs1gcqZkqSKz01E1n00N3WHOfqUPaIJDrjPgDA7AMYUBn2
         9hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739945239; x=1740550039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMweWeNSzeI1MWtj+pEFAXNqqqyma+C3FI/z06gKBZ4=;
        b=ezdOM45aPl7v9GfuqMtoAhwjH+wN8maSRKjnpG+CJmUxKpcq+yi5iA370l0zhqLvEj
         hsxDDn1a3zvACv0ZuF6vKtxC8VNM+01kEv2HSNcKdistti6pjtNGVcy8o9P3bM+odzy+
         nbBz7zInHcxOsaGzsrHJG5I44AoII1t5KdngXK3Uf7JYts9wum74x1Nskr4HAjt6hOyq
         HXX9DVXJHE3Yr5S552mdlFa1lra8pISAYOoycTMUlWWYRL5fUgXFm+FzcH+iIZVICyB2
         efQkYWMWIVnMdGeVx7BfyWFnTf0ZW2j2n87+dTf07KMxx8YSJyJL6EIkdy1aXx4kyDzn
         XYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbJBUZ50UmCMAAEz6opZ/ov750nmpGXb0B2k9pD9rwVvcBpmOf+U7MznmvZCvUra6/ZZ6hIsuMl/6J96E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwT9Hiy1UhC8Iwi/6T6kgGAx3eu5mqfz+RwE7U/q12lVrVrP80P
	uCTyl3NO2XFh3pJ5x36thF62Fe0MlLK6Z79lCinXYxPMMdwUgHD2
X-Gm-Gg: ASbGncuKKEL0/LKjWw7btRoKkz/JHolI7mqu8X37GXS1SZ3IlO2svkqpX8zfpXj+cdW
	fATwT9hp7ZTiTol96BicbIO4Bz69HQwTe6LaiX1/aM1nasqfGpiR8JR88Inqy/dxLkwmyi2DYER
	+ImSxy+mYrZyumaDIo2Ye8MIKKHYpN7zdd3sOzho4OmVFUvi7BGNHfZloYh/3EnYHK3vGMhMplv
	B5uPLCkTm2aROXvuGas8HhQ/oAVhBmXazTHN/zYb3m5XerSMT53HIZyoSwst+Rxhwk7fW7u80+O
	f1vt1fNvnBQ4JfOmJhQOKGsJPuGzZWiWaHWveVBvDBsA+bKhM61ADXAJiHVgrru/
X-Google-Smtp-Source: AGHT+IFDDkfL+/p8rzt9E4xU1vtBKwXwGcdJQ1cGVlgttlla+I+hR4jexAvPi61qQULzGxFmQbFgbg==
X-Received: by 2002:a17:902:fc8f:b0:221:751f:cfbe with SMTP id d9443c01a7336-221751fd1f5mr30886355ad.19.1739945239041;
        Tue, 18 Feb 2025 22:07:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349226sm98602605ad.24.2025.02.18.22.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 22:07:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e692263e-a390-4611-b629-2b9feca1883a@roeck-us.net>
Date: Tue, 18 Feb 2025 22:07:16 -0800
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
Subject: Re: [PATCH 1/2] driver/aspeed-wdt: fix pretimeout for counting down
 logic
To: Heyi Guo <guoheyi@linux.alibaba.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Eddie James <eajames@linux.ibm.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
 <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
 <5a33f86d-d82c-4685-8da7-5e623487a40c@linux.alibaba.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <5a33f86d-d82c-4685-8da7-5e623487a40c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/18/25 19:41, Heyi Guo wrote:
> Hi Guenter,
> 
> Thanks for your comments.
> 
> On 2025/2/18 13:33, Guenter Roeck wrote:
>> On 2/17/25 19:16, Heyi Guo wrote:
>>> Aspeed watchdog uses counting down logic, so the value set to register
>>> should be the value of subtracting pretimeout from total timeout.
>>>
>>> Fixes: 9ec0b7e06835 ("watchdog: aspeed: Enable pre-timeout interrupt")
>>>
>>> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
>>>
>>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Joel Stanley <joel@jms.id.au>
>>> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
>>> Cc: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   drivers/watchdog/aspeed_wdt.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>>> index b4773a6aaf8c..520d8aba12a5 100644
>>> --- a/drivers/watchdog/aspeed_wdt.c
>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>> @@ -187,6 +187,13 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
>>>       u32 actual = pretimeout * WDT_RATE_1MHZ;
>>>       u32 s = wdt->cfg->irq_shift;
>>>       u32 m = wdt->cfg->irq_mask;
>>> +    u32 reload = readl(wdt->base + WDT_RELOAD_VALUE);
>>> +
>>
>> It is unusual to use a register value here and not the configured timeout
>> value. I would have assumed that pretimeout is compared against wdt->timout,
>> not against the register value, and that the multiplication with WDT_RATE_1MHZ
>> is done after validation. This needs an explanation.
> It was supposed to be a straight-forward way to check if the pretimeout value is supported by the hardware. I can change to wdt->timeout if it is better.
> 
> Further, in the case of wdt->timeout > max_hw_heartbeat_ms, shall we restrict the pretimeout to be larger than wdt->timeout - max_hw_heartbeat_ms  / 2? For the watchdog_kworker works in max_hw_heartbeat_ms  / 2 interval, pretimeout event may be triggered unexpected when watchdog is not pinged in (max_hw_heartbeat_ms - (timeout - pretimeout)).
> 

The kernel internal logic should handle that. If not, it needs to be modified/fixed.

>>
>>> +    if (actual >= reload)
>>> +        return -EINVAL;
>>> +
>>
>> On top of that, you'll also need to explain why watchdog_pretimeout_invalid()
>> and with it the validation in watchdog_set_pretimeout() does not work for this
>> watchdog and why this extra validation is necessary.
> 
> watchdog_pretimeout_invalid() will return false if wdt->timeout == 0, but we can't determine the hardware pretimeout value if timeout == 0 here.
> 

Sorry, I don't understand what you mean. If watchdog_pretimeout_invalid()
returns false if timeout == 0, aspeed_wdt_set_pretimeout() won't be called.
Why does that preclude depending on it ?

On a side note, I do wonder why the driver accepts a timeout value of 0 seconds.

Guenter


