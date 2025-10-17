Return-Path: <linux-aspeed+bounces-2510-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC9DCCD199
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 23:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpLxn0tngz3cZ2;
	Sat, 18 Oct 2025 10:43:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760727106;
	cv=none; b=AlY8vpFleHuMf4TEblJoHQwWA9lBMHcG1Ija75pDKT8RDcYChNbTBJx3h+zCeQsVkRLs33adZ1jxJMtWBwTktEcvo/MLY43Zh2CDRdh7wrMmJqeqEKrVYSpnL5KtRk1+h9hTd9PpsRXrcJr3wNFi5mNpnt7EWeEQ1BXuDLNIso6hGFZcd2V4uB8LbDpUAwkm5edUHLJy6d9HadYpkWa7zid83nXgekjMvwNeHEEjAHxjvbbnCl2TecCMZuOBsxSaWO+P203WGSkhUXA/QkQd1380c4LkYCp/8MUCKn3hTA0LxxbCLPJ4fbvLBPPPzLuTFSjM6GJ2y60YwOGngh2DTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760727106; c=relaxed/relaxed;
	bh=kcMHrjvb7aW8dOEyGXLP26k9PcHppfS2rsN7ygfXW0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw9Ttw0A1djVLO9atmxnTWI0SOumiozspXHa+gCLPFHvRs1l1NPcI63XnmaR726aGApl3a7D36qcF9tfXQq9hsF6YHlOWHqHIZgHjy4drsh6A/HN9yUt/Z7cyzRz11Zk6ylYPX0Xysf1w0zS3kDDJaLC/zMe0mFworTJVntO33sQv0wR19V4YpolT98gVggP/n9IEu9R88vtx9uXgSErGZCENq5bfMd28qzkFQGybHXN4I38MIyqAz80WRek5jodJT+cowCgdQq8Bffdi4mJG1vO5KuHLS/8DSewf66n/mVPIn/odIHHuCsiZDPfyPAaVW9IX5+bUmu2enNe4VfJlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NF+u4oqs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NF+u4oqs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cpDSc6hfLz3cYG
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 05:51:43 +1100 (AEDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-88f26db50b4so306900585a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760727101; x=1761331901; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcMHrjvb7aW8dOEyGXLP26k9PcHppfS2rsN7ygfXW0s=;
        b=NF+u4oqsgWFHyu/yLmmvtfEikr2UbdFUTqbg4k0Da7Afens37kWEtrIdIyIa/Ll6hG
         jsalAJ81LlJzbSwYkINlK+n1p/50RPmmndd0sp1rLh1hgjn5w3il9emz7UMheRa3Od3c
         iUTeHwtGmMAoOGqEPk4gYXcyGnySiZNhoX+lC5sQW5vLn4m51XXAF7NUCmY3itIfllu4
         DPVHeTlZgR3Gt6qhBiwvz9NY8CPOX1iqDutCj6iaAsWP3q/Kq1EM7ezoFcZrecAZWp3H
         BeZu50bTlT735HCpn09AqUbaH0VyScKfD4fXKjqvlTe9AYYcbIsap23PQnteYKxK+dq1
         CJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760727101; x=1761331901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcMHrjvb7aW8dOEyGXLP26k9PcHppfS2rsN7ygfXW0s=;
        b=cwEk6tU79o5PNwbmkWHawwFQZzodU4qzu6KGbRJn1+nLrKz2SXnQf6aNfo7vSRqlUM
         OGbHlF4e7VFQlkWNoNn8ivsXZ7fMwQ/am1fi7WgRU4S7eCvK0j1v5efU/bDy5kxA7+ru
         t4af9txPd+rwpXxHWKM3Ew3LZPUUniC2+b9gs8T/VsL0fMnDEUE+EheIzo4c8UUvo55p
         s6/Gs+BK3wzdNCPsKqC0smO0Sl3TiY3idP21Iq7oZ318JKgYpbGrRWLuiKAooozfdbYA
         V8LqkObmf31oRcRvHScAevg7iKhbPFc233HbMIIa85o5W8JyVDnGFAU0WhUzSmOB7iWk
         sG0A==
X-Forwarded-Encrypted: i=1; AJvYcCUutABIOH0djpw+g1Bkc27bHZ5tIZtEdKAeUO9kGOHNRyyjgbAzMoX6l5tB1jsCCC21qQFCszS+6N0mwZo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzA2YSF4mH0yO64//MqoPx8T/KrrRzSBhS/P+dPaXa4f8ucV2DF
	eI6ZWtND+fiBrvVwrDd3aTFLSk6ScQu1gqt1iYgi5x/mmDpuKewzMlup
X-Gm-Gg: ASbGncuZlExJIbxZfBvIMvCgFGB9obsJWp5lgBGkwORXroG1kaktJlw4d7JtSzIv2KZ
	NhAcDUwCRP9hs/ZkjmbKX8fn9MP/dfG8d3494bcjkEXpqu90z3HdQp0itvcmQhR+E7rT5faFwob
	WYkbdu1CAxuUW/6SOBqDUo48L4BCOyzXdG4B1xTc0oD8fEDysFJ2dxiJ4MwTsv6CHgez/PiqbQK
	SpoFJLJIxbNCd9pW2oLoFckztZNOF5tMld+fCZ/J7yQPzR8bcs/0RhNxNYFSA7nHZpqp0atdKa7
	7an8s+Qjfd7VYHpGhVvbDO/biPsBn0gkMMe5WCU9B8hJCnQgHsxDigGWhaTtlmlBEr46Wb6a+84
	aPH34w1KTS2H/l0Tg9Ash4cS9G2A/pG5/fVIdqcUca4z67EgmvUlRPmEv73gZt2VI3lT7n/rt9Y
	Jnrd33UPs=
X-Google-Smtp-Source: AGHT+IGgZXVqJ39mGvceINRef9aDCQGOzv3U5h5nFkBRWec10RvkxHjWCypd6ooOxs18G5q6X1BFng==
X-Received: by 2002:ac8:7f48:0:b0:4e8:910a:ad95 with SMTP id d75a77b69052e-4e89d20f6cdmr65322091cf.6.1760727100900;
        Fri, 17 Oct 2025 11:51:40 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf87ecdsm3689291cf.16.2025.10.17.11.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:51:40 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:51:38 -0400
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
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aPKQMdyMO-vrb30X@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
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
In-Reply-To: <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>

On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by consolidating them in
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Crt Mori <cmo@melexis.com>
> ---
> v4:
>   - Add Acked-by,
>   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
>     power management debugfs helper APIs") in v6.17-rc1,
>   - Convert more recently introduced upstream copies:
>       - drivers/edac/ie31200_edac.c
>       - drivers/iio/dac/ad3530r.c

Can you split out the part that actually introduces the new API?

...

> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 7ff817bdae19b468..c999fe70076f6684 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -220,4 +220,40 @@ __MAKE_OP(64)
>  #undef __MAKE_OP
>  #undef ____MAKE_OP
>  
> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + */
> +#define field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\
> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;	\

__ffs(0) is undef. The corresponding comment in
include/asm-generic/bitops/__ffs.h explicitly says: "code should check
against 0 first".

I think mask = 0 is a sign of error here. Can you add a code catching
it at compile time, and maybe at runtime too? Something like:

 #define __field_prep(mask, val)
 ({
	unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
        (val << __shift) & mask;
 })

 #define field_prep(mask, val)
 ({
        unsigned int __shift;
	__auto_type __mask = (mask), __ret = 0;
	typeof(mask) __val = (val);				

        BUILD_BUG_ON_ZERO(const_true(mask == 0));

        if (WARN_ON_ONCE(mask == 0))
                goto out;
        
        __ret = __field_prep(__mask, __val);
 out:
        ret;
 })

> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position
> + * @reg:  value of entire bitfield
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + */
> +#define field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\

This would trigger Wconversion warning. Consider
        unsigned reg = 0xfff;
        field_get(0xf, reg);

<source>:6:26: warning: conversion to 'int' from 'unsigned int' may change the sign of the result [-Wsign-conversion]
    6 |     typeof(mask) __reg = reg;
      |                          ^~~

Notice, the __auto_type makes the __mask to be int, while the reg is
unsigned int. You need to do:

        typeof(mask) __reg = (typeof(mask))(reg); 

Please enable higher warning levels for the next round.

Also, because for numerals __auto_type is int, when char is enough - are
you sure that the macro generates the optimal code? User can workaround it
with:
        
        field_get((u8)0xf, reg)

but it may not be trivial. Can you add an example and explanation please?

> +		unsigned int __shift = sizeof(mask) <= 4 ?		\
> +				       __ffs(__mask) : __ffs64(__mask);	\

Can you use BITS_PER_TYPE() here?

> +		(__reg & __mask) >> __shift;	\
> +	})
> +

When mask == 0, we shouldn't touch 'val' at all. Consider

        field_get(0, get_user(ptr))

In this case, evaluating 'reg' is an error, similarly to memcpy().

Thanks,
Yury

>  #endif
> diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
> index 828af3095b86ee0a..6eee89cbc0867f2b 100644
> --- a/sound/usb/mixer_quirks.c
> +++ b/sound/usb/mixer_quirks.c
> @@ -3311,10 +3311,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
>  #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
>  #define RME_DIGIFACE_INVERT BIT(31)
>  
> -/* Nonconst helpers */
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
>  static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
>  {
>  	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
> -- 
> 2.43.0

