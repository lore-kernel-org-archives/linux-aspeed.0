Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2E606A31B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2DPOtoe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK3vz2X0Pz2y2B;
	Wed, 04 Nov 2026 10:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793708688;
	cv=none; b=RRjZ9w+xQvasuxdo7rBVOSu3SpNZXqZFn5uVmbvJhv+jGw4eNte1jMq0cbgmZICIOxPyuLRjLW89R9yuMWKOu/97kcec+jc7Vd4zSY590lju488NEr1J6YORM3/uo69Pb70KacrYTw7JP7Gontq69BmvXzqiYO/rcZ5mY0OkF1IZwslJJ20esuW6tAXIzYm4DW77APkg8brTzowgQCyTT6HFDdga0w2k17wcwJUAd6+sx43RITyM6v1t3x5BImDxdXhOh0FbhO4W+U1rDx4F/JOU37DcdjyOtmNvUNUsuFqaydL25s8ooqE2YIJh7DH556iTdDC8jr/Z/oUq8r3PTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793708688; c=relaxed/relaxed;
	bh=2DQ96R/0ulhMhCPuDty/w5YNIxZWO7PXWDO3bMU5BOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+N1XxepybAqdLT3iMk+TBxNzByy2+yNf5YtaNRrYKaXDjafXOUttPITlq7Yea/l0npgGg+V5cGKhbdWgR/UCTBAfMqHWEPx/WoZ8V4o+iZtJAs5OmSUG+Q2DdmMP9HUKjh+kD4zO1r9ppdyyvqWm4yGP9YwMFS37D4xgwaYXFiZ8D8u248hD8yq+QQt+WmQLIcOYdAMLCv7ok9RogpZMes8uDW+6uYMvOXpMbP0EVEIeFhr+DeDuLisVYBSC5SqfD3nU7Jh/LvMoOlmTDJ67sQwUfeC3RuKiLxjiQ+pS0xVoyou2qmbON3NDzDJsy4AMU0/gEepORFFq5Vt+q0E7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2DPOtoe; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2DPOtoe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jJnnq1Vh3z2xGg;
	Tue, 03 Nov 2026 23:24:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id A7BD340B58;
	Tue,  3 Nov 2026 12:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D33F1F00919;
	Tue,  3 Nov 2026 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708684;
	bh=2DQ96R/0ulhMhCPuDty/w5YNIxZWO7PXWDO3bMU5BOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y2DPOtoeBhQC9H3iDa32ycCqijeUsQyOWUtRGHIYLH0dXLxZUgEjv6SLfXFJy1+yx
	 REGyvcQMfuo3sZnBFrDxClG/MkMaDIKnK90l7RtK0PDTXjGL6CaKqpsTGr1H383bgl
	 4TyhCnpi2mmiJ18g5WO9YEH6HMlaMgnH5EIfxQ78ETdDfCbW0Nq7FnvPdbMq/lkRzu
	 YVxjlkUTO+w5EzhvM5yynGpZ7GDn2zzh6C78NzGOnNAyoUN8QGMgJIfas682UgvcoY
	 za6RIYThdNdxsriG9j3+KBkt/9fGZF5z8OM8R3azJs/Dg4hZMYuSZR8c3Kxw2uTAo8
	 Un2lK6ZcYoQzw==
Date: Tue, 3 Nov 2026 13:24:40 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Imre Kaloz <kaloz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
	Romain Perier <romain.perier@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Hoan Tran <hoan@os.amperecomputing.com>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-hwmon@vger.kernel.org, 
	Matti Vaittinen <mazziesaccount@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux.dev, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, linux-aspeed@lists.ozlabs.org, asahi@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-unisoc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Michael Buesch <m@bues.ch>, William Breathitt Gray <wbg@kernel.org>, 
	Robert Richter <rric@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Message-ID: <oiwdi2r7fbay3dsghfaqzejpv7d5dpuerh5jy2vsw3kjyhvhdm@hyrpff5ytihz>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 11:48:37AM +0100, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> the original motivation for this series are the patches that convert the
> arrays to use named initializers, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the idea behind it. Looking left and right a bit while implementing
> that, the series grew a bit.
> 
> Changes since v3 (available at
> https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre.com):
> 
>  - Picked up review tags (b4 even found some from v2)
>  - Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-mpc5200.c
>    (My grep didn't handle >1 driver per file well), noticed by Sashiko
>  - New patch to use named initializers for auxiliary_device_id arrays
>  - Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.c
>    (My script doesn't handle of_device_id::name) and
>    drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 and
>    failed to notice that for v3)
>  - Fix code style of auxiliary_device_id array in
>    drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a script
>    for auxiliary_device_id before.
>  - Dropped a few broken email addresses from Cc:
> 

If there are no objections, I'll queue it by the end of this week.

Bart

