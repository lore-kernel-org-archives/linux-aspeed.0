Return-Path: <linux-aspeed+bounces-896-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF4C021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 20:37:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4xhT6zMbz300g;
	Sun,  2 Mar 2025 07:37:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8::223"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740861433;
	cv=none; b=ftZeFyIUN43S2CIescc+0AF7WH/kgdU4MW+aCcqA/MN/gIrPBJm6R/7USO0nF4dK5/w7r/nBoiPRpmsufKzvjKm3dgRAZtGuSY7LFl76We0FHS5+ZfPoeFjqAxHkFgBjyJIWCf2zwcK3oYRc/EXb0lTI2N6yH048ux3qLU+dE+GHifLW11qK7hMVTHQgnUBE8rrrb0LO2bygOwZYeg6yNl0mZtdvNdzAXrAoLnzy4tzAZ6UJ+apQ1uOOc03hlOyESDgUA6P2pNZwu8jFYzhEp5e5A3pD+o30jMPDAljuwlfJYZ5k++ecZFqXB2U4Bu3c/+mdllDQsWDOnzeMqbl1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740861433; c=relaxed/relaxed;
	bh=3Acc0tGYBakmOPZLGuJmU2rnhFl+Tc281npjtzbe/74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFQrQd74O5VAlZCX7FpE8BHP8/Bf6gQgTq3Ug+1VRhjDkJlHTVFTClJ8aoZE0FkG5cmHUKfcRt2S0ZSAT2Z5SNBMm7UC6ondP5omOAiMOX/H6zAOnebSdBJfBqnwaVTfCVYYm8igMPRU9nm49WgWXoNtOXSeqbQN25lMXB3CSbguInW8sPZkgVjHYQJiy9k0uQm8mfx/MfVtERDIliIsBWOMZIfHYl7izqVzs8PscMdsCL7SowAPTdp0PpLLGwsXF4heBMBxQaeUx3WPxqSxj+viyvwQzKrUJmIwUC2BSvE+QPmk1RyG/7SjiaRndywIOloOj3mjNY40CEpIjxDwaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=j0W8ax/u; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8::223; helo=relay3-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=j0W8ax/u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8::223; helo=relay3-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4xhR6Xtrz300V
	for <linux-aspeed@lists.ozlabs.org>; Sun,  2 Mar 2025 07:37:10 +1100 (AEDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9EDE20453;
	Sat,  1 Mar 2025 20:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740861424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Acc0tGYBakmOPZLGuJmU2rnhFl+Tc281npjtzbe/74=;
	b=j0W8ax/uRquO/giWNgJhf4H4p4dxfIxzFW6MO4OZsXaQhJo+e7YlrfmfwuwO8z8CykjSQD
	0U7Afy7/Ba2WJ6ueUqpasO3bhRsmWK8p1CSKWQJLxASlHZTVaGb200Xak05pxb0hXPgbBk
	sT9SJIRG4qLHlanaDO5mFlJjeg4NV4xNVcAt6A5IcLajDdg4v3tw1PgIh8R9k5YlEQBuhG
	dfXSaVruN9RLuzUSlpcs4F7JA1n4iAXoEgtPn0uxly/CwiwCzgGYpZ/+vFDZKpgSjsOMi0
	+ATKulcM1AzPZZmNwSQMXP1nZ5IL536rUVUy1TzC5EytwvQM/AGNSzQr14PTEA==
Date: Sat, 1 Mar 2025 21:36:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?iso-8859-1?Q?T=F3th_J=E1nos?= <gomba007@gmail.com>,
	Dianlong Li <long17.cool@163.com>, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 00/18] a few rtc driver cleanups
Message-ID: <20250301203658839d5482@mail.local>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveduvefhvdehlefgieelfeetudeugfehgfeugfekleejueefueettdffueetiedvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeejjedrudehtddrvdegiedrvdduheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejjedrudehtddrvdegiedrvdduhedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheprghnughrvgdrughrrghsiihikheslhhinhgrrhhordhorhhgpdhrtghpthhtoheptgiftddtrdgthhhoihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtoheprghnu
 ghrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehulhhlihdrkhhrohhllhesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 28/02/2025 14:07:13+0000, André Draszik wrote:
> Hi,
> 
> While looking at RTC, I noticed that various drivers are keeping
> pointers to data that they're not using themselves throughout their
> lifetime.
> 
> So I took the liberty to drop these pointers and this series is the
> result.
> 
> The last two patches also convert two drivers to using dev_err_probe(),
> as I looked slightly closer into those two. They don't exactly fit the
> general subject of removal of unneeded pointers, but I wanted to share
> them anyway, since they're ready.
> 
> All of this was compile-tested only.
> 
> Cheers,
> Andre'
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> André Draszik (18):
>       rtc: max77686: drop needless struct max77686_rtc_info::rtc member
>       rtc: s5m: drop needless struct s5m_rtc_info::i2c member
>       rtc: aspeed: drop needless struct aspeed_rtc::rtc_dev member
>       rtc: ds2404: drop needless struct ds2404::rtc member
>       rtc: ep93xx: drop needless struct ep93xx_rtc::rtc member
>       rtc: ftrtc010: drop needless struct ftrtc010_rtc::rtc_dev member
>       rtc: m48t86: drop needless struct m48t86_rtc_info::rtc member
>       rtc: meson: drop needless struct meson_rtc::rtc member
>       rtc: meson-vrtc: drop needless struct meson_vrtc_data::rtc member
>       rtc: pl030: drop needless struct pl030_rtc::rtc member
>       rtc: rx8581: drop needless struct rx8581::rtc member
>       rtc: s35390a: drop needless struct s35390a::rtc member
>       rtc: sd2405al: drop needless struct sd2405al::rtc member
>       rtc: sd3078: drop needless struct sd3078::rtc member

My main concern with this is that as soon as we introduce irq support,
we are going to need the rtc pointer back in the struct. But I guess
that most of them are old enough to say that nobody is interested in irq
support.

>       rtc: rx8581: drop needless struct rx8581
>       rtc: sd3078: drop needless struct sd3078

I guess you could squash those two with the previous ones touching the
respective drivers because you are the one removing the last remaining
struct member.

>       rtc: max77686: use dev_err_probe() where appropriate
>       rtc: s5m: convert to dev_err_probe() where appropriate
> 
>  drivers/rtc/rtc-aspeed.c     | 16 ++++-----
>  drivers/rtc/rtc-ds2404.c     | 14 ++++----
>  drivers/rtc/rtc-ep93xx.c     | 16 ++++-----
>  drivers/rtc/rtc-ftrtc010.c   | 17 +++++----
>  drivers/rtc/rtc-m48t86.c     | 14 ++++----
>  drivers/rtc/rtc-max77686.c   | 37 +++++++++----------
>  drivers/rtc/rtc-meson-vrtc.c | 12 +++----
>  drivers/rtc/rtc-meson.c      | 16 ++++-----
>  drivers/rtc/rtc-pl030.c      | 14 ++++----
>  drivers/rtc/rtc-rx8581.c     | 85 +++++++++++++++++++-------------------------
>  drivers/rtc/rtc-s35390a.c    | 22 ++++++------
>  drivers/rtc/rtc-s5m.c        | 58 +++++++++++++-----------------
>  drivers/rtc/rtc-sd2405al.c   | 16 ++++-----
>  drivers/rtc/rtc-sd3078.c     | 71 +++++++++++++++---------------------
>  14 files changed, 183 insertions(+), 225 deletions(-)
> ---
> base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
> change-id: 20250228-rtc-cleanups-12c0b5123ea4
> 
> Best regards,
> -- 
> André Draszik <andre.draszik@linaro.org>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

