Return-Path: <linux-aspeed+bounces-2568-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85627CCD1AB
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 10:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs4T008cKz2yyd;
	Wed, 22 Oct 2025 21:01:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761127315;
	cv=none; b=oc421iwXolZZ/7gCsrnqV971ZyehOsgn9VSlJOXraKqLcvyOirVZzIVqsdcmaFmOrFFvE7SmLuHCHRLRtvYWJiOinT+q3YR4w4TfGNT/I1IIp/lF4yAVygYwrDJ0486QfSmDQfBvOw1diWGCm77FMmIBHArVLI1gxSGiVVprvztPJrwS6gYR1ovrg2og6LfLanOzDTGIz+PbLzve9CDeW8q4W+pEauRqB07ucmaPMPT9D/Sj68a3FezRie5opMJlzvBbbabkqNmUOUpvq9KkNKwztC1Hy22PuabQfZCUaeYBL5YyyCTiJWGPPDD5/+WeheOl+3+Qlf78d+RzPJvu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761127315; c=relaxed/relaxed;
	bh=rEJ/AcXuMMrQoXRwb6HmCfF3LFX3cn+TJWCKJF/dV3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFp+U+6e3ahiRe7TRVFC1jN3JOhTGnindlxxKfGo/RefSLOhq1ax3lA7uOdb+c9zoVfOxpYD2/yqqcAyvFJP0nLiCWnDIa7337mCcPuAWuLlvXsG0SwZmLzMa/AD6ffzPkjuWWcsYH8zjZtuyL6GDtbtWtnuYAvldK/CsG3CCnvC9lMnLG/bLBJ7w5xa3EGa7yjlUfP36HkK2Bk0UtsIkSjzoAkzhLA2CyIjB8lYR9wWhVVvgaXjmVxYKTJMFnmNtzQUYnbrgQ4MfusyhBCiewLTKNlJc3M6IPwXD537N5DdhBas0i32S9B8m2oj8bvc20ejY2CgYRcBWkWgsrZc4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.54; helo=mail-ua1-f54.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.54; helo=mail-ua1-f54.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs4Sy17C5z2yjx
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 21:01:53 +1100 (AEDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-89018e97232so1573443241.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 03:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127309; x=1761732109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEJ/AcXuMMrQoXRwb6HmCfF3LFX3cn+TJWCKJF/dV3w=;
        b=YtD6OiL+g8xtxDZBUNRJ4L2YeHDEyz0ivxSlpPcB/pB5hZIV0LntYAhbc+HJWtmP+r
         fYSX/21HOlEN209RueGkkPEZaSYfsGemE33UVaFm858JQilAKqBaM+dLlFmohhmglc0+
         Ya8eoehU+bT9y3CDmodZdiYKTmUrH0l5kun3FwdbrVRejDEmaIkZyR5t20bTtvtelso/
         fPVLiGLY5UZi9RxajLvu7A6tARCQwJG6FPLmvcXoGEV2HS8XQmNMqxPDgMPQceZe2la6
         LBYEfb35lv5GSMJsZ8IDCBk8adgNNxNPNc0bmyk3IiIX6WM38EtwNK1J2a/iG2KTC0OJ
         UyYw==
X-Forwarded-Encrypted: i=1; AJvYcCX96C9Lbn66S2QKvDxck7WMycIG998ediRK8IBTTZKBkEs3BdmaxnKbmKFGLwEef903t7UbZ7qAhmYtb2k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzwMKcx/nPPS7mIXMs1tnGHZkXjW7FYneEQjBtzt9lVgYU2TT9
	jCU2d7+uJzZk9/8/rgrzzc3FMSGUoCuDHqM7FCziMy3IJojLWjFA5TA+qOgrAyPp
X-Gm-Gg: ASbGncvV0i4AdNx5Ina+18ouIgVzJEyRKpi3qq6HJfzOMt+EwPq6JuIu1Z9p2Gt47D6
	fGlpGoa0xc7TWYV1q+buIxm3AEpi/SSDeyF2CXGMONt04l/EpUnarf1pnhiX8xxj4b78tRcKIc1
	e/d/65IyZmGofJS/5xsNWWDXjyhZiSM06ZkezmFYL8CVe0TBtfSjdiPg2UiKqV/7O1vFZjPoZTH
	wZwNAFN2NWMC/P+9TuGuzu1c4/ibpNYqRbkbytdUqSXSsR6aUo5zzoBgNAiaVbTREhJppfTjnKk
	WeldXop2WADfDnGtca6kOaX/e8CeX/ewy3jkSoUX4BDXGfATCDWs7lOBOC55w4uRF7LJMSIlk8r
	46TPUHOXPwyDtw5Itqwju2Ov+yTNtL+MCLAlK8boNEd7lkUy/IIUu0CRn+VAKvMzfDfVGbaPjCQ
	JAqCWqQl4AJjuOzSKveKFAJsrZhUy2eW6zfVbYE74t8vV9YOnE
X-Google-Smtp-Source: AGHT+IErhJQVZPl/0Pxpa5S8GpygW7TFtxB52Av4u6rwUALriA+O70gv235HuSybyuD8612ytPX4uw==
X-Received: by 2002:a05:6102:38c6:b0:5a3:acb7:55c5 with SMTP id ada2fe7eead31-5d7dd6a694amr5485746137.26.1761127309401;
        Wed, 22 Oct 2025 03:01:49 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c2accf4sm4541812137.15.2025.10.22.03.01.49
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:01:49 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89018e97232so1573434241.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 03:01:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY0eUDX+JLJQvkEHf/IC1zuxHcga2pSltlcK37qXZXxrmdYjN2g9XwrT0Z+bqOLJwzWWzNZreQfANv6zE=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3f49:b0:5d6:615:a687 with SMTP id
 ada2fe7eead31-5d7dd5544d6mr5930459137.7.1761127308820; Wed, 22 Oct 2025
 03:01:48 -0700 (PDT)
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
 <aPKQMdyMO-vrb30X@yury> <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury>
In-Reply-To: <aPhbhQEWAel4aD9t@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 12:01:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
X-Gm-Features: AS18NWAJp5tYw_pRqlFhPyJqRT3wi5ZG4jspqrcr0Xp9hgyi6lbaoTACOgNkevQ
Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
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

On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > constants.  However, it is very common to prepare or extract bitfield
> > > > elements where the bitfield mask is not a compile-time constant.
> > > >
> > > > To avoid this limitation, the AT91 clock driver and several other
> > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > Make them available for general use by consolidating them in
> > > > <linux/bitfield.h>, and improve them slightly:
> > > >   1. Avoid evaluating macro parameters more than once,
> > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > >   3. Support 64-bit use on 32-bit architectures.
> > > >
> > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > macros, as people expressed the desire to keep stricter variants for
> > > > increased safety, or for performance critical paths.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > ---
> > > > v4:
> > > >   - Add Acked-by,
> > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > >   - Convert more recently introduced upstream copies:
> > > >       - drivers/edac/ie31200_edac.c
> > > >       - drivers/iio/dac/ad3530r.c
> > >
> > > Can you split out the part that actually introduces the new API?
> >
> > Unfortunately not, as that would cause build warnings/failures due
> > to conflicting redefinitions.
> > That is a reason why I want to apply this patch ASAP: new copies show
> > up all the time.
>
> In a preparation patch, for each driver:
>
>  +#ifndef field_prep
>  #define field_prep() ...
>  +#endif
>
> Or simply
>
>  +#undef field_prep
>  #define field_prep() ...
>
> Then add the generic field_prep() in a separate patch. Then you can drop
> ifdefery in the drivers.
>
> Yeah, more patches, but the result is cleaner.

And we need 3 kernel releases, as the addition of the macros to
the header file now has a hard dependency on adding the #undefs?
Unless I still apply all of them to an immutable branch, but then what
is the point?

> > > > --- a/include/linux/bitfield.h
> > > > +++ b/include/linux/bitfield.h
> > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > >  #undef __MAKE_OP
> > > >  #undef ____MAKE_OP
> > > >
> > > > +/**
> > > > + * field_prep() - prepare a bitfield element
> > > > + * @mask: shifted mask defining the field's length and position
> > > > + * @val:  value to put in the field
> > > > + *
> > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > + * combined with other fields of the bitfield using logical OR.
> > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > + */
> > > > +#define field_prep(mask, val)                                                \
> > > > +     ({                                                              \
> > > > +             __auto_type __mask = (mask);                            \
> > > > +             typeof(mask) __val = (val);                             \
> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > +             (__val << __shift) & __mask;    \
> > >
> > > __ffs(0) is undef. The corresponding comment in
> > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > against 0 first".
> >
> > An all zeroes mask is a bug in the code that calls field_{get,prep}().
>
> It's a bug in FIELD_GET() - for sure. Because it's enforced in
> __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> mention that in the comment.
>
> I'm not fully convinced that empty runtime mask should be a bug.

Getting (and using) data from nowhere is a bug.
Storing data where there is no space to store is also a bug.

I will add a comment.

> Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> soon as the pointers are valid. If you _think_ it's a bug - please
> enforce it.

memcpy() with a fixed size of zero is probably a bug.
memcpy() with a variable size is usually used to copy "as much as is
needed", so zero is usually not a bug.

> > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > it at compile time, and maybe at runtime too? Something like:
> > >
> > >  #define __field_prep(mask, val)
> > >  ({
> > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > >         (val << __shift) & mask;
> > >  })
> > >
> > >  #define field_prep(mask, val)
> > >  ({
> > >         unsigned int __shift;
> > >         __auto_type __mask = (mask), __ret = 0;
> > >         typeof(mask) __val = (val);
> > >
> > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> >
> > Futile, as code with a constant mask should use FIELD_PREP() instead.
>
> It's a weak argument. Sometimes compiler is smart enough to realize
> that something is a constant, while people won't. Sometimes code gets
> refactored. Sometimes people build complex expressions that should
> work both in run-time and compile time cases. Sometimes variables are
> compile- or run-time depending on config (nr_cpu_ids is an example).
>
> The field_prep() must handle const case just as good as capitalized
> version does.

OK, I will add the (build-time) check.

> > >         if (WARN_ON_ONCE(mask == 0))
> > >                 goto out;
> > >
> > >         __ret = __field_prep(__mask, __val);
> > >  out:
> > >         ret;
> > >  })
> >
> > Should we penalize all users (this is a macro, thus inlined everywhere)
> > to protect against something that is clearly a bug in the caller?
>
> No. But we can wrap it with a config:
>
>  #ifdef CONFIG_BITFIELD_HARDENING
>          if (WARN_ON_ONCE(mask == 0))
>                  goto out;
>  #endif

That can be done later, when hardening other bitfield functions
and macros.

> > These new macros are intended for the case where mask is not a constant.
> > So typically it is a variable of type u32 or u64.
>
> You never mentioned that. Anyways, it's again a weak argument.

I'll add more comments ;-)

> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > >
> > > Can you use BITS_PER_TYPE() here?
> >
> > Yes, I could use BITS_PER_TYPE(unsigned long) here, to match the
> > parameter type of __ffs() (on 64-bit platforms, __ffs() can be used
> > unconditionally anyway), at the expense of making the line much longer
> > so it has to be split.  Is that worthwhile?
>
> Not sure I understand... The
>
>         "unsigned int __shift = BITS_PER_TYPE(mask) < 64 ?"
>
> is 49 chars long vs 42 in your version. Even if you add two tabs, it's
> still way below limits. And yes,

Oh, you meant instead of the size check.
I thought you objected to the hardcoded number 4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

