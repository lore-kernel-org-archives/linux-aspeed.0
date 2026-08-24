Return-Path: <linux-aspeed+bounces-4840-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4AC5DF81
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:43:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSCW4vp1z2y2Q;
	Tue, 25 Aug 2026 09:43:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787604230;
	cv=none; b=nbuQhY08MEH9uBzJ4jOv5zF7yNNgwsiqNr/43OhUNW1pO3OIfNUbJaCv8BBmZLgGDZHWbyQPG4L/ilyoyXDpb9ciMvDPEuePPC+W0vbIQ66RMRKQsd7eR6l9h/nWXuBe1HXyM5UXSfe0QDiHAbiBLPKiZHJduUZsX/QGP6Z77gPDbyO2UBS16yYv7+RZjhpXOLtSJxjHdjkYJ74RWfs0loxZybuEfXro6ufo2ryUPH32PxfRDujx977l5sTLlRQzihHS98pcfb6ze81STnRo9259AU8Kg7MmePDvpj2ljXYQyjL2Q//t7rczkchBVRKHH1g11jXg+idkbcWlKN3Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787604230; c=relaxed/relaxed;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBLSiMIFxlxhL1Fym5ACK2vzU6q3ObjKc8iBssgSONQr1szjt/EJqLm5/L+kJqSPzuBrv6qI7MCui+zEmWXD3erEuTS39c25bP4RqMua3haVyKsQZBBT3VaTHdY0ZcrSEzCC1vy27ywhOLTr0lHN38UATyIDS/RRC9AhsUyr5Dg0jytcUCAnggf4ESsbDrAbeCe6/YFoY9P0CgzCOtowKQeT2qPaR8dZgJiultw0NcPEM/YbgL+HaSiUccu9Lajg3IjxQMCTRUdka3prNd2XWSJd4E3wO+2kVhtEv0sSDIDNEWQ4iizkePAJl/ENe7bP0++ISSXZEHEbdOs2p49VVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMOOR726; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMOOR726;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTNDP4xhfz2xr2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 06:43:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B42E544E6B
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D51F01561
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787604226;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nMOOR726iilXzB8QwTQCM71Ch8G02Vaajd2yCMS4m+O5Esok3z5r0gV3VttHfuCHb
	 4g2AVRstZRMVo0Y6IUYR3j6owkp/ou4a00Y2jiJj33Ircz9/0ZpfuUV/cRNDW+23QA
	 1GluzBOVjcse336a1OdBAHZT0wEvicCM/X7+pFIs19JxWLEeAHFX5XHwBkJOCMnYSD
	 7EecCoxv1MdHvEeVrFiBCP2J2hmtiUbnaXyV6jAhIcHSP+Hj2REll4VSXfnTULnFm4
	 epNc025JmInkZuyFP/+OYoPczOeQmlLrLlbyatcAst3s47t2gWtNNzp5Yr+0MydxwS
	 v3L7qXsOPK1hg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-45ed55cbbaaso2087632fac.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 13:43:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqXqKX+4fZJV/s92aKE9lPmz9u9NP1HooSWmdXMmt563ufEvKJSyxtYYvY9fWEY2/zrBnqEe/xCrs0gzMI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kbrm1KE1gVXUk1HVHcV/22eD1ZRafHsXT9xcWCJT1/DzZeX8Nl
	7au6QYjI5RFk/Rp1hlq6Nl5O91wOfCDAvir8HfKZSY96iHHwfoJhESe1H56fOSwIF2qr1baIxRr
	HrZHCcvlZrg3gm5gmc1hyLiimO1A6Cd0=
X-Received: by 2002:a05:6820:200b:b0:6b0:4fbc:aecf with SMTP id
 006d021491bc7-6b190476525mr1271968eaf.24.1787604225387; Mon, 24 Aug 2026
 13:43:45 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <7c480e73222bb51982fb82dc0cc6cd503f2e8b92.1787239813.git.geert+renesas@glider.be>
In-Reply-To: <7c480e73222bb51982fb82dc0cc6cd503f2e8b92.1787239813.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:43:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLkBhKLYHeK8-oHfUO1tEyz4TjwxHJgGYANRgtFunc=AYA@mail.gmail.com>
X-Gm-Features: AcwNN1XWcFJ59Pf1hWO2vZEK8dV4kl2H2cgk-aSr89WZDKQWMFn5rql_SFN6T_E
Message-ID: <CAD++jLkBhKLYHeK8-oHfUO1tEyz4TjwxHJgGYANRgtFunc=AYA@mail.gmail.com>
Subject: Re: [PATCH 40/45] clk: versatile: Make sure clk_init_data is fully initialized
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

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

