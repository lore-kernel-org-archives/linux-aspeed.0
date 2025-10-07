Return-Path: <linux-aspeed+bounces-2404-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF2CCA470
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Oct 2025 14:55:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cgzhf514Gz30Qk;
	Wed,  8 Oct 2025 01:55:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759848930;
	cv=none; b=CzbjMddoEoAOKHajfLSSiOKol9mwOeWUNND4neOZkvwsw/etXlnLTe5aOjT+GXvMKjQKlJ+Jg5U44N4GYFeUnYvUetPz7VPeBJtsAzgZFUPUE1Oe9FdXRy0+Fd19E5uaVRNyo/u9mm1nL2mjBi07Tey4awjT49iLJSHLgYYmDDnvLeEbeX6zNjQfKVOlmCRqnnUViM9hsuQH+AEDpBGKxmR5iKrXD9Uu2uSle1xNPAfRDQW6S4OXXFYEnUfsJa6BsQE7pzJK4fFvWOQQq4ccJmbvhs5yeWJTXg2jEID0vcdeBp3o0pjUqiL7PRsagr52JFuwXuR/BwHrO9ATS1yUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759848930; c=relaxed/relaxed;
	bh=HkyPx7hvenwwKOYWFdLzbbOA8b6X1wKKeSXRsPSnnBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FtXot/rlCsCAaBjLbuDlzEF9l5mhqHotUIQDZGMS3uhEMIa/klokYbqix29jxrNp9+kxoXPr6R55Pezi2zjSbhKaVwJIVyXpiyJ1lWNtpZeDZaN2Qtil+7PIx8tlypgJhtZYcANVV0oRs8zSq0S/+7e7F6s05YrgPYugaKNeGZcySZgwp/5vnkeQ1VwlHhqnSobMgJNzqcbQQF15KMGovVjGXck3N28cUmyC626JFcl9MuJHRZAtswxF7QZOHmdqV85baqahxUNY82/RF705WJeCsOq2BXB2dWPaKwej+41oxUKx8drcwX3hWs6Z0aOySBgrCj1XaYyd/62Yldltfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Agdg7TJG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Agdg7TJG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cgzhd712Qz2yZ6
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Oct 2025 01:55:28 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77f5d497692so7003280b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Oct 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848927; x=1760453727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HkyPx7hvenwwKOYWFdLzbbOA8b6X1wKKeSXRsPSnnBw=;
        b=Agdg7TJG/o6afzFkEjBGzedjQj1dAwJI+W068jO08NkqffsapUlDQGHH1dGvl8bQtg
         QIjCku3HZypayThJEKlc4T7UR+bVmAKm3UBCnxumVqOrA9Za1dSh+C0etGfKFLLZ0Np8
         HMkD5EYCeLOkguyyVc+5jFq06quN6A2GJkBxNNuUEnL1JLzbLlLmpdIIp4G983jOWqjC
         t9TTDBaY627InTaORHYuxq4FXiQDj6wnonzJq7AOxmpk8pnbKOXmhpVfU4PzK+rahJbr
         bs31Jkkb+kk1Bzj8Heyz+qOOKdOllewor0aXUguqt8xtzAgpPeyKGZAAYT2KdVKyRbaf
         yM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848927; x=1760453727;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkyPx7hvenwwKOYWFdLzbbOA8b6X1wKKeSXRsPSnnBw=;
        b=c2U/B07LofQRNOpykOufwBipR7GaJ2r8MQlaI8YPy2P3ThfRcDNmP1cR3+Kt5Nh7EX
         2J2Xj/vXuv26ZivAXTkAKsMTriz9Lrzj2LY7/DejdRuVmWKUfqAw92wQNqX6hko5WF0s
         Rcb2IQgMVkZaKN5cVd5KWsIl0nBFSC8O0Yga2s4LY6njk1BpRuVruwltm2to3WYVhjrj
         nEckHcSyc/Tn/+sfTMAtUg5MyLyeyAg3RtyU1355z/Yg/77xkg9rL3KAQrfM/ArmjL9M
         d/gMiR5TMRJjeXucsCCfSdCjUK7aq8lewEl15e56Q5aaE2SKAnBu/TyK48A9yoq1+mln
         nkIw==
X-Forwarded-Encrypted: i=1; AJvYcCVxtezMeQS6UvcZ11zLEPOa/ONyFIvsVBuBkA0Utuwn9eyi3A+s+eYYSdc7Bq1vezZkmaiF960D01kcKk4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywbd5TCtmjN2m5qK2aAwuDTwsPfP5zZv09ppClYDLyy9JpRQrfJ
	2vpe7w+6ouiuTRrC9jt1eCTpCEuDbQU1ryamwM97PQtXGcrbn7mdVCoX
X-Gm-Gg: ASbGncttYH/FbED5WYJxA2n4tt+WUEeM0FQNiGgYxI9fh9+YA3Ajpbf5F7ovB+1Ej8t
	vGtlmFRinR7F0Kp2ZlTgppjSIO8QjXNPJdUk6PT1kceq3t5Mq0uVkuGwY6rQae61XUkt6M1pu93
	LN6h+FuzyrXGg/wscHgDcI9+eOuBKnGVeb4lu5HcPsR8xsh7by2FRCpuyMCv2cYxKe7XZEMIpgP
	vmPnbgkAkKuikN5PNdQEMgYyXnYV7WiCtkKa2Kuq0naj9o3gssscPEP/fLjmPEg5uE4/JFjiAD+
	wBVpkuMcPuHndX/twWqrPzmEOnMG8Hoy47cExMHsv2jJlF4OAKKr7Me2+EO4edkuEswmJYEb39M
	ow18v8kGsXkQLFUjOMUkS6xI29IoIQy8D0iuNAq1RPS1Dhn10d7jixjRT9TbP8jgu4INLKL8Iop
	xTot1v8aKsTK+dNdiwtWg=
X-Google-Smtp-Source: AGHT+IGdyeoXpxl1XmF0tLtlO/xz3iQ1BZuV8N6S1k1HOqZoXjG87A15BN5CloCPSK/tUguPJ8dO2w==
X-Received: by 2002:a05:6a00:14d3:b0:783:cb49:c67b with SMTP id d2e1a72fcca58-78c98cf84d3mr22847057b3a.32.1759848926898;
        Tue, 07 Oct 2025 07:55:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074663sm16035781b3a.74.2025.10.07.07.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:55:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83a90651-0b46-4c68-ab90-361422192e90@roeck-us.net>
Date: Tue, 7 Oct 2025 07:55:23 -0700
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
Subject: Re: [PATCH 2/3] watchdog: aspeed: Support variable number of reset
 mask registers
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, wim@linux-watchdog.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 BMC-SW@aspeedtech.com
References: <20251007083650.2155317-1-chin-ting_kuo@aspeedtech.com>
 <20251007083650.2155317-3-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251007083650.2155317-3-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 01:36, Chin-Ting Kuo wrote:
> Starting from the AST2600 platform, the SoC design has become more
> complex, with an increased number of reset mask registers.
> To support this, introduce a new field 'num_reset_masks' in the
> 'aspeed_wdt_config' structure to specify the number of reset mask
> registers per platform. This change removes the need for hardcoded
> platform-specific logic and improves scalability for future SoCs.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 837e15701c0e..e15f70c5e416 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -35,6 +35,7 @@ struct aspeed_wdt_config {
>   	u32 irq_shift;
>   	u32 irq_mask;
>   	struct aspeed_wdt_scu scu;
> +	u32 num_reset_masks;
>   };
>   
>   struct aspeed_wdt {
> @@ -54,6 +55,7 @@ static const struct aspeed_wdt_config ast2400_config = {
>   		.wdt_reset_mask = 0x1,
>   		.wdt_reset_mask_shift = 1,
>   	},
> +	.num_reset_masks = 1,

Looking at this again: Why set it on ast2400 ?

>   };
>   
>   static const struct aspeed_wdt_config ast2500_config = {
> @@ -66,6 +68,7 @@ static const struct aspeed_wdt_config ast2500_config = {
>   		.wdt_reset_mask = 0x1,
>   		.wdt_reset_mask_shift = 2,
>   	},
> +	.num_reset_masks = 1,
>   };
>   
>   static const struct aspeed_wdt_config ast2600_config = {
> @@ -78,6 +81,7 @@ static const struct aspeed_wdt_config ast2600_config = {
>   		.wdt_reset_mask = 0xf,
>   		.wdt_reset_mask_shift = 16,
>   	},
> +	.num_reset_masks = 2,
>   };
>   
>   static const struct of_device_id aspeed_wdt_of_table[] = {
> @@ -482,8 +486,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
>   		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {

... because the code here only evaluates it if this is an ast2500 or ast2600.

If num_reset_masks would be set to 0 for ast2400, the value could be used here.

	if (wdt->cfg->num_reset_masks) {
		...
	}

and it would not be necessary to add of_device_is_compatible() for new chips.

Guenter

>   		u32 reset_mask[2];
> -		size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
> +		size_t nrstmask = wdt->cfg->num_reset_masks;
>   		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
> +		int i;
>   
>   		reg &= wdt->cfg->ext_pulse_width_mask;
>   		if (of_property_read_bool(np, "aspeed,ext-active-high"))
> @@ -503,9 +508,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   
>   		ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
>   		if (!ret) {
> -			writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
> -			if (nrstmask > 1)
> -				writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
> +			for (i = 0; i < nrstmask; i++)
> +				writel(reset_mask[i], wdt->base + WDT_RESET_MASK1 + i * 4);
>   		}
>   	}
>   


