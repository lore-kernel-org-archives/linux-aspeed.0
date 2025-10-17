Return-Path: <linux-aspeed+bounces-2506-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025B6CCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 16:07:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp8pg3y92z3cZn;
	Sat, 18 Oct 2025 03:07:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760717227;
	cv=none; b=jgqiyBk3BFdPxF0CU0THtPVCHzo7MNFr5l1EtbU7fFv3r29yE/m7ln8l4J9tTZH5hxgH76n+Vt0KTRmqqvqlr78+5V/Ao87rtpIg/I+mqDnw7n9A1hFbFQ9YaXzi/W/+1MfFAPqYzk6u6mKx8DUwj6EKQpmieFAi+MBXVSYNhWk2EqOVYiTOG97q00L2/ueEncmDEB/2Jcj72rz26xPeJGeB6q684QZSsZJUE1wujw+FmfT4LWiqVXGGE6/aM0pnWRcmpRQZCwY2k/Ap5aDZ5nzBDBq+aDojvyrBFP/csDqQThvyY7XlBJd21TlzmHOnHxoSGvDSiQVaGW8gVZSG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760717227; c=relaxed/relaxed;
	bh=D4mf9FdrvOGmLornKgNki0gXD9BcM6SCmzEl3gfV4Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhjTSLeK32ur3WZirAMUI87ScM6mQArVAynwhNawRncAWMLfUre15spViy1Jwt/lo88Kvlx9Mh4rWYFpNxhXLUblJqI6I0OUdjPLCl/WY/NK/7IHKoTA8WwQBfVuqSevIW9B4t6FQ/c4KuHeqEZ4Az8p1R47d9Cy9TUd5ViTN/FHixC2dHBdsnExiak1h8Lcj3PZfUjkLcpFm+szHAUci+vUy8jdmwbNHvyDLo0N+czBtW7hkiwA2FikltqQJqkgFpmyLyTPadp7+cW7VkBZPvHDBA1ownjNQESxoV7u1MBxlYQz6Rg8xL8BCkP2WUxcjBOFR501ie/kyKK300BBOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.167.174; helo=mail-oi1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.167.174; helo=mail-oi1-f174.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp8pf1fD4z3cYP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 03:07:06 +1100 (AEDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-443a7490a54so481556b6e.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717223; x=1761322023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4mf9FdrvOGmLornKgNki0gXD9BcM6SCmzEl3gfV4Zs=;
        b=JORIw2RDD8Krx7Ufwl/vIavKmLD9JPe40J1JCcXeqqNMkRdQfQTyFrV0t8zmppubAQ
         yxnerP0ZcmoX2ZIw7zcCoLGkDLFCDzU6mjGkYVFETqLeR4JGebbaI7E04GV1uAtpnzdm
         dDMG6uH/h8BsJI8JpX9AgROyT/zvlyGHpqJZyHjCh3r4hA7BN7WiIZ6BTu60+B9akTvG
         wuIW+vrycATtpt/tsdYUa/tVfWhicsuJHPa5Jcy9rLcKHQ4qWeN1oiXwW7k6pJkLLTQ6
         fC1fUNwz2rUuFsnVX/k0m6bZNuefjoGC8hPMX6JdLfKsH9LV9KiE3JI1pSZ4S4/DdjRL
         +Ndg==
X-Forwarded-Encrypted: i=1; AJvYcCWXDZ3lvjTqZJJyO17ECmMugrc4/s0hzp7O62VBpjbew2yfBu7GbPt/0Y5a5LrnKao+apYsBigZG14RzTY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuVjm9Kyz5yyrckFHkk/oEWaiz2lhVBLAdtRQzKTvoPK1tKlT3
	uFEkHQLQ1Xm/1gtWWlMYGueIhk0IHpsuW51JnpzGASSe2oSjfowSPyPjDsrC8AQs
X-Gm-Gg: ASbGncsGL4qkA5xrQEWGjcz7+OxyTA5ODbdbQofNbYfnxZwW0CjmwV4ntCGr1XEfHiS
	ewIY9eLdhNtLrRxCrSOM5XLMYakcz0nMnxGs5aLIaYAHk0WHUU0MJSVNbfkn4plxBv5JCEkH5Nu
	M5n7PpAUNsRS2+floYRjgX7qJQ9nTdAbVuBVe7SD+lXIhgBTPWa1MnV0czWPmxMARhZYN4yuIyh
	Sy4MBt/6fAcSAI7mrB1lCag4mRdLQdFp54AVyigEzgs8aPw4m9nsZDEgnhxImNNZNXIRLvnJThy
	k10I9ciipvQg/+Qt9/9ZcC4nrLQjf5qgK1bS0oDoTuWjGv9K44/yLzksrB24DJGToRU72Tlue3O
	s054GwQL80RgxXYVf97KFeWF09TmMBZwo03uzi8Eqaoj9/hIySHAWscZ5LQOj0OaLIecHeLcTne
	FH7bDxX3lLp52tjSFNfOX5nm7uhxgCcD+jfCEbqA==
X-Google-Smtp-Source: AGHT+IEeHEMoz7l2VH/r1eFQhi92VNE2EvWR4psRJBffxT1AAaBXJBfrmPCInXH4fGvXGsAz2xlWLg==
X-Received: by 2002:a05:6808:181c:b0:43b:252e:f7a4 with SMTP id 5614622812f47-443a2ec815emr1841371b6e.1.1760717222593;
        Fri, 17 Oct 2025 09:07:02 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c27a206ac7sm1139127a34.17.2025.10.17.09.07.02
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:07:02 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3c978f55367so1021743fac.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 09:07:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKDeQNgbaYbpRyhA1b1WUZI2SdFY66X/srBeN24ZefwJwtleMrtqlLdggXzxiWZPVGWFer09XTBTJHM+s=@lists.ozlabs.org
X-Received: by 2002:a05:6102:40c6:10b0:5d7:dec6:389a with SMTP id
 ada2fe7eead31-5d7dec64177mr1309355137.9.1760716852567; Fri, 17 Oct 2025
 09:00:52 -0700 (PDT)
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
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20251017081912.2ad26705@kernel.org>
In-Reply-To: <20251017081912.2ad26705@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 18:00:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
X-Gm-Features: AS18NWD4CQztq7yi6j63q-9XtnW0otWo2wOw8z0_Fp7R-6z_qrlZWB5IqFYEbBg
Message-ID: <CAMuHMdVS5KmVkv_pmc+R-EXik-Z1_7nuiHM=vm1Cu8v91wmLBQ@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Fri, 17 Oct 2025 at 17:19, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
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
>
> We already have helpers for this, please just don't know they exist :/
>
> The "const" version of the helpers are specifically defined to work
> on masks generated with BIT() and GENMASK(). If the mask is not
> constant we should expect it to have a well defined width.
>
> I strongly prefer that we do this instead and convert the users to
> the fixed-width version:
>
> ---->8----------------
>
> Subject: bitfield: open code the fixed-width non-const helpers so that people see them
>
> There is a number of useful helpers defined in bitfield.h but
> they are mostly invisible to the reader because they are all
> generated by macros. Open code the 32b versions (which are
> most commonly used) to give developers a chance to discover them.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, but this is more or less the same code which you suggested
before [1], and to which I just replied[2] after looking at the
generated assembler output on various architectures.

> @@ -188,6 +193,81 @@ static __always_inline u64 field_mask(u64 field)
>         return field / field_multiplier(field);
>  }
>  #define field_max(field)       ((typeof(field))field_mask(field))
> +
> +/**
> + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> + * @v: value to put in the field
> + * @field: shifted mask defining the field's length and position
> + *
> + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> + *
> + * Note that the helper is available for other field widths (generated below).
> + */
> +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> +{
> +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> +               __field_overflow();
> +       return ((v & field_mask(field)) * field_multiplier(field));

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

So I don't think this is suitable as-is.

> +}

[1] https://lore.kernel.org/all/20250214073402.0129e259@kernel.org
[2] https://lore.kernel.org/all/CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

