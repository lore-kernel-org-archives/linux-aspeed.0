Return-Path: <linux-aspeed+bounces-2810-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667FBCCFA13
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cqm5zCBz2ypY;
	Fri,  7 Nov 2025 09:51:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762443604;
	cv=none; b=K/aMzZv9naBMNLYtmLGjWWGrD0jMNKmgz4/cfGaEUfApvmB4zY65renKAWsgeIep9B3Cmc6hIz8j+NZt8tMDM68WFvfw9C4caHnGauObCB1hJD5uE29+d1/rr3k2N7y5SGgPyUJ0Pf5D0B3XSCsG98Wa2g/MxQpIC3EMDGVfTSKZvnzmR+3rzs1OBJb4SMT5BTTpBOCbe6C3Fy5bzEwKFLeDb6uVMGORpIW37aAaeB155gmgZVVau3SMZ9kZDIV+/FzKSkpmSqfuFsLKqXh2seBEjN1+dm8cW32D6W5oQfrD0gLAtWD65dAzrWj9P2F2NzTYtwF6Ifmtf7g0Z/skrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762443604; c=relaxed/relaxed;
	bh=NCImS8vAPGN6LTIAPQAR8IZZ+CU8X+89zO49Z6Ixv/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReQSpGZJBhBZeBmsxI/O2n0Mk1reiAfC7dDXhnmr/uFa0gwkOKiE/IRStKLTit3RkFc+6naStBSqRSDYmZuH/RsDjs3+tzIBqAqlkjrHHmX6gBKNh6k1t/BE80jdjsTw8sOVfU1aA9hWiHkGHYmxlmsA4LVMVD6G7RUZJOR6rZJ8dHvOG0I0rLm7m1TE0WY03OG+1pxBAFSpWgvDw9VYlpeTx7MowU1/kmiiBudHHradY7zp6hcNye6TRwsYmlRw5T8ErpYOJ9kIjfGzpQC6Y2xMVnINvrTtSvB9WVY9j30rXqWfyQ+obZB2UF04/CozVLEyetgAreQCR4SWNovcng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Q9hp5LEw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Q9hp5LEw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RGC1jVJz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 02:40:02 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-429c8632fcbso886878f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443599; x=1763048399; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCImS8vAPGN6LTIAPQAR8IZZ+CU8X+89zO49Z6Ixv/M=;
        b=Q9hp5LEwM6/l3QJtAjLvnXBk6YrNW/ZLgXT2QpWpGwNFYF6T4kOJpHYpDCm1Iebzq/
         phKv74xCaKv7vNR00IicKaapsqfOuKCmZMhjplYwFxDb6mpTNYqZDh5o4iBeFNHpL6On
         Y8KDQie3WkI3A5wpPMKQ6dy5FiEwzibS2dvrtWK2xMZrPzuMweobfMJhhGLF42vaqqxP
         Zu0nZywRf4Met3eIL2WDXJFBRqKy6YojpabOuYZZGkjm0AJq3O6KWbPMnvXF4cjI6q0G
         sJy5fq8VZWbf2z+cWMZ3oT5suh3KHfA2EH6bNnsX0etw4gBpj0MAagaQ4/v4yDMSf5y0
         nzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443599; x=1763048399;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCImS8vAPGN6LTIAPQAR8IZZ+CU8X+89zO49Z6Ixv/M=;
        b=Tgy1J515Ca1woh1XjEKuijPapHIaiu32YaPNCOkpz7d/PUhV4xdri2OftLbjfuAcxh
         s+5Dzmd+xyoXDZITeL0QKkGagFIcjNWcptCWmiUEv2uP0UD32fCMFflWr+lPpJKmazW2
         M5I5gJ5ARaLU3V4M4nzEOO/jXFXPcJge9Tc/OJBF2A4UK0+NSrkVcEKTz0YpPdCVs2q5
         C3eJlwoKhC2jd6+NreVVekPtUMradJMcL38gwD3Srt+Fnxh7xlJ/IzvL/0DWKPcaoYkJ
         +bWp59ClbRT8shZ/NETqanx8RAkw1V1lo8eE2flQHBfYxheONczvzdxJF9Km6HS7cbqO
         ZPBg==
X-Forwarded-Encrypted: i=1; AJvYcCU4MVAWG2xKGMuJbsFFyK7yIE7Nt+lxdLvGY4XoC8XLlZTyM7jIH/gCvsgQpy6ARXn5OF9qj97UqniD+wA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEJDhwwaOu8O/iddTwZxAX2kU5WXIrS9GhTqidNekn9qoPAqsp
	92U7Gb9My48cM40/8K63J1t2E8b5e+q19VrjY0wzvmaC5p5RaCsxy9a/eJBaqd048jo=
X-Gm-Gg: ASbGncvJ/cyHOY9pduOYW9UqLWD7EE4tN0vJzUozVF/2o4alFgK1z0fxEf+bzh+8LsT
	Fp8Qas6RGCnBRO8pOBg6pRHBX6XyJngFPo7uucymCiK8zc48Ib0O8p5OBah6E9yAwxYito1ED1v
	uq/fIThq6g6WKLdntxj9OkrAHPyOF2dTE7mTQdFlcZfmHkgjRIULoq1yYS8uyX+8zUAFYp1rrxZ
	vfH9hBQFZ3Ikpn95JsZm14iPntt/egeH6L6pQ2FiX0jySFRhb+aUjukXVXZfqOhdsI421gbecBK
	ctEK11pOHfbB0iEJlNb9P4YiVSPbmNiYTZODYHZMBMHEhxWZCpViVSy0nB+hS4hF0bmFJavgp7g
	4DMNCSph+zrji9VoJNdhds6NHLJsnsWrChvX0SMSQ7GL24xhfxSm6vcCt4Z0kRFIiD+ZbTtZquJ
	LQklyg2KhI
X-Google-Smtp-Source: AGHT+IEnd90RJHx7ZuzW87zs5Q4EEB4nWgY3Vtjy9fpk248/BemBXzC7fRUumPfx0M4xpvI1GCS0qw==
X-Received: by 2002:a05:6000:2510:b0:429:d0b8:3850 with SMTP id ffacd0b85a97d-429e330b68dmr6675168f8f.48.1762443599342;
        Thu, 06 Nov 2025 07:39:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4772basm6489913f8f.26.2025.11.06.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:39:58 -0800 (PST)
Message-ID: <181cb561-4fdf-49c0-aeb0-85844411a6ad@tuxon.dev>
Date: Thu, 6 Nov 2025 17:39:55 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/26] soc: renesas: rz-sysc: #undef field_get() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Yury Norov <yury.norov@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>,
 Alex Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1762435376.git.geert+renesas@glider.be>
 <7feec8e9cf823dd365d6e0f21004f943964e52a0.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7feec8e9cf823dd365d6e0f21004f943964e52a0.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:33, Geert Uytterhoeven wrote:
> Prepare for the advent of a globally available common field_get() macro
> by undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>


