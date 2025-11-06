Return-Path: <linux-aspeed+bounces-2790-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C57CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 14:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2QGR59tMz2xK5;
	Fri,  7 Nov 2025 01:55:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762440911;
	cv=none; b=IbQcsWWZgCCo56hqf5nMbDQOJxWlQYGGH/rHspwPLtJZ1HuUpuL5w1EI8YX1A8ffYzF6zRB1yZaeo9fZmtPDum0O9lI1qOVHxxj3c0YulDRY6P5ekjOf4JsovMGBGL9T3B9O+D2GzujVBlljBfo0XU/HsRw8GR2Xhm1Dh99t5i++01KTpraNdNYYA+wFRulkHP11fGsBWrRNVevM7rs3KU+HLtoFAuQOHi1JEcv3ZW5Uw6Gfr9zOLgHh/SMDuJkgP9XkIA2KFqbji3ptw8TNWFBHZz0sYZ4Q6bqtDceEVk/x/mg+RUQllA5C2F0zzXkY7Qs6/jcb41exD5lDBQ8ayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762440911; c=relaxed/relaxed;
	bh=ZxZVtMOHoNocoyXPFvfejRTHivuCeFc8a9lYqiVNw1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K59ZlFxYVtkhqFFMDt6mTbzunQctzY6WXxbTEDcMbWdQ2NdgPVQvAA5VkwfGlo/wA/hUEzdziwvDW1yuoUspUd4WKGHu1UfB7zULGyfdmlqiPEweTWKGBwmCkpMnSyiJxpZa8TmIAJOpQ10I+DU6CmPSsScKwiQ6zYnenlHayonmQpWN99/KSU7TYHLNr8SXV3st/YlfUsvCsmTFehbwptde8n6p+yMpUT/8LlAcyWyY4i7UPmNXD6/eo7xO9QEsKogItwQ52ArkIuxXmD7+Y8bAlB4mWCNyE3W07HgJj4gtyITAp4uVW0MErwAHbpOfCNtHQsAF4+FQ5QMa3xr1Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.208.171; helo=mail-lj1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.171; helo=mail-lj1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2QGP6qNyz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 01:55:08 +1100 (AEDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a3340391cso10297691fa.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 06:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440900; x=1763045700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxZVtMOHoNocoyXPFvfejRTHivuCeFc8a9lYqiVNw1Y=;
        b=ZcH99QLJ7r9w3l9/Ook9YhsWs/E45Xdm+TmaP3o5DDxjX6HA70OmrKnduvgFTa2P/X
         GOL4AsdGj9zlPNNEybPsdCxj5MeuM2LXg7r1EpnjEMhkDrnZIuM/HsxdFQ+zSkX7xpfd
         XQN8xm28C5tlzKVQUOgXwe8CLDTHAftDMm3zHiuNR72rh5ksCPqIA2oFEEymUdRkb7Bu
         mDrn3IPkmZmehbGHNSJTKffDzAc1hdBN+KetgN9ug5EhZMEZxrg/ekrTFdHPdDdoSQ5f
         IOx/oZHOmu1iqdYmn+qOFfw9OY4PakOiEAbHO+gsnSeSOnEMlMkLQMz1boO5DRfFmQ7d
         GXnw==
X-Forwarded-Encrypted: i=1; AJvYcCWjXGTjwMgkEvM8qBeVCnWztZ3SBvbpKVPUaEex2s6/0AbvNbtOjOLP7ZoU0ABn8jpk2m7L42kMqABDdBM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyX3axbmfYOQBaJUrjqnbAQvLVdQ118xmQDGESDscQjp9iYGRem
	hB5G+9TobC0Ti5968JmiwEsQzsetoAgm5QpHT71rXHaBocUJXGKTQYwx/Mgi48HLBkw=
X-Gm-Gg: ASbGncvwVhuFw7hSCbwuexA2Ghf7nu+aLfrmBAUu8WI+rZlE3siYkFUze+1qpgfsrYC
	N9s6C4gHIwdREHlYdH96ys8EQuC6eGgl5ROmIvz52qG39u7gjOCG0sM0N8lDE+FJ2gu8yQKEZoT
	QOpWY7+K6+XAb+Mc1oJcM44NrT+rGhL5He+kUVWS4iPDsE2WRkaOxTWpg3KRK6ZebCl8U2mEu8g
	dD/TGCPJX7MQGX14HBb5QB4MK2vW9c7v1pCu9F6BQ3x4CAePxMANq3QMJEy8QhEA1APy96c0VXe
	hMn63XHKa8Ky0t0vQwNho+8BgzWUA0sGNgHWrcWe0koib2EGdSUb4Y+QDpZ2Gej8jnUfMEN1rb4
	qvkD+2ihrh0QbkZBmJtgogTjLw3h+EB0Lzt6IPFS3ZL15lEP+1H5LpCA4fvmn61Em3cejazfbRj
	kZvCIO/daqqZ0t08gC+x5GxtqqI4Jr7/kBIHUbWJQJgL2ELJC9/jOn
X-Google-Smtp-Source: AGHT+IH7/ppEqjSbfV9y3di+wnNDk1X5sL1X2ytEjFswcjqS5YwTj4CZACpFPnkC/zgkrtmOUGju7Q==
X-Received: by 2002:a2e:300a:0:b0:361:5fa3:1d58 with SMTP id 38308e7fff4ca-37a513e64c7mr16524241fa.18.1762440899677;
        Thu, 06 Nov 2025 06:54:59 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0fe895sm6294831fa.50.2025.11.06.06.54.58
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:54:59 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a3340391cso10297111fa.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 06:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFCUeRwqNvII0j2lRSuUAtwjEG/5SVNMxaPRaztooke1Tju+rN5mi0J57Z9PARQDD28vtcegcymW+RsTE=@lists.ozlabs.org
X-Received: by 2002:a05:6402:1ed5:b0:640:b643:f3c5 with SMTP id
 4fb4d7f45d1cf-641058cf323mr7301623a12.16.1762440555932; Thu, 06 Nov 2025
 06:49:15 -0800 (PST)
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
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
X-Gm-Features: AWmQ_bnZOzLGAFcWzxKh1EIKjH4MNs7moeVCtN8xGb6mN65nYBliBYrABdUBf0M
Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
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
> Also can be made as
>
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

Nooooh... torvalds might click on it, and complain ;-)

> > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > +                      pfx "type of reg too small for mask")
>
> Perhaps we may convert this (and others?) to static_assert():s at some point?

Nick tried that before, without success:
https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

