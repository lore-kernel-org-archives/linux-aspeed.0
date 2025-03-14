Return-Path: <linux-aspeed+bounces-993-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B32C35FF3
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 17:37:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDs5124q4z3bsM;
	Sat, 15 Mar 2025 04:37:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741973845;
	cv=none; b=c/nVeOYbemHj1s3aF0Ly9+lv6d/JCE1Mb3XVsah6NZZAIQHgbIRdXiSMbYyLzpJxmO5pn15XLNj4zyDIwiNopkZNwe0KFZkLW22tkoRyiQ2faM8Ht8E2I6iGiDmTsWAI8EQN3yu4GoMIRy7UXLLp7EikhNBn8PxGSB+lguBCofzsuWGwhXW1+SSmTp8Zi/KYB62aS54fQp/x9RyORW5kMxIAy06UPfg9CvpaY8pueN1hVadfkqeB3G3ve64LDgknWQoKP9ebxEEIawJygwHbCixRMiVi6HotjOYDTQHV+YKbHTBIVlDku3DJ9A+rMxoFYngTW8xQ++TRsxU4I/FrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741973845; c=relaxed/relaxed;
	bh=dlPNsSQRPTHB22Ndp+VzvIgQN0PVNLvyrZ2jAW0mJYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oa/QkbFxaWNGQZftJuatMyVVZEQL0BwxnXW266ZGeG3Sq0QR7W4xjy6FKbsxu+duuyTzR0cf6w68ZS+IghO8fEN0MpVoxsHu9ijZ4E4ClXOnTUCvUzWFHAAEiI60kJyK3x0BoxgDe2CFIHdM/k9k3hfYJIo73fEddB/EmB7MKA5P5vRlFIBe4EQkp359LXT787TCds6vVMW3bHfqhnO4tt8BlLQkNmXeCr8b0oZ8CyFbTPB6SjftShk5dRTv6cOF+iRV3WDIm8+anWqr/EG4vUK5HTGbaLjgH950zrzwieXxnumhPHGYP+rWukMSDAGASZNSTRJB3f21btrYFlPf5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YFuqGdY7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YFuqGdY7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDs4z3km9z30TM
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Mar 2025 04:37:22 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2240b4de12bso64743055ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741973840; x=1742578640; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dlPNsSQRPTHB22Ndp+VzvIgQN0PVNLvyrZ2jAW0mJYE=;
        b=YFuqGdY7G27S7FoeV2UJ08LKAJbUaf3/t/IOkxpD06FZ689RzxMC19wQtPdXJ65gz9
         Wwaon/W1PgRW9L32pSEoPEJlo/JzgbZbs11C/KztwEm+BnaK8rS/mfDpr9/SnV8AEL/N
         kCC4enMfHBOxYCWzxpd9ZasDiY00CsJM1PeRmArjP7GyEAYIKOIvrKhakMtuM/ypy3zJ
         efVPskcqsFyxI40NZ+85pb0uziAa2sgHAwC84lk9FK2yZljKHYNGvCXfOhV6YShaKvAM
         y0zLnf8SSeLnzkTImJOJK38kDFjBDG10AayXMk8OUR9yPXLBX+CD99t2cuubb3hCKgRr
         E+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741973840; x=1742578640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlPNsSQRPTHB22Ndp+VzvIgQN0PVNLvyrZ2jAW0mJYE=;
        b=g6dOOT8VcASEnCz2PiX2Grfp/i+MgmvRSlzPFOqUEYIIytFvhacK6myaP8TNyInbDq
         BXaAPgpluRNg8JtqYQ0c7F8CWlyaLkotUGg8xZeVyMH25GZqUBUHOz4JH8IIfgIvm6nt
         ILsV8FUGtPHdI87sASnjc+XaPeeAfKiZpHjn0tv9m9BITawGCcVuSujAH74ws+kOKbj6
         YEh/RavuJR/xvkB6dG8HZJnDcvPKgjmlBkyx53wyXNEn05gaVXb6mwOQNm029AkC1due
         UFMS3fBiMiSwZRMlziYrvZdUW02XyWxU8iJilCbxy+bbaTENr+Frnj6eHN5cqrkJhyzk
         +WGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdn4bN+xTgPkSXRnNQgExicrexczdReNXoIeeLGuzZVjfXYYE5qFOcrzt48FhKqCR78Dc3ybmJa6GERxc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMHimQTWDHFCMEi43HYt0mcFPrHfgBdPW/aZ9Z6BrRqoyIZrwd
	9jxHmHdw3elVZbRTT0hu1QwRMCyrrcuQHb27mLbeXW7yBQ+Tbipp
X-Gm-Gg: ASbGncvTZak/J9rjJroV5FJ12zhKPvG4EG0Rmy0hk635auOufIch2J7OfnWJzV1Xgv5
	yAUPAbVGYmHLSAeKg6YZfbrOJ68c8Pa/dzTrITwFCyiAqqhJxORLzDFwAjpYHrHK0vqGfj39n57
	IXzW7JlNMVYploXbcCCrtUxvZUDUlU/DpZZILOwmzE9Q/rUaLm24qsgDQmRpqfr9ScDLXgr4NEr
	ThFTNEPxenlVDJjoaEBcOw1w4mQb+tzVeJvuXxo7sWPrinh+S85nUN1Jwi9InVnA4sGx1ne4Qil
	Cg6cZJJ4V8BGcqtFeFyLrH5JVbXlsxe5JRA4XzI9XOySWqOavTXOWcpBY2MALt1zhHNN/Mn/A+K
	wMMCqY8LS11ugqbb5WA==
X-Google-Smtp-Source: AGHT+IFizML3rPWYBYQ1V1FDTrUWu2FNB4+D28MCfjpVbIvX13A36EX+sYbjaqnDQpl7bfbEsig6wQ==
X-Received: by 2002:a17:903:4284:b0:224:1781:a947 with SMTP id d9443c01a7336-225e0aa0986mr38262895ad.21.1741973840125;
        Fri, 14 Mar 2025 10:37:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa5ffsm31198125ad.82.2025.03.14.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:37:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9ff3ba59-be59-4a2e-ac1a-5ce23b1b3fba@roeck-us.net>
Date: Fri, 14 Mar 2025 10:37:17 -0700
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
Subject: Re: [PATCH] watchdog: aspeed: fix 64-bit division
To: Arnd Bergmann <arnd@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250314160248.502324-1-arnd@kernel.org>
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
In-Reply-To: <20250314160248.502324-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/25 09:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit architectures, the new calculation causes a build failure:
> 
> ld.lld-21: error: undefined symbol: __aeabi_uldivmod
> 
> Since neither value is ever larger than a register, cast both
> sides into a uintptr_t.
> 
> Fixes: 5c03f9f4d362 ("watchdog: aspeed: Update bootstatus handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/watchdog/aspeed_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 369635b38ca0..837e15701c0e 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -254,7 +254,7 @@ static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
>   
>   	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
>   		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		idx = ((intptr_t)wdt->base & 0x00000fff) / resource_size(res);
> +		idx = ((intptr_t)wdt->base & 0x00000fff) / (uintptr_t)resource_size(res);
>   	}
>   
>   	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
Does that help if the pointers are 64-bit on a 32-bit platform (multi_v7_lpae_defconfig) ?

Guenter


