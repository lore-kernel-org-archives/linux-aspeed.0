Return-Path: <linux-aspeed+bounces-2709-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0469ACCF9E3
	for <linux-aspeed@archiver.kernel.org>; Sun,  2 Nov 2025 23:15:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d09Y82C1pz2ytT;
	Mon,  3 Nov 2025 10:15:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762125308;
	cv=none; b=lggAD3mdIo34hZen9sf4Ux8R1ynx2tm5LCs35QnktQotQBYUcyCK9GqfiHs8IV3lFZg7rSpgiWmf4o4Eecnxk5quXlkZlMiWElgzA+3Tm7YSUjOuraRIRw1GB42vXZfGMVkvpstQ3wcnShyU8d3Digf2czUk3WFEg6Ei+5kAw86D02n0a9++cKOII436SgBcWoPysvagrtG9j+S5CAqRuogp4+zSKawxQwIgtDdU7B+0/H4SmLJhC57NKkpNlpeXopUQBTmt70NlZvA4AhHzvpbly5mezqIbe/IDd3gD9C8C/sVGfgsGKoT5ZSd619h6HFg4i1SMl/W/Lo/LeP001w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762125308; c=relaxed/relaxed;
	bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX+RWtVfcDkPflJz0sWl8n2cyLD5EzdXCFs7lrYDounOvzXNz0jUlIk+ARbqTY6SqebTEHqo+MQBzoz8PNNYbmQ7vsnGsfox+TiJpjLukvLPvETEcM+rNVD3n41QzIoAKoadkHAwrHxN9Sry3Pkuj5o3T9mydu4GcO55V4HxPdNrsswUCl9jelrRsLWsneXDg8wG89vmETxpQ/iO/lrV7vbpmu9THLB9wxD97agmQFcsufPlpAQwtbsfYFh+mmK5QhvS6UZag7nSUleQsvui1HdQTnaineohbMM5vVxbrKAigpU0SB6m2vkaYgf6lCYPd78Zi2w4MuQxbn9ICS8WKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UoM2jcMR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UoM2jcMR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d09Y65sfJz2yrT
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 10:15:05 +1100 (AEDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5941567218eso4171956e87.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 02 Nov 2025 15:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762125301; x=1762730101; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=UoM2jcMR9ZebQ9YJ6f3skxn6b2QBD3qTOjcvuWbb86cuB/cbeTw4T8U+eYeIMU3wLj
         LbHlrzttHul7GeHUXEfKoztzRQOnvPQnlY1lduGAAEEOSveCtLQO8e6wnGYtC8w0Osua
         yxqoFWD2RDtG67ezhJqtJ0LkjAhhpx0esREofexGCexu/qt1LcLvnFhZjKCz8h7/LLoT
         y7P9LjdV6WHH4XnGx3oJs+DS0MyEOS7dZwCMuDflmpvfgHmPu7LIpuIbJ/jMEeqvjGC4
         T7pMk2Z9AOqdukYj/GzMHhCpX0d5RDJB7PWz7io7kAKqJbreuhoZwRRdXn1lSxh92+iC
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762125301; x=1762730101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=vrnYuUOqHP3D/8RmpycDNDTeYA6iIaqzqL+UFk6+h0HfitrvGl8G5xVVigQVVyqAuW
         tlBIwZX3Ezf8U6EiyTR6tTgXXBbPXh/bGkZC3ctdWonevhJIullDdp+Tqwu8O22hCnoq
         if5/hFk4aR5SXNsuVUp5Yuaue10/Dzw5i1hBwMjvTalhfsUwtg7mZPIQvLNXkqAU6Vp4
         h3RNwRMF+xs4TTWEhoGMlj3+1Fw8piL++mLVpRoGO6BD0YT/xJYlK3qzUc1D1+EL49zI
         5sOYjOrnXV93wrf6DxSczXPARZYhg7jZaP9tVFp4DKyMlikOEuih4RTmbdqZHWQNtTjd
         n8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWxwOxhFPSI5n7DrJXMYrM/Q3PSv/ieHY/rZ0pCTwFK4u6UDy93TEX51KSCEEdjS7LaLfem9WtD2jec0d8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBcCjph4104RC9hMgUTe2ChXYPbKo2Mtaw513CbUxTey+g5Kb5
	xti85/ect9Jr0omep23QQrkdMk54ztbCemVh99ERHl6UmdQQ1i8xJh76LF90e8fgwIQHRpevRyW
	zrr+UrcCX9l8a4PAVTBRbee5ZnuKr7jSs3yjr0wy4cA==
X-Gm-Gg: ASbGncutl23xUKeHid5L3CZU3lDdRbYVcYDjfaI6VpfRLqheHXWx0HEmgQ6mteavtzW
	9DXap1S0+nnSfGNjEGfJ92wbUn4KWv9alcZ69HDaDLhqy+r1hoTiOu/H/es8JDsbO9fu9yq1kRy
	7Wwh7xZ4xJHCEonGimvhK82ReS5Fhi1eHkfa//vGSB24ts6T0T/lxsRQTAlZO0EUCROx55AzKSF
	2aZ2jgN5COjdCfIJHt9dYjQIPIDYQnxESWdLUz6WY+kg1aNNjROqIr14JRqc5eBZBGUNKghgtwq
	fE9FdA==
X-Google-Smtp-Source: AGHT+IHNOSftU4LA4kaZ2zit5fbsUjeer+Cqtnxd6HV9vMAwCSf0ZxvdazFj8kc8iFBA+Oyhy9hRt9pMH+krWfgjY8s=
X-Received: by 2002:a05:6512:1453:20b0:594:2646:2350 with SMTP id
 2adb3069b0e04-594264628f8mr1107502e87.21.1762125301355; Sun, 02 Nov 2025
 15:15:01 -0800 (PST)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
In-Reply-To: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Nov 2025 00:14:50 +0100
X-Gm-Features: AWmQ_bkG07aYa3yfLgn8mo--U0KGtThYfcOHYFtKUjSupbZy0y5m0bQWTypUrbs
Message-ID: <CACRpkdbR+5jh+OqYAU4vyUP-aQSjgMG3RRBkUTWnWz=VEy2Oew@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

On Wed, Oct 29, 2025 at 3:59=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocesso=
r
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to just merge this patch to the pinctrl tree or do
> > you have other plans?
>
> My plan (cfr. cover letter) was to take it myself, as this is a hard
> dependency for 11/23.

OK go ahead:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see there are other review comments, I trust you will fix them up
and merge the result nicely.

Yours,
Linus Walleij

