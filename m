Return-Path: <linux-aspeed+bounces-2537-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2928ACCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 12:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqvfV3Mzvz3020;
	Mon, 20 Oct 2025 23:21:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760962866;
	cv=none; b=YjJZ0eWHJ1NoHJHJbG3HYiQdlvFSdmiQzkdCpNKUgASWzIjmmpzBw5KVP14bC5S/RWjklzsYgYZHYWWt9Bx7xnyhU7iHweet7n8akKa2KCEAzWrjQmOa1BMviFVrQiKqpFJ2vpmTnx2JGsCS803YH/udEtbKhmfW7nk+o5XlbaXIjCXCA0hlUbp1vclaT0oF0Fl5cEuYEnvDgvAXhGOgOX/uRZ+tLIXW6+z/PoDp0JS/TeSH0r3Jd9StlnUEBFPF6uNxlR/24H0IaMhHuGweYgB5T8gHAKw7ze+/QlL6Ps35c+WITRsYYzSk2GIITYzH3C9CAZV7PQ5E0EzKLVs7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760962866; c=relaxed/relaxed;
	bh=Pomt2ITXhIHlFit8dq3w5svz3PMdwi8h98cx9ZzxHC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moS+u9TfF8y9kw9zUJCzroiNzsZ8t1dSMOd1HIeMsqTADKAbKiMmpY7bhlACv83Mql9D9GU9uZ8vsuszZNPaX06WJ4aIYwecGYAV6ytl6GmHx+DIu8CTloq4cX4UA7RK15b/0oECnUK5oyK3LJv4P9iyhymLn4xDg+tV5V8/rlYHeTf5NqaW+S4OmL1ZgYcORRQ8tYl9AZhk43E+G/YsMjhuQv2rpDyAw/dXAWxpNTvv8YHWfic9NFpQhmZr9RzBur97BkSR4VdqDhPGU9qThRqBqgCmGSyGynZxeif5bPeWyvoHDjrEA///ZMAa6tlknYp67nFcITd/Ug/xkGdnnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.166.178; helo=mail-il1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.166.178; helo=mail-il1-f178.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqvfT0MmDz2yjw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 23:21:04 +1100 (AEDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430ca464785so28320095ab.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962860; x=1761567660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pomt2ITXhIHlFit8dq3w5svz3PMdwi8h98cx9ZzxHC0=;
        b=ikgD+pv90vTAX2a95K/7hZIj42XYAeHErbf3zG/r+elfUsu5b4wkU02Y1PdfXlV2Pu
         gFho2bTEpUIDYTv9ehSYIxYx8KoxnqCCrwKg5kwtxcQDxgYYkkEu+j9SLZwx2D0Cdh4N
         DB8yJp8TolvI9s219lggvSvR5pqoivIBdLe+Mtc/kIEGB1oubL2UTATnonyVOa98qIl+
         r1zWx2Yu8jlVHIobYYlA4MIko03L7EOO+Jpr+jSHc+47Jr8xCBaMkL8tFAqgp3n/f80o
         d6Qg3KQ9loFwA/5RzEcAJhCKAxLZ/3w9ZTH/hMQmcsVzLvqoTrgQKMMcKT8if3E7KBPa
         4l4w==
X-Forwarded-Encrypted: i=1; AJvYcCUfNeqvC5TED6JJBalU8O6hEe0y+v7S4BSJApWa+FwHH4N0oms/euEZQHd6sxq2rTtLWQzZJ6TkgozyOjE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTZLKhY7UojsqiJpcQH9YgI5BHS6Ab3VjSKlRz+2T1LAr8QZIc
	sYZdS9nIo7cQzEmq4eYZDrY8Vpd8QpUpj/R2qMdkIHXSgHRCXYOkXgTqRE/yDxmJ
X-Gm-Gg: ASbGncu3acCS9w911N0dzU4+RZAzqnU9Pyh0fsI1smIDNjbiDtoI4aVnEb8jKHtzojL
	US/DG//QWwUoAoGivAIsczxHZJHOLDy+xBNgwEd1lgVnf6U1e1L5rxP8CIinJ7XPCgk8z5vi6Kd
	H59ZBz3rp3bUWdnYS5sMbVHlYFZLpg2+8yc3r6gF6Oo4rz2gXoTOoODSdT76U4oeejnx8sjyQQ2
	mERidV2NHAa288EAMt/YyqEgorqCWjpATYgydinfJNNlb2lxwUa0zbqZy0JXlM9MY46o05hyJx6
	6XPhh2hnA0hNt2JUOvZBTn0cpWp45lYMTePNzqjXcXnUM4zX4vOPnOh+bxeMIyA8nyPPXzedWmj
	lqwGr3mbH1njLWZV4gPNYsehzDAJ+Jki7xdWyTVHs+IAhNWa3omwiOAfYtwWhKDGbWtasHpYmvw
	U6pdmtN4GXh24WSH4difumuha36YN/AWVTJ4zgMApAlzdM/HArm+6931GzqTv/k90=
X-Google-Smtp-Source: AGHT+IGfImXXJwkSkaEyG4FJ3/Q6yGtLUYJGKFkJvWMj8XzSuUVcOs4Q9fkO00Hd02XJZikDRzXK4g==
X-Received: by 2002:a05:6e02:1fe8:b0:430:c403:97ea with SMTP id e9e14a558f8ab-430c524fbb3mr191842785ab.2.1760962859940;
        Mon, 20 Oct 2025 05:20:59 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b4372sm29868135ab.32.2025.10.20.05.20.59
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:20:59 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso25352205ab.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 05:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMfutF3AzdacX5cGOHisNFXU/MqSDBLL+/Md+BkslEK1XQSyOEALh2k3Pye3HtV0czSIrpiPp0rw9/JsE=@lists.ozlabs.org
X-Received: by 2002:a05:6102:50a2:b0:5d5:f6ae:38ca with SMTP id
 ada2fe7eead31-5d7dd6f4c27mr3609494137.41.1760962417639; Mon, 20 Oct 2025
 05:13:37 -0700 (PDT)
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
References: <cover.1760696560.git.geert+renesas@glider.be> <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
 <aPJwtZSMgZLDzxH8@yury>
In-Reply-To: <aPJwtZSMgZLDzxH8@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 14:13:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
X-Gm-Features: AS18NWDS1vbUG4-z_--VlQ3gjSspwjijy0fs8EPqX7O88cWCZQUNQKHTmAYei1k
Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
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

Hi Yury,

On Fri, 17 Oct 2025 at 18:37, Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> > There is no need to prefix macro parameters with underscores.
> > Remove the underscores.
> >
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> >   - Update recently introduced FIELD_MODIFY() macro,

> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -60,68 +60,68 @@
> >
> >  #define __bf_cast_unsigned(type, x)  ((__unsigned_scalar_typeof(type))(x))
> >
> > -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                    \
> > +#define __BF_FIELD_CHECK(mask, reg, val, pfx)                                \
> >       ({                                                              \
> > -             BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> > -                              _pfx "mask is not constant");          \
> > -             BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> > -             BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> > -                              ~((_mask) >> __bf_shf(_mask)) &        \
> > -                                     (0 + (_val)) : 0,               \
> > -                              _pfx "value too large for the field"); \
> > -             BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> > -                              __bf_cast_unsigned(_reg, ~0ull),       \
> > -                              _pfx "type of reg too small for mask"); \
> > -             __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
> > -                                           (1ULL << __bf_shf(_mask))); \
> > +             BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),           \
> > +                              pfx "mask is not constant");           \
> > +             BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");      \
> > +             BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?            \
> > +                              ~((mask) >> __bf_shf(mask)) &  \
> > +                                     (0 + (val)) : 0,                \
> > +                              pfx "value too large for the field"); \
> > +             BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >       \
> > +                              __bf_cast_unsigned(reg, ~0ull),        \
> > +                              pfx "type of reg too small for mask"); \
> > +             __BUILD_BUG_ON_NOT_POWER_OF_2((mask) +                  \
> > +                                           (1ULL << __bf_shf(mask))); \
> >       })
>
> I agree that underscored parameters are excessive. But fixing them has
> a side effect of wiping the history, which is a bad thing.
>
> I would prefer to save a history over following a rule that seemingly
> is not written down. Let's keep this untouched for now, and if there
> will be a need to move the code, we can drop underscores as well.

Fair enough.
So I assume you are fine with not having underscored parameters in
new code, like in [PATCH v4 2/4]?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

