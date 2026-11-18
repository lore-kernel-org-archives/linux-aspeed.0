Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660D606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxYrnDyp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTypH2XjYz2y32;
	Wed, 18 Nov 2026 21:41:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794998519;
	cv=none; b=RSSpuOA5EmASNHz67Z2Yp7etXxZ06H1aX1TvD1S064a5x1eu+iHlSeZ5119Ule5Jjlj7oNtDX0jdy4nFGxrFjZ27LFR/1+V/PwsvBTYay4peOP0zp3DyGoSKpNTUcsz6k6nzQsYWmRvI90eRtmtDJieKWwWoHMXBYphc/t6pEZgoAvI0k273GGGnNZR69ghT7jFSzoPOzfcCb8Cl7U95mhY/zvVf53MREaX9L03MzQb8lu3fk5nFK/H6Iza55g7ydCqqCr7JYeGraNYpo0MkgtORNRTzofqK0iq2OD7bBMqLeaDR1vIWdbNvzns7Ix3MtmlThH4CzVui+l7M6v4whA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794998519; c=relaxed/relaxed;
	bh=sY+sAZbrr9MFv4Pz0Kc/4nMk77/MPigr7GAG+Y6LLrw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtCtbCMeFHhVcIXYwGcAdl6XxoEyh5yTed8FcKkP5A4jwInDKUj5Y2FoJyNGVKt13MmiIKYLNKtwLsPP146qU9hqeCHbOOAR7MghJ5LAGVxqXcFwxTp5OoqAL/LHNsbBWOyVvktQVCGlBwMlBjm5bRFJ4H9KhIZyTEHhGyd7mtytcgClDCsPuzrBV4t8FrQ6IbCEkA5ZOUT/ghg4H52nLk6hVRfdjEnDDNQqfoHVP50pc8/ZSAa+GAOqVHWbHm/AGZmCpPD+jnePUwFO2cEhMcgQa4OREgU/sRtlnbGORq8hGD4UavU/HORp8/jyO3lrAVxN2VfonK1uwievY7WDwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxYrnDyp; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxYrnDyp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTypG2ns7z2y2B;
	Wed, 18 Nov 2026 21:41:58 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4D60A620E9;
	Wed, 18 Nov 2026 10:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC87E1F000C4;
	Wed, 18 Nov 2026 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794998515;
	bh=sY+sAZbrr9MFv4Pz0Kc/4nMk77/MPigr7GAG+Y6LLrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TxYrnDypzM3e7JBSIBnX6AyKkQsKfwPrA2ry8lUYErmw0JQx/G6r0ttoymBx7BOsI
	 +4Rzx3e4tzmRz0NgS9WalY9CgjAQ1+jgJ9RXg6eDZbqtcqbarNOBAMQmMDCOJgBtGG
	 J1AFOpijvxM2Htv+gQshgrr9dWtcl1BcIF89mLPZAn0XRrZdYy0lqitEKV1B8pUXfz
	 C6le5T+lKrAuCnLO24LwFAcFoOvI2RRnFuhSBkFdNsGlgG3rFuWCLhm9EMgP+pR04I
	 kG0IKZhfATgM5jbDRYxYQ+rZTkFTH2LRoBdT5SBaNoFf9oVaaQf+JhXlGMnPeu/0b3
	 jWTdpSnCWZgVw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xTd6u-0000000HTLD-08Oa;
	Wed, 18 Nov 2026 10:41:52 +0000
Date: Wed, 18 Nov 2026 10:41:50 +0000
Message-ID: <868q2q1kwh.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peng Fan <peng.fan@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Tan Siewert <tan.siewert@9elements.com>,
	Eddie James <eajames@linux.ibm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Miodrag Dinic <miodrag.dinic@mips.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Qin Jian <qinjian@cqplus1.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Anirudha Sarangi <anirudha.sarangi@amd.com>,
	Tushar Nimkar <tushar.nimkar@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-aspeed@lists.ozlabs.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	git@amd.com,
	linux-arm-msm@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] irqchip: Convert chained handlers to guard_chained_irq()
In-Reply-To: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
References: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: peng.fan@linux.dev, tglx@kernel.org, radu@rendec.net, krzk@kernel.org, peter.griffin@linaro.org, alim.akhtar@samsung.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, ryan_chen@aspeedtech.com, benh@kernel.crashing.org, joel@jms.id.au, andrew@codeconstruct.com.au, billy_tsai@aspeedtech.com, tan.siewert@9elements.com, eajames@linux.ibm.com, florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, cjd@cjdns.fr, miodrag.dinic@mips.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, herve.codina@bootlin.com, chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com, vz@mleia.com, piotr.wojtaszczyk@timesys.com, anup@brainfault.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, samuel.holland@sifive.com, qinjian@cqplus1.com, changhuang.liang@starfivetech.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.co
 m, wens@kernel.org, jernej.skrabec@gmail.com, nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, linusw@kernel.org, michal.simek@amd.com, anirudha.sarangi@amd.com, tushar.nimkar@amd.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, imx@lists.linux.dev, loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, git@amd.com, linux-arm-msm@vger.kernel.org, peng.fan@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 14 Nov 2026 15:06:15 +0000,
Peng Fan <peng.fan@linux.dev> wrote:
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

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

