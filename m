Return-Path: <linux-aspeed+bounces-4824-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC5C5DF97
	for <linux-aspeed@archiver.kernel.org>; Sun, 23 Aug 2026 23:56:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSrYF71zwz2xnp;
	Mon, 24 Aug 2026 09:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787517074;
	cv=none; b=n7ITeAjdgxVs600RKbiePCDRsoAXsWOXtVOUJdYxDmvL3cwS1dNfjlYXhkoLjr4sZZXQpi909SIP5DUqpViLn7sF2dwNj+9izR/TqOu1QPeqRVrXJN+ugLGAY0oisQv6R8lNvlpS10ppVkKtoCZOv7l2iZetRhZZ6tjHZ/oTuCOylZyKSTVZByN/p4Z6ZJk1ot2acUQe888HD+Of19fkpIOxMPQcYhNjkOgURdk+sDPpvlU7Yd/q4X4sHOnjE7Uq0hhcleXVJCSttZebEmVxXFZ+7K/0HZJeLAtjtyv9Fuua8T0U4OLMl1OvElS0kdvSNsxiYhElke78Iw3vQkdy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787517074; c=relaxed/relaxed;
	bh=Hz9a2/4b0H2hGIuQcX4i4J6vhXjz7a1tVe8/vJ1mK5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqpJlKyso91aIewvsThFBbMcgICCBJRrUZiSTKdjYlNcgo5I61C/cL2XCVhBPwae7LmQuFNOkgjRI/ulqw4c5apm9jjpGkuLMtJzjR6Vv5F3OfJaAeOROkIsj7nWJ3qCHfN3ZwIkfm8OJBtmdBrGWp5DQbOt5+ru+A7Cfx4qCg5FF0ABrQ/0iW2K3Rw8kz2oavh6oqwYYLawKGids5MdwaBuU0Xpyot8Y0tAiDTYxW7lTneyKZUn+tYTpPOrim+eRX/ifvcxthnLX0XNSNBz4MAWtxKKkF/zQ24r4ttGJSgvRQl3dQA+2tu6EMGnv9McmmQQGSVetX1RHoMbN1A4wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9SR/CDW; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9SR/CDW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSm0K2jB6z2xnv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 06:31:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CEAB44E52
	for <linux-aspeed@lists.ozlabs.org>; Sun, 23 Aug 2026 20:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542911F00A3F
	for <linux-aspeed@lists.ozlabs.org>; Sun, 23 Aug 2026 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787517070;
	bh=Hz9a2/4b0H2hGIuQcX4i4J6vhXjz7a1tVe8/vJ1mK5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z9SR/CDW2+RChZ3knjritt88WVf6xuW1xAcW5680A4MsxFF1qx3Cyc2rapAylHwmY
	 i01kHvJ/Qt8Az6ftSP9Wlfop6xlECrhrEo73TxjT0/f/TMQve4hcix+HMncPTM1HJF
	 PaB7k9Vh9OJ+gqrSWVZQTIzVw2l2P5vSW5Kxn344fH7uIP+cOEvTizQYaQ/F5cUzA7
	 p+sPgYQkVyJ1IO3DrZBKDbMjn5pO1E6mwMBR6s32rJgu0EpbBk5Sz2CzP916HdHBSq
	 EsQUo4o2t5BYNwQt0xwWwIZl0XHOiTkx56XOJJ9rE7ywoOqP3O2l4SCAosPzB/PYLc
	 Yuaa9lHQxDn9A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so4799005e87.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 23 Aug 2026 13:31:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrQN0G4LUYEDVc5BD9GwTaCBzB6HyJsYFULEgTCHS8jzDBpD3H1JUy+gPqPEg9idfzH/rb0o8QiYRdvra0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kSbE94avMpPBeOm5z7qaOcgKbazoEepAOmoQ4vLL7rnoYrClZd
	Z+yrNyr9g3R0CG0TZTKJE4Dd4luA6ayQESTN0W1mHM97sieGM3/p3RMAMXsNoMoyrmYLlosrJA/
	oputb2Yq8G5SwGijxx8ZvrNYuSgfigOw=
X-Received: by 2002:ac2:51c5:0:b0:5b3:12b1:be93 with SMTP id
 2adb3069b0e04-5b484736c8amr4269481e87.0.1787517068028; Sun, 23 Aug 2026
 13:31:08 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <bd84df92640a05a1a73a8bc775b2d50568a9d0ec.1787239813.git.geert+renesas@glider.be>
In-Reply-To: <bd84df92640a05a1a73a8bc775b2d50568a9d0ec.1787239813.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:30:56 +0200
X-Gmail-Original-Message-ID: <CAD++jLkYE8Fh_HpKPYjL0-ksVQA8f_iLRFNkPU5Jvq+ihay5ww@mail.gmail.com>
X-Gm-Features: AcwNN1U1aXPtuwFV8knvjn18BtYzZuPH0iZTVosQkZ_l23SVekgfIt7U_k24f4g
Message-ID: <CAD++jLkYE8Fh_HpKPYjL0-ksVQA8f_iLRFNkPU5Jvq+ihay5ww@mail.gmail.com>
Subject: Re: [PATCH 39/45] clk: ux500: Make sure clk_init_data is fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	=?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-clk@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	arm-scmi@vger.kernel.org, imx@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 10:53=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
>
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

OK I trust you on this one:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

