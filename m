Return-Path: <linux-aspeed+bounces-2849-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC9CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Nov 2025 09:39:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4l4W5P5Lz2xqM;
	Mon, 10 Nov 2025 20:39:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762767579;
	cv=none; b=cq7N3hvdjj7Y1GSPW/zkUkyHBxriVAxAstmGtDz5JMtfrevM9nzLSE22kH9P0dmez7IVybCwoDv1ikge7nsrfwfBLMfMgyb/WjBigTNnhAXmA831cA/YFX/RnZBc5rvAAe7+Xlq+mG3eKFeB3XfJKvA8+F3ICs+1Gmt6B4cKs+god99cPQApvKPyG6zahkAghEKJukkNw+i4jwPWXs/TXMd2lwtFisRuez1mbKePCtda/5w0vUOgZz6ycwRAI15TuoA8lMaWvVgwlmudTFdCWS4294ECSqxO2JFxW8vi9uVmdBNh0gyzFMKvc9SJXIKCb4Qk53aru/L5jGNsg3KxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762767579; c=relaxed/relaxed;
	bh=lsrcVDrEohRhH3DeIYD/Jz8ulaHSwnUzTLywFA/cyng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db2H6wIisld1oMnGPKCjNLUkCjkb46PJgqL0AYeXI6FHbrZhLf80s0OMmo5PC0FrESurC+e/OAH7WXFH4A1nRBKDFP6VXp90l528oKjO1qbY1qJg60nC8wPnG0nFjarI1TWeTluNdJs1Mg4wqwLNRVj2cmZYzhzzdvGVR04/WWMqvtSUmTuvqhvlB0Hel3FZCYDkw8fK3ZCPis0M+QED7wCgt9KV2+M7FeNC/7HTDDER3gY29qXrj4beDOv2p9FXhDPo0UUj5I1G1B4ErGRPPKMFJ3QXpKjLjbzmY1Nm+4VIYarSkH8iQQGqssNkRbNjRuUsDgqWMeOgB9s6PnEb7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.171; helo=mail-vk1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.171; helo=mail-vk1-f171.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4l4V4GJbz2xqL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 20:39:37 +1100 (AEDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559836d04f6so1802535e0c.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 01:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767575; x=1763372375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsrcVDrEohRhH3DeIYD/Jz8ulaHSwnUzTLywFA/cyng=;
        b=jzMA75LckyESMZDT8WJ93ZDHAgatAzzgUf0M4NjJZm8duvDrEGOX6kfdmijCnPpziX
         guHknV5uH7mJDJYsRTyw65d/JSpgwo/9WJ3+QYQYqxOO5oLn1VIMi3U6jBK9d8h3m4aZ
         Fg4LYkX2GjMJxkIiRAx/IAnTRnf4z9rM+C/aXffdOb+P5cXEomQU97VTeXbh0GF3n+ba
         /NIt/D1VtE72nJE1q4joc8LdQWiWpFIION5OuHu11911GWaEWzQKehLFDejH7BdPLsIV
         4C8q05P8ttdm8OMWeq65PHbzz17Hu0anZ9SntYsbCU1T7IT14Iv+dw3WRHu7O5pL8nLj
         c6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVcivLWkfCD8IhkfV/4d5tBW8To98jakGCyB30lIwquzPjyC19JSY8hWSfxAbLjxB1Rrt5A2Yr/Tmvr2EQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzukgmx/AuFCk184FR3sKxnbYDpqQ/qeZZ8IKBVIa/g1SaRqbHQ
	Fo5yKEvM0LGDAQNkMEqH9s271tXu83p3212jaRoPx5ptKIKKKKhb8rnSlYgH1f/r
X-Gm-Gg: ASbGncsqRXh/IexIIUYxagHZ2rhREOGpENkTV1FSWs4GUj21+QehAjsidq3R0Iq87KI
	VkUdj7ihrM/5EmlkRrp1RzBZjO7K4gx6JehjIjSR0bxaQWyn3Zp1zwNUikDHrJnt2/j025UxPF9
	gf47asf7OIaSYFwvv/7lP4iul+YHJGLrJosr31w3JoBI00MwhwESwF5oIS5zE7HENGh/bO3zNJS
	LVLpBCbYkW+ExsAovKlNvx7kxDNkZk4WZV1JgSetXKJNoIJrGTNjtwFwTSSdw7r1DeQrTtyG/dy
	ZdDByCSTDB2ARm2TmV8yN1Dapr8oZaRuvCpo19oUgFPb1HBFz1mGhfV/654gQMOxVj2hZmeuj+b
	LKPBNDBe5z6KIlRDElQgOfpvIMDqftMMrTEg2d+aZrPMAcKXEZKNmhMI8ZpsR2qgo0EM/bIZY84
	i9Bs8yLXnqTO4jdZZdGZycEpjoTq7fyT4uG7pO0yGHVTfwpvuKLCEM
X-Google-Smtp-Source: AGHT+IG1PsCmpOX71YpTqVgMICq9FPnJwb1LoXyCOzDyA3UfYDU3KdK5xc2Zt+4lJYbPfaKTHD6Alg==
X-Received: by 2002:a05:6122:d09:b0:544:9f73:9b46 with SMTP id 71dfb90a1353d-559b32eb82dmr2685768e0c.16.1762767574522;
        Mon, 10 Nov 2025 01:39:34 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55995862fe0sm6854877e0c.21.2025.11.10.01.39.34
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:39:34 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso1556280241.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 01:39:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFWetnS6nX2/BbwrcnQjNTyQaA3c6ILGW+FD4+CMT3zrmoUXryIoLXqys25wU+TCKAonHfhK4YxMpY9gc=@lists.ozlabs.org
X-Received: by 2002:a05:6102:162a:b0:5dd:8a20:d6eb with SMTP id
 ada2fe7eead31-5ddc47517c6mr2576190137.25.1762767247552; Mon, 10 Nov 2025
 01:34:07 -0800 (PST)
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
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com> <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
In-Reply-To: <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 10:33:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVUdey27RTX8mLsB5wsTfuW_mP_hF503AaF2QyS4awDcw@mail.gmail.com>
X-Gm-Features: AWmQ_bkW2UuenDn6w7Wole8ay3msAtk8Ugj-awLiClF7uVATEqk1c30upT0lUKU
Message-ID: <CAMuHMdVUdey27RTX8mLsB5wsTfuW_mP_hF503AaF2QyS4awDcw@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Ady,

On Fri, 7 Nov 2025 at 09:00, Andy Shevchenko <andy.shevchenko@gmail.com> wr=
ote:
> On Fri, Nov 7, 2025 at 3:16=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wr=
ote:
> > > > > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with =
"unsigned
> > > > > > > (long) long" _mask types.  For constant masks, that condition=
 is usually
> > > > > > > met, as GENMASK() yields an UL value.  The few places where t=
he
> > > > > > > constant mask is stored in an intermediate variable were fixe=
d by
> > > > > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > > > > >
> > > > > > > However, for non-constant masks, smaller unsigned types shoul=
d be valid,
> > > > > > > too, but currently lead to "result of comparison of constant
> > > > > > > 18446744073709551615 with expression of type ... is always
> > > > > > > false"-warnings with clang and W=3D1.
> > > > > > >
> > > > > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > > > > __FIELD_{GET,PREP}().  The later lack the single problematic =
check, but
> > > > > > > are otherwise identical to FIELD_{GET,PREP}(), and are intend=
ed to be
> > > > > > > used in the fully non-const variants later.
> > >
> > > > > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >      =
         \
> > > > > > > +                      __bf_cast_unsigned(reg, ~0ull),       =
         \
> > > > > > > +                      pfx "type of reg too small for mask")
> > > > > >
> > > > > > Perhaps we may convert this (and others?) to static_assert():s =
at some point?
> > > > >
> > > > > Nick tried that before, without success:
> > > > > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=3D=
of0y46+rVjnSgXJg@mail.gmail.com
> > > >
> > > > Ah, this is unfortunate.
> > >
> > > Of course, it might be an actual bug in the i915 driver...
> > >
> > > The extra checking in field_prep() in case the compiler can
> > > determine that the mask is a constant already found a possible bug
> > > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> > >
> > >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->ha=
l.rx_fltr);
> > >
> > > drivers/net/wireless/realtek/rtw89/reg.h:
> > >
> > >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> > >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> > >
> > > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > > this operation...
> >
> > The purpose of the statements is to update values excluding bits of
> > B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, =
but
> > the operation is correct because bit 0 is set, so __ffs(mask) returns 0=
 in
> > rtw89_write32_mask(). Then, operation looks like
> >
> >    orig =3D read(reg);
> >    new =3D (orig & ~mask) | (data & mask);
> >    write(new);
> >
> > Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, =
how
> > can you find the problem? Please guide us. Thanks.
>
> Isn't FIELD_MODIFY() what you want to use?

FIELD_MODIFY() is a rather recent addition.
That is also the reason why I didn't add a non-const field_modify() yet
(I didn't want to risk delaying this series even more ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

