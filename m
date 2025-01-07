Return-Path: <linux-aspeed+bounces-316-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19869E77188
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 03:14:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRx3L6hwzz2yPD;
	Tue,  7 Jan 2025 14:14:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736219646;
	cv=none; b=MWhKu24E0JJjq+4ZDhEMP6yvF7mZYM5T4Ncj3Pu+nhRWLoiXoI8RgiSMqUASvqC/wb6imwVFShaf2CLUfDnxcVFCuqdnaqgpy7mduhjkFxicWctZWV5szdI71f/ENvwQWqgkpESUPdlnuNGLxiAHXUgsNVdXJ60MnKbxVA++V7MUV1Iob7cs4lWaALMWW+DFIwv/RLQgFGSOFPZpceKzVdb3knoDBeYgnNVb1wp5/ry6bKZs2uDFpsc/3nPimmGpT6mikDNrlq9tlaI1M1B/svyoQ5W600bXkUZj67dNm66EQQAnT7E3iPab1mn+qBMAeAeI6Una/cxz4jUPcvOXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736219646; c=relaxed/relaxed;
	bh=i51dHw5mNIoRaqgYOtjuCasI+NG6Y61PinKIFAENVu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2rkKUpyi4WMDO4eS7iKjBCacR9A1f/j43U77vB9hnyIi5Yf7+SoIkef4Iwp6Mxv1vxSmMgPl/QyGlkTJRH5ygtiXb2k30QslzFlxkEq4a3EfbTLV8g33v7z+ledVyodq6Zfr+UK02To+HuQube25ThSI10MtmzF2BqpS4SxWVyE66p1GTeSw5sM2At/Q1N9bUjHhcILEMq5rFsMvr+1K50EH6ztWDMDDJBd2M+kHrDZ2aaHVg4oBJjiHCiDXDpooERpoaZT73S4lalW5C9AuyLHqK/aPhnoyYtX3ErWmFFTlL59zCgy1fttABkoXA3JBcbAHXaprJDr9CIOKbHnzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SI/iwviz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SI/iwviz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YRx3J4v6jz2yNc
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 14:14:04 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so18785949a91.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 06 Jan 2025 19:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736219638; x=1736824438; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i51dHw5mNIoRaqgYOtjuCasI+NG6Y61PinKIFAENVu0=;
        b=SI/iwviz5dXd9/o1rL8vjelcv2M4RQzSdz3UIBaJJsQdpRPqJAaFORQSEYongY/5ec
         9r8px0LYz1lI08ae/esT32CV0L1375cXdBMzdOT0uovIMsGoOcqxXo753wKU6oJq6Hbc
         4RUwgO4xL6LxcfRrG//4qnYoc57NSMYA8ngff8ljVlxvpD95ToUu3eIngKe0vRl7iWEP
         ZDRPFEKitK+H4+1FgSK5HzK7aEiSCs/hCyzjZO1urMLhDblZPIsQXeJuJTcFsrHpO2m5
         zfvtLcZ4FTxMrlCfuLAxOFP6nQAzEGyJ/gjNDt+p/zJVUcIk1hBOsMSKUPrOJVoLA1Fd
         HYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736219638; x=1736824438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i51dHw5mNIoRaqgYOtjuCasI+NG6Y61PinKIFAENVu0=;
        b=l7o4x73MHTFuJE9rTUcTP8KxJXOCsqN/j9LOupoPLMRVkjhRtXXYZ2owfdoBqydiJr
         rAwpojHAF1TdWQLlA8MHlE2qAAi9F2a8xAkZiKrGcWRs+1amwW+W2klgE8lIoHqTwM2f
         MVQGWDTPYoOCnmeDxFjdQTAHOtbA+UJB56x7ziTNo8/zCZnEQRPIjqL9p7db7zrdWW/G
         HyYSRMfAcOxM5bce+na+PDEF5oDvAIBwDeym2l/1Cux8LmrkcN2news2jKwq/l09FhWC
         oTl8ixDe6L4v9MC6GwRLCkCD3LEopgbEH/ffUiQ/o2NpehOnXm1RmF+KEXycWbGRMfPX
         9tlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK0lqjkme859QjUErmFe6hx7n+PM5arhvB0GD+3sqS0S1Mm61x8qNsVMA15cu7KNUTzjR78ZgKkD7nSKY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGEsrSCjvJYk2YmyfVoGIOy2QkSoeufvS7ySl9GSTvl+LrCfnj
	grU8X6Am0j3S2SmTmGIoRpdf/QdGjCAW0DNW2rqisnHYGTT372NB
X-Gm-Gg: ASbGnctqIwt3qrvFdvLiSj8tC/cLufqMWYsBiagda+s1VPCycs96X4uNdk7+daish47
	jjgFY0XLVBbbFGF01Ow9P99E534t74CcHGawPetbzOxdqGSksmXZcy+4c3xTSZT2pALMSlkaqrj
	ZoGQOcmQi31z6vnK8FwTAEhftaoq3j0S7o7rL/dVFTEoRedy9vYvSgJVEhTJwsReOF6bhawEdH5
	z2YpuEvKrO0kuW/G8S4HdNDaCM2kQX02I/D2dNwkdmshbI9ncecbRrsJHFBKUfS/gepsqGAn6CS
	6DVN3UL2ULCZgIYabXCJxTEHIOtbnQ==
X-Google-Smtp-Source: AGHT+IEqYTX48WWwIQGYBpAj2HUYugaKpRU3ZceIzqDXA+cx39JjALuCANuONI/3tuRP80rX6if6iQ==
X-Received: by 2002:a17:90b:4ecb:b0:2ee:94a0:255c with SMTP id 98e67ed59e1d1-2f53cc20b46mr2398211a91.13.1736219638490;
        Mon, 06 Jan 2025 19:13:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882ad8sm34534574a91.35.2025.01.06.19.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 19:13:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <80b400b5-0dec-4643-9503-a21a35af5bcb@roeck-us.net>
Date: Mon, 6 Jan 2025 19:13:55 -0800
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
Subject: Re: [PATCH v5 1/1] watchdog: aspeed: Update bootstatus handling
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, patrick@stwcx.xyz,
 andrew@codeconstruct.com.au, wim@linux-watchdog.org, joel@jms.id.au,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com, BMC-SW@aspeedtech.com,
 chnguyen@amperecomputing.com, aaron_lee@aspeedtech.com
References: <20250101070116.2287171-1-chin-ting_kuo@aspeedtech.com>
 <20250101070116.2287171-2-chin-ting_kuo@aspeedtech.com>
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
In-Reply-To: <20250101070116.2287171-2-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/31/24 23:01, Chin-Ting Kuo wrote:
> The boot status in the watchdog device struct is updated during
> controller probe stage. Application layer can get the boot status
> through the command, cat /sys/class/watchdog/watchdogX/bootstatus.
> The bootstatus can be,
> WDIOF_CARDRESET => the system is reset by WDT SoC reset.
> Others          => other reset events, e.g., power on reset.
> 
> On ASPEED platform, the boot status is recorded in the SCU registers.
> - AST2400: Only a bit represents for any WDT reset.
> - AST2500/AST2600: The reset triggered by different WDT controllers
>                     can be distinguished by different SCU bits.
> 
> Besides, on AST2400 and AST2500, since alternating boot event is
> triggered by WDT SoC reset, it is classified as WDIOF_CARDRESET.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 85 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..1fae70b2fa6b 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,21 +11,30 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/watchdog.h>
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +struct aspeed_wdt_scu {
> +	const char *compatible;
> +	u32 reset_status_reg;
> +	u32 wdt_reset_mask;
> +	u32 wdt_reset_mask_shift;
> +};
>   
>   struct aspeed_wdt_config {
>   	u32 ext_pulse_width_mask;
>   	u32 irq_shift;
>   	u32 irq_mask;
> +	struct aspeed_wdt_scu scu;
>   };
>   
>   struct aspeed_wdt {
> @@ -39,18 +48,36 @@ static const struct aspeed_wdt_config ast2400_config = {
>   	.ext_pulse_width_mask = 0xff,
>   	.irq_shift = 0,
>   	.irq_mask = 0,
> +	.scu = {
> +		.compatible = "aspeed,ast2400-scu",
> +		.reset_status_reg = 0x3c,
> +		.wdt_reset_mask = 0x1,
> +		.wdt_reset_mask_shift = 1,
> +	},
>   };
>   
>   static const struct aspeed_wdt_config ast2500_config = {
>   	.ext_pulse_width_mask = 0xfffff,
>   	.irq_shift = 12,
>   	.irq_mask = GENMASK(31, 12),
> +	.scu = {
> +		.compatible = "aspeed,ast2500-scu",
> +		.reset_status_reg = 0x3c,
> +		.wdt_reset_mask = 0x1,
> +		.wdt_reset_mask_shift = 2,
> +	},
>   };
>   
>   static const struct aspeed_wdt_config ast2600_config = {
>   	.ext_pulse_width_mask = 0xfffff,
>   	.irq_shift = 0,
>   	.irq_mask = GENMASK(31, 10),
> +	.scu = {
> +		.compatible = "aspeed,ast2600-scu",
> +		.reset_status_reg = 0x74,
> +		.wdt_reset_mask = 0xf,
> +		.wdt_reset_mask_shift = 16,
> +	},
>   };
>   
>   static const struct of_device_id aspeed_wdt_of_table[] = {
> @@ -213,6 +240,60 @@ static int aspeed_wdt_restart(struct watchdog_device *wdd,
>   	return 0;
>   }
>   
> +static void aspeed_wdt_update_bootstatus(struct platform_device *pdev,
> +					 struct aspeed_wdt *wdt)
> +{
> +	struct resource *res;
> +	struct aspeed_wdt_scu scu = wdt->cfg->scu;
> +	struct regmap *scu_base;
> +	u32 reset_mask_width;
> +	u32 reset_mask_shift;
> +	u32 reg_size;
> +	u32 idx = 0;
> +	u32 status;
> +	int ret;
> +
> +	if (!of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt")) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (res) {
> +			reg_size = res->end - res->start;

Is this correct ? Normally one would use resource_size() which is
res->end - res->start + 1.

> +			if (reg_size)

... and then this if() would not be needed. Either case, if res->end - res->start
is 1, there are actually 2 registers, so the calculation seems off.

> +				idx = ((intptr_t)wdt->base & 0x00000fff) / reg_size;
> +		}
> +	}
> +
> +	wdt->wdd.bootstatus = WDIOS_UNKNOWN;
> +	scu_base = syscon_regmap_lookup_by_compatible(scu.compatible);
> +	if (IS_ERR(scu_base))
> +		return;

This should be
	if (IS_ERR(scu_base)) {
		wdt->wdd.bootstatus = WDIOS_UNKNOWN;
		return;
	}

to avoid having to clear it below.

> +
> +	ret = regmap_read(scu_base, scu.reset_status_reg, &status);
> +	if (ret)
> +		return;
> +
> +	reset_mask_width = hweight32(scu.wdt_reset_mask);
> +	reset_mask_shift = scu.wdt_reset_mask_shift +
> +			   reset_mask_width * idx;
> +
> +	if (status & (scu.wdt_reset_mask << reset_mask_shift))
> +		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +	else
> +		wdt->wdd.bootstatus = 0;
> +
> +	/* clear wdt reset event flag */
> +	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2400-wdt") ||
> +	    of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2500-wdt")) {
> +		ret = regmap_read(scu_base, scu.reset_status_reg, &status);
> +		if (!ret) {
> +			status &= ~(scu.wdt_reset_mask << reset_mask_shift);
> +			regmap_write(scu_base, scu.reset_status_reg, status);
> +		}
> +	} else {
> +		regmap_write(scu_base, scu.reset_status_reg,
> +			     scu.wdt_reset_mask << reset_mask_shift);
> +	}
> +}
> +
>   /* access_cs0 shows if cs0 is accessible, hence the reverted bit */
>   static ssize_t access_cs0_show(struct device *dev,
>   			       struct device_attribute *attr, char *buf)
> @@ -458,10 +539,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>   	}
>   
> +	aspeed_wdt_update_bootstatus(pdev, wdt);
> +
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>   	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> -		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> -
>   		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>   		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
>   			wdt->wdd.groups = bswitch_groups;


