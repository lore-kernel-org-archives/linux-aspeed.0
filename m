Return-Path: <linux-aspeed+bounces-2297-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2995CAC597
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Sep 2025 10:49:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cTR2t68rRz2yyx;
	Sat, 20 Sep 2025 20:49:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758365382;
	cv=none; b=A2zzgraluYpXInboe5IOmB9LA68v31zK/hmC2ZLBzp8d9h65fO7OiGv/uBhwn0LkIOgVjVam3hukz6k5JjA4Sz5+aoID3zITKFH2BKkubaCAI0QtMqSDGAj9FWJidFKHcJF8Zrxbjpx8nBUqcBIIEn65nAtbjev1mFEtEXobCu6bHkgZLOVjQTkuvBubeu7suXo1fqcEmEORpa+ydDZlb8+m60tXTIy3+GEOLnk96r0Gxc8jslH+9gb0iY/F4gMEBmlvjDRyTRUphW5SmxK6/Azn+XmlGE06ujmDeuCr0bWzUyProj2UqWl6Qqblup+A71uApyorOT05eE/w1p9A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758365382; c=relaxed/relaxed;
	bh=QJc0EGzS/+BK6QuDuFmI2nY7ewfLLXuJxl0wU299He8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMJBgYh2O5iMyvVoCLw17lmYM+1AWcxeQSI7SVaH03ICuWC76SYxZRWl+CaEKJLNbzQISg+Eu6wSNdrVcqPvYb3qfhC5A/i3k3lTkuKYTkPzGgw1ivmWgSykTBsPM01faPBvwEy2R7knKVxFajRoreJ6kq9WxhqSJvNpPfwADrVD3DKzBCGFCV8pSHffM7LXvU0vVgWcItFCvMwTg/GLLcKdiNS5zMneh59xVT71v5SsgxFQOfK3ANNPHBzNIxyh9l0+44st4rAP8GyvuUefAZ9vAFuPl9oxnhHtnvAzjsYVSqqB7pD+v/78Ts8R6HMVSj4RM1xbkxghJiim4+WhCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKtzfl2E; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dKtzfl2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cTR2s0M53z2ytg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 20:49:39 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-afcb7322da8so545012466b.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Sep 2025 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758365374; x=1758970174; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJc0EGzS/+BK6QuDuFmI2nY7ewfLLXuJxl0wU299He8=;
        b=dKtzfl2EbVprsGrp5QCqfHLbQrDlCKHg+XE99tKHwEo1i3Eopc1+jwl8A4IoI1+6dq
         KUeD4arUYl9S4E9UV/2AHx+uBD2wsunzjkTii15BAR45kSI7NLKnDzyoH5fAhwCWOqYB
         vDxKWc6zWCWzQFCKnGRKPXNhdk2zd+el7vUNhIsR0GcPSg646OZ7vP8+irhkKUe/Yudw
         wXc+7QzaGuuJw9aOCVkLgOIq696pG9SZAO0tyrQsqKBWJmbdc65b4LA1nUDRr15ojHyY
         FzjpnM2nvLNK1oTwTDrR32FBde7UkhxKnvH8ZhBlnA2RuDNzPnzzGEqTmVEtyHM+Bexb
         iPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758365374; x=1758970174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJc0EGzS/+BK6QuDuFmI2nY7ewfLLXuJxl0wU299He8=;
        b=jp5hbKr7CBGl/zJ8EBaWwe+zE3H+j9NMp+Kfa6gO++E5rbGvyYfrmluLc0083NyRsw
         OHYy7FJofxhk594LQO5X3jD0ExHklNYdWMRj4kf+pukwtBJHPUDe0MBBUtH2AIaj/VIV
         Kf97eu736vofdg8Yj5FST1Ej2Esx89kUnDTfNi6xr3xkkwvs95ZSqnCc3AMV71AnXMZm
         iKYR4ItEXweAyPkJX1gHyovDz61u+Ri0WdYVv6PxWKrPGFpyfCeE0GuuQ+ruFFLCXQYy
         SancggdAei/ocXTAAoc+WapydklxzO08RSfAHgYRysQDfUtUB6iPJQigvIPYaKNO8jVh
         I/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/9oa608/xf2LRz2SGQlZCY5W8EY2VYPCYDifPeD2DPsxr6LmQuVS4jZWG4OL5DMVcblFYwGP5X+kHQkA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy9CowdYFbYNsA8+cYZKlti+tYzlrVMH4hUyJT1nfBlD2fx7Gbt
	AELGx5G10wqbFGMkTtwFahjP7CcZ9Ks3zYatS/3FkdXHaw6dsrwf48rANJrCZukIRwwDhKVgU0s
	273pfyK4ZuzhV22/wIUuNEkgz5ACisco=
X-Gm-Gg: ASbGncttzG3w56tUCT0NtzRwH7RNV2bGyQAgNIg/FPrWfbp73jm030ah0cRvFxzSwnT
	xyKvoVhmwlo9hQd4YYLUza7MDOw2EKJ2b3wmzXU9hinte572gdk4tVa47gbQyPQtLos1Qn5DD/v
	BAkc0LGrbs7AghCkGPDsFpacAYyI43p/m1YHcwY8c4XNbFsMT86mtECr+U2VpPDopswgouY48l+
	82b7IE=
X-Google-Smtp-Source: AGHT+IHHbhBTYGUaEQMbVjyA0lAj2luPxy2XsbzoJZ2rvsPEEjKDVfN8Ekg2zTb0h70UHa/ky/mxQ7DHX1RPk/WuHD8=
X-Received: by 2002:a17:907:2d86:b0:afe:f418:2294 with SMTP id
 a640c23a62f3a-b24f4cd1612mr662812666b.49.1758365373591; Sat, 20 Sep 2025
 03:49:33 -0700 (PDT)
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
References: <20250919-vdev-state-v2-0-b2c42426965c@ideasonboard.com>
In-Reply-To: <20250919-vdev-state-v2-0-b2c42426965c@ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 20 Sep 2025 13:48:57 +0300
X-Gm-Features: AS18NWAsgghzm2kBTHVAUWgTvM4Rjv6fz5BEJyNeWi6WNSHflPsd2h04LFjYcyQ
Message-ID: <CAHp75Vfx9kyP-rVtfvyyMK4VH+oiRVjP1fZOtbVH14iLh98Jxw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] media: Introduce video device state management
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Hans Verkuil <hverkuil@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, linux-media@vger.kernel.org, 
	Ricardo Ribalda <ribalda@chromium.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ma Ke <make24@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, 
	Tomasz Figa <tfiga@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Matt Ranostay <matt@ranostay.sg>, Andy Walls <awalls@md.metrocast.net>, 
	Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Dan Scally <djrscally@gmail.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>, Andrey Utkin <andrey_utkin@fastmail.com>, 
	Ismael Luceno <ismael@iodev.co.uk>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Corentin Labbe <clabbe@baylibre.com>, Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Keke Li <keke.li@amlogic.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ming Qian <ming.qian@nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Eddie James <eajames@linux.ibm.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugen Hristev <eugen.hristev@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nas Chung <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Bin Liu <bin.liu@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Minghsiu Tsai <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Joseph Liu <kwliu@nuvoton.com>, 
	Marvin Lin <kflin@nuvoton.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Xavier Roumegue <xavier.roumegue@oss.nxp.com>, Mirela Rabulea <mirela.rabulea@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, 
	Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, Robert Foss <rfoss@kernel.org>, 
	Todor Tomov <todor.too@gmail.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Jacob Chen <jacob-chen@iotwrt.com>, 
	Heiko Stuebner <heiko@sntech.de>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	=?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>, 
	Hugues Fruchet <hugues.fruchet@foss.st.com>, 
	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Ripard <mripard@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Yong Deng <yong.deng@magewell.com>, 
	Paul Kocialkowski <paulk@sys-base.io>, Shreeya Patel <shreeya.patel@collabora.com>, 
	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Jai Luthra <jai.luthra@linux.dev>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Michal Simek <michal.simek@amd.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Michael Krufky <mkrufky@linuxtv.org>, Mike Isely <isely@pobox.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Longerbeam <slongerbeam@gmail.com>, 
	Jack Zhu <jack.zhu@starfivetech.com>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Christian Gromm <christian.gromm@microchip.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Plamen Atanasov <tigerment@mail.bg>, Sean Young <sean@mess.org>, 
	Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Jiasheng Jiang <jiashengjiangcool@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Daniel Scally <dan.scally+renesas@ideasonboard.com>, 
	Matthew Majewski <mattwmajewski@gmail.com>, Yunseong Kim <ysk@kzalloc.com>, Chen Ni <nichen@iscas.ac.cn>, 
	Fabio Luongo <f.langufo.l@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Yang Yingliang <yangyingliang@huawei.com>, Ludwig Disterhof <ludwig@disterhof.eu>, 
	"Everest K.C." <everestkc@everestkc.com.np>, Stefan Wahren <wahrenst@gmx.net>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Akash Kumar <quic_akakum@quicinc.com>, 
	linux-input@vger.kernel.org, mjpeg-users@lists.sourceforge.net, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	kernel@collabora.com, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 12:57=E2=80=AFPM Jai Luthra <jai.luthra@ideasonboar=
d.com> wrote:
>
> Hi,
>
> This patch series introduces state management for video devices.
>
> Currently, V4L2 subdevices have a well-established state management
> system [1] that allows the framework to store the subdevice state
> at a central location.
>
> Video devices however lack this, leading to inconsistent state handling
> across drivers and making it difficult to implement features like
> hardware multiplexing in complex media pipelines [2].
>
> The series is composed of three parts:
>
> - Core Infrastructure (PATCH 1-4)
>         Introduces the basic state structure, try state support,
>         initialization callbacks, and driver helpers
> - Framework Integration (PATCH 5-7)
>         Integrates state passing through the ioctl wrappers and driver
>         implementations
> - Driver Examples (PATCH 8-10)
>         Use the state to store formats in TI J721E CSI2RX and Rockchip
>         RKISP1 drivers
>
> This should also provide a foundation for drivers to extend or subclass
> the state structure with device-specific variables in future.
>
> I have tested capture and format negotiation with the converted drivers
> on SK AM62A (j721e-csi2rx) and Debix Model A (rkisp1).
>
> [1]: https://lore.kernel.org/linux-media/20210610145606.3468235-1-tomi.va=
lkeinen@ideasonboard.com/
> [2]: https://lore.kernel.org/linux-media/20250724-multicontext-mainline-2=
025-v2-0-c9b316773486@ideasonboard.com/

When you add a Cc list., do it after the '---' (three minus signs)
line, otherwise that huge unneeded noise will become part of the
commit message.


--=20
With Best Regards,
Andy Shevchenko

