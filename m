Return-Path: <linux-aspeed+bounces-2792-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E01ACCF9F8
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 16:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2Rw6229Dz2ymg;
	Fri,  7 Nov 2025 03:09:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762445366;
	cv=none; b=F+ZFxfQkgaCkcGkEmCfvyThE78WyjUaoBJ7UpB7yQlesX8iFMRMPYR3b8LsQNX9HhYpok3hiwi32SqVRbfoFL2NjnESwXQpRriGUjbcBMs1YwraxQ+qfL12XHB0Njt/wlSJrBd7B2+GDaXAsTi9MvS0g6FMCSxYvzpYkGBrbI4vPFIxqqALOt7nlNi8kjwbIrcTmPOkHCKGiWRr2RORzYuNTDqpDASwo3wbdQoVFh3NObv/JOv4IfBsE4N2OYL00UGNadnqOJ6kCH6sYI7+jFm9ZCjmAlNGxTBdp1duxCido90Tkx0Zd/W5djC3kZM79wqInUkAzoF8q/fyF3DLVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762445366; c=relaxed/relaxed;
	bh=QWMFqahXnFZEYXUQN8+YT87PcScezAnXnt1bCMlV22c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnzHGUNl+EpxE1CFy9mkkDvti4o+83bf/SG5sLt/Jg5kmhykOav2m8oXT7V/lWy8peAie91k46bZh+das1C3gnuqKb6FZr+9oj0YMaQ6b4A5cy7KaINg5UW87+qrKmblId74pH297d9eaDAV1u/De8Q/SecNcDCjaPeQZUU/UvMcXxkJfFpFZ721fIKjdNo9keJ5t6jVywYo3rtbhP3zK4JxQQ77JxTqZTEzrpuVh5CYjjogKnCYhbfZCInEMEwVoMEnD0e6sylvFMdI1mBQCqPDW2oWgT6/asvGGaJZPEWyHnFFWikhkpp/XZA3wPRm3Y4mpS6+OjKMzPMUkyO/sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJuCbf93; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJuCbf93;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2Rw50G3qz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:09:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445365; x=1793981365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vw8ubo+7N9WsgP5kvlylaSWSYsq/SxO6iOGciGtc5m0=;
  b=cJuCbf93XzhRO6MLgWls6fK2e0dQWmINGGuo1L6zXMCkMqSsa2R6F2Hb
   +1oeJFuP5C6Hjb8CpyPkeyXktTfKUamcqlp/KOXy7u/PDQG+vF7nwkkfY
   kQKRZ8HzaZt1PUWU2fnLBkRXIixYIK2pLsauJyZurg6Tuynv9E7Isb+6h
   lGrRzT+kVyzefMlZdVJzyQat8Z6+tL9lvxR+gZU7P8VlS7GDf/i0vS+9C
   ntVBo8yok3eJCSvSbmJYxcwYtwpPeVlsLmMxyb+a8Nh/teXTHCbB/KZbH
   MBHFdahqd6QX93sByEwm53kcYBe6gT2a3PBpHsgEhbTCRcnthJ7dfFv3Y
   g==;
X-CSE-ConnectionGUID: Z00+a2RuSE2c+Q4eYtB8yg==
X-CSE-MsgGUID: Vg4+abByQJOAPRzMfwI0tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="74877958"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="74877958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:09:23 -0800
X-CSE-ConnectionGUID: NMtAY4RTQwCRyv5pYJWnNw==
X-CSE-MsgGUID: 7q5zGf4ISXWoFKQH6Cd2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192150660"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:09:11 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2Xq-00000006Bqk-1JoP;
	Thu, 06 Nov 2025 18:09:06 +0200
Date: Thu, 6 Nov 2025 18:09:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Message-ID: <aQzIIqNnTY41giH_@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
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
> > Also can be made as
> >
> > Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> 
> Nooooh... torvalds might click on it, and complain ;-)

See my reply to Yury.

> > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > > +                      pfx "type of reg too small for mask")
> >
> > Perhaps we may convert this (and others?) to static_assert():s at some point?
> 
> Nick tried that before, without success:
> https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Ah, this is unfortunate.

-- 
With Best Regards,
Andy Shevchenko



