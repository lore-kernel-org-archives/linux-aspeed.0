Return-Path: <linux-aspeed+bounces-2959-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEC1CF6487
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Nov 2025 22:51:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBcCf2WqSz3dRj;
	Thu, 20 Nov 2025 09:51:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763563837;
	cv=none; b=iWCkkS1Bo4+Y9HaG2sWtxoL/A1tfuIsyEviE7V25cWuq++fo5pneNpq1vV+/pecRiV1LHMnjgNmmeGeXGi6Vsp0/XsA/36DJIrvfk3jau9KC4+j8BbyDU4V4WNOceQbcQcX2v3omGz0JKvQ+dknS8mAQJGnj3b2XAJO6fbiaJOzcMHD35Tya00eW4hFd4bNrs7YaeKYYsRWLUq6klyBcsq4lmKbGwD6xTfpTDtcJidh7wzVAyhTy2MJhtQAWhi7kyfkrV2250+KkNvJzNx/amIMZkXwouuUtyTe1rowFBV7uyz+JtHUXM6ZuyCJV/wPx1mfOdjCZDcy3o2Zz8e3exg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763563837; c=relaxed/relaxed;
	bh=UEa5dU5h8VTkStggLA2EFBcu8SFqsu0VyRflw3qSQbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/s8qFbiJlRpcO7v/ENmcZyv+gZQVIy8NNegad8SnUx6qyr9mpe6wSGcxGAUFqvAqyWWf8iWgnNXz0YIQJOiQOr3QpOk7fd5YjWh1cTzQKTaLjsi6qfKv43GWThmcegi3bo321iY3OaTRmIkwdzAcNMKHhkMpoZtg4baTFVPM2RqUbXx9tjDlcw/EsgP2++c/2CW9F3dJ8bZpGXkYJZfKNzx+KE8O1qmaVWFafGsDEfO/YgRSL7w2sWeZnaJJfBZ0eETJrMLJ6tPCSmXfyMMlvYY/B73iI0+lR8phmplcircGmASq3C+nxX4CjLIfO7zpEgRUYIdQc5E4Q5zwi8pjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZI4RY5+6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZI4RY5+6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBPY76SCpz3d8y
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 01:50:35 +1100 (AEDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-88249766055so85045636d6.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763563832; x=1764168632; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEa5dU5h8VTkStggLA2EFBcu8SFqsu0VyRflw3qSQbY=;
        b=ZI4RY5+6bajtzTZAVQDlRojVB/yJFvKK0ndQpUgMrw82KNytQExOJYnrORPeoFTJX4
         uWcvXfygY+mShDmN4kSdtM0dL3x1+9Ra8evvflfsxX2ys59NCD0meaKthKHXnw6xJWNo
         0q0sNA6cRvB8dbt0pQ86pGmYMrZp1tMUDkbHQ2UIER6rLJT4Z08BqUUqflxYRM69lQZi
         GINeVAtcDIdFR/2GVUAHtJ3C3EHI/tkZ4kmuaFc19KiOnLNWtV4Vhkeq/Ga12+xOry+u
         XWTWKRBbb9M2Xk2ERpzMATODuQEBNdH9BdMtFF9QWC76w9cF5y2aBLKeFuLGiIQdT/b2
         HEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563832; x=1764168632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEa5dU5h8VTkStggLA2EFBcu8SFqsu0VyRflw3qSQbY=;
        b=EwXQNz+7vmo8PDMBxdRzxr2+ax/Fq+4eGv7OvHjh7mKWaTVzBmfb5BEB4VGK/UG7/u
         m2+aZBsw9+ob1RSILtPW7K1j1VgFpqKeTF2N9FsKjMaITpg6+YeDJ3FFxus+GOjSof+I
         ivVlXh1u9FrXfBz9GRQJkCx7GRKG11fwpmgzGtVy29UPimrRI6QrsWV5pPYyknSuPhNR
         UwfOyHyWbY9RbbVUi2FprfD0XV2DRMibCtS8BBnaGyBKEI0Cv8B21kBBtK4R3bsRwa0h
         vlwf4MCpuECdJlNviuzHUW6aHQx8RYapO8YcpqLyGeKk2kn1hf7oVWUqJKJV+H6p8AQJ
         4KUw==
X-Forwarded-Encrypted: i=1; AJvYcCVtAiTXXeKqgGZGY9Cyg+tdripho4aNra5QfG/FZSK9U5QexbLDzFSgYgrBfqAvPgVu9tpeGbvwQIoN+Ks=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4fB/8HyeZ7QB62nT6b1aBwXqM2UstIHisLwMhyCQbqINIqvl8
	411oSfxx/lVNOM5+CEYUj8DiRQbTiawjxVtpUJ9Pc0B2bwivLLYQITK3
X-Gm-Gg: ASbGncsu3hqDiG7d3MKb5znBuQj23LJDGVx3BWwhZYOnVLVlxiba40tXXqdt7OsGwN3
	+5TlwzmiJFKjFmx42SBgq9yUehXuLXO9LNG1EacDfbzucXTlbzbuoKaJjnp2Vc7cnUghFciQChU
	y/B3KbmPcERzuYTaCd/FNiC4g5Eammv1IniMObyBafdD5s7VyEGAP9JSisiLaPSqR+a0a8I9IDY
	U5NzyCO/GnJ1uSD/XmOILDushRB/6uZH8XPqcrui7+Z3xdzYS8R9oO0KyWNEzalqbrk7eBo+Xwi
	syd4dqd/TdYrZ+7JEIYHJBn1t9Hqk0PlM7pUUwrtVYs3BkBeyO9QRs2/3ArACYgNeCLzP1AhKTV
	6+YbhlWWLgc/6DM5Grsq5veDHoBTG8j8ORJdYO/rgjblJ2P7+1AU1EBQ6DWhG0BCKAD/6b7cCT7
	965WHBd3ECvSC/8hkcoA==
X-Google-Smtp-Source: AGHT+IEl27VY0Fzg06WvTYKsPnTaG3CI8XR1O4Jx2OOSNMzexShqbizbMp95FvmlDbVG54xJ6MBR9A==
X-Received: by 2002:a05:6214:529d:b0:882:49f4:da25 with SMTP id 6a1803df08f44-8829269e07bmr301776726d6.39.1763563831679;
        Wed, 19 Nov 2025 06:50:31 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d04e1sm135929226d6.7.2025.11.19.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:50:31 -0800 (PST)
Date: Wed, 19 Nov 2025 09:50:30 -0500
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
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/26] Non-const bitfield helpers
Message-ID: <aR3ZNmSMmtSsUR23@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <aQzQjSMOSrUIgMCL@yury>
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
In-Reply-To: <aQzQjSMOSrUIgMCL@yury>

On Thu, Nov 06, 2025 at 11:45:02AM -0500, Yury Norov wrote:
> On Thu, Nov 06, 2025 at 02:33:48PM +0100, Geert Uytterhoeven wrote:
> > 	Hi all,
> > 
> > <linux/bitfield.h> contains various helpers for accessing bitfields, as
> > typically used in hardware registers for memory-mapped I/O blocks.
> > These helpers ensure type safety, and deduce automatically shift values
> > from mask values, avoiding mistakes due to inconsistent shifts and
> > masks, and leading to a reduction in source code size.
> > 
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant (e.g. it
> > comes from a table, or is created by shifting a compile-time constant).
> > To avoid this limitation, the AT91 clock driver introduced its own
> > field_{prep,get}() macros.  During the past four years, these have been
> > copied to multiple drivers, and more copies are on their way[1], leading
> > to the obvious review comment "please move this to <linux/bitfield.h>".
> > 
> > Hence this series
> >   1. Takes preparatory steps in drivers definining local
> >      field_{get,prep}() macros (patches 1-11),
> >   2. Introduces __FIELD_{PREP,GET}() helpers to avoid clang W=1 warnings
> >      (patch 12),
> >   3. Makes field_{prep,get}() available for general use (patch 13),
> >   4. Converts drivers with local variants to the common helpers (patches
> >      14-24),
> >   5. Converts a few Renesas drivers to the existing FIELD_{GET,PREP}()
> >      and the new field_{get,prep}() helpers (patches 25-26).
> > 
> > Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
> > macros instead (which currently do not work with non-constant masks
> > either, and the first attempt to change that generates much worse code),
> > or to store the low bit and width of the mask instead (which would
> > require changing all code that passes masks directly, and also generates
> > worse code).
> 
> Everyone please send your tags. I'm going to merge it in
> bitmap-for-next before Monday.

Fortunately I didn't specify the exact Monday. :)

Now it's in my tree for local testing:

https://github.com/norov/linux/tree/field-prep-for-6.19

Will move in bitmap-for-next shortly.

Thanks,
Yury

