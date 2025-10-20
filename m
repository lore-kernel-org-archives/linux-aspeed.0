Return-Path: <linux-aspeed+bounces-2538-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681EACCD193
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 13:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqwjl5nrXz3020;
	Tue, 21 Oct 2025 00:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760965739;
	cv=none; b=SztwGZ3JGmWPSmNBc7ch70rIT+9rr88liIMS34kuI6txoHujxqrZpy0Y60DIJZfvt3MLJ0SmG8QITUKRFeUVWl2Qy8R4j/IvCVkEfHBM2GFq9950hXEsimEDe4VX+MYOhxtAC3V5EGn2XE34/gsiHmtrYZkci0ixr+qPThvmJL+zE9U9TvaHFm7nFvQAafoU8Wp9PIxzmc59s/uSW+uZmSFeKq9FHMEbvoj9u5zHSibS3d3BZwpdrIMbuJv5B1tm3xpt/j/d8FLU0YdHWOjpqpdW1niZrJ7sxu8apf+KWY6Y8urBfBgNHCEcupToFD1afzlZLcoaaOGnRhOwu1Sjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760965739; c=relaxed/relaxed;
	bh=WTAfAvg+E5E0/JeW2qvrB22XDr/x/zemAkA2zC9bvaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+aTEQ1xDPzGt+3ruW1nxicIpENeCmS+9AHb/hWxlXp+RuKcnwmifC1ScTancuS1hM7Qx8NJpBddbMH57zGNSYgr3jw4SM7pTrShtJkFzzEyBazjPFaJLkGJ3yjHOOVVibdKqe6WnYqm6vf1ddgqHucKCpQANxn6BbMvIccUJbeU6fFGbNL+a52KrMgA75ksKQp1kmayb+SpiNUA5gFYuZ4wiKI/65FVi5G+Q8ycrJ3rpXLLNptT0fOf8iU8EhJh1QJdepf3s9GTd/w99Vy/jBvNMfn01DW2KbXMJwHK+Q6fBg9ey4q86PxTQ5N/kaG4MlQf3UnvQWoDwKvdJqh7aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.219.42; helo=mail-qv1-f42.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.219.42; helo=mail-qv1-f42.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqwjk3cNnz2ySV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 00:08:57 +1100 (AEDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c21c5d3eeso60786306d6.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 06:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965734; x=1761570534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTAfAvg+E5E0/JeW2qvrB22XDr/x/zemAkA2zC9bvaY=;
        b=aHd6E8wzAaJIAWFxaS+JzlFNyx5f364SmNGqsn+nIBB5qDuIQEhgugAOVWTLYXPYRi
         ycLE8KJEYpomaEBbLdoI6Ah0vorSDYUjbazWXj0EswRVZ7J4EmE7hJrmgHFusys5OWn6
         vnR46722OfbawsuJGQtDkMP62j5JBUJaWoUg5DflmswmlplD83qoaKr2XNyzu9DQSlxg
         vBF2n27+DBN5dwCzB3vqO/Kc3TV153F9cyK/fS11bN1NEiWOe3wI17A30+fYYryVQnD2
         21u8LOKdN9DYS6NFmVmD53P/HrkWiR33FO61CkgXlK7ca8F80Pj7gMLjY1rczoDu7qsS
         605w==
X-Forwarded-Encrypted: i=1; AJvYcCXuDZdwHJ98HkNViV+0cIeSl0lXOGXN9CoTkjlqPMsPL/5QFWNpLnZEE3tZ4qWZswyPaHGFx3nkXeEjRKw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/5xNKtakYt1cfmwHtGnMho3RgLx5ibz2i2eEjOxgJUF6VllhI
	ysYdHK35DUl+Vxok5unemyRITdmhKPBU496X5RD0b3EqONQquW200LURmUVy98Sf
X-Gm-Gg: ASbGncvWNrcxJSaqaIgpCEJUBF5ntBmISWnwYkg+IHZAyy5FeiKjYs0momB/sMuPRKL
	1Z8U8UTi40b+X+DVHDXfFIzEeEVl7IJ+5NA6kno8KYVfQlENTPsjiZ8vwOSwBa+K7aTudRFgSfq
	uTgdhNkka67eW2ZS6FD4N6XSkCWb68KTwB+32rkC2LFXsMmhvKA6t2G89NfnEtHbKKL4YGOwMNo
	ERjacI6iKIz6nMMoJM1P9O5ONmB7G0Zjxe/r7qURZuxHabFGPDMTxe+gZOkKmGWqlU2CnP02Lpw
	3XvXVK6wiS/1ACXagw17/fr76IEerVoshOkAMxXhrOEeMntvNaEE8hERadgn6zXSVLEZmurArtn
	HTfiPufKeTxy6wV+Olu0WeRTaJSLeu8/e+shwjECzRAFWFIICLl6TleIIStkD/tYw97d4CajFwN
	PtYP7BCxZVko0ZUhz6IhrFXrSKhg9OTsnuZdsWoy8gCIj6mvZEejMyCGGw2RA=
X-Google-Smtp-Source: AGHT+IF4yxgTb1qWdYsuee+oy4MbbQF2FkYIauzn71kpC9PX1upMd94UJxcy6lMZw/Qu7Y19e0vz3Q==
X-Received: by 2002:a05:6214:5184:b0:7ef:d35f:e1e3 with SMTP id 6a1803df08f44-87c2081e870mr143193206d6.57.1760965734229;
        Mon, 20 Oct 2025 06:08:54 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d89323sm50457346d6.55.2025.10.20.06.08.53
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:08:53 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-879b99b7ca8so66464276d6.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 06:08:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKsYrY7R1tRwkUr50yg4jT0/M9Ln5mS6mCmWfLVlS+dtqWJDP3E3TbiFcVYNyiUNr8YmDPgu/rimRMvBQ=@lists.ozlabs.org
X-Received: by 2002:a05:6102:f09:b0:5d5:f6ae:38d1 with SMTP id
 ada2fe7eead31-5db093f61bfmr207405137.38.1760965235930; Mon, 20 Oct 2025
 06:00:35 -0700 (PDT)
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
References: <cover.1760696560.git.geert+renesas@glider.be> <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury>
In-Reply-To: <aPKQMdyMO-vrb30X@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 15:00:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
X-Gm-Features: AS18NWBop_uORR3NT3_HDoVoJ_Tyxhm-9TufWw0aoroSF1IMR97eq1M8wyRugog
Message-ID: <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}() helpers
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
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> >
> > To avoid this limitation, the AT91 clock driver and several other
> > drivers already have their own non-const field_{prep,get}() macros.
> > Make them available for general use by consolidating them in
> > <linux/bitfield.h>, and improve them slightly:
> >   1. Avoid evaluating macro parameters more than once,
> >   2. Replace "ffs() - 1" by "__ffs()",
> >   3. Support 64-bit use on 32-bit architectures.
> >
> > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > macros, as people expressed the desire to keep stricter variants for
> > increased safety, or for performance critical paths.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Crt Mori <cmo@melexis.com>
> > ---
> > v4:
> >   - Add Acked-by,
> >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> >     power management debugfs helper APIs") in v6.17-rc1,
> >   - Convert more recently introduced upstream copies:
> >       - drivers/edac/ie31200_edac.c
> >       - drivers/iio/dac/ad3530r.c
>
> Can you split out the part that actually introduces the new API?

Unfortunately not, as that would cause build warnings/failures due
to conflicting redefinitions.
That is a reason why I want to apply this patch ASAP: new copies show
up all the time.

> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> >  #undef __MAKE_OP
> >  #undef ____MAKE_OP
> >
> > +/**
> > + * field_prep() - prepare a bitfield element
> > + * @mask: shifted mask defining the field's length and position
> > + * @val:  value to put in the field
> > + *
> > + * field_prep() masks and shifts up the value.  The result should be
> > + * combined with other fields of the bitfield using logical OR.
> > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > + */
> > +#define field_prep(mask, val)                                                \
> > +     ({                                                              \
> > +             __auto_type __mask = (mask);                            \
> > +             typeof(mask) __val = (val);                             \
> > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > +                                    __ffs(__mask) : __ffs64(__mask); \
> > +             (__val << __shift) & __mask;    \
>
> __ffs(0) is undef. The corresponding comment in
> include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> against 0 first".

An all zeroes mask is a bug in the code that calls field_{get,prep}().

> I think mask = 0 is a sign of error here. Can you add a code catching
> it at compile time, and maybe at runtime too? Something like:
>
>  #define __field_prep(mask, val)
>  ({
>         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
>         (val << __shift) & mask;
>  })
>
>  #define field_prep(mask, val)
>  ({
>         unsigned int __shift;
>         __auto_type __mask = (mask), __ret = 0;
>         typeof(mask) __val = (val);
>
>         BUILD_BUG_ON_ZERO(const_true(mask == 0));

Futile, as code with a constant mask should use FIELD_PREP() instead.

>
>         if (WARN_ON_ONCE(mask == 0))
>                 goto out;
>
>         __ret = __field_prep(__mask, __val);
>  out:
>         ret;
>  })

Should we penalize all users (this is a macro, thus inlined everywhere)
to protect against something that is clearly a bug in the caller?
E.g. do_div() does not check for a zero divisor either.

> > +
> > +/**
> > + * field_get() - extract a bitfield element
> > + * @mask: shifted mask defining the field's length and position
> > + * @reg:  value of entire bitfield
> > + *
> > + * field_get() extracts the field specified by @mask from the
> > + * bitfield passed in as @reg by masking and shifting it down.
> > + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> > + */
> > +#define field_get(mask, reg)                                         \
> > +     ({                                                              \
> > +             __auto_type __mask = (mask);                            \
> > +             typeof(mask) __reg =  (reg);                            \
>
> This would trigger Wconversion warning. Consider
>         unsigned reg = 0xfff;
>         field_get(0xf, reg);
>
> <source>:6:26: warning: conversion to 'int' from 'unsigned int' may change the sign of the result [-Wsign-conversion]
>     6 |     typeof(mask) __reg = reg;
>       |                          ^~~
>
> Notice, the __auto_type makes the __mask to be int, while the reg is

Apparently using typeof(mask) has the same "issue"...

> unsigned int. You need to do:
>
>         typeof(mask) __reg = (typeof(mask))(reg);

... so the cast is just hiding the issue? Worse, the cast may prevent the
compiler from flagging other issues, e.g. when accidentally passing
a pointer for reg.

>
> Please enable higher warning levels for the next round.

Enabling -Wsign-conversion gives lots of other (false positive?)
warnings.

> Also, because for numerals __auto_type is int, when char is enough - are
> you sure that the macro generates the optimal code? User can workaround it
> with:
>
>         field_get((u8)0xf, reg)
>
> but it may not be trivial. Can you add an example and explanation please?

These new macros are intended for the case where mask is not a constant.
So typically it is a variable of type u32 or u64.

> > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > +                                    __ffs(__mask) : __ffs64(__mask); \
>
> Can you use BITS_PER_TYPE() here?

Yes, I could use BITS_PER_TYPE(unsigned long) here, to match the
parameter type of __ffs() (on 64-bit platforms, __ffs() can be used
unconditionally anyway), at the expense of making the line much longer
so it has to be split.  Is that worthwhile?

>
> > +             (__reg & __mask) >> __shift;    \
> > +     })
> > +
>
> When mask == 0, we shouldn't touch 'val' at all. Consider
>
>         field_get(0, get_user(ptr))
>
> In this case, evaluating 'reg' is an error, similarly to memcpy().

Again, a zero mask is a bug.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

