Return-Path: <linux-aspeed+bounces-2403-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5F5CCA470
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Oct 2025 14:46:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cgzV96Nc8z30Qk;
	Wed,  8 Oct 2025 01:46:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759848385;
	cv=none; b=SuAFE/ybCuhjuXyONPhm/LQtvC9ue2k5SU01TbhhVTwLVPWACMawbNQdOCZcfcTbA9y+kWOmqoZteEr+MdeGyj0aTyx0uW9LYRYfqiOXivuX5daPmaQA9Xe3GfnEorCkUdQl5pJQdkO5PxPK19U3U/AZFq5Zn8kZ3MXdvUQaQ1kWU1JxZSBfdH1GFMPLDVhlXaGlqglXyiBlpF5jlw4OclAxZsv6P1cPEgJwSAZSptY6SqTbkz+9gqf0uhZTKnVB2UiFw/wz8dbB/mw850h+mkaul3RknPD2+YGu8tIG2BL80Xfi5GEqHnciSvSyiwcoaWTgWd++VxuIheV+duMXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759848385; c=relaxed/relaxed;
	bh=x7a7yYa2BC6M94EJB0V15A3UsNpa5OhhLhNC4izb/8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WIjVSyE+ApnvrkSY2JtTpKvmZEvRVpatqXLIWM0d+WNHIGjUi2OGuJHIxzNMf5HMlrHUmaRQ6q7ph3ZTOZ7t9B+0vtUV+5ZK1RfHiTgLS2Cto3igxpe27O2q1XG/pjy0RlcElO/P0QVCjwWUJPGMUIZlMxmJh/LvqP813LuKibuYIVUtkW14g9JVjIg9FtEzdIK/GXxQ2+0r+UU+hzlvlf9Euw5aE0EBV/YZRtjuUoSuCS0OpPbBrLfWO3X9dI92UZRzjOcw2lvu8xsU+o0zAy5Ttym6CD8sEDiQAa8KoBqqG9lq4Kj2+b72dHNWREX7aZVBl0wg5ZoC4IxfdeuKVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LAJleiz8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LAJleiz8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cgzV805KBz2yZ6
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Oct 2025 01:46:23 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5961114a12.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Oct 2025 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848381; x=1760453181; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x7a7yYa2BC6M94EJB0V15A3UsNpa5OhhLhNC4izb/8o=;
        b=LAJleiz8zfow68raKhiVXZt2Rmt/Rmrb2Vycf/RE/f71dG+gRCCdTMGmsPuj2+VrJ5
         oAd/6VY4H/uUwqemVsLULc9q34sxYx2IcVjWwo2pxYIEopVMLVkboJIhFIYO0wwb6mQC
         V3nmVBeKxtm2PyitFMShPvFb5xhECUbBRAsXbtkwMsDXTesoinH+Z2PZYCXi1hayeoLl
         RdONlwLJIpj41T2VZC+/BHZc8znmXK4ZriqVB3xxGIlBYopLzPZAzS4+ywToRO0FbIHU
         e1gyIcpC6XYojdEbE+QKLEU+NauOwS5YZ8ELSgHy3gDzhrhRWOOPBKezRSx88r1DfgxM
         0VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848381; x=1760453181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7a7yYa2BC6M94EJB0V15A3UsNpa5OhhLhNC4izb/8o=;
        b=L+P7GJ4m5PUuPsbPxPeg5MyBHHXIOPZ/51tZihoP8hahNpcED/0uyAQ1p3uNp7rcCh
         aZ1iqwFkCY98zmUcimws1qU4Gmxa21mqeOq7m9AncsRZavdLc6yVM2CkYsOxoyICkioF
         s7unJG5UzFrouWQwPcckAVUf8jnlpF/iipufPYp+apHGRRKQPB3fU4jb1iCSvCtbHwBI
         t2dD1OYzPB2PFIjZAJOURBDIewpLd07wLROry8yEgGcMogum5t6DPLwsphksIU0NHyim
         Hjdn5DlyuUrntOCRkqDhRrX+GxGR40XaAjSjuZteuju10nWSwmu1xlHhocGsN7aRmtEZ
         HS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTzsWEQ4rrjgekelLS3R7zRuem12OSylbFDHpN0zozSOhhdyvaWj9kdYggP/Z8ndyeKO8HsJHk1QPPwOo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2eyiydOnr12469+RGm/EXwvRfXtHYf3yaksLF8FXURZCe6Pu1
	FDPEQCgUR3DMjbF5to1hJgvzwnjhzs4s21AiKnPqU3ILEXzLImg9EL5a
X-Gm-Gg: ASbGnctvSpgf3OdKe++XSdkOV2N51HAngp5rs6O589JAKBhZYrp9ol5LEgrT2WCEFFb
	DHlx2rR5FnQuywS5YFpyn/FS4o+vK6kmmF7ah9LX+j5LA2zPlxRO9gIHeCTWDwRO7ZWrRwFR5k1
	/ITctPAh83DtPk63Ziqq6Ahdvc5NaKoVRas68QXDYljC9Dd/5nBgqekDaiTQz9wgu77uJ5kPgeI
	KsYJ/e4t2AF55ShC0DNQOfrStYApc8642O9IB2NcWV0NebRLsNv8wWZehvo2MdKyy2Ku0z1A5ld
	AO+OJcnkgnFVGEj2i9nCiyZpd/2bse3v7QrlCSaqtzBOOsyEWGtIGbZ5YPRu6onuT7rZWWjIjP9
	M5iKsD3I5IqqA+ZlBM1+S4/aQPPVxmRSJdZfSwOXZ9JWBAJ9nL33it0W3NQQFe4plzsYDe0xwcD
	9Q7eR6LlQQMYHCaRHCVKI=
X-Google-Smtp-Source: AGHT+IHkTsFD9LWAFhO0iOSkzrJT/uIU3911ebutolUwZI//wZBM03f90uGhttRLUzWdNvxdYPBNOw==
X-Received: by 2002:a17:90b:180d:b0:338:26e3:ffb6 with SMTP id 98e67ed59e1d1-339c27b82c3mr23254788a91.26.1759848380860;
        Tue, 07 Oct 2025 07:46:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebdac1sm20685978a91.9.2025.10.07.07.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:46:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <97b3872b-7f4f-482a-ab89-5b345ea0ffb2@roeck-us.net>
Date: Tue, 7 Oct 2025 07:46:10 -0700
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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


