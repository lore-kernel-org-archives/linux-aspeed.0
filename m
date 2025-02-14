Return-Path: <linux-aspeed+bounces-718-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D13C02198
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 11:01:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvTcg3gqCz30Tk;
	Fri, 14 Feb 2025 22:01:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739530867;
	cv=none; b=TKFLfOJeBNb8XpfAUSVIyhTOR+rBqMD4RNz5O2eUtb8YQhiOjapRpIj5ElSnIkm/YsHqa8vX1oyCqSZTbPuOVXwnxvHIiCUOTGNvFi3RG0y4KrULycM07F3rb+4gcWy4Sn9sV1OriRzv95RDClhCCFRbx30g3FR092+hihlCk3IY69VIzxMkfH+7RWNtVOoelRjQsmTy/dYBGcxYJD1GSAx5pQ4WheZZOgkUzY7a+V0oKb1iaeIt3cFnn9LkNMzME8j/o/BOHPiEUH2a5LME4RhoePsSp3Y6v8r0y9kttOg2V2TLno3fSbjCd2ig6Kcd/w5yn0DH7lglRObyWm91Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739530867; c=relaxed/relaxed;
	bh=sOhOeuJi5yrz4/2ECZyl6aYLZu4BPC+rC7vskT2goxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDYNAPPmeyGpf/da+kWkgQl4EYmztTQ5VhvSskqi/00GUdmx61Tk9kdubEqtqQ8UicQIZYeIs3UFNCo2RRjR+siRBWiuZ+ddKkM4iYALKiDYx2LUUcs+eBi3IMMl0qUmK4KmCChOX13NnssgzZkxnjkff4JXOMSg4stLpoxP26SrGY4A2DRSmA9PczAWw+nF1PVN2M+MPmnRMMS+cRxDwokLE0wOHLyS7HdPdQQb3aBZ4Mv9iIjt5ED7BTor7x7D1hTzhye9cfMQUL6wKWmuh1cmohNwVhb7bAtNO2g1wcYMf4ExAkOJ2mXwu/s4exNGpvZ5aHFvnPMpVlDFn0fiEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.173; helo=mail-vk1-f173.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvTcb4hl2z2y92
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 22:01:02 +1100 (AEDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52066e96433so570706e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 03:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530859; x=1740135659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOhOeuJi5yrz4/2ECZyl6aYLZu4BPC+rC7vskT2goxo=;
        b=B40oebslnqLAxjFLutA+68x/h5U7iqir+HpCxJN6vevRn2aVCX273D2vRBpBFvUbis
         NdNyHT7VD5kcFomTFpQ/xxARSzJ6QfS3UG0YNwIU+wQQ9dqmEreukUrwPLWeYreJOF/h
         68F8yYJZrOJJ7LsLVVJ7d3HdKYXQdwmPdPVFtVasYkBTD50oKbfnd8mWosZsAQOQuflZ
         1IUhnNWbU8bCOyHbeHlXyR08ZCly7vkvALXszRTn/Wh5YSD9L4iaHtGMwVUVoHHFjzbX
         UB+I8o/8XRdSpaPTJT0R2EvqCWfi5YVY7ncYzgjo4B+Kd70tixrpY8kRx/4BJNOsIrpc
         RhPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzgAkpsaOTweh1P3OIghKyCKPf65CZuGw3Iaq7FdjuXqVlYm6um/jol4ygkyZCjmaQmKNlWRDW0uIL4D0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxDwYDHQWGV2qIjQIJr9P+85R/Z1BM+VQ5MDoCzAFkI6EJXjP0n
	bYYqqhlef0yFHDU2nMxZ2Qju5swN8/zYVkbww0f3Mhv1fEPbpz+2/bQXDoc6A4c=
X-Gm-Gg: ASbGncuULMgXYfWDJ7U1KYcUDLzT1WmMogv1tYTf28Fk1c6m5Xi+1ypXFZKLkrrENds
	LWcbikAqL3KMSRRHA6TRrCiWu5X15IkUVDwrig4rZgsUT4AkWW5rz0pF40/gcTjJnfeQUV9Uy/S
	lIHAHGPhnigBZRDD6MNXTFHfECIMX0ou0mzK1BjwuQHbu7Dq4IUsaI94c820NsMol4vyhtgPyor
	EJ9L6Ko14wT8PtC9xqaos1qPNcqZAb/L8sXSaygDgw84W6aXD8Bm83AQu1r+VYWHW+xKQKpyvMq
	5bh+yqQx9kcVKza4VslLQ7qqcs7F6eorMawQOevtxOkZRc7ccEaAYKsvaA==
X-Google-Smtp-Source: AGHT+IGCeHKZgUlXCjwDtrJRlQBbRZBtEy5D81K2luxarCHl+MkDjPesfMMU+DenRiyCbLIdxIjw1A==
X-Received: by 2002:a05:6122:3109:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-52067bf1a31mr9972998e0c.2.1739530859299;
        Fri, 14 Feb 2025 03:00:59 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa405cfsm554784e0c.1.2025.02.14.03.00.58
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:00:58 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52066e96433so570690e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 03:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhq6NK5Gpb+BYlTaClNJkDvKiR/tO0F244rdr32P+jPy1OdxLCC94Z1HY2sv7SgXfDJE+WsoBhTGseS8o=@lists.ozlabs.org
X-Received: by 2002:a05:6102:32c6:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4bbf2312e79mr9166519137.21.1739530858000; Fri, 14 Feb 2025
 03:00:58 -0800 (PST)
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
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <20250204073011.5f6ca125@kernel.org>
In-Reply-To: <20250204073011.5f6ca125@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 12:00:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWe1Fe4ZvWHB1tf_NQNg6W9PmJzpEK_28g+ix9an3jw_Q@mail.gmail.com>
X-Gm-Features: AWEUYZljxHasbqOWVQ67DCDXNharhoOj8Y29FWByT7hZT_VuVaki-I-AuDEVuCo
Message-ID: <CAMuHMdWe1Fe4ZvWHB1tf_NQNg6W9PmJzpEK_28g+ix9an3jw_Q@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Tue, 4 Feb 2025 at 16:30, Jakub Kicinski <kuba@kernel.org> wrote:
> On Sun, 2 Feb 2025 17:26:04 +0900 Vincent Mailhol wrote:
> > On 31/01/2025 at 22:46, Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> >
> > Why is it that the existing FIELD_{GET,PREP}() macros must be limited to
> > compile time constants?
>
> Hard no, some high performance networking drivers use this on
> the fastpath. We want to make sure that the compiler doesn't
> do anything stupid, and decomposes the masks at build time.
>
> The macros work just fine for a *lot* of code:
>
> $ git grep -E 'FIELD_(PREP|GET)\(' | wc -l
> 22407

Indeed.

> BTW aren't u32_get_bits(), u32_replace_bits() etc. not what
> you need in the first place? I think people don't know about
> those, with all due respect the way they are coded up looks
> like an IOCCC submission..

These support only compile-time constants, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

