Return-Path: <linux-aspeed+bounces-4671-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38416C5AD55
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Aug 2026 03:58:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJLb65sDsz2yqT;
	Mon, 10 Aug 2026 13:58:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786334322;
	cv=none; b=YTP6HIqhRFKz69qB5j3dLies8i28juHOKRLX4QEsjHwoMc8wIU7LNngfxe7OgQ9PsXLv//SddBc8QQ3BpI9KiirV9tZJ/oCAuf/sJbjAWM/nV1dfjrl+IBJlALbaJhzgtmRsYb9Dz3WG3m67dmVj9b1vMzUbIekAWminKBIVOzpQwoFTT2zdZQUpMiJdHDKQNEdoYY1ZU0Xbb24HrnCTsoqIbTX5ajV49S6e8obCIDwerVZKUYRTiq9H7ntex1Rnvl9id66ylLtMctTnyi8paP2FVWqLtHEUODmf5/B70FSNIx8xyXPYS3Agm+D2Fj34TI79haB22ZWJpEMXihqkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786334322; c=relaxed/relaxed;
	bh=QEU+pp4CCJstwvmXVbRVK0utyTpf3g/1fbsNABHVlac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILzfzZUkXcI0XTX4+p09yOQjbE6Q3XOb4JAJ/9r6LtQxactAbhlFAG5WkxtSWGRUr+37Yk2CUldK/82Nhkk0PNmaBJ+vdiGct6hUZcybPxEkCBugojEi5e8quFTi8kkqL8WRN0Z9xRdyBvfkXWZz7uGiLnZbT4HCmMVJ8LUYaFwBO3arV9ksMv5c671S2O2eWBBGkq5zmVSSZSQE4p9KKRST+7LT3dmtsT1b6sGJUVTojMPLuJwTzhFkAs0/yPCqDYX8/pW2I/HxlSdsGQWcfBdJFfkYDtx8e2vfuZt8s0rWtrH/1RMPuit3j98JxYHdAdtSJ6MFXAY3FwHgq0WnoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AnQOKpNj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AnQOKpNj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJLb43Xrsz2yqL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 13:58:39 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1186528a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 20:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786334316; x=1786939116; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEU+pp4CCJstwvmXVbRVK0utyTpf3g/1fbsNABHVlac=;
        b=AnQOKpNjmoErd5X5938qS7hhHJCIel4dOmjPsHmj/MFNIBqwxv9JnYJ59p1ipgnddY
         iy3Wei3Q1vlE3BGjGDUbNeKTkq9NcOyUP0HW8fygpZMWOJ/fb3K0zenIOpBaK4B0P9B5
         ngxa+KPSwI6Q+Y0c6sjjH9jPseA1R+jxwclb+IpXta48Vufsws4P5gxL2DteX5G/tCaf
         b+/F7QVkNxtSrqzURltwhAj5fVzfchoj9HLtaNizQU7g9GLxs8TGKsO/XwyEcIUfFceM
         SBjA4GQuI8uvpdNyrPcucU1SLWFD+SivzhPPcEdMaULgxjjWfyvHSeaDqRc4+E66VXHn
         xFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786334316; x=1786939116;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QEU+pp4CCJstwvmXVbRVK0utyTpf3g/1fbsNABHVlac=;
        b=cz+bTjsKKifV695S28Gd2c5dpUvfq1GM+zp1S7vNJUz+3aTdwY7MoJjOOgp1HjKmqM
         s6bbLsIfBOFWELzpfAhvLbHkdS9aMV5520y0FoYTxBi76ivnkh1FtwHcNGycCnhOpikO
         Tn6e0n4dSghdT8EWkE+aWFDDzQb2max2HhDh7n6T5dzSiOP3BBbqoV5qKJEeyuIoJSF6
         BPOXMldv0kGTgSa/Jil28L2aE6CqVwVThZFiPYRUdG4HS07UetCf+UWXkswKBfzOnQbF
         ganKqWD7vPfw6ESE96GCHFUGqwTNOPeU4NyCX8MOkvZSkYp9PMVfDYcIxl7v5xs5nqSQ
         r6KA==
X-Forwarded-Encrypted: i=1; AHgh+RpgxSGXTz1cHlCQXZKRqXCgx0Xw97tlRTL7ICuWHU55hjnQVzq8h+hlzG9iNFpTqn/BXHlgzu06phz3grg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvYBc/TXWWiBa8/FaFyGCIylaRoxu6ynC9c1Hca4lQsMvhQv+o
	MaTQqdMa1vwquFjs6611u6gjjeAB4/vRkUExS+Q8+lu081NYHGUmAfVj
X-Gm-Gg: AR+sD10C8f0nvkoaFW64AjVA3+dIGRgBEjfa77cReY2Y9XH/OVCAiZxtS9E/VTyujd+
	AMUBJuT2Q1saT1EGnRnVBI6Mr/7InjJgKNscSIlsbUe0fXpsP3z/b1ChlsJg3r/sx6W07lP+17V
	yTlJMppN7PXb4M3wzniXkD9ME+H3io8Zql7VQj/aogH5jm+zNLWzeeclCJvYJS0tejlYtg2Neyo
	lBDt9pgl3wLnL3uiK1yds2VNcIG6f+6WWXTGzm6ylPM78xJm5uo+7ckdFZfKJf+7p9gfZYFrYES
	PrUqirwbFbcq5rcARvzruP43ED+8iWgsLwub4hI+ma7hh/B7wGq/GYNXswNTY1ZlUYwjurN+BIU
	bWHykUzWSkuFXFBGIGHrOjpaoRgnvbszckAtNFLcyIp9nPEE/hWeHLOK4wcOe9bIuzfi/G1PWju
	x+NT3i1cSLj97BvYZxwEb83zB3tL/R8vdiD9QFA3LUcCmy55pxH3IolcwddZMvsM3CMbLwk3kz2
	3qnTy42kN3eNV7l1ePqQ7zWg3CxY9oEnS633FIvanz97tPY0Q==
X-Received: by 2002:a17:90b:5244:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-3903c5b685bmr38481045a91.16.1786334316290;
        Sun, 09 Aug 2026 20:58:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm41638500eec.23.2026.08.09.20.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 20:58:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
Date: Sun, 9 Aug 2026 20:58:33 -0700
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
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
 <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
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
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 19:38, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> Thank you for your review.
> 
>>> +             if (irq < 0 && irq != -ENXIO)
>>> +                     return irq;
>>>                if (irq > 0) {
>>
>> This if () is no longer needed.
>>
> 
> If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> passed to devm_request_irq().
> I see that the irq argument of devm_request_irq() is an unsigned int.
> Would it be safe to pass -ENXIO to it in this case?
> 
No, sorry, I was wrong.

Guenter


