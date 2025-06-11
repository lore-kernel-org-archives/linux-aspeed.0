Return-Path: <linux-aspeed+bounces-1387-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD8C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 12:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHQV73F3Wz2yMt;
	Wed, 11 Jun 2025 22:49:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749646191;
	cv=none; b=T9brgA31zpBF/5cX2XQxQ4MFC7KbkCB8MeXuN5qmnvhkr4hgjedQiFUn0liuOQ7P4nddec79MOtvUel8fb4Tw7Egif1Fn3XMg6tV1RdygvoWUGXfJu47Vd9c3+/T8AURUDr7H6Wg7sKAi0lG5cV1QASCLLzEVGlCYugkC+D7KoqB2NSW6xurjExqWuBEosQGvg8h0Gu83t0iwZKSTyAq/VhVfWXfk1BVdgqYzCjk2Q9lpxojeB+ovEw24U/5/zigC5HDNCsBMf+UZ9zBhvCCy7DvlAR/lbuKIlyyUiPfxGMEuXtcRLk/1erkc8kOvvxA0F/93Dfoc1Fn3ZljU/WgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749646191; c=relaxed/relaxed;
	bh=4X+42VVoffs25/5iRChCYikoLBRm7IkfNICMQoRWKIk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDghFb3xuDHMiWU8pExW4RdPYAby7/FrXEwlbk3gZFW81r8QD3GEHl1UNX9fdb2K36ez4WUJEiBpZPvb7Wh52XaDB4bhhH+cfq6YMKpuMRQy91RGSgl9ShRtRXtrTB6oM8XgDejbnFE52AiPwihHGLEZZX0vC8HBEd/2yAU/wGixhRtilxfLN/RAqGSTd8tmqKydIvbZDTC8vuqlyK76sMJdBwOp+uvQhLRzVlwXgAtZpSEJEDnv2ctoTlc2RtJNxhQwc3czUmFyo/fKYEkU7IrhYJLqkc1cUb3cgGov+sLXEpRqNR93Az+sdMRD34WXH9cXszyhm3nsZxh0/BSfjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com; dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=uHqQUiGS; dkim-atps=neutral; spf=pass (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=emil.renner.berthing@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=uHqQUiGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.122; helo=smtp-relay-internal-0.canonical.com; envelope-from=emil.renner.berthing@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHQV65DFRz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 22:49:50 +1000 (AEST)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 202FF446FC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1749646187;
	bh=4X+42VVoffs25/5iRChCYikoLBRm7IkfNICMQoRWKIk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uHqQUiGSYYsrv3KpNZIfbTV99aI5cCg21RN9waWYkpCKkawcfXUziQxgvU1rTFh9T
	 01FajHUTlGP1GHrWmkyx6+HZpOiQSEgUSrnt1gjDsYV0SdLuJGqICeGwe2druSHEF+
	 KJLhKZIakMAThwM8RTRW6ZxcSAN5UpQp3lBvnouU9x5mPTdc9SkpwM+DXuDk/qWr95
	 1Dz5ozMdq7SwzMUX+rda7WxJZ6qVMnLBBAum/WxmLestqm2kLP7RXMtDLs/8wXevww
	 uQnURKTZYqUjtMtMbUcFEB+U+AXCxDbcMXxYJ6qEZ3igsAizOW5cHjFwdSW15VThkc
	 DPQE6tafotm+A==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-60436c86028so1890960eaf.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 05:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646181; x=1750250981;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X+42VVoffs25/5iRChCYikoLBRm7IkfNICMQoRWKIk=;
        b=lfEPuBJNqVB8P0M51MsNRmOcB6YLV/ufWsCImV+pJksmSangemde7XNapuOJtmIpm1
         oCaqmXf0f08Os8tVDOCmjDxNCdMlZ0ujSwKi82xYDb+D/pIPXyLhhcYAkcIth3K5qIh6
         L61/Ewmwnark+Lbl5UrZbynerYzOR/ioDM26KYxi2uuneLWzXEiI6WvvQfCCbFVtg2I3
         recvtbBLkZa3HK4/FNrKBcPEBwiVp10Koh0VMxGMpzpnt9l9c9WwulGqzwxFAJS2quS5
         fQ868mpH+zMm5TO2AtZBlopZR1E2cMlrwagFSHwnHWmY6rTbBCv2/QaKK8YmtgJ7qC2c
         3tOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIt3ws+Uo16gAWft/JI14i/cKHFfhXW6xFvXG4G05c0lnJSdVhV/U5ewCVaoWr/yLgFWjOdTXqeW508ic=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHzJMkN8ZRjfnS8B99qAyES/OXRJyF1BisCnAeGbXj22yHPcHY
	KQKrA40AGy6h+9xW0ZvqZjxR2uJtgE0vratoLMhLNHwKxcygz42kzn8UdQWZD3nekud4Y5Fa/ea
	q4vfQMWu8i9MWEgSgR+j9KFu6kfDtLjAQ4AjP7DnysEtYGLAV6WW6ZEqVuR+Kzw6hDYedPtiyPd
	Fyt/7t2j0E9cis/6O2N1OT5OKFJ1Ocxn1FS4ENb6a8bvYTIxqWeTuD8UraRg==
X-Gm-Gg: ASbGncsZhfiWiKEgXanrfs1MTJ9tX2JyDwBYEXNFGKSG0JDl4L1xApxZ1AEFOLIRfWy
	wZre80znXRj3Y42CfEKAwPvDq1ukvnr2Z1D4a0/BJLdRQonbjx8NjLn1IgrrURptgJvfuQsDUaS
	TTFw==
X-Received: by 2002:a4a:edcb:0:b0:610:dff3:425a with SMTP id 006d021491bc7-610efbc7f51mr1462830eaf.4.1749646180986;
        Wed, 11 Jun 2025 05:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETnV/Jqo8g+X7qbKfoR1SGR2sJ6iPrYi1YRyXoWv3BlLfy+Wd2OtnAbWemjFYU/sz+rJKQnkUu2+FD/3Rbv7Y=
X-Received: by 2002:a4a:edcb:0:b0:610:dff3:425a with SMTP id
 006d021491bc7-610efbc7f51mr1462774eaf.4.1749646180562; Wed, 11 Jun 2025
 05:49:40 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 05:49:39 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250611-pinctrl-const-desc-v2-16-b11c1d650384@linaro.org>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org> <20250611-pinctrl-const-desc-v2-16-b11c1d650384@linaro.org>
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
Date: Wed, 11 Jun 2025 05:49:39 -0700
X-Gm-Features: AX0GCFt_vM7TwvXsEQ0TdALhpQjaiAX-QFHIHk6qjQ5EwAyWOMAoe6jaIhzlNQA
Message-ID: <CAJM55Z9t5n9MCCFfwzSWqhYojZk0Hg4wEQw5Pm9T1Oyy=EaO8g@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] pinctrl: Constify static 'pinctrl_desc'
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
> The local static 'struct pinctrl_desc' is not modified, so can be made
> const for code safety.
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/pinctrl/berlin/berlin.c                    | 2 +-
>  drivers/pinctrl/cirrus/pinctrl-cs42l43.c           | 2 +-
>  drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2 +-
>  drivers/pinctrl/pinctrl-artpec6.c                  | 2 +-
>  drivers/pinctrl/pinctrl-bm1880.c                   | 2 +-
>  drivers/pinctrl/pinctrl-k210.c                     | 2 +-
>  drivers/pinctrl/pinctrl-lpc18xx.c                  | 2 +-
>  drivers/pinctrl/pinctrl-mlxbf3.c                   | 2 +-
>  drivers/pinctrl/pinctrl-tb10x.c                    | 2 +-
>  drivers/pinctrl/pinctrl-zynq.c                     | 2 +-
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 2 +-

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>  11 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index c372a2a24be4bb80b1f2475ef8512171c8e1326f..e5a35b803ce66d247c5e5ad78e6677570a1add60 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -283,7 +283,7 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  	return 0;
>  }
>
> -static struct pinctrl_desc berlin_pctrl_desc = {
> +static const struct pinctrl_desc berlin_pctrl_desc = {
>  	.name		= "berlin-pinctrl",
>  	.pctlops	= &berlin_pinctrl_ops,
>  	.pmxops		= &berlin_pinmux_ops,
> diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> index 628b60ccc2b07dc77e36da8919436fa348749e0c..a90beb986f5bb707c54552e1333802943a4b04bc 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> @@ -448,7 +448,7 @@ static const struct pinconf_ops cs42l43_pin_conf_ops = {
>  	.pin_config_group_set	= cs42l43_pin_config_group_set,
>  };
>
> -static struct pinctrl_desc cs42l43_pin_desc = {
> +static const struct pinctrl_desc cs42l43_pin_desc = {
>  	.name		= "cs42l43-pinctrl",
>  	.owner		= THIS_MODULE,
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.c b/drivers/pinctrl/mediatek/pinctrl-airoha.c
> index b97b28ebb37a6ec092360f8ea404dd67e6c43eac..ccd2b512e8365b3a5af0bb223329f39119bc7078 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-airoha.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-airoha.c
> @@ -2852,7 +2852,7 @@ static const struct pinctrl_ops airoha_pctlops = {
>  	.dt_free_map = pinconf_generic_dt_free_map,
>  };
>
> -static struct pinctrl_desc airoha_pinctrl_desc = {
> +static const struct pinctrl_desc airoha_pinctrl_desc = {
>  	.name = KBUILD_MODNAME,
>  	.owner = THIS_MODULE,
>  	.pctlops = &airoha_pctlops,
> diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
> index 717f9592b28b51737e67aafc93664b1345511908..af67057128ff1e9e766b958fece9c71518c89081 100644
> --- a/drivers/pinctrl/pinctrl-artpec6.c
> +++ b/drivers/pinctrl/pinctrl-artpec6.c
> @@ -907,7 +907,7 @@ static const struct pinconf_ops artpec6_pconf_ops = {
>  	.pin_config_group_set	= artpec6_pconf_group_set,
>  };
>
> -static struct pinctrl_desc artpec6_desc = {
> +static const struct pinctrl_desc artpec6_desc = {
>  	.name	 = "artpec6-pinctrl",
>  	.owner	 = THIS_MODULE,
>  	.pins	 = artpec6_pins,
> diff --git a/drivers/pinctrl/pinctrl-bm1880.c b/drivers/pinctrl/pinctrl-bm1880.c
> index b0000fe5b31dfbcd6af6eaf0c01029f00cbd205b..387798fb09be51cabd5cb76e0d90a28b1d363050 100644
> --- a/drivers/pinctrl/pinctrl-bm1880.c
> +++ b/drivers/pinctrl/pinctrl-bm1880.c
> @@ -1298,7 +1298,7 @@ static const struct pinmux_ops bm1880_pinmux_ops = {
>  	.set_mux = bm1880_pinmux_set_mux,
>  };
>
> -static struct pinctrl_desc bm1880_desc = {
> +static const struct pinctrl_desc bm1880_desc = {
>  	.name = "bm1880_pinctrl",
>  	.pins = bm1880_pins,
>  	.npins = ARRAY_SIZE(bm1880_pins),
> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
> index eddb01796a83eb86c8c5bcf6788c999e8bf2926a..66c04120c29deccf53b21cbf8705f1d10c74ace5 100644
> --- a/drivers/pinctrl/pinctrl-k210.c
> +++ b/drivers/pinctrl/pinctrl-k210.c
> @@ -879,7 +879,7 @@ static const struct pinctrl_ops k210_pinctrl_ops = {
>  	.dt_free_map = pinconf_generic_dt_free_map,
>  };
>
> -static struct pinctrl_desc k210_pinctrl_desc = {
> +static const struct pinctrl_desc k210_pinctrl_desc = {
>  	.name = "k210-pinctrl",
>  	.pins = k210_pins,
>  	.npins = K210_NPINS,
> diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> index 0f5a7bed2f81b731714e3b65908df23f2ffdfd63..5e0201768323521754e7ecd27e878a81925c18a6 100644
> --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> @@ -1257,7 +1257,7 @@ static const struct pinctrl_ops lpc18xx_pctl_ops = {
>  	.dt_free_map		= pinctrl_utils_free_map,
>  };
>
> -static struct pinctrl_desc lpc18xx_scu_desc = {
> +static const struct pinctrl_desc lpc18xx_scu_desc = {
>  	.name = "lpc18xx/43xx-scu",
>  	.pins = lpc18xx_pins,
>  	.npins = ARRAY_SIZE(lpc18xx_pins),
> diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
> index ffb5dda364dc81808cfd5a168ce3f1e9f119357d..fcd9d46de89fb3e5215784109ba31b171fd15448 100644
> --- a/drivers/pinctrl/pinctrl-mlxbf3.c
> +++ b/drivers/pinctrl/pinctrl-mlxbf3.c
> @@ -231,7 +231,7 @@ static const struct pinmux_ops mlxbf3_pmx_ops = {
>  	.gpio_request_enable = mlxbf3_gpio_request_enable,
>  };
>
> -static struct pinctrl_desc mlxbf3_pin_desc = {
> +static const struct pinctrl_desc mlxbf3_pin_desc = {
>  	.name = "pinctrl-mlxbf3",
>  	.pins = mlxbf3_pins,
>  	.npins = ARRAY_SIZE(mlxbf3_pins),
> diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
> index 4edb20e619510b2f52c7cde41c2540328ec4e95d..129fa51d13b1e265b8145c87f19fba0e8f14f1aa 100644
> --- a/drivers/pinctrl/pinctrl-tb10x.c
> +++ b/drivers/pinctrl/pinctrl-tb10x.c
> @@ -735,7 +735,7 @@ static const struct pinmux_ops tb10x_pinmux_ops = {
>  	.set_mux = tb10x_pctl_set_mux,
>  };
>
> -static struct pinctrl_desc tb10x_pindesc = {
> +static const struct pinctrl_desc tb10x_pindesc = {
>  	.name = "TB10x",
>  	.pins = tb10x_pins,
>  	.npins = ARRAY_SIZE(tb10x_pins),
> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> index caa8a2ca3e681718fe213921deca8d130371b122..dcde86fed10db3e2dfebc19cb841ea7f63e74989 100644
> --- a/drivers/pinctrl/pinctrl-zynq.c
> +++ b/drivers/pinctrl/pinctrl-zynq.c
> @@ -1143,7 +1143,7 @@ static const struct pinconf_ops zynq_pinconf_ops = {
>  	.pin_config_group_set = zynq_pinconf_group_set,
>  };
>
> -static struct pinctrl_desc zynq_desc = {
> +static const struct pinctrl_desc zynq_desc = {
>  	.name = "zynq_pinctrl",
>  	.pins = zynq_pins,
>  	.npins = ARRAY_SIZE(zynq_pins),
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 27f99183d994dccb92aac81ca42228bdb9225e87..aeaa0ded7c1e5ee7f9c5e4113bfd208fb844ba7d 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -898,7 +898,7 @@ static const struct pinconf_ops starfive_pinconf_ops = {
>  	.is_generic = true,
>  };
>
> -static struct pinctrl_desc starfive_desc = {
> +static const struct pinctrl_desc starfive_desc = {
>  	.name = DRIVER_NAME,
>  	.pins = starfive_pins,
>  	.npins = ARRAY_SIZE(starfive_pins),
>
> --
> 2.45.2
>

