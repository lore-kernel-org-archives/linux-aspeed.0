Return-Path: <linux-aspeed+bounces-2802-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C8DCCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqj1ctKz3bfV;
	Fri,  7 Nov 2025 09:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762447507;
	cv=none; b=VzTcXG+D4off00kOWAQL97Qx6wU1+Bksjmw5R0SqTqz1uwmKPGkpkA1ZCE3ZxPhgPpjDOgew8tBa9e4qtj4xj0CIDuieyYuJo57y3vhYZEOdCIqeAyQFKmpwHirC4T71MPrDvtYRu4GE2wb0X3jYexu3DfGM/8X1pNOgaNPl7hD3aYfNh7LgYQDUlVaTHPMZ2y0HOzTE99CILbDmE42ZXraOM2S9OkIGq0KamNvT3Qk6yLbZLYwAQjH6nAG9kFb8+SORk/ltkcbo1N9tS3Bor/HgsTN5ikoziIsvEdOnfAM+4gxg0qxQskhA/hjYGTJslfAvCO3IlSCaEMMdqkSltw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762447507; c=relaxed/relaxed;
	bh=YCzuZ/teXYU7yevuP9B3flHK19xr/xlr710i4rE8skU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCpgEOV9m/H6C7vWlFQVFuU5sjwxoM5knbcmIvNErIfIt5NWM3dt/hQKqogXb9Mq3nlmbfK7aK8Tc1uZb6xOPBibcOdJWjUH+KvQwInu9VOV/Ak+1N0fa2qlnK0JRw0LVgNVJ3OGAGsaJPzu0Y0wRbh+tcZAvVJ+nke/qGfmWN9tpHGYZA7QrD8GvJZJCcGmDt76ATimGalFTcPEr12AWPEtR1xnc4g8F8R5t7b2rN4BdPbNpFSQapLm2KPEyqwSS4QA5WWbZCyY1khHj2ewICF3KoEVC3tKt18L2JG/N9vD3wqmcA+F0hcqLpD1BqG7to5T0+X495g91DH2FfsGxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lbc4PtwT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lbc4PtwT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2SjG51Wyz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 03:45:05 +1100 (AEDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-786943affbaso10713557b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447503; x=1763052303; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzuZ/teXYU7yevuP9B3flHK19xr/xlr710i4rE8skU=;
        b=Lbc4PtwTAWq6dvFchH9cif6V/cqVLQiAexlOigyeZyqAZpEsAoSXYvVAeFIqtAGFdC
         A1xMB1ipefrXCWlRomjSR0Slf880kJBvcmjqAHK0RZG4npX1oyFSn3YvA6rFb8QHEFDG
         c6KwBuiiQjAWOxO8/+koOQY/zUVhEhkjt3voo9S/nR+8reqjuWsCGfr/6urEaNjQnk3S
         kvxY0ISGrWv77eyFmV5b4vH2Dh5t/Y7l6cZHo+YdK8Irpyp7nPFJ8l0jVLoxI0vT8IDB
         PpRBjzaP0VUwhK8N1AWlfhMhpN+6N2r5FdX+sNWoXRlaB2zm6oiIbcuHuVyOFl1q4nP3
         +B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447503; x=1763052303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCzuZ/teXYU7yevuP9B3flHK19xr/xlr710i4rE8skU=;
        b=BPJeFwDq1FzJmEfh/Z1hDHh7tznXwvTbE9L49iLTFyMDXVw3SmSKZNLb2OoAT6lX9A
         dokW3puyQMKq3klpsrmfuiLZFIgmfdqaSWIcFn4xCLFxQQRqAMSo2GnaTKpW+P/vKGBN
         lzXxWdbPG5+gqg3aEewWTttOjAffZQ2zgu40CtEKQDMAq0V6dCUIqs5Gmq1j7TodxWz/
         H1tmt+ipJPntLy0nddj3YSqmAarJ510I73ZqdD1zyY+JxxruuMDH0D5ZOqnljCfNglDi
         lLD6/RJr83P5WXkHW93zteN8lU0tJ4JN7H+1WtMqeTUoDrHeRktwa3tyBecPjZEYvsLZ
         wEwg==
X-Forwarded-Encrypted: i=1; AJvYcCWA69LYQQclaJOqSLdWS75TiyEgvOHMuUL9ppzwHoXeDTvXf8IbIU+EmmsoNteAoEdiU/yUm4S9vClXpkM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzA+t/2Uj74jdHZSGYrKDTLahTH8dZArbQg2ZOz3XLkBEf1iuep
	ghGGLmpVf5fLn/uqT97Vj/83z+g9PdzOce1a1bb8QVHYofZCs/YXMOh/
X-Gm-Gg: ASbGnctO0Hbp7Wf94QGvYFYJz4PSB6ArzXvuzl/tKgYy+sSL2WCHJx4fBrLub2PzqeO
	eBmv0VlRx93j543GbBCOkY/AwZCvP2Ezt2iXRkKtLX3We8RKiMitsXHtLMBSqjQyzQ0PZYfREtU
	mvzSZwMkMcIrS0jg1Lw4aZu7CKKAQa64DQBob4YTdMPV86LRUgSQu2towz+fo1FhZA72hCRGu8I
	otgrnW70c/qGeNE7gVNnvYuxHvxRiVIwGa9lTe8valUNLG2ZTATpe9W8gCPeSWS9pANd4ZGjaQK
	FPEIf53IcqCBshj5SmlJ+B8Y65VMxTuoyqqM83KXonKKFpwwatYOXgysgQRwvdLvnPdlfsTRaIX
	OeY9iYrn7iBvPw7l3tlCAJFAxFTX378HkFGKZQc8vnF18ZnKwjOiakLPPGRB/n6hCAYeVFIUC1p
	7g5hm97Hb8RbDPDpdzodr2VY+OI/YF42KdGFcsA7zIhi0=
X-Google-Smtp-Source: AGHT+IFgqblsjDg64jVhZU34czKFHTApBwHTvzKvobAZn60rv4BaSs97biLpVcByf7R85pQynTZCWw==
X-Received: by 2002:a05:690c:46c3:b0:786:45ce:9bd3 with SMTP id 00721157ae682-786a41b2455mr71656237b3.34.1762447502815;
        Thu, 06 Nov 2025 08:45:02 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13b6954sm9471997b3.5.2025.11.06.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:45:02 -0800 (PST)
Date: Thu, 6 Nov 2025 11:45:01 -0500
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
Message-ID: <aQzQjSMOSrUIgMCL@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
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
In-Reply-To: <cover.1762435376.git.geert+renesas@glider.be>

On Thu, Nov 06, 2025 at 02:33:48PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> <linux/bitfield.h> contains various helpers for accessing bitfields, as
> typically used in hardware registers for memory-mapped I/O blocks.
> These helpers ensure type safety, and deduce automatically shift values
> from mask values, avoiding mistakes due to inconsistent shifts and
> masks, and leading to a reduction in source code size.
> 
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant (e.g. it
> comes from a table, or is created by shifting a compile-time constant).
> To avoid this limitation, the AT91 clock driver introduced its own
> field_{prep,get}() macros.  During the past four years, these have been
> copied to multiple drivers, and more copies are on their way[1], leading
> to the obvious review comment "please move this to <linux/bitfield.h>".
> 
> Hence this series
>   1. Takes preparatory steps in drivers definining local
>      field_{get,prep}() macros (patches 1-11),
>   2. Introduces __FIELD_{PREP,GET}() helpers to avoid clang W=1 warnings
>      (patch 12),
>   3. Makes field_{prep,get}() available for general use (patch 13),
>   4. Converts drivers with local variants to the common helpers (patches
>      14-24),
>   5. Converts a few Renesas drivers to the existing FIELD_{GET,PREP}()
>      and the new field_{get,prep}() helpers (patches 25-26).
> 
> Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
> macros instead (which currently do not work with non-constant masks
> either, and the first attempt to change that generates much worse code),
> or to store the low bit and width of the mask instead (which would
> require changing all code that passes masks directly, and also generates
> worse code).

Everyone please send your tags. I'm going to merge it in
bitmap-for-next before Monday.

Thanks,
Yury

