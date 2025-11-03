Return-Path: <linux-aspeed+bounces-2716-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6332CCFA04
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 10:17:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0SFb18T2z2ygD;
	Mon,  3 Nov 2025 21:17:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762165059;
	cv=none; b=kVOqWge5gPh/wQlRmXXpKr4yHix1aq9gSGYy31Hbg8Lbzp6nN7THMtd4XzznUm5QOD1MOijkGGKT1CYLMXpQbBEPT9u/rHBwd1bJ3ztRrGbtWN/RNHypECx1p14aipxFEiOmkgQsOTiZK6JtRQVKChezxSJStUBUcq+9jrCFbgS3qju7YlZwvHGXe+fzf3L5hAxnM4aoDbgp/3mM0bFHgAJ0C+Kr+zmaK5zhQ0/dUWTzbr7dqogorydsEDMV58Zvfs/ZuHHJxK8qy6pB3RbCWxAz6/PTIn3JrWBpIqnasic8WKHzNJPPviAg0Xy8C67ekjV90yPXMgy2WJJmMsN3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762165059; c=relaxed/relaxed;
	bh=WN9rH9/69UaI2zM1r1sL3pcOf4U1LH9TZ13cniByZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NClu8EhKt4hC0cqrLze+CzRX1b7iRTGtoL4Ry7hJAsEdUl5mjJXtTeUP0a4kwchjc/z2oIJhaX6Lm4LJ4LedsG7IvJUwiM7tJM1JfdFVINUZhCagSf7mCDW9stJcanB0tuuik8e/O/t4mPa3M8snZkK8Qzuz0+OS7kVlN3iLWBF8zRRkG26zggdbR2kh/MbrXtv8RXMMDb022RYH06iETFyC+uec9qrdsptvRzmEMIsBivAyngZBTnuAKEOLeGHJ5/gqE0xpkzNHlQCpeDITLgdaS1cvY7x6sJFPYvd+zN8LFo9seCQumi+Q6uYg1gHUbVWuCBVvxrdYKieWuiox6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.215.178; helo=mail-pg1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.215.178; helo=mail-pg1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0SFY6TKnz2xnx
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 21:17:36 +1100 (AEDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so3877281a12.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Nov 2025 02:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165053; x=1762769853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN9rH9/69UaI2zM1r1sL3pcOf4U1LH9TZ13cniByZO0=;
        b=aQJxuL2M6NTVuv4AdBiUAk47rzCJIPXzIqo7ufc/JphMe/LhmR1BbKpPYjJ7ZwpgWO
         a+lGU/UxWw84fzTWn/pQfoC0BtXyUg6CnoxgKEyyQzVWiUfSJfgM9GevDjrdf2Ee2j3U
         66W4zHHGIZTXBxPm0KBcquwy/mrPIo6sh946tS+ExfGucd7C58J41cdlgPYnQO41E6ss
         pjOK7F80qkr+weMWLhYZ1UwuVH8yHlTF1DjT9xXPBYeXHade+QjGfjmxitKlYBwLTWgV
         8Gm4yva1GFQXSGh4kYKWnvejns014p3wkIkQxp9r5skkKd6nGzSmx9hzt+rXI8Aa/h77
         ABjw==
X-Forwarded-Encrypted: i=1; AJvYcCXA9iUbD/a4PTnfKPkdY/RIBKyHj0Y2OAGyyqCOOtjW6jiCy6M7PMxvxm5+RZD8lDhqEbY1qeNc/yPjNiw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMv4l2E7omnkA03QW/e36yccmYLfGyuEs4ISr7A2C5A9oxCjjP
	4Eu7USRH87amRJHcVNOxa47dGFZzjtRx0AegjdqCaHvlOeovB9HIhFEELl0qHCtn
X-Gm-Gg: ASbGncu/muot3/F8xq312Xy87W9FtNvHJY0zjC+rAWZDkoUa73fh8RxammN2otf31Sp
	Q8pO4EqxeyVaXoqdXs0fbPe8kHHpxpiK4iqWz6Dl+nCrHW96dcDG+TSOGhzF8wIX7Sgh39Ti09N
	c27zsw78cb3cWRy0kCMxqoMFhZKT0QFozQaDHbGHEqZ068QWdxUgzrq148QmP4K0YgpIakFYeVU
	vemV/Q6hFT1ZlQ5QPypIoJ90wthU+5SsscAsNO03zLGUPy3PWxMpY86SpUDu7LPrpn/pA4Xo8oh
	5KrpJhidtQ2DKhEDA07GXWmQzi5Ml4d36t5xwNSa08X1PF69fnDf0o7SUTP0IaLWkGojevwPR7m
	xgzRDK+l/xKI+kbl2I/z+0ZM6r68Qnlm5xiwckxKQ+7IIsZfmDKpMFvDV3Ub4yb4XPev1KplxiD
	RLnljdfI9JAO1Ov7PmizOpKVwZpE/KHmPwkyz33hoWkjPfRLXMrqqJy6pd
X-Google-Smtp-Source: AGHT+IFLNnQJHd4V9zOvSo1d+RtZzJF9FVDGRpq+/o814nx/Y/p9uBdAqu5+qC6jJfd2PwQylVuUbA==
X-Received: by 2002:a17:902:da83:b0:295:9871:81dd with SMTP id d9443c01a7336-295987183d9mr62398615ad.25.1762165053225;
        Mon, 03 Nov 2025 02:17:33 -0800 (PST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com. [209.85.210.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295399cae76sm103338755ad.88.2025.11.03.02.17.32
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:17:33 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso1183424b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Nov 2025 02:17:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqcpBTHRtN+Km15KPoPS6jszEi22wNBTXfmQf0dS78AN3KGDofy5JGr1ATyT/FyXumnrGWlcYtuL2/S+g=@lists.ozlabs.org
X-Received: by 2002:a05:6102:418d:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5dbf031902dmr85155137.29.1762164587067; Mon, 03 Nov 2025
 02:09:47 -0800 (PST)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei>
In-Reply-To: <20251102104326.0f1db96a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Nov 2025 11:09:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmxzzzgoIljXMDy5wJmHF15bg4ZKICGjY8c2_gWom3ME9XAPzMw0ghLXn4
Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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

Hi Jonathan,

On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 27 Oct 2025 19:41:44 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> So this is going to make a mess of merging your series given this is
> queued up for next merge window.
>
> I can pick this one up perhaps and we loop back to the replacement of
> these in a future patch?  Or perhaps go instead with a rename
> of these two which is probably nicer in the intermediate state than
> undefs.

Renaming would mean a lot of churn.
Just picking up the #undef patch should be simple and safe? The
removal of the underf and redef can be done in the next cycle.
Thanks!

> > --- a/drivers/iio/imu/smi330/smi330_core.c
> > +++ b/drivers/iio/imu/smi330/smi330_core.c
> > @@ -68,7 +68,9 @@
> >  #define SMI330_SOFT_RESET_DELAY 2000
> >
> >  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#undef field_get
> >  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#undef field_prep
> >  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> >
> >  #define SMI330_ACCEL_CHANNEL(_axis) {                                        \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

