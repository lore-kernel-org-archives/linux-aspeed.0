Return-Path: <linux-aspeed+bounces-2791-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBA9CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:08:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2RvY39TVz2ySP;
	Fri,  7 Nov 2025 03:08:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445337;
	cv=none; b=Rz0EkWlm71jdbw1tL2MHjSzudgPO7osfVbBf8fBSxl5hXy6Su7BA9vWwYWJ0jMU3MdSTTX5NxjdWl0AfwDfp/drfLn+d/DgA4fLDPgvSjVmyJ2FDirEfVapB3GK/gYar5PBU/u9Qfk7FP4i7hqKSKK1wB+1z/RGNK7B3rZM7w27aD/4WT1mZTMxR/QZo1+AfEIkaxSKXLiMvUITgeBAyBTqVI5KOAKXo8p+8GpbzyxAjP+sJgl9nQoP5Ci9LMH2YuHLm/zS1P7IfTVNOyKes//drFcGSWq7yVZyMMlMnZN8tvWE90zKOIk4U/1S9fzynnIKrVziz27wWvV44DY80NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445337; c=relaxed/relaxed;
	bh=nz+pK57me0GYD7xykSprYkBKTfwkflWPuCYpx3wRWXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAlTehSr9SZpy0lxY8krUy/9nQ92/dwWYZ2X3YsK/Hv/UXH/8vwOPL7GtiF8g9qNDL5nmgAGtepmfazubQYL3xW/4ExCc0KmpySvb5ssJyD24j4lpl7Ts5Q8fFKyqncCOrdep6HWGN89Mlu0DmZY2ZNdxO0lGdbb4hkOw+sy6GkVyyI3e9+elIiVKDKmTIUZHPh2VQYybIf3SNEEzVmzUr5/1DsdInS0l18JHb5trSlDLd1l3X6gY/bF3WUtQA15cyamZehphsQK+0jVwMTjmv/2fimo38F2s1FapIvGXl9wHyYeJP/kERYP/l75TnAjgGIX2a/TfY+hHNtEfuL40g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nuUb8dqb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nuUb8dqb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RvV73qSz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:08:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445335; x=1793981335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxSiubnDJFoi3hF0gZEV1dDowKtMOnRvt3PDCt/YgRc=;
  b=nuUb8dqbKMZF/H42fYGejenaBtjAbEfdZJFLpSUCVI8eVIc4bBe8vm1J
   SNJwPVdZ4UHPsORFvKmnV9jr/Fc4IT2mZ00glK3hCpGiCBxIMCa+upEA+
   nKqXchkWQVOtKUBRNvYtrQZ+iigjbX2ORzgV6TUn8xItmoOjxeMoxdiCY
   Kl+ee0hbcSM9K23P6h+YOeAaiiMa67F3ANxzuab4u6RNfgjaJccdWJGTK
   WC34ZEhUWWxA5JXMG6oEaQ4dc8/gGAjjidSInsPiTlEo/FH68GqeS8CGs
   8Fp4nm39Ir1Cne7tyOdyVOEjSFMVMidl5ZghC91bSYspN70ZI+lmrm6ZQ
   Q==;
X-CSE-ConnectionGUID: /B8xbqxASLKNwVYMxLN4yw==
X-CSE-MsgGUID: vjV3Zsy/QpqCSGJYMua47Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64495054"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64495054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:08:50 -0800
X-CSE-ConnectionGUID: csRhl/YrR3mh6V3vjCg1UA==
X-CSE-MsgGUID: aB5X0TIERP63avd4sWT1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187454619"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:08:39 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2XJ-00000006BqD-4AI9;
	Thu, 06 Nov 2025 18:08:33 +0200
Date: Thu, 6 Nov 2025 18:08:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yury Norov <yury.norov@gmail.com>
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
Message-ID: <aQzIAd91tlR3o9hu@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <aQzGY4AKiMQpuL0R@yury>
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
In-Reply-To: <aQzGY4AKiMQpuL0R@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 11:01:39AM -0500, Yury Norov wrote:
> On Thu, Nov 06, 2025 at 04:44:31PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > > (long) long" _mask types.  For constant masks, that condition is usually
> > > met, as GENMASK() yields an UL value.  The few places where the
> > > constant mask is stored in an intermediate variable were fixed by
> > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > 
> > > However, for non-constant masks, smaller unsigned types should be valid,
> > > too, but currently lead to "result of comparison of constant
> > > 18446744073709551615 with expression of type ... is always
> > > false"-warnings with clang and W=1.
> > > 
> > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > > used in the fully non-const variants later.
> > > 
> > > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> > >     HWM_FIELD_PREP()")
> > > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> > >     warnings from clang")
> > 
> > 
> > Also can be made as
> > 
> > Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> > 
> > The positive effect that one may click that on Git Web.
> > Ideally, of course, would be an additional parses on Git Web kernel.org uses to
> > parse that standard "commit ...()" notation to add the respective HREF link.
> 
> Those flying over Atlantic or cruising cross Caribbean would disagree. :)

They won't. The purpose of these Links is described in the above commit message.
Even they read the commit message before clicking.

-- 
With Best Regards,
Andy Shevchenko



