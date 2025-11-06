Return-Path: <linux-aspeed+bounces-2799-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23EFCCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:26:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2SJ21dl8z2xS2;
	Fri,  7 Nov 2025 03:26:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762446402;
	cv=none; b=oIh9VtSvAh5UXj8WtJbiW+NqLThuKyHe8qi5YJe/+YqS57iF5pMDWPQ/O+BxNByuZ4+EJcbLg00orTJF5tVg6/czntXx1t1KDy3jI7Z9ZK1CQkT9jikSEDJsaTeB1vYnhIB8QHaSnEAYlYYUBLPzv5Hsp5gcv6S9oQ5IJxxUfdFdtOukllmzqSPzoP4TRCYX67PMaA6Ciog29pFMfvO46dper2dMAy97J9tEdFjydFra778gEiJwh0mYrB67heFd2nTwxVzcMjnhyh84URn80wGL8jbV5htlIgfF9pDIPpAZv3pTwL4bf10HOMOPMyXttj6wiYbw9A/Lhc3fE9aUww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762446402; c=relaxed/relaxed;
	bh=plp2F71zo3wke225yJ4Ea1I1OPDOMxgAH1RlngZdvGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvDOIuY0vTkEd2XJHhehlc7+bkETAgjKmTxYpZylxmfnsA4Pek5gNMJW9qcJyhJkMbBSgO2YK/wklUXgftFyc3u9aqFa0U0Qqaz17JtEPxsgJaPGsnw+rnUL6qcIfgNQnnGBtJAB6l5Ku0vYeQZ2LLnmOv3+pqfqJAeMOc1miwn+lKLuOI24MatLOmqpj2iacJx1ERnUczqPLJdUwa0JQWEO2CywD1LdnF8ZSxnfidn13BVS+2Od4wMLiV9xnkNte7Gufn55QwTqqLUGhHiuiD/Ffi2BX04vF/Le+9k2qJbjkpzFIG/qkRlc0t9x0JeE36E4y+XlUbolQZewGO0vBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.167.51; helo=mail-lf1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.167.51; helo=mail-lf1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2SJ059Fzz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:26:40 +1100 (AEDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5943b62c47dso1168574e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446395; x=1763051195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plp2F71zo3wke225yJ4Ea1I1OPDOMxgAH1RlngZdvGo=;
        b=SwpQkrEKAhnE0LCAWLn/M5xxQk0vjRd83N8mO3IOwWeYzDDdQWkBGzDQyjgUw8EXXJ
         uAcEheuc9YC39V7qqQ5WJfosVTYIU2xTsw5kmFXLjQptXvbNw3FHQPrxYFMbJG5urALH
         w6BXdier1hcVPZaFJ7u5r6Fw7aS16f8srsJBgvUU0LeEa94X9nhIO4cQEI5VB5qXIVlr
         uOCAwjC60t6uNF8iuWxfeNb17uZwSJ1uPXKx92E1j2As4yE2psSLO/Bo4ue5ln5H6w6j
         H9RjX0LxCTytzCp/BydW1i/msv5a2EAqBzdFHrvZ3KqPfwUQg53jT/tOG2qRsXSO41ma
         JHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRFyhEz/DI5vSYw0sjTsE7EBZnWao2Nwq68JMQY4CDTiyneg3B8WHrIcYVtghbuc2wdlGHjfltIsKwfs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLca7rnglJWoOuFLF4TaN+g96vsLT1GllxYF9WGFJXKd5DW7sk
	40Tpx5znKXyPzME/P/qNf0QPZsfeSXohk8wgRsNnQI/7dLok3MfiCRkmoB6oUW+suD4=
X-Gm-Gg: ASbGncvdiQWc1vUUAWTrJzFFyUEb30riOeV1Wd4SMkl8r6rBuEuFg+hZ4dTIbQWImrn
	bcMOXDZ3SDNBfd1f0r3UlG3vclKo5j8+s7RZmsA2qDDECT8IlMgJVrnALPVNEDcadP1bgidEY4m
	CD3xeYKi+rkQ+6gjzLoazNFLLNg9mxdUdcmC45HBQHxgJ6D5JLVGNqOsNXdsZuA2NANpTeNO477
	hRCn5JXA/egj6/LryxhvGFWhoOW4fnZnKvHOp/ZAMVWLkWzAvhvxrg3pfSQIQGTDk5qRBMSln4G
	Mp2Oe9ZlBVXzvdNvLzc46tcbgVl4Qqhpeyye6xw5HOtj4y4LFEfCASZV90CQ7+Yv3M0ky+XR5qx
	AD6n0bhb7dCMIjg+mykz8iYkho0KNRSKF6uEGBSzq3v9IU2Ozr6P2Tim5hqhlrsRZrWaz+rn5N3
	U+QujX3K+l+vlh6/2TASzl3niSnMaR9tUcAaxHcUHF8ONskxmflYXUDDtXbA4LdUU=
X-Google-Smtp-Source: AGHT+IEnejRmCaKAvGc4ObZws11Ztnn9wvRwMUbe0kULGzHnvsTFnhY2JKHzltB9Arq6G7/Gz8CSuQ==
X-Received: by 2002:a05:6512:304d:b0:594:26cb:fce6 with SMTP id 2adb3069b0e04-5943d7d0c0cmr2598416e87.34.1762446395040;
        Thu, 06 Nov 2025 08:26:35 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a1b2522sm827261e87.78.2025.11.06.08.26.34
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:26:34 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so9495441fa.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:26:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR2Hdm5c2RDzAk6TY2AnX8ohreIa1e2p10cIw1fHBGzHRHpOctju3PHHcrhvgLMiA2ExF8GFLZs2QhoyA=@lists.ozlabs.org
X-Received: by 2002:a05:6402:3590:b0:640:fa38:7e4a with SMTP id
 4fb4d7f45d1cf-6410588d45bmr7763851a12.8.1762446022573; Thu, 06 Nov 2025
 08:20:22 -0800 (PST)
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
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
In-Reply-To: <aQzIIqNnTY41giH_@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:20:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
X-Gm-Features: AWmQ_blD_P8L06tcYy5Zd39ODOkLvksucIxy1SkcdgHAnKwygGve4Lbclr5ZO9k
Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > > > (long) long" _mask types.  For constant masks, that condition is usually
> > > > met, as GENMASK() yields an UL value.  The few places where the
> > > > constant mask is stored in an intermediate variable were fixed by
> > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > >
> > > > However, for non-constant masks, smaller unsigned types should be valid,
> > > > too, but currently lead to "result of comparison of constant
> > > > 18446744073709551615 with expression of type ... is always
> > > > false"-warnings with clang and W=1.
> > > >
> > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > > > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > > > used in the fully non-const variants later.

> > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > > > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > > > +                      pfx "type of reg too small for mask")
> > >
> > > Perhaps we may convert this (and others?) to static_assert():s at some point?
> >
> > Nick tried that before, without success:
> > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com
>
> Ah, this is unfortunate.

Of course, it might be an actual bug in the i915 driver...

The extra checking in field_prep() in case the compiler can
determine that the mask is a constant already found a possible bug
in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():

    rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);

drivers/net/wireless/realtek/rtw89/reg.h:

    #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
    #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)

so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
this operation...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

