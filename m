Return-Path: <linux-aspeed+bounces-241-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E6BE7716A
	for <linux-aspeed@archiver.kernel.org>; Sat, 14 Dec 2024 21:46:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y9ftH5ky8z2yF7;
	Sun, 15 Dec 2024 08:46:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734212807;
	cv=none; b=PkcDMRGPsA1XjgOCpKVSw48RUNMUmKgJYSAclVTESmYsDaQttDG+aa4XO1ePffS3mGw1FNsScfGavu3I5i8zHn5rugtLKfcR9BGFDk+RYUxuOdoAmBD/+LREXXaNUUG+J/oy39GAkJnsRp6Go8GnD6drkS9KFcMek8iRM1yrPDQ7SBG/OC7bzm/4ABND32nzLBII1HyN4d/ZF0/wTjvmZPLPY1nsVQGs0mSPvhqsJqLogHXv4yq4Vsd9RjYTuUek2kHHcsp3tN02c5C+gb3+Ohjwx3+4jOZEQoPqrRGEyXIw03nhBpW7utG5vXV0qVW1s2ebu+ysLvvaZBWP4/8Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734212807; c=relaxed/relaxed;
	bh=6UvuuTwlUaB3Br+i87vUX933lDcfu6mE+mstWL6yF9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kZKnFif9tWwSx4FzV98uLNmveXq35MyXkJqQSmbtUHcNu+9Xa/3RW3B0qrkXShgRZ1yFIVhXqTm1h1/nW1y2bKFNuvd9Kpdz4egbQdAJAFW4jxZN2/4pOHP5qODa9R70NJCL4la9to3IB3yUgxHlw0Rt+8XN0CKzWFuIOwasV5FWWkTe8N8qghQ1++Y0g7PDI5iFdosDqaZy56GdeeIvLHzvD+86LjN6WrDgeHw3EOSXGACwh13czsXuD+YRROOrse6kyuGUL41eRxZJBgN2Ou2TzLStde1CCMGnN8g9V5owqQQxRIdmKvTK+K4PKhf5C3fpUySg5P0ZdUopsjyWHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NFgnaYWs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NFgnaYWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y9ftD5blzz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Sun, 15 Dec 2024 08:46:43 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21644aca3a0so33779775ad.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734212798; x=1734817598; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6UvuuTwlUaB3Br+i87vUX933lDcfu6mE+mstWL6yF9U=;
        b=NFgnaYWsPy1Qkiy+Ppvkm/pYtG05F6WvXwwE5M6h+fmPyZxVQawHn/LYPADH6B7N8T
         KhtBDKmLj9JKv0JqJKstgrdlJolNE4sov8N/Y6U0mxOJ3QJBMJfNy9qx+lVZ8ZCgyMri
         F85a/HuCk/QzwAE9kDWcP20gSnvdM9imF6eyWESh3q9YLMhnrdZaaK+vVkNZ8XAjlSid
         HQhcS62+UOaloz03doC7cUOaSQ1S4duQydokQ75vN3V4jA7powZfkUoXaS0TP4nnsz/X
         KEAQ1+0rx2jR1sE6dwrL0khroFy4WKPPoxRi6XdH487efdwwefpXBWxUD1Bfw4ZnF6gd
         FCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734212798; x=1734817598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UvuuTwlUaB3Br+i87vUX933lDcfu6mE+mstWL6yF9U=;
        b=gjYsVCWNMC5YDs55lDGIDUgV7/ntY0sqEK8J8kOYkCheJBXg/B0biBy0q8wdinIP38
         +wzsNlJ3hGFtHuaZJJcNDGzlnICGDH80eIRSN6bjwL3bbO2R0oZ5ZSl1m+nB0AyPcP5W
         MJASogAnyI6wijLs6y3Vvyd9E7p5z51JDxXrhCYNZIxYBpBxN3DfSeiY6TtAilk0Kxb9
         8C5UGbMt+WkqZun8uuk1pUmaI/Hn6SfibFf+A0RVKqS7hXV998I1vCNb3cgk6lZo8E4A
         UTmG4KhfO/7k9768/bWi1PfPrv/PuWvvnetcx85Xn64m13L9hsH/tVrebGGeSCvIm+S8
         +v7A==
X-Forwarded-Encrypted: i=1; AJvYcCUe3m2JqvNhtBrkb7tWef/2jIgAApmgIshFPY8sT8Fqi99dXDmoDyqgBDbNB3pHOtP8bGmgpP/CRkgjss8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKQxjJIb4kPOq5eFzgw9C4omEkRDhaozL9R18oo+PBM9y238Pf
	XzdkHUpErhtPpraEAJfe8ig5u6CO6J8KFZGVvjuEw6pL5LO7gwo/
X-Gm-Gg: ASbGncvMAT6TBFET6hujZ8bybQHOaGyYlfSbBbqb0A0SO4BWxeQuYCP4HOtM4rxnfnT
	UPd44pEP/NovinRmmDdo/2yPQBtUozt6+qZUzLk88t1E4ecA0LUHSdOzY1WboeIHx8ymcD7JHed
	A4j0HhnbNMdWrFhX8voDHTH3qg97flr1Q2wHdFNE8BC8bHRKjUJUFNwg2Pr5CNoG+/3b52e2DNs
	PSz8bMe629j+MDJZGfvUmotMvjJPwfjAD/HrX1KSYD8ysoOZUdoEcWqkHMRak0FFYAXcvjhFAJW
	keJywQ6zDgRK/Go10LZdf/0YN8hX3g==
X-Google-Smtp-Source: AGHT+IEZPwXuT+jhvGafA+HbJxXjg528LE13RpAPOnkGSYOwMGLuNDL4Y/sz5BWORDDjKyhDUEn2SQ==
X-Received: by 2002:a17:903:234d:b0:216:42fd:79d2 with SMTP id d9443c01a7336-21892a52c51mr91855615ad.49.1734212798464;
        Sat, 14 Dec 2024 13:46:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e4ff7asm16770315ad.134.2024.12.14.13.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 13:46:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <927f2063-4587-423f-8c75-441f55e17671@roeck-us.net>
Date: Sat, 14 Dec 2024 13:46:36 -0800
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
Subject: Re: [PATCH] watchdog: aspeed: replace mdelay with msleep
To: David Laight <David.Laight@ACULAB.COM>,
 Phil Eichinger <phil@zankapfel.net>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241212113014.1075414-1-phil@zankapfel.net>
 <3fe75eab-e700-4ae2-984b-42342ec7d784@roeck-us.net>
 <d7ab80332def4a328cb9492fddcb8bef@AcuMS.aculab.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <d7ab80332def4a328cb9492fddcb8bef@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/14/24 13:21, David Laight wrote:
> From: Guenter Roeck
>> Sent: 12 December 2024 13:56
>> To: Phil Eichinger <phil@zankapfel.net>; wim@linux-watchdog.org; joel@jms.id.au;
>> andrew@codeconstruct.com.au; linux-watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] watchdog: aspeed: replace mdelay with msleep
>>
>> On 12/12/24 03:30, Phil Eichinger wrote:
>>> Since it is not called in an atomic context the mdelay function
>>> can be replaced with msleep to avoid busy wait.
>>>
>>> Signed-off-by: Phil Eichinger <phil@zankapfel.net>
>>> ---
>>>    drivers/watchdog/aspeed_wdt.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>>> index b4773a6aaf8c..98ef341408f7 100644
>>> --- a/drivers/watchdog/aspeed_wdt.c
>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>> @@ -208,7 +208,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>>>    	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
>>>    	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>>>
>>> -	mdelay(1000);
>>> +	msleep(1000);
>>>
>>>    	return 0;
>>>    }
>> This is a _restart_ handler. The only purpose of the delay is to wait
>> for the reset to trigger. It is not supposed to sleep.
> 
> With the recent scheduler changes isn't the code likely to get
> pre-empted?
> Which (effectively) converts is to a sleep?
> 

This code is called from do_kernel_restart(), which in turn is called from
machine_restart(). I'd think that the kernel has a severe problem if it
decides to preempt that function.

Guenter


