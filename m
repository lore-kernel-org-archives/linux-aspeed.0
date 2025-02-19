Return-Path: <linux-aspeed+bounces-774-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13722C021AD
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 01:40:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyJxY3zDFz2yGm;
	Wed, 19 Feb 2025 12:40:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739929233;
	cv=none; b=LuPXCMN9FaJ4CD3eYm2TLDKHR9iZ3Rs7hxmPQ24dQ4SwpXT3qllSATDh0xUkpubLYMi0Y4fm5EwvAZpMc8nl5z023xekRd2+buCZ62uuRh8XAnVpPbDR8Z91LLX9Ue3CqdEkXf54UFzIufZmFvv+lNglFJtk9ye6svtnqlRYShrpC+kRSIBTS+Z+zaIIaH3QjHOmTOa5DvmSi6CD1nnN47p45tFf9NCuq2wV9MnXcUyd2qa0HJvzfxkk82Xrg8Z2BDZVoxkn5iqvd9NLDiNIjqDS5owAhnth7Xdh6A9Y1Hmy6ZFpfexvf1HYrYVZosXmW8x/FRO2+gKPNPh8NmwSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739929233; c=relaxed/relaxed;
	bh=UveaDOK1GELu+JWXk2Wn8uWWsbK7toAJuHOoB5mqWeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoDVNvETRRrGCV4bVyKUe97q1+V+voj3RHl/M60j3caKzFqkVWdmsBejKTriM/MuPXdgWZGXAjTQERsFRfFMC9dAAJO8w7BPWMl8L9H/XYdfRxGyS4X6yTzjlSTkY+MBRbqScYWnQ726lyc1lUvBYJUCuk6h5v9urDQA9RWgygnVHBNY5qGwAP2fuckqE2budD+QwV2HnC+lc6pfaw+0AogD58pLEFkMlYAc41Qi0jvdKBL7P0CaCp/MKSdOON7Gq/tO5Gl4+ftq6rx33XqWkbRdt78cJ+EkB+r8N72w3e3FcPoIPo/Jn0ilhg3DI9yJvHAiWICizPNvwzqJIT6wbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mo7eStZz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mo7eStZz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyJxX0tPMz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Feb 2025 12:40:31 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2fc32756139so6728721a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 17:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739929229; x=1740534029; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UveaDOK1GELu+JWXk2Wn8uWWsbK7toAJuHOoB5mqWeM=;
        b=mo7eStZzZvxzBhzhyO9v7NItoL42tuunfmQ7r6t2sc+BUYlsBKWOjUGcSBBPatLQIa
         zCfIlAV8JEc1+fr20wgdERgBUX9Gfe+QqYu3bx0igxLMcaxv/utGBqi7GD3LAyY/fEjF
         wFcidlsw1IRwIpfFmT4vH0PLURQ/zCTUmVftP+j4olXOIxRpacXJTq5RjA3GjKQulN7F
         135Yv+47MsAiuZosneXcLztpspuacxa8I4rhMHFxWDEk1+XgpXQvMOLwhGYIJMBsnxxR
         vG+GT8N13qXKx569KDdO7VXs23hJFJ8LxJQBBLpWxlQH/q5Q5moEqTLBKPHou2JVAUjH
         9fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739929229; x=1740534029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UveaDOK1GELu+JWXk2Wn8uWWsbK7toAJuHOoB5mqWeM=;
        b=d1XAOZF1vKSRAi2UlPXXc0imRm5NioYeuC1YsPI7XMO5F22yql5trw/Si+8vjaDdLj
         b83PyvQA18iF20ZLXrdeUFPDD4w67HtQtlEsTkogbSWjzDjQMCTzDbwETQWxkaH6rGZu
         R1xbM4jWJm7wu15a4gOK/DmO64QX02S1ROOHQdCPdWABx1zegB6IHZYtZq5JnzpZacK5
         SPf8J2aPDhhhCmt07zDkaoSkFAh4fqpim2hRvGtv4rD0yrBn0IXJ/1dZjGTjSq3PmfXG
         qN+rOp+lPbeJ3YAdSaTV0hixqClz7DS5dOhRFwrKkxdIuZjmfe6SGLk6DGXcedPcZByK
         7lPw==
X-Forwarded-Encrypted: i=1; AJvYcCXKj4COVXCzg+MZr8K4iXqeq0tBXRb7utLX9uuaVRg6GkCZrL8cutBVbggkKBl2yNCklyTtHZ8lRNHJ/Gk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytTcfAIHuQYdBU1S6zHVKUEfX1KdB/R7NvWvts6XLSf6K5+24p
	KtfwEXeLkAupd6PfxHpFOu8gwQA8DkduyEwQU/C3d9O7Sk/dBrai
X-Gm-Gg: ASbGncsj0g1pBm0hwkR759WDVy3JkDVeohh1Ck31xEtS3LYCf1tX99X7dC+r8ZG6krN
	JPAexCmnzJguSSGPxh6hkXhU2jfVsfqfGUpjDlDI+AjxOmuxOtxmXJyQW5AS9Fzl4WSN/RmE7+k
	aevrG1f2/Ui5fgp5FbtU00z2zuNxC4GoNV1xPqGVRzj+1/DIxe+dD3+Sm1Uz9Frggr/1MH1lzYo
	PXofJ3d015PZO8PPLwsKswYf9ekEs4Lo3xaSocbO1+tSTb2QK7Or9z0dFk7Duf0HVgxb6fZEVpg
	2iVepYZ0dlECtH3kEO7HCcfn7pq/rJNyhDhoZ/2f+VVDvd/0hqXKDpoy/gGwapOM
X-Google-Smtp-Source: AGHT+IE9UaJ2QOQPOJ5Simaetziy6vDR63wBY+ghsuug1DdKfXWz5pR7HZxMGQ22Oo1JEfoCMZTqug==
X-Received: by 2002:a17:90b:3b92:b0:2ee:d024:e4e2 with SMTP id 98e67ed59e1d1-2fc40d14ddfmr26976340a91.7.1739929229359;
        Tue, 18 Feb 2025 17:40:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b326bsm13031848a91.1.2025.02.18.17.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 17:40:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4602bffc-55b0-4a0a-9c36-ac391904d974@roeck-us.net>
Date: Tue, 18 Feb 2025 17:40:23 -0800
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
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Heyi Guo <guoheyi@linux.alibaba.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Eddie James <eajames@linux.ibm.com>
References: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
 <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
 <201b57c00043e2c3590c77a4d1aba413aa576b01.camel@codeconstruct.com.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <201b57c00043e2c3590c77a4d1aba413aa576b01.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/18/25 17:25, Andrew Jeffery wrote:
> On Mon, 2025-02-17 at 21:33 -0800, Guenter Roeck wrote:
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
>>>    drivers/watchdog/aspeed_wdt.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>>> index b4773a6aaf8c..520d8aba12a5 100644
>>> --- a/drivers/watchdog/aspeed_wdt.c
>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>> @@ -187,6 +187,13 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
>>>          u32 actual = pretimeout * WDT_RATE_1MHZ;
>>>          u32 s = wdt->cfg->irq_shift;
>>>          u32 m = wdt->cfg->irq_mask;
>>> +       u32 reload = readl(wdt->base + WDT_RELOAD_VALUE);
>>> +
>>
>> It is unusual to use a register value here and not the configured timeout
>> value. I would have assumed that pretimeout is compared against wdt->timout,
>> not against the register value, and that the multiplication with WDT_RATE_1MHZ
>> is done after validation. This needs an explanation.
> 
> +1
> 
>>
>>> +       if (actual >= reload)
>>> +               return -EINVAL;
>>> +
>>
>> On top of that, you'll also need to explain why watchdog_pretimeout_invalid()
>> and with it the validation in watchdog_set_pretimeout() does not work for this
>> watchdog and why this extra validation is necessary.
> 
> +1 as well.
> 
> Further, the logic looks broken regardless for the AST2400 where
> there's no pretimeout support. aspeed_wdt_set_pretimeout() should error
> out if wdt->cfg->irq_mask is 0.
> 

It should not register as supporting pretimeout in the first place.

Guenter



