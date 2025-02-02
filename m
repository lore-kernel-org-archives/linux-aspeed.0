Return-Path: <linux-aspeed+bounces-600-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C65C0218F
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 00:16:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmRqf0B4Pz2y8P;
	Mon,  3 Feb 2025 11:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738518841;
	cv=none; b=hyEMYV/HEjN8j2QC9CyyeAHuUBCKdFdjkQ6WKTdZIFuiH4bPAZLrXuFBy7Qv1fPlCpiMshtE8EevSsqM5qm2XddKMgl5Vmn7ZK2NZY+mTBMHsAUDfPTDbIcJ/87xbQWT5pr0A5kez7Omh6CnTbaNavxg68QQS0iTVlhWknsJ+J6MhSgmLK3tZ/h4lRASQFV5t75dku0Lx+fWCMqQC7d7Ejc2ef+gudhzPvXB1p3u+TOx3Py4rGEzYxUbr+pmHfk0ODkui+OTERkBQ4u5KVM0c6DXGmPOP/462qVxd2g87k7AMEp47ki/kG+YGLutiBknQnMBt4pkTs5YSEOCYoSUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738518841; c=relaxed/relaxed;
	bh=bu/o5ZKE+DmrVvfqpvDfKwO+d8/POCqsIdA64ajmPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5QGS0P6uJW6phs1Wwt6+2iwz2Xm2gNARXhx8oW7ZomyFDreCP7ue/MZsDJv8gzSwXeulArNK3JoqOREf4/KygFglW0W+MYBlVdkhsq7AktzGKaXT1Orb5u4OnzMGDHzdeZgkrl5cvObNqEpkBw5n3mvNBCpr4SZpvFf4mDItHdVQNda3boKvulpOM4+zQ+DjvKggVMba2zYSZudl7xbP1TmkIZR0zwTSgoHppTe/ssbgmPx/84pa4DNW9ZWfA2GD5CbNFnHtOSvivX9+Z+mMB8PFTfRT9K/N8aw6rrsIgkDimT7eYXT/ZUkA8ZjR7E4YiiG8TTzRZB+DO0W2imgYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FPBaY0it; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FPBaY0it;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmHLb4psdz2xBk
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 04:53:58 +1100 (AEDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-6f6cb364c7fso17285557b3.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 02 Feb 2025 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738518835; x=1739123635; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bu/o5ZKE+DmrVvfqpvDfKwO+d8/POCqsIdA64ajmPWE=;
        b=FPBaY0itWgqelvyRhjXMuFQiBeKLV4aPsy+aoHdHlX8IN+sJA+/AQAqlayIz2xkAWl
         aZc108Nf1c4Mu6Gp36tCHZNl6oYtJzyWN0XOp0mwaAwNm/ZOLgDCzPdTFzqArrSTEauh
         Dq7YMfJ40xYJqbsGsSoXYBTPPMyicGsPXkw5AoyxB4UIecpm7brBxVbcQJr+XyeG5ARh
         V6y7Jj7uGLf7jpJZhoYUg+z7jFZe9379wtBijoh30cLoX0fLjjBPlJRy2Gb/WWQ7nGsY
         ICmw4E1ZmV4i6NQ6n3/iCHQVBJ5jMyf5+ib5o0GoHwIdNwJvLXuG5wbsTJ9By01UqUQx
         Muaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738518835; x=1739123635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu/o5ZKE+DmrVvfqpvDfKwO+d8/POCqsIdA64ajmPWE=;
        b=GLAA62QGDQ3Vx+QE11OhXecc7nqJCJhKKEmIxb7MUmV/aS5I9uc7LCr7/MmUlMa2QO
         YCKZzc7nvIVhufefkRdrbd0Tjsh3+GAjN61hFKMRDuzfcQhuq7MWbx9CyJ/zSDzPV3h0
         SZKYFoWEa9TWlfwlBucUHyT/iF8mxuL9Yi51qgcpsQCD4sombmMQAXrL7MKj/fvuOyGN
         WbzMjWRUDQ3RzmbMkR8yX6I7qIVCLOLbo6C2/nTP3lA+S2dhfKPOJ450TVd0dDDFlMR+
         mAfZugE3cMJv4iBfUVCjkkWsPkEnSzKIhxHU0JgwuWWT5DbKfaEpoRhx6CT7sbXOvd3X
         kAKw==
X-Forwarded-Encrypted: i=1; AJvYcCWi2O3Wnw0Z7R2HrtNd9iNWYWZ9V6Q4qZCyuCod4gdwe+gF3aIG36IqqSzf2gynEHBQDOrMxLVm3DMK5zU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEacGihDrMcNnr+eIb/8qG0+Bb52MTjatES7lpa2zqXKyUwDrc
	mr0wBlVIxvGwjnF0Z4FzgMReWVdfT6y9koC2ZoQbsBSvVO5sBAEQ
X-Gm-Gg: ASbGncshtiNFVMdy7ZJsPP6K3KRyrmNocx0MnorNER4CNSPCA6cAu1M76g6hWWo853i
	SeFWPhhaeq+fBoWxOsXdc3yWztOj49WnV1UwZ/n4LxgriNv9GdUsXgmjYnZxozmZv1hozvJPL4Y
	g/soLl4f1zXrY4HDeGiZzZZAvFptHpStJPyEHb/wqYr1OrCNudZalLcbu+UVeXeLywqbpKD5/hd
	RJcizYlPwraVwTJLpPQqra4aTg07OdSo26HpBZmlDie1SNNgLChyq0OFNVZwBKz8OQKUJ7yTPP2
	5W7m9T4Ryizkl6w//HkkJoMO4HTn6vV2jpdU5b4tJIGgp6MhQfs=
X-Google-Smtp-Source: AGHT+IHHQI3478HvRiKWIVLIdATv32EFyyXdDb7s9xEv/S/0xqBbGzFcSVKK2nIkOtoAuYeOo+6nPg==
X-Received: by 2002:a05:690c:6e09:b0:6f5:4304:fdc with SMTP id 00721157ae682-6f7a832a301mr158970467b3.6.1738518835574;
        Sun, 02 Feb 2025 09:53:55 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f8c465b884sm17908247b3.59.2025.02.02.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 09:53:55 -0800 (PST)
Date: Sun, 2 Feb 2025 12:53:53 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <Z5-xMUqrDuaE8Eo_@thinkpad>
References: <cover.1738329458.git.geert+renesas@glider.be>
 <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>
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
In-Reply-To: <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr>

On Sun, Feb 02, 2025 at 05:26:04PM +0900, Vincent Mailhol wrote:
> On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> 
> Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> compile time constants?

I guess, for historical reasons?

> Instead of creating another variant for
> non-constant bitfields, wouldn't it be better to make the existing macro
> accept both?

Yes, it would definitely be better IMO.

> As far as I can see, only __BUILD_BUG_ON_NOT_POWER_OF_2()  and
> __BF_FIELD_CHECK() need to be adjusted. I am thinking of this:
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..c6bedab862d1 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
> 
>  #include <linux/build_bug.h>
> +#include <linux/compiler.h>
>  #include <asm/byteorder.h>
> 
>  /*
> @@ -62,15 +63,13 @@
> 
>  #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                      \
>         ({                                                              \
> -               BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> -                                _pfx "mask is not constant");          \
> -               BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> -               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> -                                ~((_mask) >> __bf_shf(_mask)) &        \
> -                                       (0 + (_val)) : 0,               \
> +               BUILD_BUG_ON_MSG(statically_true((_mask) == 0),         \
> +                                _pfx "mask is zero");                  \
> +               BUILD_BUG_ON_MSG(statically_true(~((_mask) >>

This should be a const_true(), because statically_true() may be OK
with something like:
        ((runtime_var << 1) & 1 == 0)

I think it's your own patch that adds const_true(): 4f3d1be4c2f8a :)

Thanks,
Yury

