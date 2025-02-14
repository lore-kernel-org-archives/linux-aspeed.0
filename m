Return-Path: <linux-aspeed+bounces-719-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19067C02198
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 11:11:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvTrd59zlz30Tk;
	Fri, 14 Feb 2025 22:11:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739531489;
	cv=none; b=gVRE2olPWD2pgxoS413il7PSAWsgY2omnQRisY0N5STmORwB+vakm5r6m4FlOjyGcpqU4z+rtNtIoDt+5RJN0kt80aabLZ5D9WVFq1slOo8KMcx4JEEAvEoth+JvJrQsQBm026C+ysCahJr2IwMjloCvRfebm2dEI6vusYC8gJlVMwkz//b5poRKmDhEjYPN9uDH+hFSsvVIoBgvUP5iso1YUogMVsX6oDEzngz87CGJQH+eF+df1kqgidatqYuFNdscZfOoXO45oQqh9dwBxywD4wuUMXBeXer4bc5OV9a6iAKR4nTIAxlgBXXVlAJBS9bGxDJID0PhCo8BuxRkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739531489; c=relaxed/relaxed;
	bh=r+/2I2hmbkU9zkmHuYX1t9oqaBOTTvF7uTNap3Wsbsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjpPZ8mpIry+q10FUJ8z1pJ4pTJYmzsm5kfZK9ZPPy8JWvFznkAE79Y+f/f3+4Vhc0cyxFLUS5h1DPRK8QPxAghVGrt3T57W/ln/4GvlBa06e7OF7LA6Jcr9VoIv0MuKWmWzAhOISGglvmxAoe2I+DMprGp025cEnpNdohbAneiphEmvgyBq2tRjSB+q24SMXEtmgIfrBsPsH4tZYTgXZyAAMRob8gPDU6Mvr0J9NMgEN6f74GZfD46T2nVbVPnjLEnP8lBEjHrP634AjnRT8Ze2tO83gHVZUKgBMRaYUDilUc127AhfFRNRKTUXuir48fODYw2VcbrbeXf9zXu/xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.161.45; helo=mail-oo1-f45.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.161.45; helo=mail-oo1-f45.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvTrc4z8vz2yFB
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 22:11:28 +1100 (AEDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fcad5ee945so827045eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 03:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531485; x=1740136285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+/2I2hmbkU9zkmHuYX1t9oqaBOTTvF7uTNap3Wsbsk=;
        b=TwP4RN4Nk1DzxiJHvxGa5vD7Js2/NpHLpbxNZjl+QPdWEY4Yrd2Yq0VHI4zH5/ay35
         8kXKvrGkMS/hoMjrh9yt5utcLelIyFQFZhMoZLIfnEHQYSeTfEBMNY8TelLU5ZwKcbl3
         dnuacqt4d4k/slHLlFPSOAushiB3oayo3zeW7BpF1jYu2lTqhgV2NO0emO+UtEoVcReE
         lPGYV7qmZa7Okr90jCdAShkTUXwLk8ud6cwlYIia/NdOrRe47Z6lHK+6S4Te4pjuUkFB
         FJ9c0dYowADvaGnj7sggF75l5Nze6YXz1qt+t7LkvnetZQgCCIm5+L37XHn7XR97Gv8b
         2f2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW4biMoOAIu+5C8wE7NPlm8WcRWBLGo3Ymur53viArdwGUqycHJxy7YFo4uV8ly2HODgEL91uH3Drox0c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYHj+c/R3HUYqabg1mpk5oMp2NyLo6YWSdjhJ4mtrqXB22QUjL
	iccJQtd/Go2WbReUvTLN7p+0RYXSuqVTGI6EQHGPLBkwX+15fBHoVg2yF1pVUyY=
X-Gm-Gg: ASbGncuu5LkSmsdWEe0oRTDFyOUN88joec67aLcnrGPt8i3mV05NwMp+NTz31c9ren6
	5fzb2FdEpcAroSW7OM1BxPSUKIxB9yOyV4OtH7U/yRWb0AGqpwYNXlUaFXEZXD88Pfvj5jpmM5Q
	VP8Vs6anR/RatXJOhRDc7HG86AcPUaG0dle3JAw3ekss2L/0AH6n4TERvz0Sr5pMc0kYXzEhbKK
	bvetcjGWAXivM8Bdh63HZ1k1+b5jBfrxTzWfBlENJLuvvFXckUAQEo5kqo+nQu5EQX0HjTxrL+T
	MUjOK1vDRFStr1WZL4GS01M2ILM27XtJ1DsFCsA5+3lGyFNhOqOvog==
X-Google-Smtp-Source: AGHT+IGEhEO5QGAUJkTVOY6tjiH0xBlkR2B6dt8kpcvfv/GEBm7DalIx+lMw5H+eHRl9AFi2v3l0ew==
X-Received: by 2002:a4a:de0c:0:b0:5fc:a7e0:cdf8 with SMTP id 006d021491bc7-5fcb065a316mr4169650eaf.1.1739531485121;
        Fri, 14 Feb 2025 03:11:25 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb167c763sm1138513eaf.6.2025.02.14.03.11.24
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:11:24 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-724d1724657so1698327a34.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 03:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrgPja+O0e7ND/HGULqXeyRlKYCzMS1hdWu6LJW8NBGbmKaYnHPSksUe31F1/1Tw2WSYSPQGrpgBnoVq8=@lists.ozlabs.org
X-Received: by 2002:a05:6102:829:b0:4bb:c670:7ef4 with SMTP id
 ada2fe7eead31-4bc04dbedfdmr3900426137.3.1739531008576; Fri, 14 Feb 2025
 03:03:28 -0800 (PST)
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
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr> <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr> <Z6DzQHebEKBb12Wo@thinkpad>
In-Reply-To: <Z6DzQHebEKBb12Wo@thinkpad>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 12:03:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
X-Gm-Features: AWEUYZnx82TO-9m0J2Kj8kCR7cxX7DuFclptN97k0_3_zHZhXPo2iBI5bXbywtI
Message-ID: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hu Yury,

On Mon, 3 Feb 2025 at 17:48, Yury Norov <yury.norov@gmail.com> wrote:
> On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> > On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> > >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> > >>>>> Instead of creating another variant for
> > >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> > >>>>> accept both?
> > >>>>
> > >>>> Yes, it would definitely be better IMO.
> > >>>
> > >>> On the flip side, there have been discussions in the past (though I
> > >>> think not all, if any, on the list(s)) about the argument order. Since
> > >>> the value is typically not a constant, requiring the mask to be a
> > >>> constant has ensured that the argument order isn't as easily mixed up as
> > >>> otherwise.
> > >>
> > >> If this is a concern, then it can be checked with:
> > >>
> > >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> > >>                    __builtin_constant_p(_val),
> > >>                    _pfx "mask is not constant");
> > >>
> > >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> > >> any other combination.
> > >
> > > Even that case looks valid to me. Actually there is already such a user
> > > in drivers/iio/temperature/mlx90614.c:
> > >
> > >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > >
> > > So if you want enhanced safety, having both the safer/const upper-case
> > > variants and the less-safe/non-const lower-case variants makes sense.
>
> I agree with that. I just don't want the same shift-and operation to be
> opencoded again and again.
>
> What I actually meant is that I'm OK with whatever number of field_prep()
> macro flavors, if we make sure that they don't duplicate each other. So
> for me, something like this would be the best solution:
>
>  #define field_prep(mask, val) \
>        (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))
>
>  #define FIELD_PREP(mask, val)                                         \
>          (                                                             \
>                  FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
>                  field_prep(mask, val);                                \
>          )
>
> #define FIELD_PREP_CONST(_mask, _val)                                  \
>         (                                                              \
>                 FIELD_PREP_CONST_INPUT_CHECK(mask, val);
>                 FIELD_PREP(mask, val); // or field_prep()
>         )
>
> We have a similar macro GENMASK() in linux/bits.h. It is implemented
> like this:
>
>  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
>  #define GENMASK(h, l) \
>          (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>
> And it works just well. Can we end up with a similar approach here?

Note that there already exists a FIELD_PREP_CONST() macro, which is
intended for struct member initialization.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

