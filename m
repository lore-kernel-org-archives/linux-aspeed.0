Return-Path: <linux-aspeed+bounces-436-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FA4E77188
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jan 2025 15:20:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWJxW6cDVz30WY;
	Mon, 13 Jan 2025 02:20:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736695247;
	cv=none; b=ZflvZdtXEjD8ABV1r5EMkxm5rw4Al3ttmcd62oG7AhUHXCyffmND68C29STqPEUewDMeBY9O7nzgxvTCiikcy8Du0qZ5nSw3JF7UzBukaaupRm4fJSjCVMx95vkaKW+IbTdOEubSsVDnT2xLnTsU3aETAIhs2gA+Q1JkNZA/L0dvpepcFuaV9ANohY/DgBOlOU0pIen5GlPzRtarpCHHBQhnWeASbIx5k/Jrl6akZJtp8Yb0sJBbcOwB+p647qUPJ89zytOoWDBRfFETuIu1Mqzzz3WCm5LbLOXBUc6AQjnMWq4I6aLg49RPgy3Et+UHVeRz2rJhaVA/dUkIh7E0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736695247; c=relaxed/relaxed;
	bh=x3gG01/m+hJWTLZKxo2fthJ4fy1cfFaLbH+CW5D3uW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsgMOEsjLlNcA6Oq4EIrmB+ZVk5zhaYVIuueUbfqbqGu5RI9xKDQGLbAgtj7xSZ3W6WdVJdc8oEV5bFV68vrGaQjtkLnWMoOqxT9TNwLqCfNRvpeW3LHJxQD64v0980z8ixvdKdGKJr7TkHf1yJua0mY670lREUeOQO9fojYpOPSH7eA631OWc1YOhWcZNKQAcfqgPuD1FYXpaW9sznYhUSTalda9ONql1YkzRsLinI8NPPEAabUWTFLCECwJGbap/7oobySqphuctfrkivjnbSpfC+ksbxXBoxkNxdhEyHrTG2EOHpw6vBz1/mOx4Io9R/qQ2Fqnr2rsu4dAQvA/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TLPrEkvO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TLPrEkvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWJxT3ch3z30WM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jan 2025 02:20:44 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2166360285dso59143855ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 12 Jan 2025 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736695241; x=1737300041; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x3gG01/m+hJWTLZKxo2fthJ4fy1cfFaLbH+CW5D3uW8=;
        b=TLPrEkvO2PvmUlqJy/ALzzUxfXjnRGqPnypQg1xNxqFIaR9GE9T9oM3lvI5rN8UCks
         SiiTx7jabXY4cisuSfErbXbucmyO5bpoQzUlj222hMMsYGJw488wAw/E+jjzitYJMHhk
         1H/xN+SBhrnY6socODVEIehBsg7PLkZBgssUEXRs6zqePmYz8zJgY9MlVgQS6n2d0Tsk
         EUeoGjCzPBl/8+q5XxMnXVPwCihaoKVjrvBcsZyLebinvagUG9idT924AA3GNNtIYsSR
         T0tc9bfhbBEWtNSIlqCXD3mbqaLsMsGK9Lj+0nPKs4WiNmKjNLgOenRz/ojg0a8ZpovA
         nUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736695241; x=1737300041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3gG01/m+hJWTLZKxo2fthJ4fy1cfFaLbH+CW5D3uW8=;
        b=dXyyQzEbBI1jgggLOVS651mp8DCOUN3EjqCglalieRJuTxDzCn88JdCOvZFchowKvL
         tjzJdcoik5WLZMs98eYTgIkoLpii0TcjirKr2g5im6dvLdqtIMt39BdcPaq3fFMEpNkk
         0oa1jPOx0CV5C27fXLbuIJgUGx7QTni3uTYFss6KxqN4kt9DwDoB1P6KZswecpmwolx4
         ubkp5Wncgo397IypIkhK4jtURolEh7fFd9baOF/Aks4QBwTSrGjOtB3VAi56l5Pl80y/
         lpeP4OYzFxbdyJ1pJbUQTKz19FKRfKIQ3vnYH8KLOkpE053QjKFYPdtHY17KDTbzWqG9
         IgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0K3SoIPV/BX2SCOWFHoUXBGREtr4gUdwkROIrClJsUmYeoJCj7+KZrnHnOQxa8IAh1G22w8MzcqAgaI4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzxmtM+7zgIE5AoJ7AndoWCseIVaevoH5KkL5W5/4nEJgoPAwn3
	Q8BFfC8rucFwgPWGCZCEqJfpKJ9/dx6CbHlFyjfrq0JSsKfQNeF/
X-Gm-Gg: ASbGncsDySDi0umsf7qD/2UoKqJl2pDedtoo8QYEXYxyOMS624ZvgVv8Yqdq0XaDVCF
	Vk8WIgJICiG+ILOaRXu+u6fltrxNHMjfRgPkzA3tu46XGrFUbce05uLgHewAsISzUCvyWxeVof2
	4Ux/9XKwnnpVvQ3H6Mel17YOiC5LNmWTQRawLsV7RaoKA3vgcPC5c+wnp/uJe/lQSTjh1hHBnQT
	slq+tqIycC8pteE8jHqm15QmwCdksuqJs8tjockAGqMaqNw5XFlFCz72Nzjat3EglP41GioW6Rp
	d+mcrPj1x7puIULnACjO/QdSvL3OJw==
X-Google-Smtp-Source: AGHT+IF/FozhO9qZ95zF/Im7xp4vonQs2+URIZ8u5K1tRqaZZL12OaAezyRemQnpRDUXRoKN1pKXxw==
X-Received: by 2002:a05:6a20:12c6:b0:1db:ef68:e505 with SMTP id adf61e73a8af0-1e88d10e95amr29265607637.20.1736695241213;
        Sun, 12 Jan 2025 07:20:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a980esm4412502b3a.180.2025.01.12.07.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 07:20:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <42008fe4-8046-424c-9f12-e95a0471928d@roeck-us.net>
Date: Sun, 12 Jan 2025 07:20:38 -0800
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
Subject: Re: [PATCH v6 1/1] watchdog: aspeed: Update bootstatus handling
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, patrick@stwcx.xyz,
 andrew@codeconstruct.com.au, wim@linux-watchdog.org, joel@jms.id.au,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Peter.Yin@quantatw.com, Patrick_NC_Lin@wiwynn.com, BMC-SW@aspeedtech.com,
 chnguyen@amperecomputing.com, aaron_lee@aspeedtech.com
References: <20250112081204.263216-1-chin-ting_kuo@aspeedtech.com>
 <20250112081204.263216-2-chin-ting_kuo@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250112081204.263216-2-chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/25 00:12, Chin-Ting Kuo wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


