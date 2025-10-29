Return-Path: <linux-aspeed+bounces-2688-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6406ECCF9E9
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 14:21:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxTvd6hg9z2yrm;
	Thu, 30 Oct 2025 01:21:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::130"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761747709;
	cv=none; b=Gy2pUO+vWVuPDxwwwEoObDgm6sO+GRgxPJSr/y6O8Q6xXZtmLFVoGEfxxeGP8DAJ4r0mwAuVC6fc30g0ZDYgrOY3fZUn9Z+P/90Js0obiFrGbPU23tb7jYKZUFSjHx21539g21fGBqP/2fBi4Yib9yDHxUGzSJRwltQDm7gunee4ynsLMYj2q2IWMtu9kOaRRFPDr2cysEpjnOXqrA25Mkj8SKG+lvhK4hDnUZiw7/VF/UFW5x10jfpiSeMfFPn2PmdtaJjmLHppvIkjVwXl5+QdhA2NvhPuyJ5jkffbXC6hOCH3MXzZaydGvIDycmoovmSTyCIcXPdzTNRgqcEKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761747709; c=relaxed/relaxed;
	bh=LVuX2dWoAgb7QHLLOTB16BwhmwEzZ8jO6zQdan0Y+2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYm67EP5eFJe1vFV9ez03VjTU+bPcB61t0grebJa8w4fP/B58f5K/wp9uIFQTcBzBTv1Tk/VX7Ky0CLuRsme8NnRRJtYGoYHyDVmMT4bP97EFAzGviucdaF8VHKIsnCxAnkUsmPddBNICZtWESClgP0AM5lxIqdEy2Dqntjv7rQQL6sPLvtzLrWJq3kEKCEMtPXEtRzg9Af/dZ9LIshdG54QRk7v0nh20LBLkl+Y91hU3sFrdJSJBJQbSbOSKMzTGV6+4AERGcVvpiOHP5rNgcSaLyMhVijHrgifRe9QsnFbg4TOCMylPEWbvjqrFqgzr3qkKka0BfGHeJWSRZM4yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v21k/bm5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v21k/bm5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxTvc596Cz2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:21:48 +1100 (AEDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-58d29830058so8476232e87.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761747705; x=1762352505; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVuX2dWoAgb7QHLLOTB16BwhmwEzZ8jO6zQdan0Y+2I=;
        b=v21k/bm5rslh5LcSn3Lfs8sU6Sd2POq5R1zKz0oGpjh6nrnATxRgAwgdZXzCx+Rxhk
         kKQOcf595CGCZAyCS5l36AQBIm5W0zr0kdQt23dCA/XMvgTpAKrr4Y++zwOahgwGGOiy
         ecGrEYdhoRE5D+6lCpKzEwip2dJ7SJwR1PCiUf8JBMVT+XWgeK+IVuZv72SpZeMEGcEP
         XzMqgIlKCYk0vmihOAEGJsuLNWQR1pNwMfTR7rSsBFfthPkvcX7e1ACpxtjxeoUyzkzm
         kjtCSXSFMGo6UksweVMMDM/rAiFEJOYLmOvDgVsL9u+aeKTno6mM1v7ZhnXnnganJyK8
         yX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747705; x=1762352505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVuX2dWoAgb7QHLLOTB16BwhmwEzZ8jO6zQdan0Y+2I=;
        b=foRmUQmjOdfIHIwA2Uaj7sA1FDt7EqmFFFhxbZ0O0HEQwrYhdzBevZceZ99usNqSYs
         ZK2mw5M8DbW9C9NjfODDtp3the7z5idJAk3Og/Iwrhwp9JYWNDcU+aFsqRdpPKEWdJ6i
         F9GImt01RV2HK3/gDRycK1aylhYw07BYdy+K5fUYH4tf1bNqdO8W2ssWdjFAqWdFsnHu
         oOYUXyGSjBa/vLc+Kykdv/8F9C5qeoMZ1/FZQoIxcn0We49/EiWTwGnFKGlokhyCnHA8
         NcqAfA0ecVdWNOslk/QDP5H5eNZW7IveirbCs5eOz6Dj+5L3vZhTz7YF7LbYeElNGOoc
         Sgig==
X-Forwarded-Encrypted: i=1; AJvYcCU1+ZJSKGbt1Y100MCMmEFRSG397tJaG0xAC6NNrRfNmWq7y1TKR4Cctpqxa2P5d40mHo3p3//pe2afwBw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyhoUtSXnDp6M6RXnXFmmvfrzMXELrrZqC2YIg23j8AC08S27aN
	yXHYaJuDKFHyBqQL/YiDOuYlwJ9KByUD1j6k1nbbDpXW6YpTWYMOU5vBBDc00IGiP7INYkco2o5
	DuQ2ae8v7PY3ajQr7jE/klaXBAfwS+udcKRYZaPdKUA==
X-Gm-Gg: ASbGnct9elw8b6XFBrHoQnLAS2fKVspjQ/kOaY0ghixBFvJBuj6s7m/J2z45OvNsU8U
	nEAl8kkjkiUGry0SpJTbsxtoO2ONX//Bkc0+ffnJk6ayry+nUaqVa4P2WrJI1MaglYLUlWLFclg
	8DC/JcQ45omhUV4mssY8xJb92yPCHYij9UTNjxi52IzZ3umiaNBnZd7C8ZVWrtLO6/K01CEYwxr
	4NGqAD2qySBnsE0FbNH20a2hZJnsmpVssnIqwU5Qr5QPch2jCgbRvFVdV9E
X-Google-Smtp-Source: AGHT+IH/WV9TTRDue/YlQPKqZJ/rOmSLCumqELYgQ//HXfU7luOPdKKEVQrj3vn51BUY/zZkRojEs9B5VMPxZwJpOnE=
X-Received: by 2002:a05:6512:238f:b0:592:f814:3852 with SMTP id
 2adb3069b0e04-594128b7bd8mr1157709e87.20.1761747703432; Wed, 29 Oct 2025
 07:21:43 -0700 (PDT)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 15:21:32 +0100
X-Gm-Features: AWmQ_bn0qj1HdhGI-E5owVSGvqmNxBgXc48MF5-9CHRtkVWKXcvNelNuCdps5kE
Message-ID: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - Extracted from "bitfield: Add non-constant field_{prep,get}()
>     helpers".

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess this needs to go with the rest of the patches?

Yours,
Linus Walleij

