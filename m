Return-Path: <linux-aspeed+bounces-4892-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB21C61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 07:22:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYy4N1HZ3z2yCL;
	Tue, 01 Sep 2026 17:22:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788247364;
	cv=none; b=C8uBl0Fsa2xYZZ0bKWxjEsMDY+qrSCXGyLu8p+d/E5lkK6uGtAQyb5ZF64UrrQzwPsbpGElFOy2IEC0izr95ZuLwgy0KE4gLpb65I66+RCh7WhYBim4ia1snYEEcbUMi+0Ztztc/b6eM8pDrOO5WA6KUkdpwkEgHpS8pzGBJrx19jRYzzjZlhg93Y2SalludBBhXIHZLl/BGiewqHQ760KpNoT8tBK57SuyrJfwFMdOXo2gNeEBTVk8i65n9DfYfTytOVb9n53WyWcto8zHn+IEiejVnrZSo28Zr+xrePG5nZcLMTyEyC1s+g8r2exl1Ksc8AmAbdLsUDvBPVeS1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788247364; c=relaxed/relaxed;
	bh=jx+XoqcBBsA+m2qrM8HxfQHaaz8x8crvSJWq14ITrJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDYKpZllv57NeT6kZBkOPHkLpuhNMV+WVKxZue0O9ZSKOsdw79sTDWuDGzGUgKE9qeSJtV8gfGAA1ZA64mcrWJTTmEfLEPkY0bnGUdHWoSuFsy5qO/TZVMd3oreUPY/2a3L/f5+jX3Tq3oDpp36QCdeYt3w3ITs3ZawkcWCy3MDvuoj+7lCh6Cl1nevobmpd6snVWA045Gp6mIZT3erTcnanou4EwI2M0M1RxM7f2+QhdEhB+r1zNj53/HYlGrv9IoUGJXjcU4UhI7pRj5LR8gnuAnkyw27+xOBVQMq/O6Wj2a44b6qf8qkUhQsqUm2CswpcCvvK0PeLlPDfwBmInA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.219.51; helo=mail-qv1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.219.51; helo=mail-qv1-f51.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYy4M2nQmz2y2h
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 17:22:43 +1000 (AEST)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90cc372d6b2so40768846d6.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 00:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247360; x=1788852160;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jx+XoqcBBsA+m2qrM8HxfQHaaz8x8crvSJWq14ITrJ0=;
        b=HF+BDTW5GG1B8oOHc5lfJN5ebuBZSQnBayaiutdavHj0Yy60FgDNqEXJbRBqEIgyIz
         yTkMvidZXFvpJGs71+4iHf/ptvIn/C/A1s6jIHh2s2OYAMoVh0ZeAUKRCDT0m0mUVTaX
         7Z1wG9ab0ep6EeMgNrhvQLE1FNLe93QEb7XUCiH1uA7pHXwEL2gixX3fkDtLtr/iWYBZ
         pgFccj5IDlSxA+nmNgXh+ry2PHEJxLXpXPhPTkOxUEXnljU/clktsBAG54BXCMazPPQx
         jjXSe0npV503cVQCSYxqK9AzRKURcZ+O6p/1YhSTRCtHzl34sNCum8Lkys3vhrlLQs9N
         xc/g==
X-Forwarded-Encrypted: i=1; AKwUvBzGEjugvpEj32HnUxT9ZUzvZ9YCGlkrEp8/377uqt7+6J1Sa1Ppqc48c0v8ZZC0OUBGWBsWK0mE8ug30I8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kqGe4G0NnT/Ge7p3EGp9ogaDB9YbqOC7ag8Ch0KPWhCAG79ce5
	x5UQm0xZOZXnfwfcrnGaPegNmQe3CIhklWOWcNOnc+Bf9DIcuCd8el6ErdM2gqm6
X-Gm-Gg: AYBFou2LkUJsOs3MHEE1bfNJlOoVpF90Ukpm11wnvDDyMJaG6+gGU2hPpQc9f0BjAxJ
	ms+Mil64tYYJfsRTH/zOk+jjM1DzP7pJ6epBybNIEybOGZBs0WQAHyq/vAg6V7V6+Wrf92fykGP
	MiDMicANHrjBhHU+esinPn9aACQg73xkSh66W+v+0cljLOVShQL9OTWnrM2Ni4fyktQ+aIq4SqQ
	m9IDDv6JAIBZHfGXodcUvDZayStWgvZhi8orl/xyrOtoyIgp6ZQpPcI5lAkm3PPwb2nQD5ReRW+
	pDNVhmDfR/YNKu/mRCWi0EjTLcaBvVNk3NrF/ZZnp9BeioYXDnqUCc/VRbTlrelaQxLxNioK/SM
	yEYnot/MoUrVDNAhLw4khT9mhh3NVyqirue1WGunrTtQXQYvOv/s7Bb3VyxdehqphgEgSgXhOYd
	ljcgcOcuuwQ8jiY1Ag5jiiaBgefkU6ANOAXPRMQoI9ZRVY4QGOd5Zs4B7FI7t0pINARrJksvNj+
	tN3dl8VCZRgiAAbR7/pyOKf/A==
X-Received: by 2002:a0c:f09c:0:b0:90e:95d8:93b5 with SMTP id 6a1803df08f44-90e95d89422mr42945006d6.18.1788247360419;
        Tue, 01 Sep 2026 00:22:40 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce444e06dsm102655506d6.3.2026.09.01.00.22.40
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 00:22:40 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90e95a18c92so8722406d6.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 00:22:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwC45SR8vutZzRBlZiwz4mvVGM2gPfHfOnXmtgC/FbBHO8AZkGvAmeFsrckFBcV+AmuW5mg9PlG3j+EoNA=@lists.ozlabs.org
X-Received: by 2002:a05:6102:a50:b0:77e:6f90:4aad with SMTP id
 ada2fe7eead31-785962b2f0fmr9912673137.2.1788246874251; Tue, 01 Sep 2026
 00:14:34 -0700 (PDT)
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
References: <cover.1787239813.git.geert+renesas@glider.be> <apWfW5ahiYagw0OR@redhat.com>
In-Reply-To: <apWfW5ahiYagw0OR@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Sep 2026 09:14:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8YidsoHudY54RQW4J=G446WNgRG6Q-P5f1YEHd3sHkg@mail.gmail.com>
X-Gm-Features: AcwNN1V5M0ZQ_v_xaH6RI1jedVGh-HNyKWbpGWR_Rc-YS9IPBF0NOfuHqPh0NM0
Message-ID: <CAMuHMdX8YidsoHudY54RQW4J=G446WNgRG6Q-P5f1YEHd3sHkg@mail.gmail.com>
Subject: Re: [PATCH 00/45] clk: Make sure clk_init_data is fully initialized
 (part two)
To: Brian Masney <bmasney@redhat.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Linus Walleij <linusw@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Cristian Marussi <cristian.marussi@arm.com>, David Lechner <david@lechnology.com>, 
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
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

Hi Brian,

On Mon, 31 Aug 2026 at 17:36, Brian Masney <bmasney@redhat.com> wrote:
> On Fri, Aug 21, 2026 at 10:53:10AM +0200, Geert Uytterhoeven wrote:
> > The clk_init_data structure contains several mutually-exclusive members
> > for different methods to specify the possible parents of a clock,
> > prompting drivers to initialize only the members they need.  However,
> > not initializing all members may cause subtle issues, which are only
> > exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> > enabled.
> >
> > Hence this series aims to make sure all members are fully initialized,
> > to avoid such bugs, and to prevent future breakage when converting
> > drivers to a different method for specifying the parents.
> >
> > Part One[1] fixed all cases that I identified to be real bugs, in
> > response to a crash I saw on BeagleBone Black.
> >
> > This series is the clock subpart of Part Two, which fixes remaining
> > cases that are currently harmless.  These are still fragile, and may
> > cause future breakage when converting drivers to a different method for
> > specifying the parents.

[...]

> 44 / 45 patches have been added to clk-next. I took it all for simplicity
> rather than everyone trying to cherry pick just their parts.

Thanks!

> Geert: The only patch that didn't apply was:
>
>   [PATCH 27/45] clk: renesas: Make sure clk_init_data is fully initialized
>
> I didn't look into it too much.

No worries, I have queued it in renesas-clk for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

