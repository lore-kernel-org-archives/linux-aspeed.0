Return-Path: <linux-aspeed+bounces-996-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E33C282EC
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 17:55:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDsTT4PLmz3cPG;
	Sat, 15 Mar 2025 04:55:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741974909;
	cv=none; b=SSapO0/trSfQh9kBFigItC/De5M8Ve4tjJyl5Lp2Yq0zOvuM6OeHmuxQxcsGCtwCN7taLdH1zb8iXfcuQtszJPmKyi/ax9ub5nkH1U0GqeYKc2/QCtS0T51jcL5qPGbOBXGg2ibsUKt9TgiIYtEQ2gaG1OpPiRTcAdBCObK8gukfBTLZxtCuUUh16rc05Y+b0ub6KZxBp70cZ6A8yqOI3shErXyMPqb1xgmtGS963IpCTtJZ0Cazri22UIpS4+h6T8dsShpD3MDyWGsnal6luyBIGAINgEuSBg9Cxd7RnNZzZKWTNuVlz8b94etppPxrM0LomE3rjfsDY6T8eKYg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741974909; c=relaxed/relaxed;
	bh=GYuaoE2tpXVMoioaikSazmkTcaXhz8QWbIRrJWb/YhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wrli5EUAQ5bzbfWucjHUwy96Pw+B+KBq8NHUy0/tTD7xGbHm/Xn1LEv3Qyi+xE3UeoKVuRQtewnzrIt137R5B4EJAzDOzQmqIYVruuZYPp/VkYu3YjHWVvwoMMfc0PytR8OMIducQptclYNMSwXcBg+5TGf3+C/xr747FJj7TIVoEBPK85O7djGdFJhLZOSwzFOgVQW4WhxyegVOe+8xtq4605D1RIFvz410358CF26eNzjgig75RKOjvGVw9DA2DS/lq+TXgxk5fmddmcbbBfWistNqTkTbL21IBPoFqoevVzWm+gd9apmMRNxNJwC+dfgqqcktecPe86BYNJ5aiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dnRJ3d50; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dnRJ3d50;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDsTS6BDXz3bsM
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Mar 2025 04:55:08 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2239aa5da08so48904485ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741974907; x=1742579707; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GYuaoE2tpXVMoioaikSazmkTcaXhz8QWbIRrJWb/YhI=;
        b=dnRJ3d508+9fXHFcLsSxzFoniV6Fssd+a4jfhG11FG0lwUa7pXMt61h+8t+4+d/8Dy
         Jvgu2Y7gU780SewsfUUzbJ3P3WOD9APxajs2zTrlphk12NM5AX37u0QtQBewmTNwQbeH
         egfpWYedtDGMUz/FltUT29IU1ZTZpCuFPCl+S+2a7T5dSTaDTTTALv/WVrx0KoOagemr
         NHHYJnM2BCP0xNxKU0oclsy2baE++cu5VaHicVIh9fGhVEZjwT8nT6wgdyPO3qP7yWT0
         CEZUB5CBLkUzc3BmG9tqRy0Xulbfdi76Gw92kk4HAZYk/pIvap4v50u966+Jj5iCqL1/
         nW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741974907; x=1742579707;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYuaoE2tpXVMoioaikSazmkTcaXhz8QWbIRrJWb/YhI=;
        b=YUBA7HolSQPHgrKXXDNPJwNIhHvlUJrQYL9QA6VaoNwotbOAzXJNcAdojMI1YNvWeX
         WosAz/6U8CsTqEsdcyDhlkWO1PYPJmUIRlVQoULI9VWAbaR1zbissD4EUFC3CmN3QJMn
         ftZVuCndqcGK+4HAwF2xgmgOcdutpw2bywFFWcZrh0jo2UmqMIOMtAqXXUdEERU6kEOB
         TCUfe2n4UVOFMhBws6X9K/uxdn/ceaJT0LvFp+aXWzSJNRozmlYWeivupv8rcTO6bEhu
         5mpQFVWgQ5vGDFMkgjPAzVMT8JguPbZXc4ky6bMBAodIiu2I7XEA1kf83HrDxDjoNypx
         0oeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXhj1IAAdD379O8obP20O1sWfjqtIwZGbLOMiE0pdw7dKXqdc3PbMvnEejYMj0VFhR/51JBSIDILYtOIQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywa8Qfz1NdSLmklX0s1ozRBNmiVXbHyu/kvt2BlkXQDPcvMdz0c
	7ZMY/ZU+MmhX4733orgnFVNxJNoNBAfOeiNcb4j8uKIQ9tuEh7G1
X-Gm-Gg: ASbGncvEYLIFNJ5JWoCu/XVzFPznk8AMQPNbbRGhsYbNr654W3EnGkpheQ3WcBkFd86
	R7TZpik+8kFESBwXFe8/ZCy087qMatZi9LTzgMJwwB9VbA5BjhHB86n+NuUvctgOZrJiC/tJ1qs
	7dzPgBFTW0pW2oe8yzMUvZCmTXFRw2ZISYM7dIp+l89/RFDSGhXZtaPNEPmSZF00MfEmB8eEW9a
	IYZo/5p3fENfb00RIanq0m20kmECP1SNNuCuS9GZi56TVoxmCkbc72PclKUWGq6LO+EijykEy4H
	LBVMxeHVrGTiCwz1ZNpoW9Bxhp7vRoInJFQ30Wu1Xz1ORUF+s6urOyKy5C9sFxQoOXBq5bPfoTy
	SLjBU8/kNt04wf6F4hA==
X-Google-Smtp-Source: AGHT+IFfzffcjUeInESVFEr7t0qDIWD/oGmdtUB4ui/iRUi+/KiJTJutkbCHfIyZnt3dHb9VK0PZMQ==
X-Received: by 2002:a05:6a00:3c81:b0:736:3c77:31fd with SMTP id d2e1a72fcca58-737223fe959mr3608574b3a.23.1741974906924;
        Fri, 14 Mar 2025 10:55:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711559289sm3249490b3a.68.2025.03.14.10.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 10:55:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e53b32db-7059-4167-992e-d461a996b122@roeck-us.net>
Date: Fri, 14 Mar 2025 10:55:05 -0700
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
 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
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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


