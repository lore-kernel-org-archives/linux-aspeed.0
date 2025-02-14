Return-Path: <linux-aspeed+bounces-728-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5C3C021A6
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 01:23:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvrlg74jQz30Ns;
	Sat, 15 Feb 2025 12:23:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739543989;
	cv=none; b=eQcOCPV/PUBhAtG72BzKW0l0STi1cWYrXmCTrDxgvYmETChhlmjKaH/T6E861uD1N7Uds8R1h/1bkw5argLzNEGYiPcDO1U8XwoUPyrHkJ/jzG+LqAWRcXPYW8LbyGF76ZnWmvu5SoL4hG03tO9nJ8c1DMcWpfjtZb7hRCUafntn7xmYWTSYFuxsP4gxvXbWwcKqoM3FN4ap+CaCLzeNZHy2AlGhtBDlTajW2GbpS8/Xq1L0mVpYSqfHzcmTc1DO1huJnzOS6yi94p0N5YUOfs8aKzvswL3IvgBdxGG2YrT9NJxnDJyPkq51AbiMP08AwUqnC6E8PF1riOkudgPQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739543989; c=relaxed/relaxed;
	bh=BI8KVq1D2a2mMAsVtcWo7XlUKAeczvE5EfV30VmWJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho5lC1PD0u4aZQYc6QIGl/70wSY92bkDZt5UAqH2f25GLwoYzUnut6MSWvbI9UUZ77V/S8y0qErNVA9l7VGGNp4AjP5NO/3vTqbXLo0YaZSTB3jlBUxAy5CTuXQCKIfDoF/0vNPrJ1MTqAmQmE/3GGhl2A5INRjpJZf4RSQJjT1uoLa8G+Lf+fp5NqSPCENnGBdb/7of6aXg6I4bC2GR5+8sLsCIiGjQe7yd56ofisDvsR5BjqtcM+1HvljQAKXuUJLEexvVNkU7yJZ5tK6GcFlarkeTOebzGBeTjj5DE7Ph0XK6VCA3tpLEq/Yhp1F0vTznMIJoN5j3A/2bgjGgOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UK26+csA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UK26+csA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvZSz6XwBz2xWL
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 01:39:47 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-6efe4e3d698so19167837b3.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 06:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543985; x=1740148785; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI8KVq1D2a2mMAsVtcWo7XlUKAeczvE5EfV30VmWJCY=;
        b=UK26+csAKHN+SolDjCWrHvDd/AkeXWey0O1FiYp0XclkSmYeSabE1DGEDvEg/7BEaQ
         DHw8B1juA6Z7dZETNsZ6Ybojg/lEZ+m09yc/aSV9axBNg7u7C/kFmM83g92BT6gp/Vp6
         hTNgNvOtDbObs3r3T34+m8BP62/tiuXqwVzy86j5F+x9tcyHdvo/56jiMGfaZ8QaT5ML
         OemAOT+J429rAKwkjo5NEepZ7paM2EoogZOF9ThoQa65y1jz7RcY1X3GtJkvx5N3g3oq
         BL8E9UebZNGChkRQy3tL6Ik9RlVWUmBQR/e6Cok2453qk/xEyZcAqAk1mY84J2p2tQWw
         v8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543985; x=1740148785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI8KVq1D2a2mMAsVtcWo7XlUKAeczvE5EfV30VmWJCY=;
        b=Ao/8azQcUd/sInDdier1+UUUzROoTKmEYbrSdxk35DvVC+oXwXIoqafPYzSuNnZ646
         l+TxMVM/7vwOdhDu4QRgYfBCNGmccfmuudLwYcCqXYWGPWj1dyls//meteCDUvLjgdHS
         egV/PkSptsp0g8taSpfJzJhuRW5IGbfCdXpjj1+g/ZKK+EDQ0poY8yiFALVYirQu3JGZ
         g6G3eGbt4yJY/KTLDFZKHXYanGjM0JbJAdAO8QLW+TtFWqnfTZrzzelroi9QIw0HwykG
         YVS6pF6qggIHG6uRtXWiQiDxg31sF2j1h1nC7l+VknctFFrARdtN2OVVi9obA6iNco2Y
         IPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVcHv7OWP3k5bW8vg7E4l9zK6khnWjczoQz6BkuHQKg8yj2iPCEjV/pUE2OZYG1JNvW6soW/FgF9e06kQo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxu12KCbEGMFZ6/QeyNdsan+cgKWVO8yzfQdkNKSmjkE/qY44CK
	p4wEJIqVm2UrPWuaR09aTrBM0dn6xLjCysDy11aiqAjjvtqkvvVs
X-Gm-Gg: ASbGncuo/OzHKfOrSVe4JctJ8xq7HG5zaliVVSNrh1OA14z9bhz61s+DlxikU75AEBS
	fg/hx5OADxov6rytdGKYoJu6slPvZrPhschenqlcWWCDCuupdK2jDAzMfXBNRhwg+IGjmrqgkWV
	KF/gxWq+yGTg4kHDqNV15suzZQQzES/ZqYCwflPa88D8yT7H9C8XUdJwiO1qJAW/4P5i/+GTv8N
	/h8QJSGurXN1Edzqp0E4jWeViFw+lwVtgTG73v1dHlOLuJxRzIiJS3MSBgF9Aivaza56rpLhMmm
	cr2S6UH9gDV6/DS/P7HiikJZzO6FdWv44otF+Bq8tN8WOskdL4s=
X-Google-Smtp-Source: AGHT+IFSk6lpEhh1WcbK3saqrHokhIjyrUSazUu/lghjS/PE2nJjXAP82B0Z/67hwQGCLhksXNnAww==
X-Received: by 2002:a05:690c:6206:b0:6ef:6fef:4cb6 with SMTP id 00721157ae682-6fb1edcc561mr119515777b3.0.1739543985181;
        Fri, 14 Feb 2025 06:39:45 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3609589asm7800987b3.56.2025.02.14.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:39:44 -0800 (PST)
Date: Fri, 14 Feb 2025 09:39:43 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <Z69Vr4ZGlrq7HxmT@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
 <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
 <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>
 <Z6DzQHebEKBb12Wo@thinkpad>
 <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVFG57rUVC-XXk6bsZupVTeV0YAcue=zKWGnm4owjDiEA@mail.gmail.com>

On Fri, Feb 14, 2025 at 12:03:16PM +0100, Geert Uytterhoeven wrote:
> Hu Yury,
> 
> On Mon, 3 Feb 2025 at 17:48, Yury Norov <yury.norov@gmail.com> wrote:
> > On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> > > On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > > > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> > > >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > > >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> > > >>>>> Instead of creating another variant for
> > > >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> > > >>>>> accept both?
> > > >>>>
> > > >>>> Yes, it would definitely be better IMO.
> > > >>>
> > > >>> On the flip side, there have been discussions in the past (though I
> > > >>> think not all, if any, on the list(s)) about the argument order. Since
> > > >>> the value is typically not a constant, requiring the mask to be a
> > > >>> constant has ensured that the argument order isn't as easily mixed up as
> > > >>> otherwise.
> > > >>
> > > >> If this is a concern, then it can be checked with:
> > > >>
> > > >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> > > >>                    __builtin_constant_p(_val),
> > > >>                    _pfx "mask is not constant");
> > > >>
> > > >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> > > >> any other combination.
> > > >
> > > > Even that case looks valid to me. Actually there is already such a user
> > > > in drivers/iio/temperature/mlx90614.c:
> > > >
> > > >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > > >
> > > > So if you want enhanced safety, having both the safer/const upper-case
> > > > variants and the less-safe/non-const lower-case variants makes sense.
> >
> > I agree with that. I just don't want the same shift-and operation to be
> > opencoded again and again.
> >
> > What I actually meant is that I'm OK with whatever number of field_prep()
> > macro flavors, if we make sure that they don't duplicate each other. So
> > for me, something like this would be the best solution:
> >
> >  #define field_prep(mask, val) \
> >        (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))
> >
> >  #define FIELD_PREP(mask, val)                                         \
> >          (                                                             \
> >                  FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
> >                  field_prep(mask, val);                                \
> >          )
> >
> > #define FIELD_PREP_CONST(_mask, _val)                                  \
> >         (                                                              \
> >                 FIELD_PREP_CONST_INPUT_CHECK(mask, val);
> >                 FIELD_PREP(mask, val); // or field_prep()
> >         )
> >
> > We have a similar macro GENMASK() in linux/bits.h. It is implemented
> > like this:
> >
> >  #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
> >  #define GENMASK(h, l) \
> >          (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >
> > And it works just well. Can we end up with a similar approach here?
> 
> Note that there already exists a FIELD_PREP_CONST() macro, which is
> intended for struct member initialization.

Hi Geert,

That was my suggestion. Now that we're going to have many flavors
of the same macro, can we subordinate them to each other? 

