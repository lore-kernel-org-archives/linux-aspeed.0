Return-Path: <linux-aspeed+bounces-4834-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6921AC5DF94
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 04:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSyJd1yPQz2y2P;
	Mon, 24 Aug 2026 14:16:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787544388;
	cv=none; b=Fyno/m11kgRbX/vSBVRMveohP408jGORBnp71fVWIGf6h41yOyoZ1U4ZMoN2i41mpIqr9JH30wTbgPqs/mSd+g/gXXkSNiGJNnjC0L4yI12vLZ67NZqDzv0oZ/E84Q9hqFow5VrG50xh4oPNvGNAaC6Z0TkObEd8KjByqVaXvVgVRm56kfpgv/E+VFERc8HSm+m2/bFmwPMLi0lmiuhMvg+PQ5E7pR70zyxBFfyNOunnzfgeUPE3BJOp1h5p9t25MhPQlsx0pK6wtKeJ67jzNWehFxi1Mn98snq6DUa2sG2BEkrydw/GdeT4jAUWEQgWe2Pa7RBavPmrfmAZbV+uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787544388; c=relaxed/relaxed;
	bh=aZ+YAW/hXFppA4FxL5IflpWDS7HfTYg8qTJoBoXjwNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyGoLqa+yRbfSBQ+BvJvG1CmvRgSIleU3RgptLvuSrljSypDeapoMkFj13dc+Blk1thgmiZjOwakb5e3Ncxi0ELkRxgUyEAwY7cZSpsyeS87a9PO4m80/lHCL2aCF2qPylv5umGCvG2DaJIh3UFQbn5Ufry0XtekMoLNLYT1G9oGtst9KyyAOtYAXYeYo4tOIzkmIPOhQ+Ga22VwxPplUVPFGu/0h9CcMgd4Ehc2aeQ7dVRxbSX9vg6klnGbA5fvas1wo30aEJ1RSXt8jSZzZ7v/eelKTEpOf/TT4xPfLI+rURJILc6v4hrscXRlrEO19nVQvD81ga9Hn1A0ifFlvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ImPCb+sS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=viresh.kumar@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ImPCb+sS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=viresh.kumar@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSy5Z1G8xz2xns
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 14:06:24 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c999f162c9aso2128991a12.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 23 Aug 2026 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787544381; x=1788149181; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aZ+YAW/hXFppA4FxL5IflpWDS7HfTYg8qTJoBoXjwNs=;
        b=ImPCb+sSkJfJ0LFBxVX3sY5so5B6YaFkRGgzJ5mWiIGTuv0HMEzKUwBeh3x6HkqD0c
         4IlA8RYunwZglWKo7+N0d65XGqOY+ezVcp0zDQx52myGozarpb+u0dZkRfQ8AT50afpn
         29C4/Gt/jEEUFeRwgle/MavDW/N/AME/hWWNn3Hu1rXmewZ3Q1jE4UUiFRb9LXbNC19O
         2UE18c7SVMNSZiK/rjg23Os/Ip0RWyVDQrx7R5yQHJti8s6zSxQWh40d2sDBDCJ1uVoy
         qayyASuCBflHylXlRzlW0GaE+wIWlpSbt1TCtYL+Oc+E25jxPO9suneszdQ8zX6dDfep
         WYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787544381; x=1788149181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZ+YAW/hXFppA4FxL5IflpWDS7HfTYg8qTJoBoXjwNs=;
        b=HnGOcA9YI/DoYkdXETOsg8tbpiKieHuM9N1YxBE0G4i1GtNtRbfMZnMuv3EW+j62aB
         vcqUt/JifmsGhL1jERlOYws6GPic/jWT1kvEs2fHxz4BGfz24JUBJ0jDO1MOB964UrPp
         nijmKYevls0XGSPa/RkieKs7oOWUPOVy+iDj2DoT16CsKegeHTUMyPnIblfTU6u/u2B+
         H93QmCAfpn41I1mXv0jNLZmABJc2MM54UQLL9e2SIZPZUGp4FCA0i0AiqgeFWUn0+oby
         C+l7w5TcOGaSfkIfMUZeis0Py7zhG9Nh12CY4RCiEd0KaIIoG4LzkZCaUh/c5oq7weYo
         IOTg==
X-Forwarded-Encrypted: i=1; AHgh+RoRKRGmGP4OcPSCXwt6xsIYz2mq4mVlReBQRXtGClowI87s5h5yQbGsjMHXy/UrOHPIHrn0YWVg9nIn/rI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kiHCrK+BklQJHW11vOwjS/MopTMNGy9qU3vD/lQ+KVasJ3l5QB
	VCY4aWKNSEiMM2E5o0y+959v5A3soHh5OhQVXQE4o4eHm3/BFhXJg/R7kf9di3CHN9I=
X-Gm-Gg: AR+sD13lULN0+fbq2LXXX0p32RvXT9m8BFuSwq+dQNw9iZznf6YDLueTiyh/zg4WlYn
	62t2S6Gly5CRT62ofP5XEQdfsGk1qNQR2Fw8g4gy9l8vvsw+faARIQwcpkwC+EgM9ZQ7SlutF6/
	2nX0ZGR/SPg3UZMQOqwQ+NFqEQyJfwrIoBohFHM8YjIO+gmGd2NtaRMKolJRZzYVjmO65Z6pQO8
	9gBn/wdoFh2LlLont5VzkaIqV6pxXzwJtNuvJ4OfAJZVXkmET04r6idwCJZj/GpBRDRI4V1YQKB
	cqjx/CcwAskFtEvxH9fPxPs9vPjONvRa9Y6bzzpgaKAm2t0Yrz6BfXqJtMxBmS8FrOr5kHF+xU0
	MA5DkERW60JuLZEJQJRE7HPbKIJ1OF8oFPoGP9yostnClMwTU3dVa9aUwzOdUtSBKx3DIzGDEX4
	OeQj4opmo4yI5A2aB9CHWNHeRTZZpD+OwM5xiTGOh1htIlozAl8FmVLlU4OLk+Nn4=
X-Received: by 2002:a05:6a20:7288:b0:3c3:6b6e:8ba0 with SMTP id adf61e73a8af0-3cd3008a6f1mr36995990637.11.1787544381391;
        Sun, 23 Aug 2026 21:06:21 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm19733419c88.14.2026.08.23.21.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 21:06:20 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:36:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Linus Walleij <linusw@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <david@lechnology.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>, Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 33/45] clk: spear: Make sure clk_init_data is fully
 initialized
Message-ID: <aovDOSMKhHLI70dW@vireshk-B250M-D3H>
References: <cover.1787239813.git.geert+renesas@glider.be>
 <d4500d249021013d52aa87407f875dc203a251df.1787239813.git.geert+renesas@glider.be>
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
In-Reply-To: <d4500d249021013d52aa87407f875dc203a251df.1787239813.git.geert+renesas@glider.be>

On 21-08-26, 10:53, Geert Uytterhoeven wrote:
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
> ---
> Compile-tested only.
> ---
>  drivers/clk/spear/clk-aux-synth.c  | 2 +-
>  drivers/clk/spear/clk-frac-synth.c | 2 +-
>  drivers/clk/spear/clk-gpt-synth.c  | 2 +-
>  drivers/clk/spear/clk-vco-pll.c    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

