Return-Path: <linux-aspeed+bounces-2689-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B9CCF9F0
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 14:34:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxV9p4mNmz2yrm;
	Thu, 30 Oct 2025 01:34:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761748446;
	cv=none; b=ohHycIDHL1AYsHaaPDbhtzvwz5jhqHsqm33SpbpBexZBji+UzpfGTokR7LhbXEwn/cuMgz353hQDEPlrkual86nwMdMIY+fcFixA7e+CL5DITSJp/qH9ow/vFrGXuVzqVbAnFA06LyQ+KJI3WJL6Mq8nhnX9MnVKf2oEUZMKPmQAcNtGBgkAraexAKWwLKoCpFvetfDpv7VEpLig/nWDqPSIssrM9OE9kG+EKRaRGDjvaLCvbQlP9xkJVZ6PXLRU7QqK69g/9PqNyTJ3pMVVP5MuxUzkEcFbU7GONV1B+3HmM5SGwgAxs6S0qmolojHxwvpZQORNjzos469xN/JLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761748446; c=relaxed/relaxed;
	bh=kNDkhDDabcFgtYSzLRibzijDMaquJ035sDb5A+sIiAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQ7X5BlZTZSBuyt1b4wOGanN5JRakjJQD3V1o6iiuTBc4hXuNqU279NGkl6uj5mPABBXYYE1OMbmK4OxsEjx0+c9vDKe6UEOVlF5DgxRxAF8vPdxUobnObhJ5eF4YGZ+1HRKfqRGo02cNGxTqYCYOTgzXxNW2Bck0RSmgDMoUwCN5ynUI9Iw0F3SYggzEGiP0kOqbBJK8YfkTjpK1UbaIKlQZwiR7gZEDa2ZLa6XFIx30pWdcvUtxXgMgRwPWTHsUAKOnbaQYtrlifq40e/mt1RVjZUEFd83JWSs86hDj1BWxH1RKSIxDn3+KC+7i5EoQzFuX3zvKvFwUcG6B8UXwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.47; helo=mail-ua1-f47.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.47; helo=mail-ua1-f47.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxV9n28kXz2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:34:05 +1100 (AEDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-932cf836259so2957617241.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748442; x=1762353242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNDkhDDabcFgtYSzLRibzijDMaquJ035sDb5A+sIiAE=;
        b=t+zQaVzrK4s2JDyzovkaMorEtdmliju9s2f1hyy6hPv9aj4LE7MUq6bfMEXiT8AbNy
         CKa98M2QeWfQZjU/UkWzou7oAVHvQ9LG7or6oCrdSuEB1FmEblBk522Pyz+Q/pd26izw
         Lt8JmmQzK+/Pm7sxUsohY7JsKkRzi1lcT9f6pQRhuDZoLV5LAKA2PIqAOseJtbahAm+L
         rl0M1t3+Qu9pcQ5g1k7quj55CqoPSKTxHw6v5RNFTBkiNWX570RDNMFkOV0mTDjWUqs/
         VbbB/OpNFdSRysHRpAgHXJW7xHrZtUhaAt4eSUvT9MhhYmzGJAgz+zE+16zJXrcgVCK8
         KLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbAeQ4pBNH2rpt8WCxIHjsbRUpm8ErEtAbFNq1xFGzexfLVapxcWNd2ow0DhVlaXm4ClYPGq5KV/AytRk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0wXcin1/Hd66QcrUAp6tzMfkjVL5XSIkkKrgSfx9L+2tNo2vU
	BuoaBoMWVPw1mUJngvD8UTgnUmM6KPVR6wCLDTW3LKR3pT4NESUZtQnblB5GYcWB
X-Gm-Gg: ASbGncsaEMiuthzioSmiqFg62/uYyl93N+zgt8M6VKgZDhUbBik/BWFYjAz55oWTiPk
	0sv1+4EDQBE4RBgqK6Q3wMsmmKv5fB0O1nrDGXFvlnarUdzQ7KqxY9L6jJUwYW83PqzwJ2kNv1/
	FN60u/ClrpPeFPf3lLEUeaHY9v0L1057dvmDu/BuhFSEZ7HmlBGU0/QSV06j3krNJIhBou4k2h4
	xijv4Ib5bM89CumkvjLG93gjNKRAHAogdjLT7Bt1EwEtTjlY2HcfctcR8c4DO3uKZYfjsKnniLk
	3fPLuIXCeD/E46N4OSgCOoT8TIDBctoSCY0Jxd+Di11FfnZNP7FMcYJ+EDMY/F6u+CJOgzuboCh
	R3Po7jyFr4LmcoBoIM9QjAB6OYD62CSaLrAhdQZgF98GnOzbvr7TjwlDd6s5YoiAfPKxVpd7G+x
	2dF7sCJUQdm5UL7fCVc/fIJQudcqPQGUvPH5utBZPT/by78blmu5aq
X-Google-Smtp-Source: AGHT+IG3Fa6IWa/5e8+Ue0L73Q9XZicavq68DLFO15OBwPtDZJg2ZMrIcvXLlWjInEB+1nu07Qui8Q==
X-Received: by 2002:a05:6102:1624:b0:5d5:d1ba:439b with SMTP id ada2fe7eead31-5db905d8f89mr974396137.11.1761748441748;
        Wed, 29 Oct 2025 07:34:01 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c3ed019fsm5235245241.2.2025.10.29.07.34.00
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:34:01 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5d967b66fedso4432637137.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:34:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/C0hf8mz1nlZVhfszlMpAOcic2w8R08tw6kjcbcLrtaUIY+iTyMuyq/uGReuMVMqJ5gQ2UWqrWfucbGg=@lists.ozlabs.org
X-Received: by 2002:a05:6102:26d3:b0:5d6:156f:fedb with SMTP id
 ada2fe7eead31-5db90694687mr933346137.36.1761748440676; Wed, 29 Oct 2025
 07:34:00 -0700 (PDT)
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
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <aQIlB8KLhVuSqQvt@yury>
In-Reply-To: <aQIlB8KLhVuSqQvt@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:33:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
X-Gm-Features: AWmQ_blqiXGJheNiHtKi_cJSwq0gfFP8sAonrx_tsjN_f5pUMr0aiWqvAOsiPck
Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
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
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocesso=
r
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to just merge this patch to the pinctrl tree or do
> > you have other plans?
>
> There's a couple nits from Andy, and also a clang W=3D1 warning to
> address. So I think, v6 is needed.

Indeed....

> But overlall, the series is OK, and I'd like to take it in bitmaps
> branch as it's more related to bits rather than a particular
> subsystem.

OK, fine for me (if I can still get an immutable branch ;-)

Note that as of today there are two more to fix in next:
commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
in sunxi_nfc_caps") in next-20251029
commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
registers") in next-20251029

Thanks!

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

