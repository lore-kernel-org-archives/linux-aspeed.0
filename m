Return-Path: <linux-aspeed+bounces-2690-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F75CCF9F0
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 14:38:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxVGZ6j1Wz2yrm;
	Thu, 30 Oct 2025 01:38:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761748694;
	cv=none; b=QUSFjrdkY339Iblyd9yTh3aEyvh98mfHpU/Brlu7tAkKqJ8Jdek6KQHjBhykpOwsCNZWuYdb2HHsYmMPBh9sU6DPxrRQqwCDBS5aHBjQuOrIo/x8M1nKz5CEeZvJ169Tl4R/JpwvRv0XZdWsmR5PnKXf+EqPGhLqrfp2u9K6jEAfnnWENtGqiyMX4vPX4CQcO5XweNt+Cvk5ideVlA1QSbMc7mhSwc/6ZVkujQz6R7QteyP72QcEitDw5q/n5b9bsq4U0C8tFXH7NIQHis+qjx78wVfvO0WmKgp1nkbQcTW7uJeRGEvTdS6zmneFCUom3tQdEwyQ6sDI1yuHvAPYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761748694; c=relaxed/relaxed;
	bh=UmTxX9Lp/E6iQMSfd9sSFodFiE1yd68ZDUJdx86zE5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np23x+pf6zToHulDE+MjXHCrV05T5Bo74XBhRxePtBjUZkKZpgigQ1JBu8kGwWLcFOpdmKenrmgbetkvdJBY68R+wboK2W8836E0YIra37lyfifPJhkQX/nJGP3rztsxrZf7Grk+ui8wyOp3ic97DA0dymZfNzforBO8eQXm6NVAuAOoekieDND2XG8sfWEAd6zlQaHiOx/BAM8TZZ7XHGraJ6EtgFgcV+4epIRaXH4hD6cl2iNTBiOJU2KbH9dQ+JAjm+YgvtZ+Da0DhH9HgWMEbcZqRFFFrSQRddpMlXpULiwxytlIUW8Sm3Oc0s5oFBLIQS+RwnbuvBL0s+efcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.172; helo=mail-qk1-f172.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.172; helo=mail-qk1-f172.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxVGY65nVz2yjm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Oct 2025 01:38:12 +1100 (AEDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89f4779fe03so500922485a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748690; x=1762353490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTxX9Lp/E6iQMSfd9sSFodFiE1yd68ZDUJdx86zE5s=;
        b=UmakcRWLorVs5N5qUoofURXBRa//hhZSycv18g1MjoC7hbUAqMBIADgEyz++QU+W8Y
         z/iV46ZbJ8t37FEyX2moyRos+Y9K0xJ3PUc4Os9YxacA/87iPWPkOPVeHdW6TP8U+zz5
         uqpRrVrx4F3uetzZ/GE9VHkCy9q1qzYDnwvXPcT4HkuJ9omgj+cfHx09yTBzvbJd9Kem
         pwcreuHH91d70YOXM0WSyQ9dccyOGyTdwwI8QfGIMuCVLqQMB0TXeWrvGbGaJLqhy8Jc
         78+pTi3jcxlCC7PlK56YGsjwReLeMfcgXNuFuHnMdVB/n7CXWOCp12hXrsPrxWKDW5Oi
         jo4g==
X-Forwarded-Encrypted: i=1; AJvYcCWb5D6jdIqE545zYykK3JLEX2KZBRo6DWAkJfRa3LTCmMI7Gxglw5Dwnu+iN913IS6uNa46REF4JjYkVbU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxz8nmQEfPneUhthA+QYgH3HThXppQZ0BMvuwnhpyI1/zKIJwws
	eo5FGB0H51daC/XV58Ba4BP+K8yrv4tYoW/WpxYluJaqN3zbX+z/GJK8KJyawP7I
X-Gm-Gg: ASbGnctfnniotX9bdIPzLKjO3qV17GDoszFsxCZ+Y83Lz2ESphmZnmCawI9B9MSt8hR
	jvGEVP9vvurmA2Ve0GZ43TwnifNlr1B99j1G8YmMz97bbTQoDDPRs1v/+H1cpaLKm+aobs/Reio
	Aj9rdiguxJwfGffN5es5d40Kp1aIFtaKMn+j4iGrl5qT+TkdCAMZn8LxH2Nii6s88BeyGhcVaG2
	khhy7fZHrmZxuZoPVVJ0SFEPn0EAbpsUqvryLrwJhqAfmh7XYpwzz+/QkVS+mRYJ+BwfrhBltL/
	tz/5iCRilNDjjKgy4xF1DJMPl+m8bQmJ9xOzTj8/yYV9KFc61uA64X3NKVAi0MnXYjUrNze+jMt
	je6cc/hQt2sjkCvkAUtQ1XIMHQTTLNf5T7lydrhzaWObFIz/t2/uOD0Vq5hmlMFvspcM5tbOrB9
	MVGoQFt9N/4nITOAAc1HWnw9gY14VCbUz5Gbp0PUkj9s1nflmFgAlazw8X
X-Google-Smtp-Source: AGHT+IEFF5oelWkNlKUubMoqjYoHRv7DFZt4UZbktrIHoimNAEcjH+uDIKQbJIIfHVfRd0ExEtHFfw==
X-Received: by 2002:a05:620a:1a11:b0:862:8fbf:f8e7 with SMTP id af79cd13be357-8a8e6668575mr373344085a.72.1761748689873;
        Wed, 29 Oct 2025 07:38:09 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f251b8a24sm1045325685a.25.2025.10.29.07.38.09
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:38:09 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-89048f76ec2so810130585a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 07:38:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+wJlNyHjXWeVHQaOeoIX5Jsr8glwsh2C0IpwRinCKA6OjxXemRT21D0Quc5DnWcj7Grf32zCAjxAQ6jk=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3e95:b0:5db:38a1:213b with SMTP id
 ada2fe7eead31-5db90656011mr932905137.27.1761748238614; Wed, 29 Oct 2025
 07:30:38 -0700 (PDT)
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
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:30:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
X-Gm-Features: AWmQ_blleyKJMjc4oETFxToQhJJ0bdzSdD1fdMmRWAHt71coVgn8wIHcAFgDdM8
Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want me to just merge this patch to the pinctrl tree or do
> you have other plans?

My plan (cfr. cover letter) was to take it myself, as this is a hard
dependency for 11/23.
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

