Return-Path: <linux-aspeed+bounces-1386-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC7C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 12:49:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHQTM1Bjwz2yDH;
	Wed, 11 Jun 2025 22:49:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749646151;
	cv=none; b=Vyr1PuWQHTIf3emhsmpGmItVUOhQgA2pyjw7RI5jqBZw6JIEt/EYtU9Fw57+dFsR9dRaZZp0L7fueUuRiSngKV8ma/TwNhBQ1O3nqd5EuT8wGjFsQaQH3p4xON94WubQUeXnmNEbwPx+OoYc984+d7/aBDoOwV1db6GmeW5pEklaLDF8jk7ZXrXAV//x/SBpFkmAURJeCwtmDIrUnBEGAaQHmmZF/EjSlqMpVHjqSIFzyZgBaMRmrbeZRe23ziVcIq8b/Hm0P18k/u0QtAsBuZrt/Mi/UHaUvAi/C73Rm94KvemMVCwhrcuiY3bBbzEsF+BJJd3w517TkuORBfryUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749646151; c=relaxed/relaxed;
	bh=bELfz3w2j893PNHUaLtbdQ42P6gz+Z983PYtPwmORCE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXzv8XUx58KGw9js+kGvR3WwN1zPMtN+6onE3PDnYxfUevnu2IkQH7WoHdyGHMORBH3MwPVYb6tR8uNX0JdhxVK328AHYrD8hjgdjqLnBfgu0fEWK1FANn8mPm5SWgLBA9RGYhZ5e26jAVxbxGyzG4zekGunhqZi55qtn8fs4v2KQQ4wmuv1bZMCBUkKEu0JSKkolpf1Tk910WaJJgKNaN1Qiv7F0eD/rcmMkR5jTwuInaG3bI7dGDoQL3NoK73NAoSJaKB4Xkc4BrVkUjzp3bVyhtF7iMo8zKmub2A/YkcPhW+YYw8zDgpG6N0iBZMrynEjDCnwMcYHVUuNlSASXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com; dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=a20UDsYi; dkim-atps=neutral; spf=pass (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=emil.renner.berthing@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=a20UDsYi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=emil.renner.berthing@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHQTJ42vkz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 22:49:07 +1000 (AEST)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2AFE744703
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1749646141;
	bh=bELfz3w2j893PNHUaLtbdQ42P6gz+Z983PYtPwmORCE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=a20UDsYi2qY6HfKd0ZzRlNFs5q9bSATI67LFDqW7k9VCeo8Pzz1ntvfqvBPk84gNS
	 TtvsigjkOUdlMnT6/2zFeVlbqp8YPC0ErnLHdBpT1VVyMKVajZALtwwN9Go2SlruAD
	 DgXbPSedT/bERJb/w+rtOuqMk1wlf15a5HDBgiVpFCNm9MjO/iX081rDvsNVaCrkI5
	 9/vuR7AWTgVC5l0yKeypcCULMzrnyc61ti6WR/2wm10LSob5BPtWE9Top8UeS9/CSW
	 fedML+7o8c/yamObmkxmytfqHfmYHEGsFDHrLiHDGm0Ke746QC3Y8HXqD1uR6QdQwu
	 sBGB9kituaXMg==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2e990e17650so5728921fac.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 05:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646139; x=1750250939;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bELfz3w2j893PNHUaLtbdQ42P6gz+Z983PYtPwmORCE=;
        b=VDzaQbgQxR0/1i2RO0ZmSWOCqjet5XDYmontyqz3djaWVePX0yTp/hw5JAxlXHGxmg
         jemst+10J0PScviKan9a6ilS/4ieutew8auAcp++b9PWVMvXvtIjTftN+N47gJy0c97y
         0XBnQWKM6bnhJszmR45tEsxVYcY3jtsFrntCTYHm7ZV/ZxFihUxUEXNZ/fRdLFoiAegm
         dN0ES4KXf8P65o80GOML6I0x36ykspATdMlF2q3a6LNZiHFFFCcIapFOZ1qVtdvYscKL
         t/0tL5Kl6d4Abc3iv7Jhaeam16/s4zuMPlliVEHXprrzIorUeFrwDwC42gghD0M5giIR
         YncA==
X-Forwarded-Encrypted: i=1; AJvYcCUaPV1U55g3pEAQ69zBcEx569+6cAbqSycGQqJ5s9QOA+PDx0lVqnVTlGQfnM7plZL8YvINR3Ozw/Tujec=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0L5MiwS+e4OAzui21NBgfofEt/kJ2cI8aBq7df+PWRuBhqHIJ
	guP5UxHGo9Yk6nWoSHM0G277C0lsopvsA4ZtTAxF25DzR84GaXaX7Vqn1DnDlZAm3PhxFb5eED4
	23ot8qI5cPuus6Yr759AZRSktJ2glmvpTJ+OHrY1nP7Quf+KmfC4LjDzhH9piZgRzf7dKcZHz1H
	Lkv9YmHfvkykG2RI3OthfV/ystGg0JzhFCLJznNPXfmQDcaYAjAVkb152KDA==
X-Gm-Gg: ASbGncvYLUxQ83B1ph2zAJihQ2lmAMoKogkI3ecdLvlhgb3vVRDxIBkvp+/X9Tfwc4S
	epDCHBl/kdpBcXKrQJaaU3l4bj+LHnGVW+5ebluzCpq5SLsXcXUOp3a3uQOpJm5JqzPuQVdE0dK
	dbew==
X-Received: by 2002:a05:6871:e803:b0:289:2126:6826 with SMTP id 586e51a60fabf-2ea96f18fc2mr1940868fac.30.1749646138984;
        Wed, 11 Jun 2025 05:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhqyM2kCCDhwaEPz02MLETIROTaGu5WeJENkIMCzCu3hfLe4ldyitgFfsfYyGdI6dZNlApiM1ratiR1ypk/k=
X-Received: by 2002:a05:6871:e803:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2ea96f18fc2mr1940818fac.30.1749646138634; Wed, 11 Jun 2025
 05:48:58 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 07:48:57 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250611-pinctrl-const-desc-v2-1-b11c1d650384@linaro.org>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org> <20250611-pinctrl-const-desc-v2-1-b11c1d650384@linaro.org>
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
Mime-Version: 1.0
Date: Wed, 11 Jun 2025 07:48:57 -0500
X-Gm-Features: AX0GCFuz_RtY5rxDREJdwFYXLGRQkyQfytWb3LifI1_It-SfpAfrMZfWta2TVOY
Message-ID: <CAJM55Z9WzsxWGmQYH05hSisigTRaHuKOn8g3AsLJ9h6Womy2dg@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] pinctrl: starfive: Allow compile testing on
 other platforms
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, 
	Lars Persson <lars.persson@axis.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
	linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"

Krzysztof Kozlowski wrote:
> Always descent to drivers/pinctrl/starfive/ because limiting it with
> SOC_STARFIVE is redundant since its Makefile doesn't build anything if
> no Starfive-specific pin control Kconfig options are enabled.  This
> allows compile testing on other architectures with allyesconfig.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/pinctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index 65dac8e387985ac7f865d13325eb903f64645a2a..de80f3ee52c40f3a817f229a751909c590161594 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -83,7 +83,7 @@ obj-y				+= sophgo/
>  obj-y				+= spacemit/
>  obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
>  obj-y				+= sprd/
> -obj-$(CONFIG_SOC_STARFIVE)	+= starfive/
> +obj-y				+= starfive/
>  obj-$(CONFIG_PINCTRL_STM32)	+= stm32/
>  obj-y				+= sunplus/
>  obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
>
> --
> 2.45.2
>

