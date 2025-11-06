Return-Path: <linux-aspeed+bounces-2798-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689EDCCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:23:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2SDj03B3z2xS2;
	Fri,  7 Nov 2025 03:23:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762446228;
	cv=none; b=HD8I9vRzwQnmP8HAgtSPQB8dsfWtwR+uUyyDQqfoWqn5MpqQjkgicgT6nyZf8tZ/xN6603/a4ZgiTrzGuf0V2Zf+I8aZeU/llmsoH7RnApImdkRHRCyKHet+Ybo2Zb5gMIQZbjZ7YnyWOvILFcsjyIiJNqOSHab352Ssei8rQEK+OSIluqpOVx9sNrLC3TQzBK4VZWT21o+2WTuXpYByxNBVv6v/s91Ey+IKnvXTsplzuOa7RRqfMTfyMkn6kWxheSv1rb3mqhMmEzrxeuce/7q/2Poy94yjkoxotzUSxUnmVeTE67IbUNfwP4wcrALAtADYCRsoHRvFwuWZoOkoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762446228; c=relaxed/relaxed;
	bh=R8aL6w1TYvGrl1UBIVVUpuAsDW/dJzd3vY+/verHnfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dATag1s3/Dd3n9IwBJwFuNtQo1PtLrgEm6cY1RErL+dSLhL6MW1vQxKUF/3p0KsYpHSLegdIAR6welI9+PZmvtRIXYaBopDIFD15C21D4kFNdFwZ44+/gNa21KwQYdLsgG1NauMPiSLsDEiDuQakv1RkqnbaC5fRWJGujmCyGw3ZBtf+sK6b3xAtM9qsr2OX5cbwS/m2Cp5WV9ztOuWJJ8fuq8LMQwJwrlf5UREYLUNNfh+vUAT6uFQ5vFSe4CaRxQobqXC0EwrLcuB3AOlqQzqCqTkv4uyjW6fduDwCn5gDc+/tU5dwuEtAx1xwlIJo1+kxCsP9yqtVG9jjHsR7+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Nx8x2ATL; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Nx8x2ATL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2SDf6328z2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:23:44 +1100 (AEDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5943b62c47dso1164854e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762446221; x=1763051021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8aL6w1TYvGrl1UBIVVUpuAsDW/dJzd3vY+/verHnfg=;
        b=Nx8x2ATL2r2cVpBcfIm68ICAFl/euaqgafw7RHejtq2dQdEejmi2gEnJO5Ewu56Bz/
         fcyCfHPu3muinLXU22Am+Kf+QsXNGtEXvunDOWzl1ZM9Sh2CQkWx/042ugkWF8eiw6dW
         /uCgym7DSaJNopPnM9qn2WtRlu+vfO0J7dlhtgyIECwpkVz9Vwe6JMyFeePqdCbmGtik
         Sclhzz0xkUo2jCO3Z5H5uXdk7aBGZxicvBe90dDbom5KQWNIZ3KEHrkngSFV1qwKgTUS
         z7rY86Cpjq0Yh6kSBanDfjCc9QVE4zyscC7KqmaQvUhVjEdWGgXCSDmtPrVrLHhfM3G0
         MWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446221; x=1763051021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8aL6w1TYvGrl1UBIVVUpuAsDW/dJzd3vY+/verHnfg=;
        b=MPYGe3TyH+hIG1tVIoevFTtVPNKf/tH4ntbwnRRgUbTA7nCk7Amsv3OLeZCcQSJM7l
         rG3kMwgrGu76vokascH4RMOK8mbYLHY4JmqPafuAb17KYrXuMqOAq7H/sn+owvIpS6nZ
         PW7GQYoG3ZNk05VPMkxDDMX1qlXO3md8Kxf3uLEumliOpkoQ0Dj3N2tKGRqua4rH35gt
         16LYRXRmqXSfEIJq3wiMi/AsOcfB2dye2aLUCemZOwy2ILjU9t4j9x83Yp8RG8rAmOOR
         TGU1Wn+P8x4r8PxtFuajSWhuUX0jJZo7WtO6Vu9x1LJWTglHDKdgnrMJFSy+2weN3V/H
         H+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWHO819uo0NLFE5BWPFa0KHddYMflvo4eM3OtIzKRmwXmAmOeiEGKUCjOiHLn4iHLzBOUALqj6sO8T1zFc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWvgIu7DsjRWCPsdj3dJfQKOYkeYSOtk/VmnA4rpN8zQ9RwfPm
	B0b3EuEOdR1m11DUqjy0BsV59vV18zUgVNd8qVK+8P7YPKJC7l/TqKNxN3aS12AafigAqprEyZN
	7HoRNEsfxcRUya58JhokxTmZQPXS4Tnc9YqljINJFwA==
X-Gm-Gg: ASbGncuPZ4n1u3vNH80fDHVi/Yb39OT/+5IwrUkjAxdh61Zi13BKCC4kyadbIKbiXJF
	oI7GdFAkP5dV/oxfZ4SZooHsqT8RMPGo9W3RfTgfP/kF311aLtlB3XRMQWl1aWmJPNheE1aSO7S
	kY0MTzaH5o0HZ4Yb+Ait1hsJdxp28Xzb8gNS/8wmHPLpp3moBo30AQtN1K7G/2Bgs+41s45uiJv
	WKpiJM1K54lU5PJ1zZ2qEqApY9yAGF6u2ebLrqOPNkIdooXf0uZC9QOr7NkvlebZJBVc5xHIJ1K
	HHP4BDfEOTBQwcw=
X-Google-Smtp-Source: AGHT+IEE1H2M6E68md2CvbeNASgGUriHWVB9qaOo9QOrW+nmquKWYbcNGDJmBvvG61zzqmoVo8F4qdYMWY0LOpJw9hk=
X-Received: by 2002:a05:6512:10d2:b0:594:35b7:aa7 with SMTP id
 2adb3069b0e04-5943d7ed597mr2555824e87.48.1762446221207; Thu, 06 Nov 2025
 08:23:41 -0800 (PST)
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
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org> <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 17:23:29 +0100
X-Gm-Features: AWmQ_ble_VVUCkQMV6BUnht3lKL4n7LMuzlixMmgduve1Vk6OdDcUVcnzGZ5wm0
Message-ID: <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: aspeed: Simplify with of_device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-aspeed.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 2e0ae953dd99..3d675b63936c 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
>
>  static int aspeed_gpio_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *gpio_id;
>         struct gpio_irq_chip *girq;
>         struct aspeed_gpio *gpio;
>         int rc, irq, i, banks, err;
> @@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_device=
 *pdev)
>
>         raw_spin_lock_init(&gpio->lock);
>
> -       gpio_id =3D of_match_node(aspeed_gpio_of_table, pdev->dev.of_node=
);
> -       if (!gpio_id)
> +       gpio->config =3D of_device_get_match_data(&pdev->dev);

If you're already doing it, just use device_get_match_data() here and
elsewhere in the series.

Bart

> +       if (!gpio->config)
>                 return -EINVAL;
>
>         gpio->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> @@ -1334,8 +1333,6 @@ static int aspeed_gpio_probe(struct platform_device=
 *pdev)
>                 gpio->clk =3D NULL;
>         }
>
> -       gpio->config =3D gpio_id->data;
> -
>         if (!gpio->config->llops->reg_bit_set || !gpio->config->llops->re=
g_bit_get ||
>             !gpio->config->llops->reg_bank_get)
>                 return -EINVAL;
>
> --
> 2.48.1
>

