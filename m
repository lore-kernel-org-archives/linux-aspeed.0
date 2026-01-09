Return-Path: <linux-aspeed+bounces-3271-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40822D26D9C
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Jan 2026 21:07:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnvTv6bX4z2xGY;
	Sat, 10 Jan 2026 08:06:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767992819;
	cv=none; b=UB+Y7zKMMluA8Ou2IcaP3aqDFtHg/S0ocXsmetNz0k1Cm3izS/HEdKuWZk7pl82osTE/T33ryxCX3HlAfLMTUIcBIDlJ6g1Ub3NdbFj2DRqGRzG3lqJaSR51vyWBucjH9ZAgftyfq1b7dqrqSzxJi3Llw7zXsTDYWcfHhEom9tjjrcl5/3CSp7VfICyGlXdzRG743Ml7OLY3xG0bpIqjzqK5wiYHBt9Q5yhSYlhwo36hteAXHOsi/G+uK6ULvTrtHX0Fd3tjDKFk42dMtww/U2HP32yBBmTsRas88D6FiKq/dYYWjzyg7WdVrVlTSicunQ5w51WRi7KceLEOV4Tn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767992819; c=relaxed/relaxed;
	bh=f+kn0nlzGkQ0BViOYfFFGO8lkUm/rT4hSAopw8yn9RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amiy6J2+bP2Okugeg2vlOxUL75dtMgHTFqBUEpHyarptt/Vpoj0JeR9t0PKK9BOnI4VULDINQUMd9sLuUj83TfhtpWhH2CDODzHHdvPmZ5dOjLA/DsiSGDe2sQecIM6nFVqvw4Es8gda82t8reWGFbkXRCAropOgi+S35TRrf+vlrkikbMoFm13uNBQWnidzguLwvBRn9K4GXBBiVYWKnfIsb6R4jW+A2ZpJgR/2h+x4u1ADuqfAt98u0GyWefCU6IznDvTed+jriBU7hVeseLoT19AcLkGKr/JdKaGf5La7qeghrpiwZEQyDyjlBvBylq0HZAkaz1s2jZQ10nxOqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20230601 header.b=MrEEhE4Q; dkim-atps=neutral; spf=pass (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=martin.blumenstingl@googlemail.com; receiver=lists.ozlabs.org) smtp.mailfrom=googlemail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20230601 header.b=MrEEhE4Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=googlemail.com (client-ip=209.85.214.169; helo=mail-pl1-f169.google.com; envelope-from=martin.blumenstingl@googlemail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnvTv1k8Wz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Sat, 10 Jan 2026 08:06:59 +1100 (AEDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f1bc40b35so53566535ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Jan 2026 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767992757; x=1768597557; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+kn0nlzGkQ0BViOYfFFGO8lkUm/rT4hSAopw8yn9RE=;
        b=MrEEhE4QQbAxbW4DB7/MXwMOrhWj9Wn5uPEdOnaO2xSgG0847w1uKWWFA7hzRI61gc
         EByXxC7lBxvn1vxZgb5wVlLnOGsauCNDd2iOgfUxcZRlocpdPnVe89oRaTwPpPcSf+4f
         saslUX8nqnQkWIB+O207eEuCRW1h1R/kzdefdmqrvTQ1DibvzeEs/iibHy+namT+XLJu
         yEsBY/bMu3L03eikQg+QwqN/pz/3icMDdUxKO6gU00bbQeshXtrZ6gay3Zmk1mYsrxQ4
         TDJgijmSWF7ZjE/RsgmgzdNxHpr2Li04OuBc9fzkb7bLNRAR1Tkey/k4RP/xET616Di1
         vezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992757; x=1768597557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+kn0nlzGkQ0BViOYfFFGO8lkUm/rT4hSAopw8yn9RE=;
        b=NhCzWi5YFXY06e649HL//QspaSKQgaZegiOdlLY+Rq4IIkR23qsdkAdRW/OJj9WhSQ
         vlkULVkxoT0m5Vz3kmRbHyiLQZ9Ogf4y4P28V6Yjf5XnpQ4ili2wWLYWYX/ipwlk/iYJ
         M0BShTGntOygHCmsAoErcu+itTAKAzGnIhMi44oCfWWvwYNAoFyCsCVQm7W6OyXKiu/8
         101RvBn8upLmGEop7OTWDFSwUpFf41byuPmrPvH2sV76zAi/QoqY+UfdtzxAx15pb3gv
         71n8C+zVk7Yo0BtO7Ex4ECIWLW5FYhh4Q9qWaxnBzsl12/Qb19aC+IG1VYssNaQm+u49
         P+hw==
X-Forwarded-Encrypted: i=1; AJvYcCX6V4O5eg3FJqhGGyMA2R19/C4qVrRuVoX4mHf5TAyXY93tuzoaqGoUpw/plG2zdXydm7bjERP0LL3y50k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwGl6/AT3aDZlenPMBqotapLCj6DwHmQ8kdrIcA8Jvu6aYW6/El
	oWjHAastyWGoN6lBOQyZt2Z0+FeakdYulFkrZXXjzWLAgVKzpbALkj0bjBWG5IlaqEToZRQCw3y
	pCvXorY/6ukxADj0gBZSMFMjvW9dZrYw=
X-Gm-Gg: AY/fxX5vS8Yq6/pZ24Wfqhb5FtPSKI70ulxiUrGvLEIeoN8fdoRj3R/0GsKz7TGegeh
	xL3moVmYiz/4WbCzWDI9agS3b7464uUtEzXFHIHC7XQtuOIi2bLNXDv+FGQ1s5cOONXwTedmrmZ
	oM/EYVcj6txs3OvWvL27TWwTtnv8RaM1MTmrd6jvVh4+2LYIsAGCfAO63urVGRuKMYBzzfKvffk
	T4jUTewRzWj1VWzeb/G0Ycf+JABOeIMb9s1ADjiXFuX5PyNBFTrbwXk8Us4etCI1Vo4smkZhfKw
	YQ0qOhW9MuU5euioSXRzWFMYaDwCpZWMZfphB7Q=
X-Google-Smtp-Source: AGHT+IGzEqZSKhDh+mfZnkqq/TwV9IRDJvdndDZXOgFLWIDXGIN31XCilSikaluLQUb1REl5xfFtQyCdyy3ZvPXVWkE=
X-Received: by 2002:a17:903:1acc:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-2a3ee49b5camr115632895ad.48.1767992757127; Fri, 09 Jan 2026
 13:05:57 -0800 (PST)
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
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 9 Jan 2026 22:05:46 +0100
X-Gm-Features: AZwV_QgnJP_ucVFfV4UzfxU71gNnGoxRPDRc5QYDA0rdtBqGfiMffeomtdZlKmw
Message-ID: <CAFBinCDzAOC9Sc_LZEbLhtajvPC4zjRiaoq6k9at2iJQnJxwjw@mail.gmail.com>
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
	Alessandro Grassi <alessandro.grassi@mailbox.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Darshan R <rathod.darshan.0896@gmail.com>, Aaron Kling <webgeek1234@gmail.com>, 
	Vishwaroop A <va@nvidia.com>, Haixu Cui <quic_haixcui@quicinc.com>, 
	Darshan Rathod <darshanrathod475@gmail.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, asahi@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-rpi-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, imx@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Jerome Brunet <jbrunet@baylibre.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Han Xu <han.xu@nxp.com>, 
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

On Thu, Jan 8, 2026 at 9:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The SPI core provides the default of_node for the controller,
> inherited from the actual (parent) device. No need to repeat it
> in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[...]
>  drivers/spi/spi-amlogic-spifc-a1.c   | 1 -
>  drivers/spi/spi-amlogic-spisg.c      | 1 -
[...]
>  drivers/spi/spi-meson-spicc.c        | 1 -
>  drivers/spi/spi-meson-spifc.c        | 1 -
For the Amlogic and Amlogic Meson drivers:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

