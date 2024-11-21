Return-Path: <linux-aspeed+bounces-162-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27581D75BB6
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 04:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv55m1gxPz2ykC;
	Thu, 21 Nov 2024 15:36:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732163772;
	cv=none; b=Tfsq+8Wlpzisuu/SLDFOm4QBI1M35MBJ6eXGa+z+paGONY52Bers+J8yMUiiVOuwOAKHSC4cN1fzWKKffJoc7aHv6twvAYGztdRAhIr1/2oifWPk6LFmntNir0i59hkSWKQWReibkuzr+h6C0khr5A6xo9KBlDXe2asuBKj/JJVyZVTVALZbvt6pYHEG01fHoRhsJTkb1xyzHOVxZWvl9g9vzKS+pfsDucgI2IHgCyNGbWY//BYOcvDHaHIAufwFXyUHwjOtCUq+iDfINbzzOasUqKKT41kViYPPmQI6EUP8W9KanW1b6tTeplf5bv2T1QAB2y2swR+Wmi1qxGa0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732163772; c=relaxed/relaxed;
	bh=1/0XIMY2uA6o6zIyzy4M5ULjqGepYEcYqaZjgiCOkJw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EjQLePF3isvs02o5S7nhpo3RhgPpSW9pnRdQAw+3y/CSBoFpd/o/Ieg/N6npfVGiPHJBF1PJK0vj4o+upfbe+t3YH4t1HtIFlQecruEWq/fUkzulb+zjeUIFhBx7PoLd3AM8joKCz1E2OB2SZ3vFyyCD1/iSk12cFwCJdzx+WlICwzL7j40BiHoBrmWloWDAbG8Yjn+gqQGbJB01MZZdxJov46CDZvvndd+rKt1WairtzgzdxPU458cqSNljrsk+KpV7VOajooGsMjRTRuRNlUaxCllJrHA8RVV6ZY2C01IvB8Kpcrg11Kkt2yx65i8teOkDcz/aquaxURSBJGYouA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmeVSJBU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmeVSJBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv55k1pQGz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 15:36:08 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso394604b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 20:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163764; x=1732768564; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/0XIMY2uA6o6zIyzy4M5ULjqGepYEcYqaZjgiCOkJw=;
        b=bmeVSJBUP+vUt7epwlA4kL5sTRJKY7ZLRxP/5aK/+Z2LH0jKsSLdQY63QxZgTlPh4P
         +IWRzMtxOSd737tb5ziyOd9zb1enVc+8gJRqrth/G7y/uW48sRRzTD+9C/RIYjOBlvzR
         N55+ytdhpqJOtWRHi7ZD+TWMzb+EkU0Fgo1zmW2ldgDoFM631kU9KcJ349m+kKqmwuP/
         nXkfg1CgzcBh9rhq3NgPYzKd1R1C8BGbTOqkw+MLt4d5QCMIfS9Z4mV5dn7a8DhbV8Rp
         LU1Ey8UzqAl87n4PrncDLQQ9GBkafmYY1JMvHbHDZdNNDN0fABFFfHFju+v3vFXC+gnc
         XgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163764; x=1732768564;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/0XIMY2uA6o6zIyzy4M5ULjqGepYEcYqaZjgiCOkJw=;
        b=O/K94bQdR2IPVulLUSdydPuCGUHtugAwOa7tvfA6NMpvJswFHZqNeaYHHklsMls5JC
         mWal25hdTufDEW+YnWGaQrI00GwjH87HbN17xm2nYI41R/Bhcpdo2vTut9J2aCYk7m+r
         8vJo/5Xurx+rCEwBGekUZp/5Ofca7oB5N6ic8Z/CuLlm19QcPl2m1lf4UgYRUJzsblk6
         bLmxAKD0XZ4f1qeAZj78LjIIJkAtvxh27PFLRx4o9Z0wELUdEzJjIPtNOw25ANe3FLTQ
         WElrAmEfTKkRiYXHkTJDaxQXoLuf+oCG2Dkya/pwCjNX/CmmQl8SzXrwFonpWcekUifg
         Y9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaKbNOXq7YXiYKMlC1Lij7YiZrXbu3fFyAangnFtVybUDscG4/DoYZzOhdcO3ykr+BvWGI4KkV8+QpbU4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyic1exM21xaybAbrzKJwJkAo/IrRyBeFQCfdeNflur7ys/OYSz
	LzZbk4f6xAKwl138CxT2T/CTJ3dw5rM0Vn+xgCvZfQcoiPuV/IvY
X-Google-Smtp-Source: AGHT+IFaemvzryO7WCLz5Ca6Xg1J+x2yyqw0JJSN0FkNyVQdTywTiZN7n88034g5Msg4VO8+oq5ykA==
X-Received: by 2002:a05:6a00:21cd:b0:71e:1722:d019 with SMTP id d2e1a72fcca58-724bed5a647mr6328217b3a.22.1732163764184;
        Wed, 20 Nov 2024 20:36:04 -0800 (PST)
Received: from [10.10.14.80] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb659fccesm393651a12.73.2024.11.20.20.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 20:36:03 -0800 (PST)
Message-ID: <b13e5063-3b07-43ec-a7cc-b19e73b7c9e0@gmail.com>
Date: Thu, 21 Nov 2024 12:33:50 +0800
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
Subject: Re: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
From: PeterYin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Content-Language: en-US
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,
   I believe this series' path will conflict with upstream due to 
version differences between OpenBMC and upstream. I will update to the 
latest version of the DTS from upstream and submit a new version 
accordingly.

Thanks,
Peter.

Peter Yin 於 11/21/24 10:53 寫道:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> Base on:
> https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> 
> Base on:
> https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/
> 
> v1->v2
>    - Provide additional details for SGPIO.
>    - Add adc128d818 device
> 
> v1
>    - Patch 0001 - Harma: Revise node name
>    - Patch 0002 - Harma: Add retimer device
>    - Patch 0003 - Harma: Revise GPIO line name
>    - Patch 0004 - Harma: add e1s power monitor
>    - Patch 0005 - Harma: fan board io-expande
>    - Patch 0006 - Harma: add adc128d818
> 
> Peter Yin (6):
>    ARM: dts: aspeed: Harma: Revise node name
>    ARM: dts: aspeed: Harma: Add retimer device
>    ARM: dts: aspeed: Harma: Revise GPIO line name
>    ARM: dts: aspeed: Harma: add e1s power monitor
>    ARM: dts: aspeed: Harma: fan board io-expander
>    ARM: dts: aspeed: Harma: add adc128d818
> 
>   .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 134 ++++++++++++++----
>   1 file changed, 110 insertions(+), 24 deletions(-)
> 

