Return-Path: <linux-aspeed+bounces-608-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ADCC02192
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 13:59:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ymp630XFFz2xLR;
	Tue,  4 Feb 2025 00:59:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738591195;
	cv=none; b=X+plbv7CisStK+WsJl/AiuhcAbQOJ3dRS76wSXy0SQwZBWOpuvE5AOnLCcivQEnpnsHaF8R3PV/DwszfegbWVCwwJqNlxNgQ+fEbN7dTvnxTQ32jtYsRgNbP4HqpB3JUSw3RyFEimaIAUdB/GE4v0PJGS8JXy5WdJtQx9xc8iHzI6uC64TQ0R0INTXVTxoX1LHLdF7zgJLNjRBVZuchDq9cW/mV1Ki5Rt4jUB0FqeHyZjE0U4GntR+oRgEE458sds6XOPO3tneJvUXR/qw3UD4nngoPb/54SXfJmUZjmZGID4TvvrYq42zM74uRi/5gGVYyn05/CNhtMqaEJEF1SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738591195; c=relaxed/relaxed;
	bh=2e3vrd26snuR7BBCNgEi1ltS7NqcxsA/B6t8vBEFYDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU8awpUWgkoxuHu9EBD3bA3GnnYZPxGXLLHCcFB57B3chonwiQBpfB34ZRJyqcPFtwrjwxF2FtHIwaIURtABCUqGonzRI9CM6Kmad2/s4Wr48iMWM1k0BLg4rSLxqjk+6TgrKi0JxDCTpbVG1EhlchzhY3V47W0Z9jvZycwAQaxhb5rfg5sEsSVSVbmjZQpiJ3ZcPRhEqDD0BQwxX4KBUDm0YdIh5Nd4IqDA4JqPlcklzselJvKUSfFzDLd9Leb5fpSIRZ4CDZAWeDa9TV9Nv4Wb6EjhhyTzQ+bpgeB3YmlAJlG1IQhlkHjBW99YH3HN/q6aGgYYb9twU67rkIUv8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.54; helo=mail-vs1-f54.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.54; helo=mail-vs1-f54.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ymp6141Ncz2xH8
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 00:59:52 +1100 (AEDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aff620b232so1314608137.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Feb 2025 05:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591189; x=1739195989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e3vrd26snuR7BBCNgEi1ltS7NqcxsA/B6t8vBEFYDs=;
        b=rbY9Qi0sxLc7YN61RJGQ+c+IZOigL7Z7kMsztjY9GIU00Obk2VVNK3Vm+/+UGQt/DW
         i+l0GPz6mdFZ1t9EDUeuPLIhTrzL+5dJ4HSFpngJAgDT3qTZ4KzY2SM0S0WFl4W9/IiI
         MFXEMnm67CFun/cTuu6gyFUBYYQZu0xh/CFKB8d+CJnnOnT9P5cG2B7Df8DJbYhrVt7V
         Fql3tKXtEXcPWMlOi960CaeOmnF1kTfMRLGIjUzRXFr4yCzzjo0xQT3d5JotMhx7MU8C
         1KZWkEwSfKQIAtUW5lGc5PHVTOrq+CL6Mc39dRTQoHThX4j0alPjDsij0/bwubIvr412
         6hZw==
X-Forwarded-Encrypted: i=1; AJvYcCVJdlpZOaKd4+9i8RWaTYLOUNhge5Pl9cxWwtWTZIgAsrKsG7SQz/E5zKQ0drWY2H0hxOmpsxhQCD3HSpk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YztXlyJCse3Z979flHACetymCSVMfW9/87ZL30DjwIY7fUP3s8J
	oUeIOkLVZKaxscB6RgfvNErcF8bvBoKhAzZcz3D57Gt33wI7FPgmmBdZVmin
X-Gm-Gg: ASbGnctJ865sIswWAJFvVpt1bMdMlBDPI4QB43NXnjhViMJKSoGEcQG32jjKZVn2X7R
	IryvlNnjzXiddlD3gru3RCyzw+vQEyqz3AiaM90l+0RdFQq8UGJM21arVN3r/KKmplm0vmcd+yn
	wccCvOHOkkv7el7i9NI/DTANmJNDh7NuK+hR22V4Uf9kic0OPrcH9aAg+O1WNmpWfNmu9+2fsPb
	tCOIl35T2KLZLheKGQT20Va8xJgG1o3LGAMt31Fpc46A1oMKP1KQD2ImDx1JfVIjM8DzLwD+6fC
	Q1kSa1ACjOwLNEb1QmC5Er6YDMXhWNljDUIIzoNt9r+Lh2DNhNmJKycKEA==
X-Google-Smtp-Source: AGHT+IGznRJo0Zk1ak1+0q9jORolSlB0X6+sxkw8JwBfNX2JrQOzDj4c/srhSpAyu9Zp/2J9awIzgw==
X-Received: by 2002:a05:6102:3ca0:b0:4b2:9eeb:518f with SMTP id ada2fe7eead31-4b9a4f4d68bmr15865366137.10.1738591188841;
        Mon, 03 Feb 2025 05:59:48 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866940ad22dsm1464598241.20.2025.02.03.05.59.48
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 05:59:48 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51c7b5f3b8bso1379682e0c.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Feb 2025 05:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuXHVCCr72t0+yqkMn7QIF02e7nbDRB5Kl9oZyCBn2AatbxMzrzgpJ8GsXNLAihbZ5CiC5oHCdNgCYVkM=@lists.ozlabs.org
X-Received: by 2002:a05:6122:1990:b0:51c:aa1a:2b5b with SMTP id
 71dfb90a1353d-51e9e3fdc44mr15881808e0c.4.1738591188554; Mon, 03 Feb 2025
 05:59:48 -0800 (PST)
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
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net> <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
In-Reply-To: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Feb 2025 14:59:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
X-Gm-Features: AWEUYZkxzrXQCnvoDXR55r9qIi7LTjZDYDZYK_OEJibEwCDu5alOHeJTYjGkvIg
Message-ID: <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>, Yury Norov <yury.norov@gmail.com>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> >>> Instead of creating another variant for
> >>> non-constant bitfields, wouldn't it be better to make the existing macro
> >>> accept both?
> >>
> >> Yes, it would definitely be better IMO.
> >
> > On the flip side, there have been discussions in the past (though I
> > think not all, if any, on the list(s)) about the argument order. Since
> > the value is typically not a constant, requiring the mask to be a
> > constant has ensured that the argument order isn't as easily mixed up as
> > otherwise.
>
> If this is a concern, then it can be checked with:
>
>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
>                    __builtin_constant_p(_val),
>                    _pfx "mask is not constant");
>
> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> any other combination.

Even that case looks valid to me. Actually there is already such a user
in drivers/iio/temperature/mlx90614.c:

    ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);

So if you want enhanced safety, having both the safer/const upper-case
variants and the less-safe/non-const lower-case variants makes sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

