Return-Path: <linux-aspeed+bounces-3275-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F790D25032
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 05:52:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpl5N1fP4z2xrC;
	Sun, 11 Jan 2026 16:52:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768110728;
	cv=none; b=aqiXgFDSMF2+WPyKT6iCyqwTnUV71F3HY+g4Y7qcpouR2pkvEASWxrtrfaEX0SCCJQEsloYp7SBo4NugFwLvFGmw8+ZQHQtSFDF3g9EeeGewH0paYlaS/pDcpv68GknsM7AW8MF+BzYHhimOITWCaQa3IneIGTSu8w7Kv55K+9BL8O2dVnWbUcBe+YXwnSRycIrmlTMY6ghYbS/JcaVCeuoeZGB71WDd0MfdLSSk5sZzFUyIaWlPz1EKZosWrZlYET2nxqarBhZZSpFlSz/a/5Dd7kl23+eRBJ+KjE88ffLH3pJsORD8aeeWdhpc9MrXBO6N6FpkSFsOBF6+52m/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768110728; c=relaxed/relaxed;
	bh=/CKDTUszZa8m5D5wBdv3ua92FBu1OVj+TXW3ffFaVDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihlmlQf1/fIYqJPE2x1uvgbx6EM2ARkSYDYbLtgso1fKFE0p6wCJCNMSr/EOLXb2kwI5zX5Rh63RwA90LX4RiulexIy4FYfKgtjNc4d53rl4TD7v7TYRKjGIU/H2tEi01dbuiXeUVWIvsfbnETxxk8bU9iOKbZ9+mgOIoo+6gza/dkx6XUf5rY0cvSndl7irDP4WMfGUwIkHffWT2zc8u6n+6q8dYofjVTMIcv/QnG1dlv1TL6Y6YiUDNsx07Z+k2tYz2O6Fe6IELrShSg4FpPXhlMsyZ/VtqEirGcTYdqKStvN4tld3cS9Zq72z5sL1aD2w8s33bEohqtv+KNvVjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P0lTfxA7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=wens@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P0lTfxA7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=wens@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpl5L49Gjz2xZK
	for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 16:52:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9C03460010
	for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 05:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFC6C16AAE
	for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 05:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768110721;
	bh=gFOqW5EllA9fOAMNFfoSxTnUWA45XGayQuA1pDHkobg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=P0lTfxA7J1vxOQY4hChwaQHlTa9WRMPbmkoUzHG4DuAPpLAvvhJwizp/45xu3tPYm
	 gvDKAm3Zq7v0Fbfjp0cx0La4P3ldfaxXRa3T0qXjTsAsqNhNgAYS26YwB7iHXgV8FR
	 l91eXhrG3u0SBvHjZ4mQx+gVkG8nN52cd4aHXCYlxN/cxkX93RlWRGAejgjqmMBwn4
	 b/VcWocgQ1uDlCCjFttNeDijhBhO7EX3yvy55uWq5isdwRXzWDjUEHS0Eyd/bfGBNw
	 SYdY1H0+XTsZAaI1Z+C/JfbSg5XTjFv/2Pphs9ocUxbEDFshKnrGaHKltKmdwRK86u
	 bx6XOxfy1uHPw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b679cff1fso4280884e87.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Jan 2026 21:52:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzjDOxU9O6grUkdwiW4QlCoXKNW/AMwr9KSc5l3JDoxDeLksrfBcykpmB2LQIBJfXztEbZTP+TQvzcbxs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwjBW1rfQFgAOEs+9eLIgGS8UQkq+W66NYGtqGYAr77d9qGR0CH
	/xr2QBznqufJ+jtqAbAIajSAlw/U7KOC8b0fi9IayK5r3eGYZ/v9qsCHrCoyld8EBJBzNBnn4T9
	1XTSURG3pnjd/C40wQfOBNRlxOh6Y1TI=
X-Google-Smtp-Source: AGHT+IHdx8MpFefSjShCgzPfxBNx4mIFIm/zyAePE38bdBhjZyOXA6x69rTwWZ2pdG4l9l0f7a6WNZMxH5DhWbEqc7E=
X-Received: by 2002:a05:6512:31cd:b0:59b:6853:f085 with SMTP id
 2adb3069b0e04-59b6ef04985mr5236958e87.16.1768110718798; Sat, 10 Jan 2026
 21:51:58 -0800 (PST)
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
References: <20260108203004.3538449-1-andriy.shevchenko@linux.intel.com> <20260108203004.3538449-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260108203004.3538449-3-andriy.shevchenko@linux.intel.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 11 Jan 2026 13:51:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v640nT=+g6bVuROizSG5Qb-upfQefs0-j9X0BnOHf9NYMg@mail.gmail.com>
X-Gm-Features: AZwV_QjlNyXyyBCLSJ5be_kfqm-PbzUe8msaEi6oZsEaSVwRVLe_bhZOZe6iKv4
Message-ID: <CAGb2v640nT=+g6bVuROizSG5Qb-upfQefs0-j9X0BnOHf9NYMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] spi: Drop duplicate of_node assignment
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, 
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sunny Luo <sunny.luo@amlogic.com>, 
	Janne Grunau <j@jannau.net>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
	CL Wang <cl634@andestech.com>, Manikandan Muralidharan <manikandan.m@microchip.com>, 
	David Lechner <dlechner@baylibre.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, Hang Zhou <929513338@qq.com>, Jun Guo <jun.guo@cixtech.com>, 
	Philipp Stanner <phasta@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
	Shiji Yang <yangshiji66@outlook.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Marek <jonathan@marek.ca>, Carlos Song <carlos.song@nxp.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Xianwei Zhao <xianwei.zhao@amlogic.com>, 
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
	Sergio Perez Gonzalez <sperezglz@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Gabor Juhos <j4g8y7@gmail.com>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
	Rosen Penev <rosenp@gmail.com>, Luis de Arquer <luis.dearquer@inertim.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Longbin Li <looong.bin@gmail.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Alessandro Grassi <alessandro.grassi@mailbox.org>, Darshan R <rathod.darshan.0896@gmail.com>, 
	Aaron Kling <webgeek1234@gmail.com>, Vishwaroop A <va@nvidia.com>, 
	Haixu Cui <quic_haixcui@quicinc.com>, Darshan Rathod <darshanrathod475@gmail.com>, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	virtualization@lists.linux.dev, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, Sven Peter <sven@kernel.org>, 
	Neal Gompa <neal@gompa.dev>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Wanner <ryan.wanner@microchip.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jean-Marie Verdun <verdun@hpe.com>, 
	Nick Hawkins <nick.hawkins@hpe.com>, Yang Shen <shenyang39@huawei.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Lixu Zhang <lixu.zhang@intel.com>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Han Xu <han.xu@nxp.com>, 
	Yogesh Gaur <yogeshgaur.83@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Heiko Stuebner <heiko@sntech.de>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Paul Walmsley <pjw@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Li-hao Kuo <lhjeff911@gmail.com>, 
	Masahisa Kojima <masahisa.kojima@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Michal Simek <michal.simek@amd.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 4:30=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The SPI core provides the default of_node for the controller,
> inherited from the actual (parent) device. No need to repeat it
> in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
[...]

>  drivers/spi/spi-sun4i.c              | 1 -
>  drivers/spi/spi-sun6i.c              | 1 -

Acked-by: Chen-Yu Tsai <wens@kernel.org> # sun4i, sun6i

[...]

