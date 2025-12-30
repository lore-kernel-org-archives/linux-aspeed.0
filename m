Return-Path: <linux-aspeed+bounces-3239-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6C9EE0217
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Dec 2025 15:35:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgcbv4y0Kz2yF1;
	Wed, 31 Dec 2025 02:35:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767108923;
	cv=none; b=Cvnw/y9vgkXBO7CF8KB3xAmwBRL/Ski9SuFxV1oSnrIOQr7IyGepXV0G5M+swSGFX5ycngsojHiDkn+toJYQ0KKBbu8+n+NvSPgBHFvsqwDVGwmklk4JFPU9l41JdwkcuETND2O+ZkL2/nA79gq2g6bWyfdR6gz8Kkhg+19CY2B6+Duer/+K6by4DHPYMk/Ewxj+ulLlgvNR8aUyM5RbhGbUTdZqgyRal64iKixPLw0Xk+M3bOyzdNbpPzwIOyzPH5Pqcp5iaCzEEnqI/iVt5RYZUr3TLrnMJJfNh3nUqN+n+Z7OTcpkIYHWbttGC8aJcDsgCQdZna4jSL+GQF8tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767108923; c=relaxed/relaxed;
	bh=nXCQAS3HJRf+jQxCM70PqHXnYYGKX1vopCn4f1WZ9cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3ycEMWUWW+n6kvrTM4iaZFpttDDswdx4Q07Byop81uAoHMHCtcijiY56lc1D+7WABCcpkn4uhqHxaQq+lR56U5J5Dm/RNjMpLwz5lfce0axGn7PAbeZFLDpH1om1dCEd5UtIHpEZ8l1yQ2+CxLRPvSS2vjNnMRfUhvarQpudM7ympgT3CvdqTcP9vkhhotXV4RH3qEDV/3UazoFt3Lb04PZGi8+tkggsOcahFk7oQMSO8Kt+1KIbi5nFh76483ojVr8JRWBAd6cr4M+/vkJ7EHCHQCNi8F5y2IenJrYtWBT85GN5ZW/z42AyS+xasa/tJ69eQRsgaYZ6s+h2o7Vnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OYNAHmds; dkim-atps=neutral; spf=pass (client-ip=209.85.208.182; helo=mail-lj1-f182.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OYNAHmds;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=209.85.208.182; helo=mail-lj1-f182.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgcbs5DXhz2xs1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 31 Dec 2025 02:35:20 +1100 (AEDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b983fbd45so76667691fa.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Dec 2025 07:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108857; x=1767713657; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXCQAS3HJRf+jQxCM70PqHXnYYGKX1vopCn4f1WZ9cE=;
        b=OYNAHmdsB/xLSJqtrHEZv7go4EeEX1+Q61CqjahFveJDsxQDl/xqfHmj1h5cbMowum
         2wIbAZsdhdZvGcBqcR85gvqHBmZUxN81B0IpaThzWvVOXub7Isyqq94GOsRb4EfN5QdI
         8Pyq+6SBifS/5zH2z9oMPliK1BBgEvnRri+tFA/zq2WEJssbNTX0okU1HluhbU7SLyLs
         bJdPjC5ebMx8hxIbigeuwgdCLC0m6/S5sqRA5YNLFoYx9vIgsIWRAS0lzf1RhYhVgnth
         i9xuDBpvCweubBABZMlppijbiDotP++Fx5ARVfXRv26Yx8LA+aAQfpXUiQD2s9XWpriC
         Sd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108857; x=1767713657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXCQAS3HJRf+jQxCM70PqHXnYYGKX1vopCn4f1WZ9cE=;
        b=PqYH/nbcAfJa4d9VZd0dfiwdHJIj3aoo+OSaTjSA36XeaPGCp45yUGn4JV/DMOazmr
         BFbtH5iS0SjAXbjdPUnHE3Xt4ZM79w9PxjopwWu2T1W4jJtgTt8wYrUf9rOEZQ5CUv4H
         XOxnhF6GPQp+Pk2mcg0iW2+BE1uGJIV6pCFIr1NpuTxlEC1m2T9qmaXEqioYI7nd6/+R
         Y22QyXRnFRVOeiZWMbmJjVAFewbMD991NxvEsXe5leWk9Ig5Pm9yudY8rhcWP7WGztPQ
         4sbUuqBlbnNaNONHTVsZGR+jU1ef+DbPeHTo/HN/oiNyZYmULXInDnbMw/9Nf1bqgVAw
         +n3w==
X-Forwarded-Encrypted: i=1; AJvYcCUT049+Kk+XX1d2n0lCUGHSUFvK5ProGK12Jt5oxS0H59s09XZNYGfIReAshm8TmTYPrgc2cHUHIMjzixY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzkcDFaEaTBEBxiLBcwiQxV4ouMUSWOwp3QDJml3VoTFT+96wVh
	vqpbHiUc81beHOPR0U5MZNXnxO1hho80yRsk9Pnna9wV7DyOCdQRtY48Pez2TJzTWqzoHrz5pZe
	uBccW0NIgCfsBYIUezvxyY6AquNnsXbq3FuJTLsuxaQ==
X-Gm-Gg: AY/fxX4WcE3WpgzZYhFkxm7gqZL3vRk6S8fvUnZV8o2RJw5wbuVKDu7r849qfybC/Np
	C+NJLAXfwEzH58PXoL3BjHCgNTNJiUxs8SiJyZUXNBpZwtrPD4evQkrDn7wBywVDs9/A4S5itVG
	hWd24F6UzT6LhBm1L85JzcWCQltq2DlrE7hNI92FjkU+71Nz6lOW7OMX0yi7/2exGAXZ+SQpEiV
	kPTH/EH6KQRYVWSu4Dc2cCph9rnhzxTO/w2GtqWr4qs4Uyy26GqZ0xHEiJczlmqyM1Fbxb9x0sU
	Ut+j3MY=
X-Google-Smtp-Source: AGHT+IF8m67UtLFJYo+1Sd/5xP1asTd78BRhH0xaCX+pqytxUScESGkOS8OTTGNkp77INxT4etPPBh36TlR00OdBV7U=
X-Received: by 2002:a2e:a801:0:b0:37b:b952:5e2 with SMTP id
 38308e7fff4ca-3812158e6d1mr92229501fa.16.1767108856717; Tue, 30 Dec 2025
 07:34:16 -0800 (PST)
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
References: <20251224124431.208434-5-krzysztof.kozlowski@oss.qualcomm.com> <20251224124431.208434-8-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251224124431.208434-8-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:39 +0100
X-Gm-Features: AQt7F2oKPch5XI3ozINSBYMELnoLnRJYzcAZlrhoJTH7OcGc0z1qpY0CIewnVRk
Message-ID: <CAPDyKFp3X0EeiGRHLQqzE3vkVoLmOwi=1813S32sLTqXab43gQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: sdhci: aspeed: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Robert Richter <rric@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Adrian Hunter <adrian.hunter@intel.com>, 
	Joel Stanley <joel@jms.id.au>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Dec 2025 at 13:44, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

All patches in the series applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index ca97b01996b1..4296def69436 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -519,7 +519,7 @@ static struct platform_driver aspeed_sdhci_driver = {
>  static int aspeed_sdc_probe(struct platform_device *pdev)
>
>  {
> -       struct device_node *parent, *child;
> +       struct device_node *parent;
>         struct aspeed_sdc *sdc;
>         int ret;
>
> @@ -548,12 +548,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>         dev_set_drvdata(&pdev->dev, sdc);
>
>         parent = pdev->dev.of_node;
> -       for_each_available_child_of_node(parent, child) {
> +       for_each_available_child_of_node_scoped(parent, child) {
>                 struct platform_device *cpdev;
>
>                 cpdev = of_platform_device_create(child, NULL, &pdev->dev);
>                 if (!cpdev) {
> -                       of_node_put(child);
>                         ret = -ENODEV;
>                         goto err_clk;
>                 }
> --
> 2.51.0
>

