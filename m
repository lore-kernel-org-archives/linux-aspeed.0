Return-Path: <linux-aspeed+bounces-2805-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B8CCFA19
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 22:51:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2cql2c2Bz2xnh;
	Fri,  7 Nov 2025 09:51:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762443633;
	cv=none; b=X3CcXl00NDc/whzzixIoFISxxMN2uEHQnO5b6gDmPlefeF9eBpX6FlZRTZr+G/JZZCiL+nGYc9PHNOTwCPQHxRypil4umE4HDB7AkX1J6nlQ0dHqRIxBtzvftfpPHpf5yydgwGvAy7oWR6/UGivlWJ70JDnvZ2Xkz9pqLc/D62rin579lp4enSa6/k4lCAtlMcYNPTb2Iid4Dq6LrLtL9nB+VOr2E19bMVhL427j421rZLCpyxCboEc0AtRolCqCmqzqX/hh35rb8jCHQIRgv7Z8nlyMParq0CDBFC1a3h0wLVlV2QTADSwtftsEiGnA7zYd6vM09v1b86oZVePcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762443633; c=relaxed/relaxed;
	bh=Q1Wk3Zb6iHABuxMtqYWJQhotr9eHGE3DttWEmz8jd9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEqywargmIHz24o1d1qexRSf3ZgCcZCcgRGmxRnXBhSynwjZ1qQI1UnHoC68mNeVL3Z2DUSY9K8qEQpb3WR0cZJJyhiFon6sDwDX+CdFWz7vOagpGyeCWKhs2GVKLOtrVpIR2EQGVo6289xigMTcDRiWE8g4S5JCo1GcJPUUKNDWQL1xH6ft3H8Iu3CXOhnTji3wHl5MSFGLNlpbuMON7y1oSHvG20O158GCDuefRYxavYKk/grg83r8lj1d5PvSVw+QKMOJzvxCh6BwCcN+bkq5c0uqNQcSH5v7+wLF1HywMIrOOlx04UDvGzHY2AsJJALe8zBx1VWvq8tRthFO1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=R207YuPD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org) smtp.mailfrom=tuxon.dev
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=R207YuPD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tuxon.dev (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=claudiu.beznea@tuxon.dev; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2RGm4nq5z2xdg
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 02:40:32 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-429c7869704so985594f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Nov 2025 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762443629; x=1763048429; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1Wk3Zb6iHABuxMtqYWJQhotr9eHGE3DttWEmz8jd9g=;
        b=R207YuPD+H4dRlXqbb0ZEyok8qlth2kog/IaJzJ2caSEKPBIgKNR33MakOtCctup9t
         /ILAhtV9YQWXj/onynokbKeuzKuunL+WMu4BNWFZiZEyKFtEt03KRe0P6fgCwgeq9mcr
         Y9vw34Pb/ZN8O9qvNmp+09EqpmSXzEoSX1BRcDsfwaiwPTeXoGr8LQz2Jd+q2Pk6ghGJ
         4T18F3npLwoJI6dqg9GhUUOS40qDdmy9SHuKMAVb3GfPmR2INaSKzwYSJj49dLt2Cf3u
         F06YoDA/jN/NxLjybknpW+41MYYiOyq3HgIjpNMNWCFZem19pOYI0hkIP7pPOPk8yf/+
         CUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443629; x=1763048429;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1Wk3Zb6iHABuxMtqYWJQhotr9eHGE3DttWEmz8jd9g=;
        b=OCr+atWRjzCZPhLdnyUdmEMJZWxXyQY/5X7lNCtnBYb2iB47r3NIpM7lKbYiHwr+R5
         Id2UxgXI+ZOJOmTm9vAHYnGkjoS5qbpmzRqkH+34weNx1szxE7uyHV+jajCO+FNpz7TM
         EVAj+Sqdic7db5jV8rFefzkqCf1Tqqq0CAKugX4oXWIFdt7btcD8oa67O4BFqDgWLny3
         XIgjuNvudGGhb2I9GWRxT3tIkmH0E5OPU2LDGJGgRKPAu/fBUJRur4haxZQqjj4I/pXT
         XESsjcDbBrSaKYjMLCmQMlMfyf0nv883yoDba8GGbcah65v7YIN45pAVZTcbPHtqBHye
         hKaA==
X-Forwarded-Encrypted: i=1; AJvYcCXRdPpuNRLduAN4yZtunu7HYM5/lT5BlrEp1A868RaJmlB4fvIZbTWI0tnHdOEpPC+G8YLA32XcwBgBDCs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0e+luy4VaZpGYvkLPWyTGMWwwVdiSikqCP02bJJym8kaQ0vNi
	prYGJ309irSjubM/MuBZgqi1KumrPJUNOBRmn3LwP+Z/16A8fm+9Xms+LfVJubV/8C8=
X-Gm-Gg: ASbGnctiu1+5zpuPnOEwlZlYOMWLXeqtUy7TnDvCf2g//iVkdc5vJzsDDymMk7juXzL
	z+w45UJYAuDvXF+SHK/cfxSDNAyTSkAXK+Xn6wJ3QMbRo9WuDAqPv+nfgasrIobwXuHG8efLpwW
	iUV0UNugPRQpysb0vQ6hC6m5A2g1QnQ3QY0bPG6PWI7XpeDuGKP/3nGd/vqHSZByRmgupCO3kG5
	ZEn7RjLtNYigFp1n77fQ91dzhKG6wQLm9tGxCctu/i/02iA8GbTu0T6aeArBH4bb8Hpm1ZPyVlQ
	wx4OMdCD19HQMfUjG7cXHoYbhqgNBbWHBvkg96JGkd8SpkdsqOIzUpFYqibloTu99gDeAWIYy9/
	SzX8aewOTkHkdYZy3QHxU9gWH02OF2loRt6+NVb94HJy2AdJThIXz0ShLqQk8DwsYduAb1+euGb
	y35pBAjxvIeV2QmZXSf8o=
X-Google-Smtp-Source: AGHT+IFjpy8Et4z+rAreshTApQ1UnG8la7y5eDtsFm4fqVoBZudQUf3WRA0jtYYTZf5YlVXK7dWKmw==
X-Received: by 2002:a5d:5d0c:0:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429e3309cc9mr7040773f8f.43.1762443629298;
        Thu, 06 Nov 2025 07:40:29 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ec767edasm5003126f8f.43.2025.11.06.07.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:40:28 -0800 (PST)
Message-ID: <e0c8b161-3e08-48a0-89ef-8e0ea8b76672@tuxon.dev>
Date: Thu, 6 Nov 2025 17:40:24 +0200
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
Subject: Re: [PATCH v6 21/26] soc: renesas: rz-sysc: Convert to common
 field_get() helper
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
 <ed045ec4db284ca8b4ec0c5b6ff334e459d14096.1762435376.git.geert+renesas@glider.be>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <ed045ec4db284ca8b4ec0c5b6ff334e459d14096.1762435376.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 15:34, Geert Uytterhoeven wrote:
> Drop the driver-specific field_get() macro, in favor of the globally
> available variant from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

