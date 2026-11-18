Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3ED606A333
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lvlw2APD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVGhM48l6z2ygg;
	Thu, 19 Nov 2026 09:37:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794988205;
	cv=none; b=hxzu6oX8iyrLXOw/qPYG7aevY686p2spddeSwxsj8LNQ9EiuIet6LOSpQg/Anp/HEIA4ddsaojLODRHj8qa7ntNYPpDfVhAPC3fN6N80bF6FHPPktq8CtLPro4ch8lQPY5LpRAtLWa8tlb9gSpH6nUcX2SN6dgnjT/UgnKtBjqiF6fFX+SoUusNW6V9BIvieJCRMcfW7dhk6O17r/U0NysLNKWkNS/ZLxkttkP/EVZgTlZ5jJ1kNUvWRyXN9tuaXpihG1LoHTTdNEC1l2XcaELnPBB5sohrqEx3lX29c5ChDThuFjImzPeOmJXdau8lrXHwM82WOKeByloZ+N6NxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794988205; c=relaxed/relaxed;
	bh=5tdOi87MUQVrh0lDnm0y5zaT0nPUT+qlg7v5xkEiqMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr7mgfCR0Wfk+f/2Rzr6Sk83P0NvTkssTCCK63eKHM9KhDjq9AOCzQnpq7oZHfAjkzr5KLJGlNO9I2ivZ67UtpP7PllLqpA++LyqC4V0HLP7NXJ6xDQIWgOk9evqp8wxgSZOx0IjPw9ybdmOqyBRA1MHCnOizoACZgSji3qxEBSGnq+//OhpAJaIrxcTWZhnSuCMKLCDX8z00RPwJvqDePX3Udoh1z1mrFRMuZ4ywP3WyubNtlmrVsoMlAR9xaG+HRff34o2UO6e5B54A7Y4sWHHI5LxEtWJUsX3opWH35QZf9aqN4i/GR2bK6brQz2NKHeqaxV0833cifij5vta6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lvlw2APD; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lvlw2APD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 382 seconds by postgrey-1.37 at boromir; Wed, 18 Nov 2026 18:50:03 AEDT
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTtzv6Qglz2yMK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 18:50:03 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA76CC4CBD8;
	Wed, 18 Nov 2026 07:43:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DE395FE9B;
	Wed, 18 Nov 2026 07:43:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77C8D11BC076C;
	Wed, 18 Nov 2026 08:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794987811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5tdOi87MUQVrh0lDnm0y5zaT0nPUT+qlg7v5xkEiqMk=;
	b=lvlw2APDkLOsWdPZXrcTGO0SBvJt5AeVKx0Z42miklOsc8vPctTcjUfLvtwVkHahSrHPLo
	CGkq45BFyuEH8fedQgM6HJ/XMbau2Rz9aKP/PJ7PtvuBj2hMJXvtJKDgvO7p6Q3pjLfN6i
	0Ut1+LTYYEyg77hZo16dxZxUGEgStz4MKBFw9hj/2Tiw4koxWXy5yQ8yIHNJQ0YwvKbt02
	l/18CHS5c8YF9Wb/y9UNTxVZrOZMCPnkOtQCGZPI3/uD2p7Qv4dv6TVs+LHq5iTBVHSMvU
	434h8Tsq1BRLh2Btis1Fush6eJ7xmbr9hxqVcPbs2tV0AeddsTbxh0K8Mz1lOg==
Date: Wed, 18 Nov 2026 08:42:46 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Peng Fan <peng.fan@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Andrew
 Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Billy Tsai <billy_tsai@aspeedtech.com>, Tan
 Siewert <tan.siewert@9elements.com>, Eddie James <eajames@linux.ibm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Caleb
 James DeLisle <cjd@cjdns.fr>, Marc Zyngier <maz@kernel.org>, Miodrag Dinic
 <miodrag.dinic@mips.com>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>, Anup Patel <anup@brainfault.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland
 <samuel.holland@sifive.com>, Qin Jian <qinjian@cqplus1.com>, Changhuang
 Liang <changhuang.liang@starfivetech.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Nishanth Menon <nm@ti.com>, Tero Kristo
 <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Michal Simek <michal.simek@amd.com>, Anirudha Sarangi
 <anirudha.sarangi@amd.com>, Tushar Nimkar <tushar.nimkar@amd.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
 linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev, git@amd.com, linux-arm-msm@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] irqchip: Convert chained handlers to
 guard_chained_irq()
Message-ID: <20261118084246.5b5bf203@bootlin.com>
In-Reply-To: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
References: <20261114-irqchip-cleanup-api-v1-1-4a9d598b0bdb@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng,

On Sat, 14 Nov 2026 23:06:15 +0800
Peng Fan <peng.fan@linux.dev> wrote:

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

For the irq-lan966x-oic driver:

Reviewed-by: Herve Codina <herve.codina@bootlin.com> # irq-lan966x-oic.c

Best regards,
Hervé

