Return-Path: <linux-aspeed+bounces-2809-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B5CCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqm2jkFz3bf8;
	Fri,  7 Nov 2025 09:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762446715;
	cv=none; b=LEv+/eJZ2sOv7eFVWD4wu+EhXoOrTIyLdVIbINmOKlq2teaLVSG284G47gXYT6ctmMukJYZY+CxU+RayEl633JNXs9e03R6gACL8BXILcQGpSN0UsCZII4+V8rDW7wpCJyGIOQ3lSor4c9J5TigDbyX/Xv2uwG/dlO7Gkn/tehluKvFqFROsfZIle2E0Fy8qdLJbcgrmV3TXIdSsZGNRfbDoJ9jqVYGT/6V7W73o6UIHx/ypTJEWrlV6FQ0ZTUypNCXB0XuUcU8LRlmrFtJvVmROXyL42gFHPvLLbP3tIbOTMJCdp1xEZ+BCxqqgjfh/Qe63yrvXiPXRfzz5Ek/LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762446715; c=relaxed/relaxed;
	bh=mLV2PDnl4Ik3dMiBcJ6vRzCiNGFzAVWq7I4DrxmSPKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNykGAgUiCCvf9iLESiKF+A1OB5mWmQZYv0DAd/yfka0DH7jYJTx+oNI50UGUmXLcUBIt8f/b2gW6lNrjIkc149ag0LSjpBPxqnMXxOeR+pR8a5ksWUb29L2NoCW2wo+GYwO/NeHuFgU7fuzltHzCIUpTtgluWNHTT2UUsCvKnT2JRS/KCaR8vdBAACk52uGQxTT6yySgdwKtYFw97IFLXKSxiY1WJd3fJIZQ9mbx5oS2eD47KIYV/GqWGpuA/2m8h6PEgVy0RjxIQUShWClNEx2WQf9tPmwwWzVK9rr+aGnhG16kdJDSOd0oGQQQEgLV+GP2MemPORI6cw0AVjeXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c++/fE4Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c++/fE4Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2SQ20DClz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:31:53 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-640b4a05c1cso1283725d50.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762446711; x=1763051511; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLV2PDnl4Ik3dMiBcJ6vRzCiNGFzAVWq7I4DrxmSPKg=;
        b=c++/fE4ZWbiE5Ul7bM/lnQmgaLbJJBxpwXbehOfyN8DIwN0iH535+tg4kegp9PaUKv
         ee9drxOKrkmh2C6ElK4Ot11/qLE2d6ul330Q3AoBdzB87FrVtnIjZL4MUcIqazmO47yE
         VlXBnEr9a/8Cr+cVScNKF+UCn4dc5URtM3fgtagFu4vSu+378+pzOIk9vSCgHO+becDs
         +XqOHBnXmz9ewSj8UanBCunZPUlCGZTS6UR9dqoF/LdI6/WYBYEPO4OR0GIRGKFEYdrb
         sxzuE2fIX6uajUHX1gIZbv3HV/Hc2z8euG9zmvBaLM3Ynav2XnqlUSyoLlWgQgfeDhoo
         D15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446711; x=1763051511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLV2PDnl4Ik3dMiBcJ6vRzCiNGFzAVWq7I4DrxmSPKg=;
        b=VeGWWOZ5RO/IjiIE1BWXggAivJE1IImer8VTBe33N4r1xCMJuxPsrGxmdijs66yvQr
         5mEjO2dP8v9aKCUkqhryayuhwyWUKnV3AkhDZERoVxSRN/wMv/IMBf2sYqVU6Yslu/xz
         cn4TAPqKHTjSdG5wO8rrWrFlIRXegxkyFUaJ7YGb5LY66KJnpfeN8NnNhjjWl/fOVJQP
         W7Ko73T/6TwOVS6SYaEKzwJdFomnGpIg1KUxI6LcEwpsxeOrK1DcLhAjQeCLj/9U1w/j
         6CT/hZWVzN4vtwwXje+i0Bj0DYiZESUj53shI93IxnF4ezpKafEy5FnqesWtnDnz+0JQ
         73wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1c8fGyG/AGaSka/N2zevA/fMJVQm6KCyOg/X6pfco81m0PbgNODRCxmYlbKosKEKFbv1hr+hVl/S+a8Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxcHb36z/55lzeOYiy9XDr+DoYXYmkkWyunnDgQdGThHVuc7fZs
	ZiGD9v/svxjj0nf2lkHi9n6qpcUzOSlBNL3q7mAMmJdG153Ed82HsaoP
X-Gm-Gg: ASbGnctnCF5JVu4eils+0mpvXB/eaLjxqIJQlO3S/rMURIin2KtjbNomUEA+eLRhKgZ
	Io/2Rg857FdvMKHy3SDVXqv6/icJqJ+LrSnKd9BiAbH5ozAnzbXx27QWH6PPEFTHPATI2bstLtP
	BRg89tBDHrLEM9Pp7JZuZxJJbwSGI1mvUoNHPl4RCpadFesgvfAu1S8+1y7Wvu0Oz53h59nywLp
	0wo+o1pvjEjesL+devBq/Vzgh+C7sq1FxdnKnXlNnIjauUKvDBrBe3o68K+ycLEHX7f36mp8JF4
	WTyDQcf8oRKMffXq4colkpsTdJWBGqD2MTr8D/gtDxtoDzHBScwvgwLC2DYhbYlpZw6RYhVA6vk
	zHWjqFQygFylCsLqCx+oI4LhlyN9cdfv9lNq2tquzwAP2aVllGvuXspDKdbyr90lpbO0HmEphBA
	s0P6lQbpZQC4JMquy+WSEUSJ9b5hBuPf3y
X-Google-Smtp-Source: AGHT+IEpqWmkZjuH3DQIeoTdW2YBETsoULiRC/YJVd9G+NTFiGKOkPxXPnseVKzqKGSB50LDoYAi6w==
X-Received: by 2002:a05:690e:4109:b0:63f:b9d1:b165 with SMTP id 956f58d0204a3-63fd359be98mr4428593d50.50.1762446710597;
        Thu, 06 Nov 2025 08:31:50 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d94487sm902855d50.21.2025.11.06.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:31:49 -0800 (PST)
Date: Thu, 6 Nov 2025 11:31:48 -0500
From: Yury Norov <yury.norov@gmail.com>
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
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 13/26] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aQzNdJFcStVak5jS@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <62a5058e460129155e4e7539e37140bd0f0d4abc.1762435376.git.geert+renesas@glider.be>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a5058e460129155e4e7539e37140bd0f0d4abc.1762435376.git.geert+renesas@glider.be>

On Thu, Nov 06, 2025 at 02:34:01PM +0100, Geert Uytterhoeven wrote:
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
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> Acked-by: Nuno Sá <nuno.sa@analog.com>
> Acked-by: Richard Genoud <richard.genoud@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> v6:
>   - Align \,
>   - Add Return sections to kerneldoc,
>   - Add Reviewed-by,
>   - Document field_{get,prep} in top comment block,
>   - Use less-checking __FIELD_{GET,PREP}() to avoid build issues with
>     clang and W=1:
>     https://lore.kernel.org/all/202510281335.UpSLYJG9-lkp@intel.com
>     https://lore.kernel.org/all/202510281414.DnejZh4n-lkp@intel.com
>     https://lore.kernel.org/all/202510281304.RK3J3c3t-lkp@intel.com
> 
> v5:
>   - Add Acked-by,
>   - Split off changes outside <linux/bitfield.h>,
>   - Document that mask must be non-zero,
>   - Document typical usage pattern,
>   - Recommend using FIELD_{PREP,GET}() directly to ensure compile-time
>     constant masks,
>   - Check BITS_PER_TYPE(mask) instead of sizeof(mask),
>   - Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>     constant, to improve type checking.
> 
> v4:
>   - Add Acked-by,
>   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
>     power management debugfs helper APIs") in v6.17-rc1,
>   - Convert more recently introduced upstream copies:
>       - drivers/edac/ie31200_edac.c
>       - drivers/iio/dac/ad3530r.c
> 
> v3:
>   - Add Acked-by,
>   - Drop underscores from macro parameters,
>   - Use __auto_type where possible,
>   - Correctly cast reg to the mask type,
>   - Introduces __val and __reg intermediates to simplify the actual
>     operation,
>   - Drop unneeded parentheses,
>   - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),
> 
> v2:
>   - Cast val resp. reg to the mask type,
>   - Fix 64-bit use on 32-bit architectures,
>   - Convert new upstream users:
>       - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
>       - drivers/gpio/gpio-aspeed.c
>       - drivers/iio/temperature/mlx90614.c
>       - drivers/pinctrl/nuvoton/pinctrl-ma35.c
>       - sound/usb/mixer_quirks.c
>   - Convert new user queued in renesas-devel for v6.15:
>       - drivers/soc/renesas/rz-sysc.c
> ---
>  include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index bf8e0ae4b5b41038..f92e18c9629a59c6 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -17,6 +17,7 @@
>   * FIELD_{GET,PREP} macros take as first parameter shifted mask
>   * from which they extract the base mask and shift amount.
>   * Mask must be a compilation time constant.
> + * field_{get,prep} are variants that take a non-const mask.
>   *
>   * Example:
>   *
> @@ -240,4 +241,62 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +#define __field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\

typeof(__mask), I guess.

> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\

Same here: BITS_PER_TYPE(__mask). BITS_PER_TYPE() doesn't evaluate the
expression because it is based on sizeof(). But we definitely don't
want people check it every time they read the code.

No need to send another version for this. I can fix it inplace.

Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;				\
> +	})
> +
> +#define __field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__reg & __mask) >> __shift;				\
> +	})
> +
> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @val:  value to put in the field
> + *
> + * Return: field value masked and shifted to its final destination
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_PREP() directly instead.
> + */
> +#define field_prep(mask, val)						\
> +	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
> +				    : __field_prep(mask, val))
> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @reg:  value of entire bitfield
> + *
> + * Return: extracted field value
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_GET() directly instead.
> + */
> +#define field_get(mask, reg)						\
> +	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
> +				    : __field_get(mask, reg))
> +
>  #endif
> -- 
> 2.43.0

