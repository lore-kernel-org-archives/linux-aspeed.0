Return-Path: <linux-aspeed+bounces-727-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D129C02198
	for <linux-aspeed@archiver.kernel.org>; Sat, 15 Feb 2025 01:23:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yvrlg65P7z30QJ;
	Sat, 15 Feb 2025 12:23:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739551585;
	cv=none; b=OYSVQJoDVDWTAksGOmb1vxw4IuQ5wmyDsv8bpJPAuoyzznLJ77jxvnXPVQTdfI6eOWXmzaZBQrHixyEYst0u9W9byXMvnaVFZ8dZRWNZuBZSHFbt4AxINV/TwdbNqG9oVtp+V9xV5vIbdyZwBhRezn2j/ryQNl3BKOmMMeCeA1qJUarHpCcV+5IaX98XZ1lfUYUrjG4SXYUS14NaTzygZc1pvqb59OMK6rb3FRATjK0RD4g6rjrs7LJlTnGFfar+PwGFlMwB3BPH0xLT2f8ohoF/hUqK8HXMG5snYFUTu6WuFSnAF3+oAf5rLV5wQgS0vu0NeIBPMgNqhZL1BkL8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739551585; c=relaxed/relaxed;
	bh=gEUK7M60lRQardXDr3rcqI3xJ8vpCF/l2APWaA9DFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNAgPOCXSS8fXA3mCbKMKjSLfyr+XxiWDOIO6XRj+0g4zJt6I/kmu/ia1ljyn6gONlE7gG35MArLzAnQe59D+DrJ4fsttJgfbYlPXKv6SPxhq8JL5UfY3ZrPcegF62HigVns5NMWxu+GpvkFNtWxHU6Rqt57OR6LAOVxCTVv1buzDrQbUxRjJLjLUctJhssetRx7UIq09mrM3Fh/7ErU1WTV3c/ky0rt+kTgaPo+kGSW9hobmdjqTgyuy5HxH1WrJhCx3i3dtCCf8jeRuh8dHdZtyevKaF4ePKI/Lp11A/H7iod94eWhuns0GXIAEg2afanRO1v4kPgAPbFD2oOe8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IgnDGKax; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IgnDGKax;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvdH32ppFz2yGm
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 03:46:22 +1100 (AEDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so773554f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 08:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551578; x=1740156378; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEUK7M60lRQardXDr3rcqI3xJ8vpCF/l2APWaA9DFUQ=;
        b=IgnDGKaxnuW/9y2HhAnJEQSJ+fL2XwRrqusV6Jqx2xwsmBoilg05VhoSsDMzXFnu4L
         8oNW+D+7kmQiz5N0h7RcQvCal4DbIV2szmVEeP6vNF9oA4YvGQ46l3cj1R5AhcvVfpw5
         szw8cMfEUu7hPgmzwQlDYCk7/VBr5STzpOAxErhhD6pY0PJcaxxxOf4exMD3PDA67FZQ
         I2QmjcEkxaCXFuXQRPnv3h5L8AlTEUNOObgQsC233ubg0CXpXn8QbfWlDszdk6E4rKfw
         lB8fXuadFrZlwDIkfAzUMmuqjzkq8XEBg9C4lAjykCUyiYc+vwayfCiY3xQC6onn/SMl
         XJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551578; x=1740156378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEUK7M60lRQardXDr3rcqI3xJ8vpCF/l2APWaA9DFUQ=;
        b=fvZeFbjF/ysX6tSLep8S18al3aQo9tS4mOcsfcv9Fpvrz41U/C2KpJd7/A9hf4Htpe
         BMq/fK0FgPY6ppEWCTFeUq+43YlKBE0muuUxErEZz0TxuBTzVRIHs1xiBbcZ6R1C/HLt
         oOlEgwG3xaa0VwsnUCMeTxbctWCEsJi/CYwEVd4LGjwbrCPvCnGqvEK96fKM9WDsjdL1
         6NzRtspwBgNyZs/p0qea9mHHWR8bsil/+M9muS6+A5k1YDPSSmvPAMs2GWvPQGaJehha
         fC58m8pIPEKjdvpaNcyH39ldhiVXL39FYEo7ZYWw81COyeL05ZpjaWl/5HX3/cal1x2s
         Rh/w==
X-Forwarded-Encrypted: i=1; AJvYcCV0hwG5V/2FDPqysuF2+qa+sCXHLIeJaYy/MyX/QlyO+a7bS7D18rHimfj06Gdm/BHyEr1/6A5BiRvVGJY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWs7xzd6ZqszdYxGhqQiJn+XnLex4RvdNHzXVQo0XKziDXKLx+
	6WA6Sd9TamiBcj8HPfepuPlcTj1PnGw1MlsOvrshiZvySuNpURGl
X-Gm-Gg: ASbGncsxbzQNj3cRZhJqrc7kTyIGw6zUaVyzczaTx+pyP+QaM1KJFwH5o/YIhyow3mM
	UEC7efMfGIGTKh5HkCTnG2rsFivGHKKA9UtCBLVs0GhHzuQ0Oxn3gsAweXg26XBu6q4qc1D3JBP
	ex4TkbsxdKDtlxo7GNh99aXkAj4QqL/6SABE1m4816m3dg0S0sUKTv6Zapnc4BwEr1aXlVMZd/5
	Bb8wbWRajtEWgFNaLRQG0AmL7PWqOqqkbBjhegD+WR89+5u9LDy2hYK0io1KAhyNXKote4r1R4I
	N8L0gfkYOZ6Dk4JPckWSdj/QTuqb1p78vacQzKFFNSrR3THp6C0EDg==
X-Google-Smtp-Source: AGHT+IG9iRvkwD2Pnjr513qQIYSAcwjpWUdTSopHyr3FX8/GpCTlATk6Kd4aSQlT7eXs7Bpa1c1skw==
X-Received: by 2002:a05:6000:1f81:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f2173b9aemr11306900f8f.18.1739551577421;
        Fri, 14 Feb 2025 08:46:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm5125878f8f.90.2025.02.14.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:46:17 -0800 (PST)
Date: Fri, 14 Feb 2025 16:46:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
Message-ID: <20250214164614.29bbc620@pumpkin>
In-Reply-To: <20250214073402.0129e259@kernel.org>
References: <cover.1739540679.git.geert+renesas@glider.be>
	<2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
	<20250214073402.0129e259@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 07:34:02 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 14 Feb 2025 14:55:51 +0100 Geert Uytterhoeven wrote:
> > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > constants.  However, it is very common to prepare or extract bitfield
> > elements where the bitfield mask is not a compile-time constant.
> > 
> > To avoid this limitation, the AT91 clock driver and several other
> > drivers already have their own non-const field_{prep,get}() macros.
> > Make them available for general use by consolidating them in
> > <linux/bitfield.h>, and improve them slightly:
> >   1. Avoid evaluating macro parameters more than once,
> >   2. Replace "ffs() - 1" by "__ffs()",
> >   3. Support 64-bit use on 32-bit architectures.
> > 
> > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > macros, as people expressed the desire to keep stricter variants for
> > increased safety, or for performance critical paths.  
> 
> I really really think that people should just use the static inline
> helpers if the field is not constant. And we should do something like
> below so that people can actually find them.

Especially since you really don't want to be calling ffs() on variables.

Much better to have saved the low bit and field width/mask.

	David

