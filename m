Return-Path: <linux-aspeed+bounces-624-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA370C02192
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 00:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yn4L71lyVz2xVq;
	Tue,  4 Feb 2025 11:41:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738601289;
	cv=none; b=bxSt9Epma438pWfYsWkYZ2iLnonT1h1RmHz+UyWss0pQXEg4q9JZfIM+3ePoWVTvSBnnsiIDzZvxvQOkYlu5qfX/VXMMIEHZDwmXh6BXR4JMqGChOffEGa/cWr6xKwYNVY5f6cpyrdsrkAqbbNVgemffsUj9yid93Tg87z84ox/lmhoTQp79h9f0SgwYF2nF99JfGHPGIzxAjcCKO+Kg4R335kPhOXZ3/HtOe+z6KDM+Kh/42b35nGsTOoFialEevKf9C49bUxU/TtJf5DCT1HB9H1y0jVZ1VzjgthADjag3mjejWAe86uI6D/fY6yTutTGge2rIp4lw+Xj+pg3pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738601289; c=relaxed/relaxed;
	bh=yPAYDZWhZdvT52ze2ZOmieMRhyI6YJK1D7vMTJGJV3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLPTODfAphTQWJfTxi6so9SPuQnh24oPUmRQmCDPB9cJKAVYK0sTPPbJHLhVHARrUC1+5vizQ7sPQxDkf2bLYEhz/M6hbgQfXLczluj7FeCoTQYFfXB7DDqQpUGnvNzdhdUIZ0JGd+Q/bojTkK17uhSgNGs4rjpOyji86qYlRrteVZYTTMG7m95symgSeSo1ZmVjbnc8usvn3sATn8WGeg8YwPyzV3YmJumudtiYamKbEgPOkviO7PfFTyJyuMYpKtRFoo3VoHhVoodlVa+NoK+ZMWTJtIvo1Bo/5PiMDh5NUS288aP77yL3vT+cYwfUAR1FzI2z2bvDcOm4IOaBwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g/00dhHI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=g/00dhHI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymsr74CP9z2xjd
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 03:48:06 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso8025387a91.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Feb 2025 08:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738601283; x=1739206083; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPAYDZWhZdvT52ze2ZOmieMRhyI6YJK1D7vMTJGJV3Q=;
        b=g/00dhHIGC3DrWK/z3EZWr2oPhr7pKaMItfgdgomnHymtro+8RRtiPF+O4mN2MnANi
         wPbP23tAM86IOtYM3Yj0dDXJN7akLopshHD1TYL7n/7u0Q/f7+heE+5uVkoneXx0Lppa
         nMw82HsHS5j3bazqkeGJM7zxseBikoH7hR5rvN7XmkB5W5JKZylIDCjM1p+7HHjc5DO/
         wfIz/2ti9A8z6dcyudQ8GSclJNh6IK+gxp6BW7ZqaPx9/9icYpvDSntAA8YC4vhfALDz
         KIR7bejaSJBLPyJEXBj3AItvHHkgRt08k8B9/TSJ5zIHAGGhfP2a15QC5uFRl9qlHJtI
         yozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601283; x=1739206083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPAYDZWhZdvT52ze2ZOmieMRhyI6YJK1D7vMTJGJV3Q=;
        b=a+iKMZSggrQZnzaJ9/ZTAK1Zw08izE8Z0dUk2OND1i8bWlmJq3fPAwFPMv1Z5JfEl9
         KFY+xM6PjbKDLUH07Pybz+pV41TImD2S1mjs/5HFIicultuPgb6e/pBrOeFlAPnKYmDu
         dgsCJB/UfUWGjNHnnGY+IYgzksKTds4uM2kXuvlekQvvDGueDT2cHPSwOer6YRdpGoRD
         E72xNZIQFvu2dFXs+CsA2URhebWEMj1rXpcjW6h6GbvY5nTGcO/OdCiDIYr9WMIJ2yJy
         39u71OvzECmqg4HJNIudP340Cy0kPbxofzEz+FREPtx/LOvMxMphJU1LUaKABFVprhdn
         hG2g==
X-Forwarded-Encrypted: i=1; AJvYcCXsdiTJV4eO+Kso1wFJ1QWM2Wl1QiK5F3D+PnF/TJNhzwAlVL5ViVoAH/oFUs+cX8uka78OUpe0sRYgTXg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2LBECCY4r9g5wM2DAGa52JGs8s65TCA85frmW5WSf8gVZ1adx
	r60e8CCuilwcy0tXxgKoU8mqOo4DkTbIipDupae9EDVGUAdULOWe
X-Gm-Gg: ASbGncvKPunpHBeC29lfUPOe4DRbjpRiwzx8UkBFllgP+Qv4miOozmytU5BsYJ9qguh
	zQBo7BesIQjIHiLVE19fsmTYuK/sY+xv+T8S4FIX059XIbdpWGkdy40fPD6VU/lO+6JOV451ASy
	HtvcR7i2DvUDPoUlP4CTn+KiwegLGtXppfcIl/y/NcsFt4ZYJFXX5kbrayaiFu5i4y3hw31sB3N
	/HC0r8JpTI3M1ZbvkrSu8CfusUAMQAQhv0OjGAHBqtOArh2zIzsu/O+D967+/Z0OB/UIiTkfUKn
	OaFuxGtwElCoaRFeEnyjPA7olg4XbSax114ZAHE=
X-Google-Smtp-Source: AGHT+IHh9exrF+8QB08CxBY/dutMFmF0pU/5zhM+ZnTaly80R74kffODtDWK+nW0lOwVLaaD6ED6FA==
X-Received: by 2002:a17:90b:53d0:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2f83abb8f42mr30994632a91.6.1738601283227;
        Mon, 03 Feb 2025 08:48:03 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489adf7csm9341363a91.13.2025.02.03.08.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:48:02 -0800 (PST)
Date: Mon, 3 Feb 2025 11:48:00 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <Z6DzQHebEKBb12Wo@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
 <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net>
 <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
 <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
 <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>
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
In-Reply-To: <16e1568d-8747-41e0-91b9-ce23c5592799@wanadoo.fr>

On Tue, Feb 04, 2025 at 12:41:55AM +0900, Vincent Mailhol wrote:
> On 03/02/2025 at 22:59, Geert Uytterhoeven wrote:
> > Hi Vincent,
> > 
> > On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> >> On 03/02/2025 at 16:44, Johannes Berg wrote:
> >>> On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> >>>>> Instead of creating another variant for
> >>>>> non-constant bitfields, wouldn't it be better to make the existing macro
> >>>>> accept both?
> >>>>
> >>>> Yes, it would definitely be better IMO.
> >>>
> >>> On the flip side, there have been discussions in the past (though I
> >>> think not all, if any, on the list(s)) about the argument order. Since
> >>> the value is typically not a constant, requiring the mask to be a
> >>> constant has ensured that the argument order isn't as easily mixed up as
> >>> otherwise.
> >>
> >> If this is a concern, then it can be checked with:
> >>
> >>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
> >>                    __builtin_constant_p(_val),
> >>                    _pfx "mask is not constant");
> >>
> >> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> >> any other combination.
> > 
> > Even that case looks valid to me. Actually there is already such a user
> > in drivers/iio/temperature/mlx90614.c:
> > 
> >     ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
> > 
> > So if you want enhanced safety, having both the safer/const upper-case
> > variants and the less-safe/non-const lower-case variants makes sense.

I agree with that. I just don't want the same shift-and operation to be
opencoded again and again.

What I actually meant is that I'm OK with whatever number of field_prep()
macro flavors, if we make sure that they don't duplicate each other. So
for me, something like this would be the best solution:

 #define field_prep(mask, val) \
       (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))

 #define FIELD_PREP(mask, val)                                         \
         (                                                             \
                 FIELD_PREP_INPUT_CHECK(_mask, _val,);                 \
                 field_prep(mask, val);                                \
         )
 
#define FIELD_PREP_CONST(_mask, _val)                                  \
        (                                                              \
                FIELD_PREP_CONST_INPUT_CHECK(mask, val);
                FIELD_PREP(mask, val); // or field_prep()
        )

We have a similar macro GENMASK() in linux/bits.h. It is implemented
like this:

 #define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 #define GENMASK(h, l) \
         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))

And it works just well. Can we end up with a similar approach here?

> So, we are scared of people calling FIELD_PREP() with the arguments in
> the wrong order:
>
>   FIELD_PREP(val, mask)
> 
> thus adding the check that mask must be a compile time constant.

Don't be scared. Kernel coding implies that people get used to read
function declarations and comments on top of them before using
something.

Thansk,
Yury

