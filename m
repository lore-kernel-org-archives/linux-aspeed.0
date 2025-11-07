Return-Path: <linux-aspeed+bounces-2826-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F767CCF9F8
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 08:43:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2sz204Nhz2xQ2;
	Fri,  7 Nov 2025 19:43:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762505005;
	cv=none; b=ekXZ/ITOz1dxxlNLFmsaIP+2lSYZi6hYZ+dRrBhW3HyBXqoBD2X+YUSYcy+m7y3LjIrkTd83yd6kE0BYw+4Ji104Q0msrydYNZ/IaFF0hKxCnVPlnAzv5GDJKqOz+Sryz0ibRKe1qOU6ms0vMhNg+rC2oKRR975CJySOprcEEaiz/7F7rftuYGdmRhcXV2c29nqW+FCYIjcChUkL488oD01SsoRwuams9saZmFrX/vjY5ThvqNB0zK5xZs1rVukLFvwNAgFjSbyvxIz1SZiNJyrVK6PygnNMIthfziQyEP9dU6op2s5dHWeNA9e8jxvu1kA+JZIDbgqoZ3+xvVTluA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762505005; c=relaxed/relaxed;
	bh=RsHZezS59+NExnNGIIdIy6ER8EF0CQG8kO0yNppcdcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3aol4i+HVaxz4kP2ZqfwE+CNk5HWdBLmrvkLcPgEnvIJO/htxosB0H59f7OI7ci08OFDXMaJdAEyuXZr6ULGrgNbYwFy78L3m9xVuzelB6Oq1ovGuM4TCL05lrEtvumlI5KxJ+1yAQYJZIHmXJPtT13hLGu2s6yRY9GsxwUhWPsom+eSjqBFX6CcBQxuAwmzfrPzlp/BQ8rrQPMonRdbD+ke4yj4YQlFvZT4j7jcbmCkeM+MKf0kiiGgKhZMqJdNk8VL8YLXQphckB3GwIR8Y8AnKELQDECQLvx+h4wP/HAc0de+HhzJvGHTsmvLNRGFgRfn0EeMBY+dNvnQ4WsFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.51; helo=mail-vs1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2sz04W0sz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 19:43:23 +1100 (AEDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so398791137.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 00:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762505001; x=1763109801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsHZezS59+NExnNGIIdIy6ER8EF0CQG8kO0yNppcdcI=;
        b=IEwDefMMVQrFocFMzQMWxNHCWnmfOzBWwrAMSkwjPx9PcIwfx0oj9O5AH3LIYAbVRx
         dhcYcBP8Mwr2rVE/IDeDcUS0/mfHxr1byeEFswRRToRFMx0GeUQ7aDh8HEJFNR4Yh3Ww
         EACTn4TdlFrXoTN+jZtPnG/vNNzTKdvArEuRVOWzN+Fp3c4ObdtzruR8W8DO0jiUVe4z
         TaOdBcN1AVmZ9MqcM9200hUetfddOBfln8zLytZjpgThOP4MpWtyEKbIzWJavxKIbBAc
         Zsu8LhAzbhrFl4gMFaSwlfr48Ob2OW7DE/hzxaNw7Lj66L294rZnKbPumUormC3MDRAy
         wvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDrxKqyGThqAs+776BsCrnsvfo10UnRScF4OBIRxnM0boAtvOJWZNK6TaIIQwh5F+peVmXbtzX7YHL058=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJRd8ubL+FOcg4TGRNygFO/WoPPvJyNO+rOwYs/KHwFoHlZllH
	4pAQVHKjuO9dzpnZCx93PI9NBICWnf2B9SyXRgnVDhL0tFpJsN84nrkI1vEI0Bf4fh8=
X-Gm-Gg: ASbGncsIc1PyniXzsmPxfF9dasLpOSw/WAzFFfzZAeybd4arGjAtfvi29YkN2SWId8u
	RXNe6p/BWDBhp7n8/9hUYrrliySg84snSxt3UwIHaEmicsWtO2fgD3xYwSwV3HdrCFv4/6PVsVe
	5JCf4Bo53tMVowETVY3H9yA5gxfs09uTIySx1Uuxv8Fk39oblqPNOUzRzpN8GiWUVMhmlfoVuj8
	WsuAZ/G6lz04P6DgYnFqN51hjl7jgGjTorBC8DctPGWRIiTz5mzN2WCi+MNaA7VEAvYbYIBDslp
	795rcEjaIHX11QF3jHtlLBdOpOGULU9PrBTeWhnvy019S/IPKWjtMVUQGecFGQLNEByIEROncwG
	Ko3Yli/4nB6ysXuan+gRbSeSnSetXJX4wrjtKh6P3ZVGcOdWQBrmH9vYyqEdIPIAPeDQY8gDRRl
	z0kEMFWxA6xI6PnsWu14mSrkZClqHFG5lfAowd6A==
X-Google-Smtp-Source: AGHT+IGAT6nw/wq8HDV55l76GQCzHJvRk83cQrUF7sSP/A7fPahzO/DTx8B0fm8hArXS7UZWpfk17w==
X-Received: by 2002:a67:f69a:0:b0:5db:3c3b:7767 with SMTP id ada2fe7eead31-5ddb9ceb671mr156524137.16.1762505001135;
        Fri, 07 Nov 2025 00:43:21 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda200bc7dsm2102145137.10.2025.11.07.00.43.20
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:43:20 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso461372137.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 00:43:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1cvf7y7yrjLNmt6Rl0HyIQEu75UKy41sASTB5sfmQBO3A3Bt8eEnx9k6SVlXbOEJMu7zcHUhNQ6TH1j0=@lists.ozlabs.org
X-Received: by 2002:a05:6102:4425:b0:5db:e32d:a3ff with SMTP id
 ada2fe7eead31-5ddb9e056aemr278996137.19.1762504514580; Fri, 07 Nov 2025
 00:35:14 -0800 (PST)
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
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com> <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
In-Reply-To: <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Nov 2025 09:35:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
X-Gm-Features: AWmQ_bkZe8xF0tkRpW5gVlylkcfm2r3jZb2Xa1XdOQVS8F7wx8KXagIs6XSHJvI
Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Yury Norov <yury.norov@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "qat-linux@intel.com" <qat-linux@intel.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Fri, 7 Nov 2025 at 02:16, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The extra checking in field_prep() in case the compiler can
> > determine that the mask is a constant already found a possible bug
> > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> >
> >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
> >
> > drivers/net/wireless/realtek/rtw89/reg.h:
> >
> >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> >
> > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > this operation...
>
> The purpose of the statements is to update values excluding bits of
> B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, but
> the operation is correct because bit 0 is set, so __ffs(mask) returns 0 in
> rtw89_write32_mask(). Then, operation looks like
>
>    orig = read(reg);
>    new = (orig & ~mask) | (data & mask);
>    write(new);

Thanks for your quick confirmation!
So the intention really is to clear bits 22-31, and write the rx_fltr
value to bits 0-15?

if the clearing is not needed, it would be better to use
#define B_AX_RX_FLTR_CFG_MASK GENMASK(15, 0)

If the clearing is needed, I still think it would be better to
change B_AX_RX_FLTR_CFG_MASK, and split the clearing off in a separate
operation, to make it more explicit and obvious for the casual reader.

> Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, how
> can you find the problem? Please guide us. Thanks.

I still have "[PATCH/RFC 17/17] rtw89: Use bitfield helpers"
https://lore.kernel.org/all/f7b81122f7596fa004188bfae68f25a68c2d2392.1637592133.git.geert+renesas@glider.be/
in my local tree, which started flagging the use of a discontiguous
mask with the improved checking in field_prep().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

