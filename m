Return-Path: <linux-aspeed+bounces-197-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619BCE7717F
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:56:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8DXR5d60z30WB;
	Fri, 13 Dec 2024 00:56:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734011783;
	cv=none; b=ew0SKWVT5pSchWwcmD7qVp+RPma3QzBvmqk5EQZUuHOdC1j10oGe0j/KXNZGxQxoG8QuDPxtXZk0tH/cH6tFwSl0Fz1mA0toAGgyrvuO5kcEb5dHTZDlKfnmFW4ID0uI2nuo2lFPPmVctdhQNbHRSr/8K+NKkBxAz9abPSmc/bz4o+dQdkNRBgbJUApzrCpunYq7R2wy53yN6zH6wN+VtNnJlkwRj78Zkt4P+6YsB35pucKVT2HYECZ5/Qancu6KEEG8nxIRp0vTb7GVh6YervN5sDOGfrWnQ8mgCOCC9ksqS4i8vQnr/NAMVzSFTieJdehLyiCsCmzLM5uB5xaUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734011783; c=relaxed/relaxed;
	bh=e4O93T3nWN1CvVNDoucw7J8PWjYgMeFXCoydStFkkYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P3saWKmYzIfLB1oyzMjCTaVpWD/Tu8FeNq5eA+cBNZ9+7lEeR6B/qIbmH49n/TJLaMGMnhoqrCahtwuCZ14KSYj2W/Nd3tcPV6nEf6zqWKryyzpogEq3vmsi6tfM5B6zTmmfJ1x4V3Oe18Kk8fbuSlsOASPFWEXEjgb1qYAsMKLh83AikG+/gXAEF9P54d1wTnUxLVHFuzAbzn9UtXvwgUZHUOgASaAOJggtslysRlr/AE0SKz24JKDCrQ1BfF7gWBO0WrM1fLEzLrjSrAsTAXQBg6aFSl2j/GRd0nCfRbmm2VEUGugBgDRBYLNBVD/1KMQO45RWmE0z824UWJUvOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KjwkwKHn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KjwkwKHn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8DXP4djBz306d
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:56:19 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2166f1e589cso6675845ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734011777; x=1734616577; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=e4O93T3nWN1CvVNDoucw7J8PWjYgMeFXCoydStFkkYU=;
        b=KjwkwKHnbY4XCPULCopvzpgDWTYWlrrWMKukziBVt6yOLaJgFjgS8/Ba26pQYYKjTT
         oLUpTSl/Iar8Rl5WrNiwucU1r+FfGaKpP97Ciuz8Q/krXo1YGbopmaFU26Rr0gilL2IV
         o090huEqlzy2xG5N3ZfyZXnG83a9ZoZ9FzEJnZx89ZnQpOYKpjI/zl+DNitLRVJTqHcL
         r4la6KjYyj9r5GjBzbOEqRuKU0eFtt5oT61AHLf3AYyC9zNFdUzi0ijy6ei2oKS3Fuat
         SkB9ZhkUBL+hNTd2nnhMJfe9oPI80950OjnVsiL7ZgHxOJiMU1N47EuOiJlISd0WZF4Y
         hf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734011777; x=1734616577;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4O93T3nWN1CvVNDoucw7J8PWjYgMeFXCoydStFkkYU=;
        b=LL+Blz+IQpht2ADNcQil127pAI6kHFodp1ryocDu339G8VlPa2zId/h7aMEYtqm389
         19c8KW1dXzXzgbKSG78iHA6wSU6EvuZtyvmMt0MfrahHRnoOrw7+fNpSuvX/5PsaVryY
         XSBkB/bJ8Ze4F1KHjzWrwuIraJmE3wBdyWIlETBfoUAqlBS2cLNUoZ8HFaM4LPw9cb1q
         n9jYBEjCC7bUIcugbmz5x2YFQ6hWPf3IaTzWyfFhZSlBx7cUq3bJR4q+xHUL6GPGc4pd
         MfrWx3SCIyhvphqRfG4zflHbgQ2159l8hXO6sgQlkrKNhx9HGAV6tNjGMDWbbw064MK4
         AL0g==
X-Forwarded-Encrypted: i=1; AJvYcCUknk8UYR244PsSJgoaY1GJ0F49OP5Age+xtBfE/CLJGX3c2uKCZel8NWQ4tyCA8m1QF/yzMvSpGs5YTik=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyy1cM0u+g6Mi8hod1P0EX0ItkeuAI1NfCpbOXwFcWvGBw7Laa9
	THBDIdkrEi4TOKkXpKGyZurhcT2Cl6J6j8wQ1pGKNgKlBmtxDZKa
X-Gm-Gg: ASbGncu2cudxiIiyOSuD1SwaLxE0eezDP2DFgkkeJujyby1l/8QP9ufKQ1MzcWcn5n5
	SVmbU2PMQhWGzn6Cs4GaYi31UsZylsT7w9eXJr+EaxNm1cFmp/qOL+JYZ6PUyxjBOHD0I2vNT+z
	LaRXK/WWrZsI5axqR0kvfWSIq+VPKWMC3rJ6OQxij+K542mENd+OJMMBaHgxOEtBE/CaP/whqzf
	+VOc/M9x7VUi2dRvFWYyn2lu48c2bgXtIwOyIWJ/+uYnp9ywuz2uCJ+2Ka2639dPdhPSEnq8eOz
	tAkUJYHdA9g4bvO1FIExz1YNzvASKA==
X-Google-Smtp-Source: AGHT+IG9t76dpjEFCQdDLx6ycmXDuEQ02DE+EnhOu+AEhkJ/qd7d7+aSme/4j39HQkmI44uCAwy+5w==
X-Received: by 2002:a17:902:db10:b0:216:7ee9:21ff with SMTP id d9443c01a7336-2177899ae0fmr107634975ad.49.1734011777022;
        Thu, 12 Dec 2024 05:56:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21669ca7be3sm53985785ad.234.2024.12.12.05.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 05:56:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3fe75eab-e700-4ae2-984b-42342ec7d784@roeck-us.net>
Date: Thu, 12 Dec 2024 05:56:14 -0800
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
To: Phil Eichinger <phil@zankapfel.net>, wim@linux-watchdog.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241212113014.1075414-1-phil@zankapfel.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241212113014.1075414-1-phil@zankapfel.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 03:30, Phil Eichinger wrote:
> Since it is not called in an atomic context the mdelay function
> can be replaced with msleep to avoid busy wait.
> 
> Signed-off-by: Phil Eichinger <phil@zankapfel.net>
> ---
>   drivers/watchdog/aspeed_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..98ef341408f7 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -208,7 +208,7 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>   	wdt->ctrl &= ~WDT_CTRL_BOOT_SECONDARY;
>   	aspeed_wdt_enable(wdt, 128 * WDT_RATE_1MHZ / 1000);
>   
> -	mdelay(1000);
> +	msleep(1000);
>   
>   	return 0;
>   }
This is a _restart_ handler. The only purpose of the delay is to wait
for the reset to trigger. It is not supposed to sleep.

NACK.

Guenter




