Return-Path: <linux-aspeed+bounces-4841-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24684C5DF81
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 23:43:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTSCb3txBz2yCv;
	Tue, 25 Aug 2026 09:43:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787604004;
	cv=none; b=PjWc+ewHA+JmQBXn+DQ4hlAqcVUwQ8RtHK0uBmBwSofGR7r9NiSTUX3KaGvIjbnPUcmfs9Y3zLkzrvdVkspE/k64thSBqLYlYJxafFbn8iTU5znmSpUJjUMz1buvASd2O6xScAS315epthIl3Bph/6pRylfs/GGP8/bvW5JLTvSt+pki+AwZpaa046TDevzPu9eKvCI9H/gqgDL4qe4i79CrBIEjuaFAGBmzt+f4bRiFdO+LdZArNCMHMVBbNl2uKyR4uhfmiPoe58y9FSAgGBex/lw2R5xCFB2RJIEjc0pa4pfiotYCaclrf2hGS96gFzocRH73C/XhN2+XsuDxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787604004; c=relaxed/relaxed;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csqsGd57rXLLyTiG03BNqSYGvOSSP0Jl6+kOUk8q9uH5+PzEizu3rIv8PYr5whdmXLA7gllPZAIUBG0mmUtRoL3v8TlT44cmT5tytK+n9JL7WwvcGOf+KuyjW/jw3ZXFGsSNKWWhPLnouMMeWG6FVBNNzh5uH/ojflWNhCTud4NKdU+2vk+uU5RecxPAFbOKyX+1FxvsROygnomoCYhlt+CGEkqOMPAZJqKCjgkzKWkkKLHndKNzHafW0pEDeyKnTR8ykyOFv/YkqyMccvwIM94kY4oAcfsTKJpnk1xJnVese+iyf+KljBKbvS2cxtbdRBqej08iz4ovVQDYt+TBrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fud7BxQ3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fud7BxQ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTN831PfGz2xr2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 06:40:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CED044071
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4781F01568
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787603999;
	bh=LEMIXlW7UB4hHdDf5XWpYKY9mKhf7DDvl0I5DYYVcWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fud7BxQ3mGLqvIlEbg6ad9ks7USWBuldJ1rhesQ/I5Z0P2TbTL/B4yjUjL1TSSrTD
	 v9RK49uFy/MyVlVnS8Z/JZDw9ZTdeNWDOS0e+/wAdfU7LjgosBNO5vMauS2LOkhSwL
	 h9es8uX1/IuSMbLrikq26C8DDQWS9jjYsQIWnhTN/9oY8wwhg8Ib5NngWTfnaG5VPb
	 QNRFXSnXUIyQ729E68Byd/f2DVHD/1gkoUs1R571cy1A1O4+ogllCKGvmvCpO5h+eL
	 qJLr9moIGO2e0IP8EFl/5HO0egD7wqzSaMyNhD5h7CfhF2rFlDdbxcC/fexzhM8k3F
	 Rj5nuaFX6ztWw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-451fd21113cso186648fac.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 13:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoVvj0+qjtnNcYzku/vzahCkX3CKUH0jYtRPUqwrqQmDmv6q38TzqULkO0/TdzmS1cf/FTEG/sHqeEZA5A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lbsFvQYc7jo6WHX4hEZu755tlUSyB4GumpSIE8qNm5GieNs93G
	W2bJo6vYrI8A2v2YpMh6Px59JjY8/iujDogVq+2RtPqJEtp7Xby4cmiWrmQZlEwFPyUk1KTCgrM
	RVoZ1owhylKqRGDINpIU8Fp8WneSP1zU=
X-Received: by 2002:a05:6820:4b83:b0:6b1:779:89f6 with SMTP id
 006d021491bc7-6b18fa810bemr1569885eaf.3.1787603998213; Mon, 24 Aug 2026
 13:39:58 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <631df13629bf77d55bda770f94c7b1863690f2e2.1787239813.git.geert+renesas@glider.be>
In-Reply-To: <631df13629bf77d55bda770f94c7b1863690f2e2.1787239813.git.geert+renesas@glider.be>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 24 Aug 2026 22:39:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQd4ZfKAxzCaOobfQKyYqa3jdaCiPEd8Tp=yyC4YeLuQ@mail.gmail.com>
X-Gm-Features: AcwNN1WWNgSFLas9lNi7aTz9dpo8225CQLxghuyz8Km9gH4_yLCmhqwBO9vh3BQ
Message-ID: <CAD++jLkQd4ZfKAxzCaOobfQKyYqa3jdaCiPEd8Tp=yyC4YeLuQ@mail.gmail.com>
Subject: Re: [PATCH 22/45] clk: nomadik: Make sure clk_init_data is fully initialized
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

