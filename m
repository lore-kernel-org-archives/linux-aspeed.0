Return-Path: <linux-aspeed+bounces-2540-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDBCCD1A2
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 22:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cr9dY5SJvz303B;
	Tue, 21 Oct 2025 09:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760972198;
	cv=none; b=j9WlDZEEKVrrVdL77ib7DC23k06DiRh8rfPSvq8SACd4qhLLhdBkV+jLSiOLW53IU37oBYsZfaDIMzRWlrCrLAwWogrhQnhPDBwJZjqRby8sEr8UqnbKmKBHOE6RUzfDoasjHJN+n3B7AS5vIi3eKS4iy5j2gKxNQOqDt7lSPKw4VVHSSpdMxCQKL7bPqy4zTMMa9d7MTHyDRt4cjvw4lZAoMqfyN2IKyznsZtIGCp4jX82Q24EUe+O1QVQZZywDeL3zQTv7bBBwoX//IafumI2g6MPdQ0n6NfOgA0MAAHOSdQVOPHfY+l2S2sI25p6Mf8g1k7rnhbgsqWaRVsLLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760972198; c=relaxed/relaxed;
	bh=DErh0jkxEaTV4PU1gk6ECpXb4KgwIGFW/OBZ7JW1qeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMfMyUcnQexKbwV9B5em6v//2rl53f9ITrlazYz9zfi6Jq7HKb7TmRLQUdB1XAy0RO3nFcs4vZN+Kp2IL9DFaakKwoBhltASPJVProDlqfN7x7mWkL327Cic0vTR9QDEStZOUPU2Bhu9zkQnu5u2gyJjUW/6Suzf5TsGXc5hvVZ5Wo/DwOqg9oejoY+T+2grrOQ1louQqhgs9xnfmPEbQ6N1vzrESJXxr3N8hGUN0CqQpIfND/PYPdO22iYzXEPcGFcFASztTZ1lsQfVh6FJU3gxTLsHIQI8j4uKnAI9l4zoQMr9n280xF2vXZ0fEI4WJCD8fo1hw5VYWW1zfKEYDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iHyzWS9r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iHyzWS9r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=yury.norov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqz5w6sXTz2yrm
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Oct 2025 01:56:35 +1100 (AEDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-781014f4e12so55443897b3.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760972193; x=1761576993; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DErh0jkxEaTV4PU1gk6ECpXb4KgwIGFW/OBZ7JW1qeg=;
        b=iHyzWS9rI7nmciGbKsQJRpx0dI6zD7o+IGasKUBkF20HwWWfv9kNETHwmyvBGd+j3D
         fSjO4tx7NM9HLRmQqV5cZYhWo3ZFFt5M+FOkc1ws7RPBoNkf2le11eWGmBKsb349KA25
         4WmvV2FaYOKBiM9PyubDhF06aSwsm4+9xApOmwbsYLGu+UwV/HcbkapTvpyViLQuMCPF
         HoFtEvsd6LM8fRGheSnuOShjJlMuuSLiCQIC543Tx1aX7oGcXdoZH8V59CelH9HQ4H2f
         Z1hw08wlE77+nywqdRRQLDoDN+9/qm9SU1+gVQV6rqz09nmb3V+HlX3zAmAL2wRRl1dX
         k2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972193; x=1761576993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DErh0jkxEaTV4PU1gk6ECpXb4KgwIGFW/OBZ7JW1qeg=;
        b=WOdujMI0KKwQQQBtdvwDYWUREIS6mTDtpwjFEznGDRA4dsK0tKwsfnyhqdzT8N/p+M
         VsVtg6A4GD18nC8KRI7RTH4hqy6cr2p+w5pfMqSLuWH1GbvxgJVg0vgi+UiQWAyFyRdW
         IfQ8FRwZs+jp4PTpWmdyMYnlfnHpyC7XoJ4L2hqydscS6XvDE+iAMBQM/ikVSuJuyCMo
         HslYuITwoWW6kgusWVz3RQGX8G4DDT9taj6E5qjenldHtdGTq4lz4otnN81uqvtlxbOa
         HY+SaA7lc4cF2aF4+HitxbqkL0RMrZ3Depxiuq5+O0R1ke1rES9opKrpdMNkNj9BrzyS
         DxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRJexwZjUqnYdXl5ib+hk2bepKucqKNRsNS9b5hBWwyfoDxTsv2z+/MSAtokCOMH66tkJ30iC5i1O3KT4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvYbcaXjT+wsDMaXu2BVg9CMV/ycFwLVDIQ++tZr7gFJlXeLV3
	W3zMjDwheGcoo+jsw/d/cE5aVY3ExJpPqE5sBw9bxiNxQV+mK1e0hEIL
X-Gm-Gg: ASbGnctiU1S7oTKGY913E2y7FSn9TlhpNGYJDmbzzm5mg2PR2BgCKiKMXmA0Z/g5+Rd
	yfoanrVT4spI2hGutvaPaYZV181GTqHs23JRyjm8QB+VxP5x0I7psfzcSH1qNZZVB0/4PsRu4uL
	KcO7xXX8v1jcqJ69IV2n+qPt0f5JO1ofLOr1DtqKWfr5V4A+qiyVFYLb+FfTGoIUS8hNjl009tn
	1gOoz4msGx4t6meOx5sPaFfhY1MMKxU7wz+7D6FOgoQBigFzzwnKOla/ZLM1ISpDnBfv/93OKvE
	U4325B2lmLznL4lGRXfpfJfDmJ3YShN5vGEXNNyKAAVlTS+xMR5GU6Y3NnFGip45O6fHvCbbeIA
	GtGMdeGTvOuTc2rIzV0Y2pJFLUAF99qLpzkYFDsiqjwTRRa7LoL7YI+HuTfs8YHFfI2/rD8rsaS
	D+5/9GxpcRVzH88HeZ1zFcvAIN2ilWZzaH
X-Google-Smtp-Source: AGHT+IE81F/jaXbyHR42ph2vrE4i4G97ZO8UgGatFFTjrjbQ0UYwj8u7zrZ9iwbiKwTlSepO74M7sA==
X-Received: by 2002:a05:690c:951c:b0:781:1280:db43 with SMTP id 00721157ae682-7836d3bdceemr92264887b3.68.1760972192509;
        Mon, 20 Oct 2025 07:56:32 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784674d66fesm21762357b3.41.2025.10.20.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:56:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:56:30 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
Message-ID: <aPZNnmot-Z5a2yIc@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
 <aPJwtZSMgZLDzxH8@yury>
 <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
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
In-Reply-To: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>

> > I agree that underscored parameters are excessive. But fixing them has
> > a side effect of wiping the history, which is a bad thing.
> >
> > I would prefer to save a history over following a rule that seemingly
> > is not written down. Let's keep this untouched for now, and if there
> > will be a need to move the code, we can drop underscores as well.
> 
> Fair enough.
> So I assume you are fine with not having underscored parameters in
> new code, like in [PATCH v4 2/4]?

Yes, sure.

