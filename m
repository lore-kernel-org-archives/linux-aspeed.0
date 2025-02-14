Return-Path: <linux-aspeed+bounces-717-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D59C021A6
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 10:28:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvSv01T2Nz30W0;
	Fri, 14 Feb 2025 21:28:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739528908;
	cv=none; b=hIFEgI2aszMGjmyYs4EmFW+wTh6rCn6shLNSwrkqde7hCZ/sh3VmP9ffEz89jtBhioS0HbO2kSpLGOEA7qymCVkwZQcO9crwhI2WzczXPcnJdTc2wTPY1X25rFATmYoXeaJSLgd6U4BDbzTIcnsE601N1qe17UVImrNl22LzREsn64zcL6B/EU01XpCw+aXwE/e/nOL4dfGZEaBZ+pbWACIAcxKdkECxQ/2B3d0qKAPLgLdZ9C6+O7/xLvnZRJU+xOPHKWWy2QC9K/BF7P3srreJBj2jaJ236p5HMdVMT7EHddVXb8NT8ZFtYbGMLdMI1NtRxLwRbO8bTH07G+dhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739528908; c=relaxed/relaxed;
	bh=DD+ssK7Im57vlq5FNxfqHbbrTwFIXn9O88i3TIuD0PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m07V3ZYJe7Jm5p6qhSewfTkv/ZxIE5OXF642KDwmIPxxBdFKVkzJQpB3M8rqK/Oz+fhyUYbbzsI5XiYBMpa9gFgw3WwxYDhLm6kFrGERqwq3SI51yUMdD4fP8Nkpj6IVvexlyOYWfM0o7KTizFQmv8WXEFvqAf3F8xSswQRrCgqJRhk3y3JgC3Q0a+HUn2rOO2QIMJHLWOqGEWgJ2faDZUkj9PvDYsuV+QecUAkFie3fxFNBahplGQntOUU5TNuLNMMlO6WqHOKShm81yBZiuVJLCvjFmu9gKna5PUGDZonmj3Qa65HkqM/KqGSrb8tisQE2/y3i6ibvz2FHCvKVjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.180; helo=mail-vk1-f180.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.180; helo=mail-vk1-f180.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvSty4nH3z30Vd
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 21:28:26 +1100 (AEDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52043dec766so1681190e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 02:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528904; x=1740133704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD+ssK7Im57vlq5FNxfqHbbrTwFIXn9O88i3TIuD0PI=;
        b=jGfObEm01PJyF4G+PvAf7SkRpL0UKEdq8mmcPtTvzcTWWUHd4OfNS46I2SKBjdr5/W
         FCVUWvDjfcdbV92fEnoo48c2ZIVjJxEcWB17payfojUsKhVdztmSmrWorSkl7lDF4Oc2
         8NBglkgDhmctwEorcw+kxfVOn4fU/ejaHp41VtsEWWcaJHrJo9XlnkSsj02cudlGmaFO
         N1jHxn7j8BCi/zPoq/PkHyAcvSAhYFSwdlkC/iOCjBeB2RNlLe+g1d0Pk6ni6RGBS1oS
         dTFiCQ4Gf9CXrzrnqcWY2SdIjfOjlIx3Ru9DCUT+us7kdPXhSG1oOOaANCyKcSQzFNJ9
         BIOA==
X-Forwarded-Encrypted: i=1; AJvYcCVA0cv9MjNHNOK3MoK5y3TvVI3qDv73QhdsI9LoDvKj7pq+hA16kpXr9RBAvaYj92VW1fRNdHo7tMEGF08=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKZ4+1Ua+brHYdK0iH33PHXiTobVP3k7u28E3k90172wKglp8/
	ftfgxsjgXYuYEgKiPJUk8FUJtn9RalzhKsooEgbSfpa295tHdUo9ZieoktHyAFY=
X-Gm-Gg: ASbGncuyD0eGjM7iWgTX9hijQmdeTsN/RLlJhmrDgACUA8gsiPxhtuRwCFXmT7R7Eji
	CDvB3LSYSTBe4gSUkGGLYicZmDWsdDEvj5Ajd9PijEfaSZifpZ4LrCDhxyYVLwVOKffL71AZv1N
	oMGXgLTE7UfDk0BwEP/2oMqkvp0EpjqX+ZpA77x3KgY/z3Bdr42Ex+aG8JHvpFN0LleGw6TLDwK
	Go7SVZk/xLyzf1BvJy4ZZ/YyfrrZWItEmgKvdtoWZWnjIl0WmpRP7rzlxwgUFGUM5WXg8Xj/exA
	fVCo8W4j0B/zF0F5P0jzSlmaPja4ceAiuDuzI/3ugvugbUTGgbA3Zw==
X-Google-Smtp-Source: AGHT+IFYNbh57FmUEQTruekogOVzQHJT9rvJTznWXoxTWJBQpMcS9w1ayVPpY/ybZ+Pk2dQW4ifEdA==
X-Received: by 2002:a05:6122:2218:b0:50d:39aa:7881 with SMTP id 71dfb90a1353d-52078a353eamr4937953e0c.0.1739528903745;
        Fri, 14 Feb 2025 02:28:23 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207ab6f512sm539911e0c.46.2025.02.14.02.28.23
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:28:23 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-866e8a51fa9so1102557241.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 02:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSovFGaFQmrSRPatFsJiwY6EmSyZ8JB7B7UtJQ+krjyux474WD0D4rgtgfgPEaZtPgUMgexVB4oJVYXbI=@lists.ozlabs.org
X-Received: by 2002:a05:6102:50a4:b0:4bb:ceeb:eaca with SMTP id
 ada2fe7eead31-4bc04dc0ad2mr4618891137.1.1739528903305; Fri, 14 Feb 2025
 02:28:23 -0800 (PST)
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
MIME-Version: 1.0
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <20250131190335.4c18fb3c@pumpkin>
In-Reply-To: <20250131190335.4c18fb3c@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 11:28:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP+GBFMfd-C_7oiXHKSbycPv6adxJdM-Kt03+m9UqDiw@mail.gmail.com>
X-Gm-Features: AWEUYZm97sUT3mKi6JQWzWdUxKryfF3L2VZZmMQJHiBs0ICC7K3YkCuZ7Ruhdt0
Message-ID: <CAMuHMdVP+GBFMfd-C_7oiXHKSbycPv6adxJdM-Kt03+m9UqDiw@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 31 Jan 2025 at 20:03, David Laight <david.laight.linux@gmail.com> wrote:
> On Fri, 31 Jan 2025 14:46:51 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
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
> ...
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index 63928f1732230700..c62324a9fcc81241 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -203,4 +203,38 @@ __MAKE_OP(64)
> >  #undef __MAKE_OP
> >  #undef ____MAKE_OP
> >
> > +/**
> > + * field_prep() - prepare a bitfield element
> > + * @_mask: shifted mask defining the field's length and position
> > + * @_val:  value to put in the field
> > + *
> > + * field_prep() masks and shifts up the value.  The result should be
> > + * combined with other fields of the bitfield using logical OR.
> > + * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
> > + */
> > +#define field_prep(_mask, _val)                                              \
>
> You don't need an _ prefix on the 'parameters' - it doesn't gain anything.

I just followed the style of all other macros in this file.
I can add a new patch converting the existing macros, though...

>
> > +     ({                                                              \
> > +             typeof(_mask) __mask = (_mask);                         \
>
> Use: __auto_type __mask = (_mask);

Likewise ;-)

> > +             unsigned int __shift = sizeof(_mask) <= 4 ?             \
> > +                                    __ffs(__mask) : __ffs64(__mask); \
> > +             (((typeof(_mask))(_val) << __shift) & (__mask));        \
>
> There are a lot of () in that line, perhaps:
>
>                 __auto_type(__mask) = (_mask);
>                 typeof (__mask) __val = (_val);
>                 unsigned int __shift = ...;
>
>                 (__val << __shift) & __mask;
>
> Note the typeof (__mask) - avoids line-length 'bloat' when the arguments are non-trivial.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

