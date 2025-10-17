Return-Path: <linux-aspeed+bounces-2501-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2479FCCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 11:00:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp20r53q1z3ckP;
	Fri, 17 Oct 2025 22:00:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760698828;
	cv=none; b=YqT3Vn4cOsq5UrEWoo7WiLymVU9Qs9IusDkpmz5KVOoB8WQEOwvYaz51aFAeAdM9NwAGdSrGlGuuj4n9X9p86UP+dWIg97ZfSSKshWiGTBw9dTGs+/vvSrTYvH/Kpvgd4Bl4m5D/O1dp/ZJCOX7hCZ+z5rFsW9JB7KyaXNf4OMNWR2bqiCrj5bA2Mv+Mrvmhmzf+w7/iZGjVTx1mQYZlaZZD0kHt7lSEYgAe/cx06wcqL/YGfEcbSm/kkrnWFdUtCNp4x0RIeVcGoy4utw1z6A35du5y3PdFb+xlQBZCxbQgsAqutXQ29l3hFmnCeKRwb1XPXlc3onV75zmEhWi7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760698828; c=relaxed/relaxed;
	bh=zPE9WHNZsdRI3QmdRcH/wWeYzKksV+R5Ry8aWltKbjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWiYMhFcKFp2kXEVTby9PHK2QMCOUWVv6oCrwk4WYfVbHvuM3yKF56YptlhX3vDs9k2bx0EFZ7OOeJyycSkKtSzWfzDBj7VKpFjH+SFCkGf0YPVpByNy8cq9kj3x0mmeLAO+pORuKOMGUwfMAJ6E/XizLaO0TYLLHfNWCStd6G9/XAywSHNMX7fyHlY64j/KsC0Inncjq1o57O3iIc1DlL0++xxK98q1ya+1tNo28hJV0wztleCmIp4yxWhMRcRqT1oUiHsOkhHIB90I9olg78/cYRIOllQJeVqdzWHFe/qARvhPa9+0S6uWDJhbQYwd29wyMCjeXgHt+AKAh2aihw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.214.179; helo=mail-pl1-f179.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.179; helo=mail-pl1-f179.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp20r026gz3cmg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 22:00:27 +1100 (AEDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290cd62acc3so11040495ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 04:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698826; x=1761303626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPE9WHNZsdRI3QmdRcH/wWeYzKksV+R5Ry8aWltKbjU=;
        b=bupkx6rPY01ViL5VL/Ef2m0lF3pGtuatSdnYRUmPQCYhWZjT4bIeqUufGhDLH0o/RM
         b2ZvTU7n+zVkblffMUedbUPmgNwcqCaeYsCbJgDlWQw8tgKkI2hvHk+ng4ekhW3Cbyxy
         bueMfBtYIKWtzVzvM8rszqr0iGjSuhxOCwweGUg91UF0aDIfJ2jvoTC27snsN6yVSGla
         /hGCXgNV4nOqpR3I3SwWeNBzjKgKAXZaROGU2faXp3tPMmxhmCvmFDznzO8LcwoUY7ny
         LbiRtmo3XnUuk/3jo8TQOgycVTYiaDc/QYuZ0+4l7md14y4fHBIRX5Mhki61XLrxiMRI
         1o6A==
X-Forwarded-Encrypted: i=1; AJvYcCV6zuW2rM8wmDJw7kLLSKqKy3OTlIvr+538sM54r12rNWqXykc3oK5/F0lL9mMmbyi17TUgLQ6VFUD4usw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxstOGo2diW26KAv67G9zvoeaMgsd/WI9wDviKa/1pBq3opNOPT
	6hR1smnWfSMC74LKwlgHL4sTtr9lw2wW9m1d1+mbSZrtRhcba1PP+o1wJrFOaAXu
X-Gm-Gg: ASbGncuxqeGXB42BPoxMEL7XBbvRgvgQftTNiog1ze4+LZnjj1DJFXz+U9ye+A820Qp
	1CPDk9mtMfvgXBu+VukPNj65YqIUUeMcO20hobKozOTgD5ny/UXSb5tYOT5F5uXe8CkcSdEVEoC
	MICnF81ByE5o3UARU7v65L56pSJodHrpAn0v77E3LSJo8oKfS9v7xcuLCcI78oS1nLNfHN8qaRw
	Vn3Auf64XIHVBTjoSQYBHu/D+5nGJVAZfLqxAPHJ695MtoVvy8sOfSWqG1ov2+rSBAmHllydAdU
	b5XNfpPHBlDlpOHZWbM7KwM37FhybMGs0l5w9E+YV3EI9GKz3V4J8zSC8diQDof13Ip7eVabDcI
	y3TIL2Vs3FvXnbSdzD/dBCr/yO0i8ouporIgIvJSey3nC9Fmva7pO0oLyv+LQd1JJy0B3fQ0nyA
	AmEDNH2Q6toStAGWFiVtm8qfD/LC0myEzSVlMDVg==
X-Google-Smtp-Source: AGHT+IEKaEy5Cp7tG2QRrIIn5S4dGRZ5E5sgtrdDonBJ597Sxh8VDmjqBlpxpZcV+pyrKlIcgJ6AZg==
X-Received: by 2002:a17:902:ec87:b0:25d:5b09:a201 with SMTP id d9443c01a7336-290ca5f0e86mr47413375ad.27.1760698825256;
        Fri, 17 Oct 2025 04:00:25 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba3fcsm59848705ad.99.2025.10.17.04.00.24
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:00:25 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-330b4739538so1637867a91.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 04:00:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXR36X2TATN8EBjOk5ePYQ1OtAp/CBAfVt7iZDtTSLXc2sZRoEir0PrY4YAIrbETOi9O6IRnPGr5x2Bz0=@lists.ozlabs.org
X-Received: by 2002:a05:6102:5111:b0:5d5:f766:333e with SMTP id
 ada2fe7eead31-5d7dd5934demr1126362137.15.1760698513447; Fri, 17 Oct 2025
 03:55:13 -0700 (PDT)
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
References: <cover.1739540679.git.geert+renesas@glider.be> <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
 <20250214073402.0129e259@kernel.org> <20250214164614.29bbc620@pumpkin>
In-Reply-To: <20250214164614.29bbc620@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
X-Gm-Features: AS18NWAcP6voBjoIoEi-7RxJ0pdmzXqhfe5FdHBNP60R0y-DyUBofdEL44euygw
Message-ID: <CAMuHMdXost7vL5uTocMGtrqhEk5AY3QUWvyP5w7_hBtf3MkMfA@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 14 Feb 2025 at 17:46, David Laight <david.laight.linux@gmail.com> wrote:
> On Fri, 14 Feb 2025 07:34:02 -0800
> Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > constants.  However, it is very common to prepare or extract bitfield
> > > elements where the bitfield mask is not a compile-time constant.
> > >
> > > To avoid this limitation, the AT91 clock driver and several other
> > > drivers already have their own non-const field_{prep,get}() macros.
> > > Make them available for general use by consolidating them in
> > > <linux/bitfield.h>, and improve them slightly:
> > >   1. Avoid evaluating macro parameters more than once,
> > >   2. Replace "ffs() - 1" by "__ffs()",
> > >   3. Support 64-bit use on 32-bit architectures.
> > >
> > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > macros, as people expressed the desire to keep stricter variants for
> > > increased safety, or for performance critical paths.
> >
> > I really really think that people should just use the static inline
> > helpers if the field is not constant. And we should do something like
> > below so that people can actually find them.
>
> Especially since you really don't want to be calling ffs() on variables.

It is not that bad, as most temporary architectures have an instruction
for that.

> Much better to have saved the low bit and field width/mask.

While that would allow some space saving (only 10 or 12 bits needed to
store low + width), gcc would generate quite some code to create the
mask (even on PowerPC, where I expected a single instruction would
do ;-).


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

