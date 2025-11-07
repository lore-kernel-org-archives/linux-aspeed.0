Return-Path: <linux-aspeed+bounces-2828-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F310ACCFA05
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 10:33:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2wPf3tbpz2yrF;
	Fri,  7 Nov 2025 21:33:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::229"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762511590;
	cv=none; b=l9p5gMoRvReY17K/VDwTaAefYDgPrIvxnDER302TD+e1lRLu4F6p6D2HGs0JMVfcEIUIvIGOvjpqKfXGjJBtoWREsyblv14SAx9ryz2dwYOnhfER2vZqI7kTp3y3LEZA3MATYEXqeRMXumOd+Ccgw446BrpM8OEFVl78N3igECyEwMHPQwMpdUGvRx8TM1inDERlJQXl+2wr+WMwC6OsnhwSuWOnkbOHXbBVZ8vZ25saknBA1/eAjU9vn6cOWezgEjsgt2tNwhKBFpcEO6+mzlxfc/A0OkdF+A00HT7wjzFsPw9Q/q5qoxJpG3EWXlmMN6mFeMphf00VX6tB/UwgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762511590; c=relaxed/relaxed;
	bh=u0SC5dtN/EI2PuuKztOZyox/MGIrIYy9hq7oU1yzaSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBgW4pkoHwLc0K0MBKjvYMU9egt5hnfz2J6D18UfrHCT8q63fphFelbnsmk/IHnfQOx3b/HtwKXMyrnrmXiRp/UdybXO8Ch0bt2SXsU/fsQ/ojcnIR+XJnBx6V87yXmg6ApRS6zZ6kOQxpFFgxCW+2xbFyXlI/GH9M/g54C5Xll6TpsFM8pGX2PbMZ2vGnLyw88DbCS2k5tG+4SmhX1Vn+my/F4ji6AheD38l0J9MD1LJmX2qun4YG1HQqDbMPNmSatNGwM37dqKchpwGRGqEFyHN4NL6w1i3E6idci5wc4V9IPphZGqQM3i7AAAXSwBdLSsw1nxWbnzV5/VhsovpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2r3OusOk; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org) smtp.mailfrom=bgdev.pl
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2r3OusOk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bgdev.pl (client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=brgl@bgdev.pl; receiver=lists.ozlabs.org)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2wPc5Vmhz2yFJ
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 21:33:07 +1100 (AEDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-37a48fc48deso5327541fa.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 02:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762511584; x=1763116384; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0SC5dtN/EI2PuuKztOZyox/MGIrIYy9hq7oU1yzaSE=;
        b=2r3OusOkXejZvb6n9QUJASOjMYtGuB5SrlHR9mcc6i6/T01aAriGfHwsqkIFBe8rn2
         d/FWzWw4y7+ESjGJMU54sZaQKPDqdi38wxC4+dOqoDhOTdZe6eL5AXDe9r93wQcYQeWp
         Bkwb5M5BAwnRxFKoMaP2hngmpQZBm67q8hZhgbXsJVS+p89szOmmFjzPVqXYfeWjAKBN
         tjVVC8kidFZypWgJnDNZBcaes0OFiVrlp5BZNBaHL07p5XfXf/xW/tZndvm+DJ1VhKKU
         K+hKlF6DRkcbXr/670NloFTJXaeASDvxKzfltrRHNHoaK5tNq0mCPXJoJNTtZcSMdFHl
         mz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511584; x=1763116384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0SC5dtN/EI2PuuKztOZyox/MGIrIYy9hq7oU1yzaSE=;
        b=DgWpbCk22u7ABDVdEoDLF7++ud5n49g5Qmgr8KnndnXzmrMEerVACGRFa1aR9hpF5z
         n5VtCt5JEJ4EryL1F4bp8HLZgY8iwYPccAuPfV30mcYS0xuEuq6/ut+BzV698vTbxZZN
         7etEooyNuLkdXnhT7nBZnBEBnbZaiu2Ey+N9ez6IFaOTx8Q1M0L0vBdeX5XU+xX2bbw7
         LGWeXubIc9/GUcrRGgTEeaBLeulHqYFktTxn+ndH8SXX+naU1e0PNfOwaSW3hWciQqkk
         9A7ixW9YM2T3BL/urWlgO86XYT94Il6KlnznG0iVTdMv8szxgg3E0nNl/ZmRgNHiF02T
         RGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxOaIGNom62JETJVIKN+mD8UF2gBe/gPz8G3CyrcRnW9tsRZFY3Qhb6OCvoQg1pv6aiSlpj93wTvFY/ko=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzX9lT6iHsdG8apI6mnbbaTfpclA2OWHyCUJ7YptmV97qR41As
	RHJcE31pQxt6cqgtQjZRWITjnBVk1+F5AYFbUYobB4PyLeW0JBAWUWrjeSUyp+Y+QRGrl1fkoQU
	clKCyYdU5GEZFu/ZsHNSwe+QpGvUC1GH3RER5E0CPng==
X-Gm-Gg: ASbGncuy4Q1BlJTMgHXcwYwYHYoDKhc17KldVDcLIUCR7NDNZUolonGoWSQbpjUCo2k
	JA4pdA+OiVAylCxkHdpB15FB28r5WAk1ULxq0JkOfaIee8tEiI0Sis8P2LWeUUfwfT8cNx0BwEm
	wDY0da8BsnS9VSU6+71zaS2EsJyrJNcJ3t6tL7WHuity1f9O4ETDiePRF0Q/BxnruacXD9bln1o
	A580YSnXzX6P3bLJLJ3mQoAcc6KX3t3bDiq1jIpwIlgDVWEOAi09syPrhmZON9Eb+zNFuQZ8MIR
	bBVLi1OQ8LHMQukGnvg5w8H2CQ==
X-Google-Smtp-Source: AGHT+IH/NaO2IV2PuSuT+uIy0ell6f4pEVJBNYisr1Il5Fm4JRWfx8ML7AoeEUzy6VOMfbvkcuWVGadITNGQPdN4yQA=
X-Received: by 2002:a05:6512:3a86:b0:591:eb00:9795 with SMTP id
 2adb3069b0e04-59456b5b60bmr827315e87.13.1762511583894; Fri, 07 Nov 2025
 02:33:03 -0800 (PST)
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
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
 <20251106-gpio-of-match-v1-2-50c7115a045e@linaro.org> <CAMRc=Mchtho0yDsSp+wwBt=yBGg1+3i8ifkUrip1MJaq-uk+0g@mail.gmail.com>
 <cf23070f-8a3c-4c13-a46c-dc95f044c936@linaro.org>
In-Reply-To: <cf23070f-8a3c-4c13-a46c-dc95f044c936@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Nov 2025 11:32:52 +0100
X-Gm-Features: AWmQ_bk09Ua_9bvIZ5lzbEUjBii8ELdurCEnXHjZ0WSd4oyNENmk6WbdUM8c1Lw
Message-ID: <CAMRc=MeQk6BnKPGNxmFYP6Z=Qmo+PB0T8bBZGAbR3LP7xRzELA@mail.gmail.com>
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

On Thu, Nov 6, 2025 at 8:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/11/2025 17:23, Bartosz Golaszewski wrote:
> > On Thu, Nov 6, 2025 at 5:16=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Driver's probe function matches against driver's of_device_id table,
> >> where each entry has non-NULL match data, so of_match_node() can be
> >> simplified with of_device_get_match_data().
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/gpio/gpio-aspeed.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> >> index 2e0ae953dd99..3d675b63936c 100644
> >> --- a/drivers/gpio/gpio-aspeed.c
> >> +++ b/drivers/gpio/gpio-aspeed.c
> >> @@ -1305,7 +1305,6 @@ MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
> >>
> >>  static int aspeed_gpio_probe(struct platform_device *pdev)
> >>  {
> >> -       const struct of_device_id *gpio_id;
> >>         struct gpio_irq_chip *girq;
> >>         struct aspeed_gpio *gpio;
> >>         int rc, irq, i, banks, err;
> >> @@ -1323,8 +1322,8 @@ static int aspeed_gpio_probe(struct platform_dev=
ice *pdev)
> >>
> >>         raw_spin_lock_init(&gpio->lock);
> >>
> >> -       gpio_id =3D of_match_node(aspeed_gpio_of_table, pdev->dev.of_n=
ode);
> >> -       if (!gpio_id)
> >> +       gpio->config =3D of_device_get_match_data(&pdev->dev);
> >
> > If you're already doing it, just use device_get_match_data() here and
> > elsewhere in the series.
>
> That's not exactly equivalent, but I guess it does not matter if driver
> probes only via OF. Sure, I'll change it.
>

In this case, it probably doesn't matter but in almost all cases it's
better to go through the fwnode path, as it also checks potential
secondary nodes when retrieving properties. Not to mention better
portability of the driver if needed in the future.

Bart

