Return-Path: <linux-aspeed+bounces-2789-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078E7CCFA03
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 14:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2Q2W2Vdsz2xS2;
	Fri,  7 Nov 2025 01:44:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762440291;
	cv=none; b=ekafOXUhXvxVJ7D0v2q7/IB+mRi8CEBccJ/vdhpTJCxerGcgXN2fVkHqGejfejW8pNTmwwo5JOXbTzcuzsE6UZ07ibMo8MUHUtSOOnhWeTAcZ2i3fdfuReOsZMZtFwPtkTwWcAnkDUyi3PQbGK08NPiWOnd0rp1zrIY1gpONpDQ21cEJf47uNuBR3fowHcSqbNyCCqdv8y22i/kIC6d6FTHXj7HyBVB8vcmveUKPuDVrPbT+GgWc2FaoNUS5xJLI9nAj5Uk6UweSPBH34Nxn3Rfpl4uwWkAyYE6ILrHBM974/w51BvSqN78DIA65v+DUpA+WObrvt6evB9LDBqC5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762440291; c=relaxed/relaxed;
	bh=Y+xJKA4uDsqdxA8J0m5vL1gE7S37y8IhTpLXD4dVtws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRUiVIWhAqFdjSj5T0wZoQP5duu0mXPGcRrWMJPgfEUmkTi2FRLN2FXjpJ3AxkNTrJYxck5AJMSZJlS4BmY8PZHOaIVaCEEVTiscGsgSCy6GMBZ7N2/wrbRBNmEujpCQEe1qb3LNulHml3TPttw3qQPleO7iyw9Z1tTD6gKjGb0gwtg8/NvqhLNawTuPXZkcc97IhHxVO4taSQzWeOgGeVcBEqA0FYxBs7aVCGkuKDDxMircCGEqQyGGjJCPUgbV5YGDgyzjdMABgnZ/piJDJEQHyc4MZfj0zT7g88LB0rAo9Zcd4Be2axWpMMMqM+oDkFPCfjcU9zACVvEifkiaCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yy3VZAIw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Yy3VZAIw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2Q2V2Y52z2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 01:44:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762440291; x=1793976291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CgKPrhlOB1S3JfrLDg6vTp5p6jX2SaUAEva586MhNWo=;
  b=Yy3VZAIwAc4YregUspZXZc5JXJN3TNdH6ob9xiH0cCzbb6hHjutcFEt2
   MlawIZhHJlzKE3Ge+vM9PW549oS3+tSBdqdGDxh6iS7qa7xy8o4b5Uj9C
   U7wGTp0uReYuCMYWcDqx4CXpoSYWPSkbFpbb0x4qBYaGhraU2UkkSXsk6
   pqf/KHbRSczVXYsG9I6sauIsBl18rlJHmYNezMvqbHKRAbZTQyEEDROJJ
   laX3RS6C29LLtwnU0af3pg9MRlqfgFEOaJdiGtvWWtzovtsyIXivm9/aU
   VJm9M6DOYZiHc3FTPWZFLGpWNDp9HavVSkgXHEXI0cziTNZaK7iJ169kH
   Q==;
X-CSE-ConnectionGUID: LV9pV69gSve/Oe+H/cJLRQ==
X-CSE-MsgGUID: bR+jp6qbQUuecemLBxUBAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64612572"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64612572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:44:48 -0800
X-CSE-ConnectionGUID: kvm5eJDVRiSb47UCQQrdxA==
X-CSE-MsgGUID: 2tiTZfdERMmRL0zFQqehgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192819498"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:44:37 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH1E0-00000006AO5-06YC;
	Thu, 06 Nov 2025 16:44:32 +0200
Date: Thu, 6 Nov 2025 16:44:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <aQy0T2vUINze_6_q@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
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
In-Reply-To: <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> (long) long" _mask types.  For constant masks, that condition is usually
> met, as GENMASK() yields an UL value.  The few places where the
> constant mask is stored in an intermediate variable were fixed by
> changing the variable type to u64 (see e.g. [1] and [2]).
> 
> However, for non-constant masks, smaller unsigned types should be valid,
> too, but currently lead to "result of comparison of constant
> 18446744073709551615 with expression of type ... is always
> false"-warnings with clang and W=1.
> 
> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> used in the fully non-const variants later.
> 
> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
>     HWM_FIELD_PREP()")
> [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
>     warnings from clang")


Also can be made as

Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

The positive effect that one may click that on Git Web.
Ideally, of course, would be an additional parses on Git Web kernel.org uses to
parse that standard "commit ...()" notation to add the respective HREF link.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

...

> +	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> +			 __bf_cast_unsigned(reg, ~0ull),		\
> +			 pfx "type of reg too small for mask")

Perhaps we may convert this (and others?) to static_assert():s at some point?


-- 
With Best Regards,
Andy Shevchenko



