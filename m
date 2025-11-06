Return-Path: <linux-aspeed+bounces-2808-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67797CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqm1Hfcz3bf2;
	Fri,  7 Nov 2025 09:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762444907;
	cv=none; b=IZdi36NllfiZ6O1+sAGiwi9LMrs4pKy/0vaC1BljlqwxTPIdTGEkhjZ9ExM6dgsO6rQ10nBUuDTV1DJrNWyLVPGM+6uvRDZKehkwMpkbkBaYJa9RRckM7baXm1jSUauRN1yV5blijEGPh+a6T7wzGgMLRStvmKxtKHo+Av0Hx9zuovUILEOJDzk+vXrtkc57Jdr4DZO7QnTuZi6xhQDBE/As9Idq+CoGxtcPn1YrfpKVdiLxgjEmtSf4yrSN4Ga0qqy3bUsHzQtj22ZeSViztQLgg9RrmYX0xejZgUFEsDbjZ8iz9Xm8KSpF6G9k0x4gfc8iOGTYWwDZ1rj7TDDiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762444907; c=relaxed/relaxed;
	bh=uDqvdpSXd7EVG4K3GSPuN1+lwa+x8rxJ7aM50JiFwXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjPnl+JERZS8aVflBoinhkF4buOMvEQFpKQnVa7cXR+t6NOHpr7dy00D+sXckGQm3z/bnLnDz9vjEh5+wwe/Qq3ln5wXTVkNzELpRE3mBMuZyWXki5/mfa2PKna3QsggVSrlKQEUJqC9RIJcJ+oqQtlwdF7c3PfhHoAeyL6znDLEFixSWfXpiu81MsqSeCtZFhcUMqT2lbzUlB91F8xIMsMNJ6LHCdb3smhg/8BKw21fKWGwZZcj+5kSEntByYTHE0GFJZr/C/lYvjDSaohizbn0kFu7Cvy1L5V49Ra+J13MvgYu+J7YxBVyKVePXqopTdoVnmgiMNA5bdmHFVH1wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=de8+HkoI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=de8+HkoI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RlG1wbwz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:01:45 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-7864cef1976so32906767b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762444902; x=1763049702; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDqvdpSXd7EVG4K3GSPuN1+lwa+x8rxJ7aM50JiFwXE=;
        b=de8+HkoI6khYtKHVTK2UEL26Oi7ufEduDjo9ZpcW896kd9oZfmHCyQE9sxI2iy0jX/
         LNSOiSrKNYLKUZ4z0xLIq7PvUW1pMWpbubmZBIAy7ZTK/1v8lj3A9he+rFTJgedIx6zb
         MYQ02vpNKDgtTqnqAoN3Z3HlNpQEE+u8I4y90YD6HgeX+5spikm52BSdFF4Tu/JaM5wS
         e0fT2G96PIAygngycB9nOBQeDLTmFocmkim+EauGr5eaq8DHyIJfvrnzW+Wer0LTuw+K
         wiKxq0AKWgMyOY8O+SQTjhneyqleH92kL34ClEuHfZYKQ3xGplW0IHEGB84365YhUc4Z
         ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444902; x=1763049702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDqvdpSXd7EVG4K3GSPuN1+lwa+x8rxJ7aM50JiFwXE=;
        b=CTV5W4y5V+8KL2rb9K/L7zayCdjZ2HheWU9corGmmIX5j8bznfJpTK/20NrziWZtr9
         fpTrNmrhTz+7B/MZXVYPhtfAsCUp+AXLz6sdm7bis9m9sB1oFiwsOfEeF84fGDOgo4tU
         YrDCI7dQ3b1QXS88U23l4XdzZiODW7H7AoRNnc5g0HVXU5RpreW9G6j55yUYiuVlFpja
         FkzBNB0k/dtEiCFu3A8qtlRkhB/sfyZ3hJxJGZcFt/qhFMNkhYzPpziZgC5zm4Fsrgfm
         XlvRUWBLDnU2TFYjCwAqjE7gbz4hKkvDSJj6yzP4u5snkwF9jTkF0NRd2qOkNoKO07ch
         QzUw==
X-Forwarded-Encrypted: i=1; AJvYcCXzgx9NVpHSyehmMReO5zye4T+/Nev1SDuN3cywGN1ZHdZZr/fVfyZjYIjFczMzq/KydEgCjFqYTI4kr6Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxt5ZyHxHejU/oa7es1FBacbo+GrGmMQidmbjSgySc25BnluBr5
	wWnaff77pHJGOdTVgcHji4s3apqt3xGTmUoRxhjj95R5O2QD0qDArjDt
X-Gm-Gg: ASbGncuaGV0TFIg0gCtYE1lA1rpbddOaOTh1U8uW1rhUwfhcs1fGOrnh6d0P5RLaOii
	QxIqjno4g1XYorlPfuXzMezUowgNQc606B1KmQS9KocAX1EKYkHEYYPoeotPur2j080o+1/PgEW
	xl7oHsJzRutKC7bz1Tx+LtR4AxQEBnWnmzqPmoC0VyZ1pJ5mTYWRgMNvfuX+lPwE3f17bdOVaxc
	YFgUGcBr1rko/O3u5q6yPjOLu/TdK92Yw1iFCJQ4UTpZlF7HSIIceDMr2LzhX4kx2MdqoWwnN3t
	drsS+7NEIKompzpFojHzVYc3UCEoGixI+bqyKoyw/KSFJ/dv4j56sF+IZb97RJx0JIhNxyo+wmU
	bvUijJ6c1M/cLO4gz+mB57NsC4CfFx0KXj73YW+jFsLbDjZEofGt9JmhVisr0GuYUO/5hyUISBl
	m+RTjBA6jO8ojlBUWtm6c/d5CjHiIeWPs9
X-Google-Smtp-Source: AGHT+IHH1OiCGEbzPId419SmPeowjgjZvd2uwuBPgu14uOeMTfnhF3EzyBaZ3Vf1fe9K5qAqRN9gOQ==
X-Received: by 2002:a05:690e:2405:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-640c3b56ae5mr33952d50.33.1762444901924;
        Thu, 06 Nov 2025 08:01:41 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b15d6379sm9121887b3.45.2025.11.06.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:01:40 -0800 (PST)
Date: Thu, 6 Nov 2025 11:01:39 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
Message-ID: <aQzGY4AKiMQpuL0R@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>

On Thu, Nov 06, 2025 at 04:44:31PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> > 
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=1.
> > 
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> > 
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> >     warnings from clang")
> 
> 
> Also can be made as
> 
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> 
> The positive effect that one may click that on Git Web.
> Ideally, of course, would be an additional parses on Git Web kernel.org uses to
> parse that standard "commit ...()" notation to add the respective HREF link.

Those flying over Atlantic or cruising cross Caribbean would disagree. :)
 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ...
> 
> > +	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> > +			 __bf_cast_unsigned(reg, ~0ull),		\
> > +			 pfx "type of reg too small for mask")
> 
> Perhaps we may convert this (and others?) to static_assert():s at some point?
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

