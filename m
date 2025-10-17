Return-Path: <linux-aspeed+bounces-2500-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17FCCD19A
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 10:55:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp1tw4cxCz3cdR;
	Fri, 17 Oct 2025 21:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760698520;
	cv=none; b=gdJp3s2zRrT/N+bheVL+7zq6n7pVnMjKdGsDEezzHRxgLGjvfIQZbyQu04vUlUFXTNIWmMNQGauyre9CCtE3KKvO/BXBpUl7Duc7UnyyxPE4fgkQ8JmveDPQmLi3W5nXlCJHPAE9Y+QXFlegA3uGgmr0oPoxRH6Mu3WX+QyRW4aqo5xIXu40RsQHWpOeRXORncTXe1WhNJUBB7ndWSX/wI9UEyOzgK2HMhK77/yWIrynFedwV6NRmKcDIgWoMcLNRozQKdnt38p9kclNC2FdP73JDC2eXI9vxUXo2aLwDXCw/pbn5eFjwxh7w/nCOKsIY1X0NLyauThwxi8cfbPFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760698520; c=relaxed/relaxed;
	bh=XCpfZFAx3hiLnczCJXcXTR7Dek411X8RRc+fD4xQf5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coytlxrLpvBiHLHNv+a7+S5VTc7EMIuNgiZtPaHae6BZSsSsTMiKlVU1IfgLidwCwZmfZkVlkm4V0EJchQdBeDp2mDorvEXLXA4+bjGZ7BjpboI3nUCmNPwgwegI8K2n7ynCY9YiuWfg2NsqiwXKcOSSUACI/EMYZIVMx1OLz9dF9F+FnkhA4pt6qYKC4F+gqfZY1Efh4MNZara3AwPoSVCrt/JZJVdpfUfa9SnN8tlf/DjQEz2x5oAoUw/HgH52dtlwPLrHfI41xNgi3qHOtbJp7GZUVlN9cf+OtmbYwVygI4Mu9ynNGczJMgkSgG/4YuQC7CGFvIJFPacXtn0V0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.175; helo=mail-vk1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.175; helo=mail-vk1-f175.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp1tv0rLmz3ccF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 21:55:18 +1100 (AEDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54a7bf06edfso1097013e0c.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 03:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698514; x=1761303314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCpfZFAx3hiLnczCJXcXTR7Dek411X8RRc+fD4xQf5M=;
        b=hXD22oI0Es1ufgtDbB/IZXXTNoXLV6oPU7Xytb9DSssoqSnAA3bHpXvHh1DE3meJgY
         c2UHieB+lTdSkpllZY7BZexX7PqIDjVRhn7zhKm3aaeB6q/HQqm04Z9979Z2hbZInkbt
         asDCWeAM/9qebM/ZYmyj0ys/nMgdbgf/fIddbzJAkH9m73VNj/9DAx6FfmJ0UWcX4c87
         mItw2bwJgO+wRyQWLft6AwqMHMOHdiGi92ocit7pFCl2HmYA361K9Rb0gLQ+U7McUZKI
         Ae4MBVhi733IjkBGsi5w0krEbb1/DDl7RFQwm+0/L+Gbes1E/MF+4IQu53wIsqIM2S+V
         3Oig==
X-Forwarded-Encrypted: i=1; AJvYcCVmhey3GsbweSoJ2ZN1MPfQw7NMWXWMcGHds7FuVvzaXCcw4T7Wxp2lTHapLZiLFG1bxpilGkvVXobcvfY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxF56Rfuvz2vmSdCoX33hF5p+Kn7trMw/4AstHOpZpqCcHSDQeW
	B8S688+yS37DwnkJyZEH/clKbp36kSqYiEUTVaBtqPI54ZoQSOyZoBz3YFQclrW/
X-Gm-Gg: ASbGncsc6UpLevKzwDbWkbreJS0+WVSF9/i8qXSimJPxRh/eRi6JV5g8au2kxIcazAF
	Sku72KFeSOg1PRODbXWvX0E16LtWDM9NxpB5WIwWmvzdVQ6cXdiYhVolA1ERvXggyYAkC9XhUya
	5F99/sHwV3/nIgKjd9fnW2L6V78PbDOmZ++xdo/GrpW8iMS+loSQ9PTK6nqxe4ORcBv1SSCmPDa
	79LtCNmNReHR+KNXEQP/8SqdFkvUv14Yr7yUdhMHcczA0mB7BI47q6debqAYCBrS54UuZRrJqkj
	pRF8XQy0eBBIcy5AQaitTiX864qBMY6Hi96ZD4isSo2zqqH7g4AHHpYD5ps1EFDGSmKLRb6TNGK
	Z2GfpW4gXL13cCFXJAfB7yy/TwG3BxFAlk/YgGaZbB4twfnjHk09821s0AplCF7arhUcfp0ggbC
	Y6Sh5RaVEXmKAskkDfVSaZERz6MhHenW8ZAf9ShkdvleJVo1Pi
X-Google-Smtp-Source: AGHT+IEjxKFYBL/ukHJGTMWm4+1jww95gyb841YRi/kL72Q4Q6Q0p/SU2+0apFJ519X7PsNsNLPHVQ==
X-Received: by 2002:a05:6102:3f4b:b0:5d5:f6ae:38eb with SMTP id ada2fe7eead31-5d7dd6f5c2amr1350291137.44.1760698514059;
        Fri, 17 Oct 2025 03:55:14 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-930bf78d14csm6080819241.16.2025.10.17.03.55.11
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 03:55:12 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8e2e9192a0aso1262527241.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 03:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcOVqj10JPqHovY6dhOy2gW++O8jtoJwwkwQMAexbxqILuoUW+cRV9dwd/obLtgHCe+wR9hD3GMj/1L0U=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c49:b0:5a1:f09f:524e with SMTP id
 ada2fe7eead31-5d7dd59bcd6mr1313646137.16.1760698511065; Fri, 17 Oct 2025
 03:55:11 -0700 (PDT)
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
 <20250214073402.0129e259@kernel.org>
In-Reply-To: <20250214073402.0129e259@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Oct 2025 12:55:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
X-Gm-Features: AS18NWCjFk9wo7Q1aPnnkBYJzaq6xcQVQAXawyeid30N8a2RlJlAbXrKkziomTs
Message-ID: <CAMuHMdU+0HGG22FbO3wNmXtbUm9RhTopYrGghF6UrkFu-iww2A@mail.gmail.com>
Subject: Re: [PATCH treewide v3 2/4] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Fri, 14 Feb 2025 at 16:34, Jakub Kicinski <kuba@kernel.org> wrote:
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
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..e02afcd7aeee 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -156,6 +156,80 @@
>                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>         })
>
> +/**
> + * u32_encode_bits() - prepare a u32 bitfield element (non-const)
> + * @v: value to put in the field
> + * @field: shifted mask defining the field's length and position
> + *
> + * Equivalent of FIELD_PREP() for u32, field does not have to be constant.
> + *
> + * Note that the helper is available for other field widths (generated below).
> + */
> +static __always_inline __u32 u32_encode_bits(u32 v, u32 field)
> +{
> +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))
> +               __field_overflow();
> +       return ((v & field_mask(field)) * field_multiplier(field));
> +}

Unfortunately gcc emits actual divisions or __*div*() calls, and
multiplications in the non-constant case.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

