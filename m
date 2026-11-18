Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E37606A320
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxwDW1Jg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV2ss1x6Wz2xdX;
	Thu, 19 Nov 2026 00:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795009521;
	cv=none; b=LQ8eIu/SdDQN2nkhFRakKJKuLP7zKdwDPmm6Gs99DQ2yl+c7MoXaMG5LFqfYEUX6JlPLjuLqxSb6x5XkesvhI0iUIKnNMoXphVjZZN3+IkwN1tlr5Ve77618FWh0eeEU8eYhc6LEDtWTo9OHPXfoxCPtsTJJjF4CJxOwS3mFa5m7Z2YnG0LYpscRoPuR62VZwyySPlwexSN+yyuknkRlFkvkO3FWSkZzhZ5WswK2dAp06YV0C+OBIagX8vvKCYmt4ERr1vfVt9zYPONfOf1ocqYkI0h7i1htXn5CJeSsqBKUgEVLoMtLWNpcRoOxGyDNljpq72UtlS1Wo844N6yYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795009521; c=relaxed/relaxed;
	bh=zbYI8uP1li72NzJh/wjWDJ72bmhe8G4M88p9Kdrkgp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9O7zABG98cBjQ8VFSR9QwCB+U8dPBPUFVB89Z2pLKuqtpW67p4gbELnT/Cr6O9LnVyuhIU1B9IAy1G2cpCdnEtfqP5q1gYAu4Yn7OSukMez4TFzTri4mT+YUkmB3iY4RqlgBUXU/YW1P3hgshUHtn//t/4mEXJZtrGnnZkUDhRsiGNQWpVxsstT5j8s0GM9wQwxlfYeR/5BY09zYzxF/GMGg8FRhhcgqOXu8a2xp90EVthSA4dHUDb+POhKG9a6EUvjmp5fYvXQAaFPH6oAAftUldBtEICAfO78HwsZSqJOKO3iptESRGTXuD+UciPY8JaY+xEALGQibEZ4m2tDPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxwDW1Jg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=wens@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxwDW1Jg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=wens@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV2sr3L7zz2xL4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 00:45:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2AA3245D21
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 13:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D94D1F000C9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009518;
	bh=zbYI8uP1li72NzJh/wjWDJ72bmhe8G4M88p9Kdrkgp4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=RxwDW1JguCDucDNsShayzwrpopd1ZL9Qf2ZCAagnmVvg0zW+stUUkU79tiVnQB/Zo
	 Pmp7J5O40OKniL5gftISQKy3xeMQgqfUbNtMIYx/OgRyH5+WyU2VySZ2IsBbRbmLyD
	 Lcv2pp9ib1bXBYNArl1iETwXLKN6wdgElDCYFpz/BMJc+rZuNQ37QytMx+d2WMCe0H
	 FOrOeLU8pFP47A4NCAla2ZZdXV5MbYDeQMlL1zoWCPwvU6TpWK/+ZlW3NnD/6hU3zj
	 TjvzFKfPvmXqp86SHZoCLdg9t9YdEaZ5DJG81/QUfM4q8+rzPhOD6DXr9sxVvO3l1m
	 hi3EWHj5PIRRg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3acd239776cso10201831fa.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 05:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFv70awO+suwQ25B8/kf6it2cRm1JtnA73LNjiRejzrsPPo8i3KiC7dRtXanVSf+cquDDca6gtfYcKYj/M=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9xF56XdLavTRguLvpk3RDJ5uTNSzPH1Y3A49opVrvNpoTrKeGA
	034yLfHD0IYnc2ISut1SMjkEUwY2GcnTb9J0U5KCAhWcLAygAgWztzWZ9pN/bbJ6qsnpAn30tF8
	tdEsxJnbDfe52p2E2R9BnFkubYxsJiMw=
X-Received: by 2002:a05:651c:b27:b0:3ab:3b73:4560 with SMTP id
 38308e7fff4ca-3ae670b2ef1mr8658421fa.11.1795009516447; Wed, 18 Nov 2026
 05:45:16 -0800 (PST)
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
References: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
In-Reply-To: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 18 Nov 2026 21:45:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v65uyYnE-sryit44oXBwstxkG7HRtYWip5nyuHeZ034TbQ@mail.gmail.com>
X-Gm-Features: AclHuK_Ko1utGgb-Cp6pja7wJidoLs_raftCWPKZ3OajYizpg1rSK6L9ElxDv8s
Message-ID: <CAGb2v65uyYnE-sryit44oXBwstxkG7HRtYWip5nyuHeZ034TbQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Convert chained handlers to guard_chained_irq()
To: Peng Fan <peng.fan@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Tan Siewert <tan.siewert@9elements.com>, Eddie James <eajames@linux.ibm.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Caleb James DeLisle <cjd@cjdns.fr>, 
	Marc Zyngier <maz@kernel.org>, Miodrag Dinic <miodrag.dinic@mips.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Herve Codina <herve.codina@bootlin.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, 
	Qin Jian <qinjian@cqplus1.com>, Changhuang Liang <changhuang.liang@starfivetech.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Anirudha Sarangi <anirudha.sarangi@amd.com>, 
	Tushar Nimkar <tushar.nimkar@amd.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, git@amd.com, linux-arm-msm@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 11:06=E2=80=AFPM Peng Fan <peng.fan@linux.dev> wrot=
e:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Use the scope-based guard_chained_irq() helper in all chained handlers
> under drivers/irqchip/ so that chained_irq_exit() is always invoked when
> the handler returns. Handlers that duplicated the exit call on an error
> path or jumped to a common exit label simply return now and rely on the
> guard.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> With [1] now merged in irq/drivers, convert the chained IRQ handlers in
> drivers/irqchip/ to use guard_chained_irq(). This removes the explicit
> chained_irq_exit() calls and the gotos that only existed to reach them,
> reducing boilerplate.
>
> I use a script to do the job, and after that, do mannual checking.
>
> No functional changes.
>
> [1] https://lore.kernel.org/all/179417458323.2093942.14330197609841896598=
.tip-bot2@tip-bot2/#t
> ---
>  drivers/irqchip/exynos-combiner.c          | 7 ++-----
>  drivers/irqchip/irq-aclint-sswi.c          | 4 +---
>  drivers/irqchip/irq-armada-370-xp.c        | 4 +---
>  drivers/irqchip/irq-aspeed-i2c-ic.c        | 4 +---
>  drivers/irqchip/irq-aspeed-scu-ic.c        | 8 ++------
>  drivers/irqchip/irq-ast2700-intc1.c        | 4 +---
>  drivers/irqchip/irq-ath79-misc.c           | 5 +----
>  drivers/irqchip/irq-bcm2836.c              | 4 +---
>  drivers/irqchip/irq-bcm6345-l1.c           | 4 +---
>  drivers/irqchip/irq-bcm7038-l1.c           | 4 +---
>  drivers/irqchip/irq-bcm7120-l2.c           | 4 +---
>  drivers/irqchip/irq-brcmstb-l2.c           | 4 +---
>  drivers/irqchip/irq-dw-apb-ictl.c          | 4 +---
>  drivers/irqchip/irq-econet-en751221.c      | 4 +---
>  drivers/irqchip/irq-gic.c                  | 6 ++----
>  drivers/irqchip/irq-goldfish-pic.c         | 4 +---
>  drivers/irqchip/irq-idt3243x.c             | 4 +---
>  drivers/irqchip/irq-imx-intmux.c           | 4 +---
>  drivers/irqchip/irq-imx-irqsteer.c         | 7 ++-----
>  drivers/irqchip/irq-imx-mu-msi.c           | 3 +--
>  drivers/irqchip/irq-ingenic-tcu.c          | 4 +---
>  drivers/irqchip/irq-lan966x-oic.c          | 3 +--
>  drivers/irqchip/irq-loongarch-avec.c       | 4 +---
>  drivers/irqchip/irq-loongson-eiointc.c     | 4 +---
>  drivers/irqchip/irq-loongson-htpic.c       | 3 +--
>  drivers/irqchip/irq-loongson-htvec.c       | 4 +---
>  drivers/irqchip/irq-loongson-liointc.c     | 4 +---
>  drivers/irqchip/irq-loongson-pch-lpc.c     | 3 +--
>  drivers/irqchip/irq-lpc32xx.c              | 4 +---
>  drivers/irqchip/irq-ls-scfg-msi.c          | 4 +---
>  drivers/irqchip/irq-ls1x.c                 | 4 +---
>  drivers/irqchip/irq-mmp.c                  | 7 ++-----
>  drivers/irqchip/irq-mscc-ocelot.c          | 4 +---
>  drivers/irqchip/irq-mvebu-pic.c            | 4 +---
>  drivers/irqchip/irq-mvebu-sei.c            | 4 +---
>  drivers/irqchip/irq-pruss-intc.c           | 4 +---
>  drivers/irqchip/irq-realtek-rtl.c          | 7 ++-----
>  drivers/irqchip/irq-riscv-aplic-direct.c   | 4 +---
>  drivers/irqchip/irq-riscv-imsic-early.c    | 4 +---
>  drivers/irqchip/irq-sifive-plic.c          | 8 ++------
>  drivers/irqchip/irq-sp7021-intc.c          | 4 +---
>  drivers/irqchip/irq-starfive-jhb100-intc.c | 4 +---
>  drivers/irqchip/irq-stm32-exti.c           | 4 +---

>  drivers/irqchip/irq-sunxi-nmi.c            | 3 +--

Acked-by: Chen-Yu Tsai <wens@kernel.org> # sunxi-nmi

