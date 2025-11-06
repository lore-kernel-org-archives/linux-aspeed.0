Return-Path: <linux-aspeed+bounces-2806-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0023DCCFA1C
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cql3mwTz3bfX;
	Fri,  7 Nov 2025 09:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762443410;
	cv=none; b=OsO4DIRkrKYFB4Sotz28goxcwyezlkiqYAXrDNSpc2uJxNog2UA/qEVSrL7oj6EcHS0A2agpNY2n/MG0Vf3q0LZn4p1jdiiJX8paPmsoc3YzDi4p3mBq3/y3Xu2ZpZhugqSTmci2y8KlnZwAaZGH0k2+/zLphJN1D4XYI9v4F23vZQiVziLB3CaJMcn85tj7YU3dW+Y61Cns9R/U5DTpj0jBFN2UukksjUvwQgz6Yma6VOEFZQJ9LHsoutMw80TKeZjEYVPoyyADU70yFwZMokaW5AYYHCEkVFTF7T4CN+uGB5qBx5QxXn2RI53APniSePcm8xmzpmMrMqDy8U83iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762443410; c=relaxed/relaxed;
	bh=NoiFfWZaW31Ma9mD3WuZZQSDOEMD5VY8nTTYH6Ca1fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJk3ttillx1RVpJk04pND9FfZj56pxnOsYUgoPTxSi6u+xmLjen85WduiijmUVLMLIJgZAq2D5vZs3pyrMLYZC/TrZ23hPhXqTvnt4QqhfldZ0BfeT4KgOevKbnttS4GONQ0XN5BqyG5QqR+/8sU0tfsJkcUDH6hSk0IAons33AkI3jhRhCQ5urd4zEyE/e27hTWT14VszBUIkgG17jUfcGciL6JaK1V1huGGFQsiRlnrf+wYlRvOmchpq92wEzp7ZaOuaNREGFX6Pd8X+sCylee42PZWFCqbqFNBDbNMEnrixqyLj0G3vcpmupe7Wk+kB2e4mHnlV0QKmIuR7Yvaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=DyEdofDF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=DyEdofDF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RBT1G4Dz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 02:36:48 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4775ae77516so13202555e9.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443404; x=1763048204; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoiFfWZaW31Ma9mD3WuZZQSDOEMD5VY8nTTYH6Ca1fs=;
        b=DyEdofDFPGsvKGIE5xfDhZxAz5pOJxj/4vafX2QH1Noig6B/vINgMksvUGxgNCyu9V
         8RjSn6ONKbH4qWlMbO8XWk04fn0W726h4mRvJRzRWoxqbdkzIVDh2d8NM5G6HMYKWsu8
         jHJLLj1DqUlpClLkHgo5ZzUot2gLJdSRpZxWsehtbbzVTVqL8fTLOJ774XMD6GTnlx+o
         YebMcpJW+ude2CRJ6cJwp52Mpnz8PiGjBLN8Nr/m4u+siPgpwT0fHjnWiISzlWfhDLZr
         Ees1XN9bzy+vRbZ2p9rgNf8L3wUA0h5LYpLlYnYWFnPch1elOm2Pb82AeTHffdSdQuaL
         70IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443404; x=1763048204;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoiFfWZaW31Ma9mD3WuZZQSDOEMD5VY8nTTYH6Ca1fs=;
        b=Ng+6To7jJlrajPHTaAp+JBmD2OIaGNva6/fT2FRnOV8zxAqj1yd4r27//eaGbHgvhL
         Zm5NGcEogjmxBxJTS0gGd6BFGeEsxHq70AerN/gXgEiGTzoI3BW4xNaeQn8J7lng/IO/
         2902A3MjUBhfAUBZ2oCufGLXRUp4QXyLDDBZxotS/NvkS/NwLNWzUrke1QTI/WM/vVZ8
         wFDXUP12sZ1gQYG0Z/BjVTYio80hH9HCJSyN73/Bz1/14RV1oD55yQpmf5+vn4e+g8mx
         tuASOiBWK9EM088H7x3seFiPq9YBdJqhpMGwIiRrMVL7KSyr+FghB5st9iuQV5fkge5F
         TPXw==
X-Forwarded-Encrypted: i=1; AJvYcCU2QMrDTCOpAx8u0ogLTjWF7YInhMvgrspx8B+U2QO9uKEdS2yZZ1oTgYmvy0vzMuFRGLUSMpOJ5YkT3ZA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKIFhY4t4LK92Q6769lbs1g5Jh8UAcBKb80Xhn4eqvKqDWQeon
	QrNIq0VQHxzaqjEZ5G2WTxKetM1H/CFJ2vM+PNHtI86Yk1215M9+lC9bfeRjP7wlxVU=
X-Gm-Gg: ASbGncst59AV+txTwKjwH335/LmVDGM8JgOhd5FxxmTHw/T0GBNtUayIS7vw3rQJyDb
	lYEpjdf7xjYD/wkvElFc9h8ShDLsJ7aBZX20aXEDp3ls521F6UENEwlYphYOuCzMWZBHiUpFzOM
	lOw1CyUApUwAdPjUroE15+h9xdiOyTSf7qOfPVh26XlUPac1oef3zsyksjfo1umxXlI27RNBfd/
	36lQnRhp43Kl1dF+9cjhiTxRw048x0WzgahStiIlZjq2tJtBvRUe8JyUzktG4anH8M0G1kDu5aK
	Qe2YMRYLgalamebYu7REYfNLK4+ina4a7Qbfyfz4IZDv/2gWOKLVsD1J9Pqzb2cNwl43HDWgu8O
	VBXMvADDv6LyXXIK7+fQi16x4s1wOQEDhaeckVetg9PUX/V38NPZ0xg9VVoGVV9eS+s6EoIifDQ
	Wt6HZWqS9/9TdXA05eULI=
X-Google-Smtp-Source: AGHT+IHm/6/RnHvUQpqjyEKIYZGBSjHuPRp5b3DBLGbL1GoDEzCDZheRRGUhzX2BHAHpgilQLx/Q7g==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr59734595e9.33.1762443404278;
        Thu, 06 Nov 2025 07:36:44 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477622f42a5sm98437525e9.1.2025.11.06.07.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:36:43 -0800 (PST)
Message-ID: <d1b02488-7722-4b39-bb8e-f7e5c8e11b1e@tuxon.dev>
Date: Thu, 6 Nov 2025 17:36:40 +0200
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
Subject: Re: [PATCH v6 01/26] clk: at91: pmc: #undef field_{get,prep}() before
 definition
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
 <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:33, Geert Uytterhoeven wrote:
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

