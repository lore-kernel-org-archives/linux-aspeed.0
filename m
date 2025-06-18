Return-Path: <linux-aspeed+bounces-1496-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825FDC71157
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Jun 2025 11:27:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMhKp5khtz2yFJ;
	Wed, 18 Jun 2025 21:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::135"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750246046;
	cv=none; b=WaGy+iUfegkE6dZxsUfsUROVMaYISkSz30F44huoxx7SMgjzkeMuPhvPfKoTykvzFRlyCmJSE6TGcy7YJNZwGsi8SqJi8LqgnoGc/W3tj6RC3pzDHg0+zowFwA5Ps1EMjmLUfbD2IPhooHORs4Yhsq9yzacHF0SHYHZu+xGuwFL1KOgCu6MRVZvk2LsladBZusF0KwwZScVg3QXK1VOumERgkG72ibwezPA7QA1L4tDdeQ3pznOQvS5v/kWnkaABsKQKVZeLNF7SAkOw6AH4DOuAHBg4EyR1tZgeEeaUe1qQbCeW6ZfGqWVZBXJC07do9Hbu/U57oVcy8z+rak/V+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750246046; c=relaxed/relaxed;
	bh=hC/rxmNEx7lBs7LXqlf7wlayqnKtYiiYbKP9iLo7bEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDnvzzSo5kKfF81AJyIpWedqaHoeaRB6opnaEglthNgzwGrbYG7TNVsqPtJSW1Zg0qqxXdVWnNGuTyvarW72q2DYHYPdF4xSv1IcdaOUhvc0SdwE+jrGD3vDZwBQlOH0BU6gJzzDYdZD/uow4LeGElnOk7iev9EiPhtnehKW8wuPGJcaIzBYqAk/UcbYEioKZec6qj6FzEmin41kAYFnrolVh3ReK8bdsbQT2V6YPy4LluOtg9ugK5nq1Nkp3+WdBtuN6gzXTMMHWobGKeYtBo2c4RgMH3JA2gk9ktbR9fgWLnB5hzMAa7rxSU5KdR8kduRO0wEQ9PfsZjBgTQf6Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u47ObV8P; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u47ObV8P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMhKn2jCwz2xPc
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 21:27:24 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6958772e87.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750246040; x=1750850840; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC/rxmNEx7lBs7LXqlf7wlayqnKtYiiYbKP9iLo7bEA=;
        b=u47ObV8Pj7Blj3fgiensixnPrk1fe5wOS8VXef+bBSb8h5gr9/dFmOETXq8sxChAqG
         GYaRp/T672lmKFJIM2QMhkkcmuoOw7HThu+4BBtxYzUwhoZa00D/pyn/RONuYd+23bb8
         Tpn4BCyPTgZV/CRgPUZTrkFf0JEr4otCHXBE4zR418n4uzutYrtaEFtRyEvMlp+Pxdco
         U7jxPU/+ldV0FPCNrErvrHc1rdryJrnxV/9mqNRvXyjDnXkYRmKw20dukaCbU0fT79rZ
         FTDe2eSpSGGjme93qm/QAMTtcDOQbVQce1EqKoydNWYQWCPWdn57E1Jr15d/0D6bkVh0
         orwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750246040; x=1750850840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC/rxmNEx7lBs7LXqlf7wlayqnKtYiiYbKP9iLo7bEA=;
        b=KISStYDkaysAyVMZdPfrmTodgSvDRWSqN3piW0ciDPsk67CO361Gtx+r9fJH3LL6Uo
         cHxVc7LYn7OzH8QDBlwHzwAQfYbXpKoSx6i5fgOnQTFQEnKqr3snmb7lQbo0BBOSZ7Kq
         2wr7AIfJbgk+A2klGsHTNLmayG5jSg+Fvc04ly39wIMgJnhQYAMQH0k4XMWSVS79gtAb
         13cZpggrnvoTHftS2xpVezSuCXPq0O/70YPrHro9Tc7Q8wzIC6fai5i8Juf7CPsPjXMo
         PKCKb7/UmgCpSHzBE4rgcx9kkgF67aYIpszgz/v3tWU9+Ta8EzCpplCNyxnzr08Dz3u5
         fLRg==
X-Forwarded-Encrypted: i=1; AJvYcCUrqvTjkF05hOL2H7d/pWlwWiTacz6mt18eTnrhz44VKvEZd/kY/FfvXfXjOPd9KzzLi1JDH3LwOTaan2w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxr7O3WMt4YXjbL2lYjnZqH3M3bL0otSHy6SyLxAOJZ3yY/W5eB
	2FW/ZhxSg2gk2/D9TpD4gX+En2IL6CXg66vCSCZQFcypWoAcibRMNCWpK3q18ytPHqShtIhIu4l
	mSmQy09bpT+JwPL9kdAzPh2LNC3iAdGFGjnCW8mUZag==
X-Gm-Gg: ASbGncuP7yNoFgO7USsh4CV9h3+gt+3fr3SDO2dNGBVSJauGIEwSCwVYjw3Maw+0SC4
	MpGC725O61FBsI5V4QMQ0xJ5D0CQxGvzdmhSASi2/s5DEq/xuXqipr3wQbh0VlbkZIvWRfpSI1h
	VQXaqAt4Yejg7LvlHP1MNMz6PznSXwpXeM0dZ6UinlIMI=
X-Google-Smtp-Source: AGHT+IH9N3s8eV4QAoWcV3ZISC8T6rNpJ4leRaY7YHuJFlZ4bPXaxx7Hzh/4jfbIVAzp1tapzbe+4WLXZFpaeF/7BEk=
X-Received: by 2002:a05:6512:39c8:b0:553:2bf7:77ac with SMTP id
 2adb3069b0e04-553b6f15af6mr5016567e87.41.1750246040209; Wed, 18 Jun 2025
 04:27:20 -0700 (PDT)
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
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
In-Reply-To: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 13:27:09 +0200
X-Gm-Features: AX0GCFuhKOslIDouO5PgG3-FBiOJa3cs6VfF8AgbesblIRkK52-2f8uLA9uvwos
Message-ID: <CACRpkdb1YqS00tEeyAUTjjJ-EQQbH5wfE8QzZt-UFwQYCfNHRg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] pinctrl: Constify pointers to 'pinctrl_desc' and more
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
	linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Changes in v2:
> - Add Rb tags
> - Patch #1: rephrase commit msg (Geert)
> - Patch #2: fix/require dependency on OF
> - Link to v1: https://lore.kernel.org/r/20250528-pinctrl-const-desc-v1-0-=
76fe97899945@linaro.org
>
> Description:
> ------------
> In several drivers pointers to 'struct pinctrl_desc' is not modified, so
> since core does not modify it, it can be made as const.
>
> Dependencies/merging:
> ---------------------
> Patch #4 "pinctrl: Constify pointers to 'pinctrl_desc'" is a
> prerequisite for all further patches, including RTC patch, therefore
> probably everything should be via main pinctrl tree.

Patches applied!

Yours,
Linus Walleij

