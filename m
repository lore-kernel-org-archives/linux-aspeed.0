Return-Path: <linux-aspeed+bounces-2848-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD88DCCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 09:07:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4kMW18N5z2xFT;
	Mon, 10 Nov 2025 20:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762765655;
	cv=none; b=fxMVgJx9QSCtysrR17jfIumnYBWtAjnA4mEs82Zl1kzkzqdClznT7zkIgDeLZIwZX7L9kRFhCOHMxy1juV9OB3K7e66OyttDFA1sjk11BrgZs6XsvFFVUG5r0+CH3JDoVZIKNDoLAltcrmYPLwThBxMUXBIDMk9EmRUZBSp1f10pA+gekUmL902fF6tDlKPK2qGQCe1lrBb2/G/O5QgvyDfkJX8DlnMbS9KLwNNURoxYl6iLipj6x20uh1/yA17PMxfvYaVMIJp0PFHUB9ol+pQG6Sn0QIbth8AHzozVgrXlRlj1tBxcfPccuxLTw9jrYyKEeZEggk7a5mVkfCjxOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762765655; c=relaxed/relaxed;
	bh=zuaR1c68u39/qbD5w07qCJ9IxeheIz5/8CL8hB/l6OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sf9H6twYIB7onhORfSgvUBctloTyIwT55C3RYhlFqQcwWDnFy4+LnuGq8g0/1N1c93OnWcAOSXT21YYW55hYuiO/EVHhMjIeGfKJGzte1qdy5n1o9J67UwKMW/HjqxqL/k/C39oBneFDBkVAa7pGzCDNjIO5B7UUmOy7Mit7I97HyaM4wKyXTAiXw6M4Jiq3fwacryli6xI0EBn//+8SAD3fRkcYplgeYnqfMyHXFtEfdOif8Z2fiH+iwJNSZ/ebQtiEZmBIQrgw0rT/Vdxkb4rrOu2MoikhvN53TSL+ir8M4Mh09kL5Qxw10vcvE6MSEUQn07fuB93aNyoB70COWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.215.170; helo=mail-pg1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.215.170; helo=mail-pg1-f170.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4kMT6SxLz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 20:07:32 +1100 (AEDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2128670a12.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 01:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765650; x=1763370450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuaR1c68u39/qbD5w07qCJ9IxeheIz5/8CL8hB/l6OE=;
        b=w4rrC3UqOnBBSLlkHwYDHrw5raX/eN4dBtzBlmODmtYcydvPNmYxBLo48OOd/lEEPV
         uCz98bbtYgyX4hdrzJNP0KMyg5Gen1WN+fKp3CaD9M0GFtnDQdo/Kf8EPcZc4NAdrMDw
         oz9XOJl75NnakkOKtj22tMUbA7nziFv+HwS3l1Q1kzttEU0LfVeqnVCKXH8ItO6ODPzT
         81N/z3256G8hKyTtwhfgFyXKxytF9NwOHRJqkwJ0Vwcx6plgsINhsStT/J8OXq4Q1jhq
         2S1nIZbDI/K1UEfzZ/VDaAvIaTIh8ILdP0pVB2RAX8JyQid4om30kK+0B/PZ7bLYwR/j
         e18w==
X-Forwarded-Encrypted: i=1; AJvYcCUomuNcFujLXxJPqFZobHeDHer+K+XZu1yhqXX11K2fLE5sDpJam7WVMLmgVAzp04q6ZJMo+nY9Lo7aaYs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwiNA96Jv2hnCSE2Iq60bnmmh49OscjUmdDb14oZ7lKMKlItIME
	YIqy6AyP1sNigTuCD5f9Hx2WxNmKf6isP5Dp2J5SxjJLkPqKQQzdHtADIZ0lXbb7
X-Gm-Gg: ASbGnct4XNU0RZU7KuLLKvcm9N/lUd3NoFLk1nw//8+d6LDIVgHXCWaah+IcNZ180eY
	mnDFjXVJVzO+nicHQsKXLBMFygRsG6uY0BDXqpBzd8irkAI4IaxArNRHJAs+9PKuu0+SC/wSMMO
	qy96DrExak9K8fT1Pn4m7v1uugnSrj20TQ/sJv4YXea1F+uuAtdsuYhWqG6BmgEf6FmW/iBaPHq
	WVaZN2q7Oa/xK53yB9AKxiR0Y9YTgP5mdm3m8Sd1/O9sKtV48nE28QEMqrh77EHjp2aW2z1jOWG
	IrS+Yf5im5STWRLwSCNsGBUlL9FMgX3kc1vq2I0tRA6hcAna+SikDRQ1mAz9ov6o3UlThoAGO45
	RvbFIN5pk1FDVknbcDgFGo/Jsl4Xthq6Kp5H+vFKTtKYZ7jqY0sKZioYzjX6xycYvX9y2dnICaS
	+Yr1NauHKr1RDA4ma4gq9aeEK/SYl1HG6yuBr9KZXqs8ixNgLY2lCsgWpN
X-Google-Smtp-Source: AGHT+IEDQhnhnKAtKsl/7tcHV7GyiyXLjkA4cGAJel8xt4djqAkh8wltTHYYuWP7Ka9AR4YJdDmrlA==
X-Received: by 2002:a17:903:244a:b0:295:6511:c0a0 with SMTP id d9443c01a7336-297e56b8511mr95406315ad.33.1762765649612;
        Mon, 10 Nov 2025 01:07:29 -0800 (PST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm140561865ad.72.2025.11.10.01.07.29
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:07:29 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3303582b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 01:07:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMySW11Zry6nYgMhy+80Khr0v4qRxnOvDdekyZX19cI/d0vlJAAXhjLkmtnBc/AK5ZelL/nD66IJOI+oc=@lists.ozlabs.org
X-Received: by 2002:a05:6102:950:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5ddc471358fmr2304047137.19.1762765185596; Mon, 10 Nov 2025
 00:59:45 -0800 (PST)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei> <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
 <20251109125956.106c9a1a@jic23-huawei>
In-Reply-To: <20251109125956.106c9a1a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 09:59:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
X-Gm-Features: AWmQ_bmD7LCstBufqr7pTwqKUhf3WnheTdaFZy-l1C13xKAmQ3xomq2Nqy5MxZo
Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Sun, 9 Nov 2025 at 14:01, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 3 Nov 2025 11:09:36 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 27 Oct 2025 19:41:44 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > So this is going to make a mess of merging your series given this is
> > > queued up for next merge window.
> > >
> > > I can pick this one up perhaps and we loop back to the replacement of
> > > these in a future patch?  Or perhaps go instead with a rename
> > > of these two which is probably nicer in the intermediate state than
> > > undefs.
> >
> > Renaming would mean a lot of churn.
> > Just picking up the #undef patch should be simple and safe? The
> > removal of the underf and redef can be done in the next cycle.
> > Thanks!
>
> Only 1 call of each of these in the driver, so churn is small either way.
>
> To avoid a bisection problem if your tree merges first I need to modify
> this stuff in the original patch or leave it for Linus to deal with as
> a merge conflict resolution which is mess I'd rather do without.

If you add the #undef, there won't be any bisection problem?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

