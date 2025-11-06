Return-Path: <linux-aspeed+bounces-2807-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B25CCFA13
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cql4MRlz30T8;
	Fri,  7 Nov 2025 09:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762443902;
	cv=none; b=IFoAhN52NT6AjOthKSotr+ksY4XdC1KPL2bZFNzLsXeHetP4pTKcvnziC1pzjTVm6TyWmzGU2cHtAoxbEzF2CGIR2BxqUBtkYJ+8Hgv02RmyfBCXV8qPD6H7T1zllpuJHodOegLC9XMjBMm+BvSV25rEw1cBYm9cAnboz/JYnc+JNLdUPrxySNVmmiziDr4R4oeCI3DNmjksC++fzgeM99zhHMKJ+WucmIdsy6D24sojDfRi2qrPHxg6UEVM6M4BbMnbFQFllC5vo2rdIVYCCrCyEjO7SuU1x3YnkMW60l6maN3WHIxPWQ6PUydZ8Thd7ql0sI4c88eZgdhVKMEi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762443902; c=relaxed/relaxed;
	bh=FDBfIt+d555CHw458VAbNG3bfHQEwmpPFewi9LatYFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFyUlQt0S7qYKtc8qrj3dcpw3h7t4LSZaBh0snxPImckAFi2meLhkCoATETxuHJ66s2Tx+8PukSEyIj7/rusuTH4V4HwA1EcpvBSogSaqD3b04noBVhBgVR/sd+lVm+v0QFNUcexd5N8jGAXcXClOfYlV3BOABAmL5R3CDkVXf/5H2siDc9oumqi/XaVKnKbmf7zPTgGa1xUOiO2cyOkdsw5VLbuW+t5hZ4+TQUrD/Ox6JmoD7FUYBTuRg46DR/8BIAxNKt5JPbIASv7T/xwMj24Gj9ZQiSKFLNVtO8KPJFDj5o97XAhbKq3xsb53bM4wLzT/0D6CjWo4HB2VEtl2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=WxyUcVyZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=WxyUcVyZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RMx1dVBz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 02:45:00 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-477549b3082so10558395e9.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443897; x=1763048697; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDBfIt+d555CHw458VAbNG3bfHQEwmpPFewi9LatYFE=;
        b=WxyUcVyZnOIH9iuTCnnBkJzVRyVpeHg6dERvovukE7k1hpA0btSiVzQoXaVq09zwZk
         UpN4ACJQs5haxnBp5CZigXMcdUKhXQPMLFH3XdjI3gaU96A0QSrQdjSsS6fByUTKOWJ8
         E8o/0yQQEp8qNvu2OYi+5JzpsmfNMYruthAk2eHDqCUZWs2zhPcFs4uNwvRBwTKBFP+r
         T/r/y8N/7+KwOulz7QUOVl0nCNxSsQMhhYRRo+jU+XUFj/1rBzX7m3ByEKHK7auACDAf
         S0acFmqhCS5aJGcsFKCZeWuepBA8pjpgAzM79KBdy6zoShC+9ok8pi7ABERkvo6MwxWb
         tO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443897; x=1763048697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDBfIt+d555CHw458VAbNG3bfHQEwmpPFewi9LatYFE=;
        b=lgoYq2QmF+EuYrsCsRj7ptFc5R5PlyjzO55dU1wFkTV7q1fno5uf3o+gR80zfWjFOy
         UaRy4FAcr6k6Lmzvej9WcQFKXjt1rRIM1iDhU4ms2cdg46KHFc7UB6F8odiTbcdxijmg
         +/x2UvaugV74v6+21XpMVsxh9jYJ+qp9q04QixGO1d8H7R5YU6R4NoORfL70hBpLKeoz
         z+WEascIThNGQfsadASSktJ1VvG3ZK5T3BZpx7YEJziJzN0OCycdfhRpVZAUoy9JyBb1
         18j1AI96caLEBkttGYdCqcJDRYbJR4ZY+JT/IzpKpiWyBlMTXagf4y8nbZgOroaKoeQ+
         4WQg==
X-Forwarded-Encrypted: i=1; AJvYcCXem3h5An0joIwdnfiHnBRmdbieQauogzJIu3zFYPH3ZtImygvr0cniS5IkTI3PC5egCRoCglUpALQ0bu4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywge4gmsvoWJY5USgMb0aU4cxUrfX3lHUMGLGz1vOBtj999IyJC
	Y2svtdqWDwuy+IzyxOdK8fP4zmelep3KuCJ8S8gxsvxgrClW3YeSblPOq7YKIYMZXbU=
X-Gm-Gg: ASbGncs9Gr1rBroPP2FQj9eOIU1R/mrz5MdKP0z+2pbkfwM6moKRc5cU1kJepvjG9Az
	vS4HFR0CNHmf2taxIH2VDoyk5GsYvKy6OIVIJ1VbdT8CaDu3IlTh/aQvmVMU3HnFbruD/7F8g1u
	9jN4/BWoEUQpWFWbfmL9/wVwt6zAJCVGOu3eE6mpTw3/TT7hcBxrNePQgPmipLvXenTmD2Dwvzo
	b0awqp5vb7vOgJOD67iZKhatM55zfeKu2TmO/nloK4EnWi7dKaIyAgcyPtDORQPTofuxxXDCYed
	zhW/G7CiTAIa2CMyuTMLHnAD/Y/g5+p98fD5hyElo92BBHOmGijAFdmJv0s0EAVjcuoaYCQUkzA
	Q2wayobBinr5qUIMx4rXeJ7V2foAuwvvDXPTqLmt7dXJZTc2mA/jzZtjmJbdA7yjBQCYe9Xj4ni
	wDRlI7D6+X
X-Google-Smtp-Source: AGHT+IEAc10N1RtkN4NVSk1Zu24SSpZFPG8gHp4xc27V6x28O5IWRTQBVQkr2p/iYh6QAS/I0T8A6w==
X-Received: by 2002:a05:6000:310a:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-429e32edf7bmr7715744f8f.22.1762443896966;
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40375bsm5553906f8f.8.2025.11.06.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:44:56 -0800 (PST)
Message-ID: <509b427c-5586-4c92-88ad-16bbde7c3f92@tuxon.dev>
Date: Thu, 6 Nov 2025 17:44:53 +0200
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
Subject: Re: [PATCH v6 14/26] clk: at91: Convert to common field_{get,prep}()
 helpers
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
 <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:34, Geert Uytterhoeven wrote:
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

