Return-Path: <linux-aspeed+bounces-2669-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B297CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwlBQ0Gnkz3dXC;
	Tue, 28 Oct 2025 20:17:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761643021;
	cv=none; b=KLMNR5n7VseUVxrcJpmtxGIFkbXgtMAC3de7aFAtFP7JQcB3UwzWQ/W1KDOUEkJ3Dx1DezL+Gg0OyDcDT6KVE/RRSpCPJV7QPPP+WJaYjrpooCgnyt0gBG1BBgj8ZD8ki/fILwsdMsH45Vob43r3xWc840P3pQg4B27XuAdD9JRUFLJvnAPW1UuRks3GonxcsuaSwS6KIJFpO3mbdDKAyiREgfGS+2habySGQ466JMaWZZKvgpClc1Hws9lCEpEPDsOXUe8WvND7ImFRyxiE99cYYQSzUFaQHOyVUKMaivJaPS4pKWurCBXJThhw/Q29p6Az5m/KMfZ79dSpcROkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761643021; c=relaxed/relaxed;
	bh=nARmoiOvo2miXZHJtV5YjjBbw3vVGV6UZ0ui5NGlLpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijrEJPa7qiDTv00ngtWR4hcaEQzxAZOfnFlW/BCy0aTf27ZJ2Wx9ui3k/z8gHpg8Cz1aauzlX5j5Q04uYRHiafa57QknPtS3mfJtXBzqrUZ6oij+KSyOwgrWvKKwYytZn6j+d/csIerb2HdhRJlY2DjIE5HKUkC3pCfBsHbmLBSNXp+wlDXwkx/9DQGqFZHL6/BvEmmSefZatbyU6ZhE2nsFxszKSlljNZVYfO58CAqGmOQN8LYi9cBe59y/va93UA0uhjqk71nEYlk0URlrZ0XggiFJlF+F3eZ97pvnmH1XHjLu7o1FWHvwTW7iAOQnRUhDkb7f/i0o0/uf+SpRPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mivb2ZU0; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mivb2ZU0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 28 Oct 2025 20:16:59 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwlBM3xFrz3dXB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 20:16:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761643019; x=1793179019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W+e7hOA/Qjutz+64AuQHJm7aMHFQ0pGvnRZi62DxLWw=;
  b=Mivb2ZU0ieQamyaIixD6ptqkGNYlNvJdsZdGfYR8MY8yCDAr+AW+9hI/
   Hpiu6v0k7VtqJCCyHpIXb1zX0/D7R+DzOVquhkyW87dWmSBx+tYlLctl6
   u1oA/DOQUcsbbvMdi737KKrs87eW8k3Pg1buzDK/fgkyc2lHUjl/f2wih
   JYXeZ/S8op51V1B6K8st0Wzn5g7tBVYJBFpbIARAOyF52f3qYeM2uayVZ
   vowcAR9TByhOZPHfd9BfHVQw6FkZVzIWdf5IqI8AJ83tK3OZn33s9yYiC
   aWDjW5TPTWZLAPGhb1Nu8tZoMxBoEiARLDX/sBKJKtjzZEfu97rlms9jC
   Q==;
X-CSE-ConnectionGUID: dtGc3xfQQDKtbm67AyZSxA==
X-CSE-MsgGUID: M3mCrk5aRSKpcdNOdwGq1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75081601"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75081601"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:15:50 -0700
X-CSE-ConnectionGUID: HnXMTj+ZTTS4uXqyEjc08g==
X-CSE-MsgGUID: 6qzZimyUSheG9U+2/VGM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185624057"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:15:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDfnk-00000003GRk-3M7B;
	Tue, 28 Oct 2025 11:15:36 +0200
Date: Tue, 28 Oct 2025 11:15:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
	Yury Norov <yury.norov@gmail.com>,
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
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 11/23] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aQCJuADNYTzdbPQJ@smile.fi.intel.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <bf68a22ce5be93bb2ea0a0c53071433814401ff9.1761588465.git.geert+renesas@glider.be>
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
In-Reply-To: <bf68a22ce5be93bb2ea0a0c53071433814401ff9.1761588465.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 07:41:45PM +0100, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by adding them to
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures,
>   4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>      actually constant.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.

Some comments below, but FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
after addressing them.

...

> +#define __field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;	\

Unaligned \

> +	})
> +
> +#define __field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__reg & __mask) >> __shift;	\

Ditto.

> +	})

> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_PREP() directly instead.

Shouldn't it have Return section as well?

> + */
> +#define field_prep(mask, val)						\
> +	(__builtin_constant_p(mask) ? FIELD_PREP(mask, val)		\
> +				    : __field_prep(mask, val))

Personally I would give it a single line (but it's up to you, folks).

> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @reg:  value of entire bitfield
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_GET() directly instead.

Ditto.

> + */
> +#define field_get(mask, reg)						\
> +	(__builtin_constant_p(mask) ? FIELD_GET(mask, reg)		\
> +				    : __field_get(mask, reg))

As per above.

-- 
With Best Regards,
Andy Shevchenko



