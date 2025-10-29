Return-Path: <linux-aspeed+bounces-2691-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36FACCF9F6
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 14:41:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxVLl3HqMz2yrm;
	Thu, 30 Oct 2025 01:41:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761748911;
	cv=none; b=E/REoYP6OEoJtXG9WKo9AIe8I22X4mrKbgkoZ06BcSh+54z4Qu02aag0T/39C+OJy16GkO51EKzpxTm/7XkwKcoZBl/NW+rcEv+eeK3z2mQYN7AnNkDOj66oUlx/XtiDLekR2PjJDsKmK3TJ2eTV9+F3QiujRgqcZmt/oqsOHOrbye7PJeo+dnQVeYm8doTEueAo94D5pDtZZDnuztiBwKoAlZRqeR51lb7tHu2+3xK41O5Mf4a3pI/Hj/cmdDI6IPdI++yJWM6gpgC6LjUMRSr6ko8AIOxocaRAwR9HGZkjL7k+jyi2/5akEsGHP8/Jlug+uoN4eHT5JPrOq59vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761748911; c=relaxed/relaxed;
	bh=ohi/8MFIs+pUNYTuSKDH5KUVpFMJO5wn0YyhdMa7QIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFMr8hHE0ozBCjBCwQaw6i7TCD8RzHcYHcgjjBXy9X30KYwRq0tpbbCvWlnnyKIYHX0bZW+ob6grXnJUtqf900YZvjt3fqh8GYJhVHW02dHK8WF6xQzWJAf2n9luvMTklMs+wnc+vjs51AqmLRM/9cFiXIy0AcVLlHYD/cCkS0qxouyszG5hUMDs4gAHuSmS4jSYL0hm6jLCopgd5oFBNimrMu/+1ad8N5GuyNIIGDMViotkUEknvp2u7fg3zpKeOHEAoQRbwMxuG+f0CWLF9+mvtNo0fGaJdlzzKED6RrTTH8g3tjWLmt5AFd9eTAYk+EVg0fNgc8YJ7XHZZ93zmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.42; helo=mail-ua1-f42.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.42; helo=mail-ua1-f42.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxVLk4pl8z2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:41:50 +1100 (AEDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so734838241.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748908; x=1762353708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohi/8MFIs+pUNYTuSKDH5KUVpFMJO5wn0YyhdMa7QIc=;
        b=V/I7wEXV8eWJFtA8Ra5P/0R9XMgKOZwVKdcsk1jPrsvHfWeYntLpsq9zhrtVxj1uzf
         rKghNWCBBEqS/xFy86zKsFEJxgQ6XaD3NbW7nPtXvLvWZ+00tk+p2eAFWds1O2eLXthM
         1jx1reEOezLqQ4FoCG7nxvRoTvTHZ26iXoUpO7xEKQ0ZfN5xaRdJTrYo4Nlckzn6l6I/
         312KK6qf4FwuqCzj/Ipp2iQ5Kauv1FMKnuP7xSTdKFKHys2kPkVHAGjHPqVywxU/xPDm
         Z0BOGcbT/q81hIKWjOmjwY1YSeEqiYcydvTQr2qXcW4lP7eeWInyKPcr4LMh7AbZHd8r
         Dd9g==
X-Forwarded-Encrypted: i=1; AJvYcCUF9mrhUucGG0tJoIZjAQ+Cla3wnUq+lwOJY7JMORPjWpq0zGFqe3arWWTR/XkWPEGYljf0ntiZOZqr3k8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzlj4tXWEyWz0VjUbLrqopzyecJY0IHHNLGhB21pValrVUOYqcG
	WR+qugglsKYtlcXsU1d/J9ZUfJtJz+Kq3fjQeIeIBtpn93leV+B4E86eJdZ9Htx1
X-Gm-Gg: ASbGncv00u5kllStgHBjd7EcII/EEFZ7vU0tMVhAb8JHojkneyT/YPy3+ewRq5q78JH
	YHj55m/2D3j+KmrCxrAE15P+N4RT5eMk0bzDg6cW+guzzYk6KQjeI5RYUFO/Zj+K3o1DE6LrNxj
	Ccp1emlu+/xgtqSyO12CEmCQnm5K3JFTzVpyUrXGTjk2Zt/lrU9y2X8c9tlXqqoN6Zi2tghCwa1
	1U8jshLhlOZYdxVP6sNODooL/9Y1PgOnw1Yb9ZML2SEwlPJhspo9PgFQQdW7Ku1SOl1mHz428rg
	4mesU49pJBBxgdHol+D6YgHZSfJ+Bcx2zHUx3hik/xSOljmwOW7YE6MFEKc8Fg/2LEXf2LmNMbU
	rjb70ZlGP64vLGB3p0b5UXCvuzOII3DDYGI59SGGHEoJQtG6VPq+rp7t+2JbEjbiEtlWKWHaEmu
	Q8u1mMH/eXXyHoXWDlCTisDHoEnJBe9oxPMgjEYNMkoQwsYSWkiRk2
X-Google-Smtp-Source: AGHT+IFGOh/QDhNVLDKT7AyqMXj5atavGvEvO7z/0UP9r4+B219t++fVPTvY4fav4YQ4snYw9j63DQ==
X-Received: by 2002:a05:6102:1a04:20b0:59c:1727:f59d with SMTP id ada2fe7eead31-5db7e205124mr1972512137.11.1761748907562;
        Wed, 29 Oct 2025 07:41:47 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb06b1csm5791212e0c.8.2025.10.29.07.41.47
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:41:47 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so203137.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:41:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwB1l6XKf8zVdysel7OVWQGfgKD5QNR06M4yj36N9W/F6LLiEfPdlivIP15iRNnHM9bsZr78lMmWB9CjU=@lists.ozlabs.org
X-Received: by 2002:a05:6102:2acd:b0:5db:9b88:1fec with SMTP id
 ada2fe7eead31-5db9b88219emr535412137.9.1761748503547; Wed, 29 Oct 2025
 07:35:03 -0700 (PDT)
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
 <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
In-Reply-To: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:34:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
X-Gm-Features: AWmQ_blZ8dUVr2aBwtWAAkAOaE93AtUSPNFDpslgvmXepFfW4tMWIOUWnRJkksY
Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
To: Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

On Wed, 29 Oct 2025 at 15:21, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Drop the driver-specific field_get() and field_prep() macros, in favor
> > of the globally available variants from <linux/bitfield.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5:
> >   - Extracted from "bitfield: Add non-constant field_{prep,get}()
> >     helpers".
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> I guess this needs to go with the rest of the patches?

There is no hard requirement for that, but if 07/23 goes in, why not
include this one, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

