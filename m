Return-Path: <linux-aspeed+bounces-2824-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B13CCFA19
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 08:00:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2s1g4ygdz2xQ0;
	Fri,  7 Nov 2025 19:00:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762502439;
	cv=none; b=IKksDlymwh5CuHVg//GLtxXgSxMrmzAktCrvSMYwiSy2nFuYxnVkFpCIvNXk+NYmPAUJeNOVf1jtbKKzfbjsUY6UqwCZBc3DWQF6n7gg0pF/TFX9IDqBHVXlyOOiLY8p9WNmIMsRIdTIPjtCrx+meKWqJcxoee/JAYSCLybx4kqCkDL8c8kmYrmzG0sJupB1Wnape7lEibbpd5EhEV8OzqTPMzmcXsl1fYcIAaLUSpoU00VheBoG7jPesry9Z6GttlUQVnr5koQlfHGlcHgSw3wkGjayKrSh6HypSI1EQCNQs12wn4isvjdx7f6G9bEaG29CVbH+jVfKFwiSt2rsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762502439; c=relaxed/relaxed;
	bh=L4L8nwY5tA46qS9RhjMiBvwIJ3m3PvlUWeeZDUBNYNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QL2T5q8orTG9xLyxOkfWd9abXlsJ4E4/J37Y+pwb9ZV/chn/o8nWTao6J6CHyMW69LqJgqgizFpuGazOFyv9NJMBOhmdnQVEHyFZaaxQbB8gpDpFtihR87dJZ/CUmj2n4gCSItD7mpZROgn7NZLfJP78yGE3q3Rv+hL7zI5NMD+taIXqIdmF2S9yqMbgBExVcQCKe5re4miz5JIYascDmvuflOxlPvK9on2ewDl1IZbicesZS+rmqNCSg3YwmfYMEOn0WlG8NM1j4FF/IqA3lXi2kp9EPpz0CAxdhtu/kUWTfrkNdQCOrbVch5oIGaIUT3R9jwW78s2xXuc2RrZprw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JdpgEZWp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JdpgEZWp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2s1d6P7hz2xPx
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 19:00:36 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso818322a12.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502433; x=1763107233; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4L8nwY5tA46qS9RhjMiBvwIJ3m3PvlUWeeZDUBNYNE=;
        b=JdpgEZWpl6a8TzrFDZcWPNEpPOFWAveX2fHFON8vvGUfp6dNn0kkfI2xPRxAGUCEwu
         nchctgNlELwCDK6m/Ga3TXJ/gRcdeZW8uwsJ9F6Hm4oe++B0fpy9okaQZakCL0W6VqZD
         WWkG04/ApIspRgvGswQ5RTX8H/2Yo113ebZNleHEfdmt87wiIlrA0QyGOAOWIppbDMFY
         9nBzgnHhQmqnEz4HLPCcFv+wSSP65F9B/64ZXgxpTdxmU8EuIS8Lud0WbwOglXNt0BBg
         9GNq4hS24nJ5gv6WC3NNoaefY6HRdfS+46e5gKNG2jEoAGcp+eMCmf2ziXxNlmP+EQY0
         nf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502433; x=1763107233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4L8nwY5tA46qS9RhjMiBvwIJ3m3PvlUWeeZDUBNYNE=;
        b=TcpULyo8TRGTJL2xPdOsZ7ncpWhoHC6a2ix5Il81RFXIm1nFEnNZHg2jP67gHRTUm5
         tUXWKLZU5GLhCA96rWH2RHPgEBac1G/jaFT5PQk/XX/UXzVqphcrHfopE8ntAm+rJveE
         qi6LVL8cMx5DKNvTjDO3K8qQ8LPJDy6+ZOzfGxKJ973NSOB5cpSwIKU0vcJ4Ls7oHu1l
         WTNRUIaOi8aI27sj79PBoWylcaK2OJUFwGwlGtNzig4QVZnpE8sK1OSYpPolrAGr8Hz9
         pQSw+NlLoUxQMPxX9zqolTsWmOKIajMROX3eFmYzDlNxYDxmWLVpGslnTMRNZNuCi4Bk
         3juA==
X-Forwarded-Encrypted: i=1; AJvYcCWdqJlyyypMGbRdKmwEuyNv2+IOAFV3v3dEzxmoYKZ4zJnTpOB1iWf5fydaCogX9gsIvR9HD/VY0sfYJX0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyrbLjkMRMaNBfFgQ4ZN5Q8ZafJ6BoYMYmyppnFEIXd8QL4xyyb
	FOjIP3Dbf3feSuZBADN8C2YncGcAwvgjTwk8MWcfMmwIO/E6caKsxFVkBHLUxWNmlLtxgk9KOaM
	m//XpeMRwXCax6bNdzDrhepDNHfIkZ4Y=
X-Gm-Gg: ASbGnctM0l61SWWMV6rYS39jKKNAAFEUFBOFosoXGT3JToYNNJ1qSedrS4GBvXsXO1B
	iP6bRhHwes8XN5+qthTkQ42EuwY3J18eGsp8Wj4E/zeUX+idMM3BBsgWIKZG4DMvrZOab9gCmvD
	02sbf6LwE65+1Bf8LT6b56oJ1Y3pcuHYpaSqXyoCZbodf4FzvR+W1S5VKdwnUEfpuGw1JbXTroL
	A0PW0lXaEFz69PyvFtgYT3N0B6RJUh2Pf3ImJrvBMtHocLS/aAcQeugQwBs8YZfAJMX2hqe
X-Google-Smtp-Source: AGHT+IF1uok4S2/ZJxGVMG6j0RZBxmZiPcUtNqCXKtotlWPr6F8OAXOZaMRmuRE8uDgHau7bT5W5RrHY3dcLjEjQckY=
X-Received: by 2002:a17:907:3cd6:b0:b70:6f46:d401 with SMTP id
 a640c23a62f3a-b72c093317amr195124066b.11.1762502433125; Fri, 07 Nov 2025
 00:00:33 -0800 (PST)
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
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Nov 2025 09:59:56 +0200
X-Gm-Features: AWmQ_bndsm6ikZxAsR6MbqZ_7CJczSuokLGcsZHpDoyZxbjksOeSkgDr0jWR8fA
Message-ID: <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
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

On Fri, Nov 7, 2025 at 3:16=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "u=
nsigned
> > > > > > (long) long" _mask types.  For constant masks, that condition i=
s usually
> > > > > > met, as GENMASK() yields an UL value.  The few places where the
> > > > > > constant mask is stored in an intermediate variable were fixed =
by
> > > > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > > > >
> > > > > > However, for non-constant masks, smaller unsigned types should =
be valid,
> > > > > > too, but currently lead to "result of comparison of constant
> > > > > > 18446744073709551615 with expression of type ... is always
> > > > > > false"-warnings with clang and W=3D1.
> > > > > >
> > > > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > > > __FIELD_{GET,PREP}().  The later lack the single problematic ch=
eck, but
> > > > > > are otherwise identical to FIELD_{GET,PREP}(), and are intended=
 to be
> > > > > > used in the fully non-const variants later.
> >
> > > > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >        =
       \
> > > > > > +                      __bf_cast_unsigned(reg, ~0ull),         =
       \
> > > > > > +                      pfx "type of reg too small for mask")
> > > > >
> > > > > Perhaps we may convert this (and others?) to static_assert():s at=
 some point?
> > > >
> > > > Nick tried that before, without success:
> > > > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=3Dof=
0y46+rVjnSgXJg@mail.gmail.com
> > >
> > > Ah, this is unfortunate.
> >
> > Of course, it might be an actual bug in the i915 driver...
> >
> > The extra checking in field_prep() in case the compiler can
> > determine that the mask is a constant already found a possible bug
> > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> >
> >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.=
rx_fltr);
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
> B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, bu=
t
> the operation is correct because bit 0 is set, so __ffs(mask) returns 0 i=
n
> rtw89_write32_mask(). Then, operation looks like
>
>    orig =3D read(reg);
>    new =3D (orig & ~mask) | (data & mask);
>    write(new);
>
> Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, ho=
w
> can you find the problem? Please guide us. Thanks.

Isn't FIELD_MODIFY() what you want to use?

--=20
With Best Regards,
Andy Shevchenko

