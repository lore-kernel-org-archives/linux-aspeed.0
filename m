Return-Path: <linux-aspeed+bounces-765-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB6C021A9
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 05:33:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yxp8t5Pc6z2yyJ;
	Tue, 18 Feb 2025 16:33:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739856814;
	cv=none; b=Ja46Z1BdKezN+cOYSyHYryDw1M0sJoU+GijsTzX/lxSk521VMn9zDLqZ1DrUA+Ot9Hfum83hR8YuMNGNvI8peXqhGv5OCBnQ+Cli7z1R+xdxbFNSn+2/Xq2u+VCBKYhlC+VFKOM1xx6Oqxu0VrzmIVFW0Q3pv3imhtdfuB1PWDCWZTVR8wVZxSZ9Xy8T6jnqdjOSENUZdjdOutmM11Dk751WGbJWR6MpL41akZSgCCz8U5WMOLVMEfEbsX6wRGttWHk7XYlwF/GPnazNDltaBR4TL3brAkXK+W0d5w4WUEoWT3APUZMmg2zc64cvyfvFlYJISM4I02wdulx1HX47HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739856814; c=relaxed/relaxed;
	bh=ZIXUg8SbRufb036zZV3HGnjlaTM/TH+KOn8o/6auPy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV+gr5LibnCYQlP6rkdBnI1drPvct/ZJBUjO0fmFDrmnzkCSJqNn1+/k4+hLlct4Us2veZXY48kwLoMnfqQFuQpD5FI81LbK8BtGo1/isSvEj3POzCumZt3JD6NLeuU/RkLjPHYpwq//8Vq2ksYY5hAXQv+vRzE7+yAUb13rT/DPS/K+nLKoMj3vYdEFBWovq7qknjFNQPWcHkCSxy3UwUpkNdbahuUepPxGbgcZ2NJs02MHWOTxOCRzt2cB4knApLaPq2ALtJOtziJ3kSwIm1PA8JccE3rJywcLu7xAi6+ipxQUxNB/1i/zrFi+wlwdVgCMCg4yBLMrUcNTdVe/wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H2KWQW6u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=H2KWQW6u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yxp8s4JlGz2yvv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 16:33:33 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso9414991a91.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 21:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739856811; x=1740461611; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIXUg8SbRufb036zZV3HGnjlaTM/TH+KOn8o/6auPy0=;
        b=H2KWQW6uYq2102O4WC5PA+MEkOEMP6cRLUkfsGa8EC3wQmRcO1WCeygD0lkyB7LYTv
         C2fIre7PLzA3wvCDtcQ6H5t0Fwl5x65KCB+17o3ts57St2mbiyi8nxFYPnKSRghutpt2
         Q+I5bE1L6tZD/7s0UD/5t0QmhNls1Fl4vwyTRlevP1uPRqEsMU5MzMd5MaWdlpkOmgbT
         ebXUrja8JyjjmQ2O7AxfPZyM1/RrXeGbueSR3r/8cnmARwOUDIj3halmRoWusJT0B0c0
         6IPFHJ+h+F9jYzgP+npmwU7hReDo32sge7oDRttbiqmCKnK4cuVnErp+w4iH1hCH5iKi
         5h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739856811; x=1740461611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIXUg8SbRufb036zZV3HGnjlaTM/TH+KOn8o/6auPy0=;
        b=uFHBiNd+ufHegoxiK2eozv1aqIqL9sWDBh77sXKyFkL6iEfQ7Yb8CUw8XdMuSHlHjC
         i1F5yTzLoy+lsKCddCr/FzKHtdDxHln0QykV5Tj/OfkLrwtQHaa6MhIgs1hsNkn+Gqzb
         CwZddjliz4U1Kz0RZNsbIkc4/OfStKB6GVdbcktO12Y+bOhiwxCcSJDbNCMAM/7TyF8U
         U7B8JwjVaQf26YEqRQB7/AN1aqBNmkBiMSgq901wUS6hWnf0F+72FLy5AiMPXCF5ccAu
         YmOGWFB2XbsFMd4xwV24iJAr7dyMKjwfzRbmuwUry0q7HqyFasH20YzpKC1j/4jIi6p8
         V2pg==
X-Forwarded-Encrypted: i=1; AJvYcCWB1kWt7NW3CXdxL1LXjisTI78/WREtwnHnYIsr8Gk8fBaBQC5cQpaoJNi+2mbNVXPK9dSbnWiUgHgNPdc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5Q0VLkxdL0TaCwEZFuQBqqHVsem0YKwwjly0fdaZnbyGB9wMK
	KkpUfICsPcRHY0qgw8h92C0ba6DCiXBBrT+VCE7DXXQbCyjE/5jy
X-Gm-Gg: ASbGncun2g3dazuBdgL3K5cbVUa6BB836aBauU+IpFwLliHWFWbb7mogx3U/hvJSPiz
	Qf7vQj6lbp60f44S+iK6JEI/9wO8xS4vo02UQy/KKnBmds/PGbU6LXhqdTrQyugdjLipIf7DLny
	MYAvfOZX9Xf2YbxZLaPvpTHZrOl6n8m07qEV6+9MP22afiXEX5UYGy1JLDdpFUurj4mJx0v3IfY
	DNAzNxHo/bbNlPQkSyzH1+zV4GXjVWv4Oft7pZ3bDETXSdlI+m75e/nLESQDuI/KNW+cr1j9Xf5
	eBhL30NMECL/2a4vbEcZ9BMbL5g/gUVB/p8JcQ/pM4gSqDh0w4eFCoI1YrhDieih
X-Google-Smtp-Source: AGHT+IE3yaFBuZ3jvd/c/xksrjQzXgC2Ka5HLYonZdx0VSjT+fo54DpWdxFWB6u9LmDK+vl70/Lj3Q==
X-Received: by 2002:a05:6a00:2e08:b0:730:74f8:25c1 with SMTP id d2e1a72fcca58-732618c0351mr16588841b3a.15.1739856811308;
        Mon, 17 Feb 2025 21:33:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73270de9b7asm4451004b3a.90.2025.02.17.21.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 21:33:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <50ab5a0a-b807-4bd7-bda8-7c6f4bfc76fc@roeck-us.net>
Date: Mon, 17 Feb 2025 21:33:27 -0800
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250218031709.103823-1-guoheyi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/25 19:16, Heyi Guo wrote:
> Aspeed watchdog uses counting down logic, so the value set to register
> should be the value of subtracting pretimeout from total timeout.
> 
> Fixes: 9ec0b7e06835 ("watchdog: aspeed: Enable pre-timeout interrupt")
> 
> Signed-off-by: Heyi Guo <guoheyi@linux.alibaba.com>
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..520d8aba12a5 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -187,6 +187,13 @@ static int aspeed_wdt_set_pretimeout(struct watchdog_device *wdd,
>   	u32 actual = pretimeout * WDT_RATE_1MHZ;
>   	u32 s = wdt->cfg->irq_shift;
>   	u32 m = wdt->cfg->irq_mask;
> +	u32 reload = readl(wdt->base + WDT_RELOAD_VALUE);
> +

It is unusual to use a register value here and not the configured timeout
value. I would have assumed that pretimeout is compared against wdt->timout,
not against the register value, and that the multiplication with WDT_RATE_1MHZ
is done after validation. This needs an explanation.

> +	if (actual >= reload)
> +		return -EINVAL;
> +

On top of that, you'll also need to explain why watchdog_pretimeout_invalid()
and with it the validation in watchdog_set_pretimeout() does not work for this
watchdog and why this extra validation is necessary.

Guenter

> +	/* watchdog timer is counting down */
> +	actual = reload - actual;
>   
>   	wdd->pretimeout = pretimeout;
>   	wdt->ctrl &= ~m;


