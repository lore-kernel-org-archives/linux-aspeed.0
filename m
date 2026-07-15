Return-Path: <linux-aspeed+bounces-4509-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A90C4451C
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:51:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DrD0dLvz3c8w;
	Sat, 18 Jul 2026 14:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784134573;
	cv=none; b=nLv2+DvTkCkobMoxT2duUyc4bXcWPcQXWHFACXq+zfJ87L3fmF/NGqGoxZUyv16NgJWtiQ+0khVHUhUyb66Wmp7t8uimnqqbMqPVJCSaIV6UfSFCyFDL3yQr1/OB98kB2GlhCH2s+zPb13d4YyEMbaGFVJRr2pNgiXpZRVC4QGdhhYYtFEKe/m1GReZBiSAJG3602KCGQAwrwCFe9smvI356E3DlXLnFAbV8gXceDmT9vHSPWKekjUABaUKetB3Rk1rnC46bFbj7zXgyTjTV7T2eruM1B0OiyyYZE4nCcS1OJt9BjhtuXXaTDeDOJT2eHcoUBsYscmOtqt9jZQtOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784134573; c=relaxed/relaxed;
	bh=dc9Aopu2Z728JKtTIyYoYTkFBGcLajEY2h1IaXFOYK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRjo/NiomCMwC2jmAXkBUVxXaToDcd32xInzkjK1tMGI62ifwbaWJxggi+yPw+ilmN5B6+DP+ZUuIzPXAc2040GAcsy/uEasbcuSgbHydyAotESLh53cxDHkAdY+N/mf60JJtIJh3EaqbF7hP8q55/JU7H4OwaAnSAIfoGPe2jgXuji6v+PLmh89RUwY1i30YU8kAEhnMWm80x9tSNmuZsfUKHkKXcSS/GSu1Aozqr7XNqCf6bhDVSBnR+JEh9zMxUIUKFeJmQBNnvxoXRwnHK0l5IrWfStuh2nl3pRq+93kQst1JKevbfG8S31lGNVVF4Zm2RQ4maKu9aaMNvyglA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MDaKDeZC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MDaKDeZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0j485ypsz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:56:06 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso42517695e9.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784134563; x=1784739363; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dc9Aopu2Z728JKtTIyYoYTkFBGcLajEY2h1IaXFOYK4=;
        b=MDaKDeZCd5lwAcRzrWhdzdM591PwtSK1CMDRQJ9NLT7Zuc2I7P4vaNsU0KnyFgoDGQ
         BCVhcQoY1lCgvODNBJFOOO3GSPcUCOlbkTRhMDs77fSigCGQnF9iQzGpICD89C657T1S
         xVa7ZQ/2QwhP4eiDsCXuBmeGTCE/Jf8IyfVBWtUWeXn2b956wUSxRHp79XuuoQNWLAvB
         R2l2rdhxO+9ovNshwIx2qnwwYX/7IhnRaymQD/JmJVAL4t7L8w75lNNpy43SJlW2Kmg3
         6bNz6oc2SvrxxcMXYknlu61HiFeLeDqmBi97aZOdPsK/bObt6GHE1EeFtdtX+4V1Iut5
         FozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134563; x=1784739363;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dc9Aopu2Z728JKtTIyYoYTkFBGcLajEY2h1IaXFOYK4=;
        b=tIvLsSTDQUQiMXmiIC4MxH97WdmdgcgounLD0ufiOY9lwQ4Pq9VXSt3zThq7j4Y4sl
         aEtdNELa1yjVpqnLiLMP3tDZiPbTNNLHpyoW1Po61KyZ/5vvHL6e9p5CjnU8P347FrCV
         wMAavbWPHk9YTz5jG/+SJWIsQ8jdXVS0Pgxyxfn8brs+02e1F0zVKG7B1MbXp6SOJXvD
         WkNaBSD/depufM6oUKIV5LHjjovACS5DgIOwRBGUgqVU8qc52Qa54cK1ZAgaynaRLp55
         8Qwjrf80uK6ieHXm9/9Q0WVuup3buE8A1pBqdDIWTS4Gz0JgS7D+aR2HyQ0hEURk4eSz
         U6+w==
X-Forwarded-Encrypted: i=1; AHgh+RrUrK/ZDc0ZPbZxndxEIZSBMFXYnFLuuXl8MzgLZXPd/SqWgV0UiNLlrBZgZdLlbcjWBZeFqktxJX/GhQQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywgo6M4BR7Xa6+DoXcCPH5E9WuPzrTsY5Mg2WRJDsMfK7036/p1
	9iIbTfJ5EWNZaArfn5DJgsRs5rEBHBqXRv3nzjqrt0HvMM0N5lchk9+da1glUuMDJpU=
X-Gm-Gg: AfdE7cksnOloc0Pf0jot7wv2MK4O9pIyN/V782oTDGGmA1LOwMVklkDvfajgIv0gFXP
	nhaWX4B0ZYgIIjCgdCuNAxdYy1M8pEHEdi6y63/wJzD5e/QazFjoAZVO/s1+B6wWLkXdBHlkR0P
	0vSd6acFiJCRNtdGKQ6hMCgpefY5vh7lm48RNKJ+H6Bc9d8Fq7nvMZhtXoMw9ytFt5QZnHzaPTI
	zJ/d4ZRJZC7yoL0df7jyn7xvLvWTF9yyiI6yZNaEz8jBNsYWPfzL0qsrwXH1+kCEVKKoLTpCq9F
	sQv1ykV51oeMmZ/sJV40sMdqKwROqreKGB+2Dad9uDaWma4yaazH7rW9PQ2hmyMr5o3Xx7j+7On
	E9UFJSACkl/i07UQziVEQDZU7ul3+rlP70AuR8xPZoXvupx+9m3ohHhIQyLO69sH3GIsDYPhNQP
	0AhjLLRAuZ+XE8vj7tokH0IXQhdO57CTTs805nadbSfAOLPeXY3NhBZ7zqcpopV8lTgsJbQYzaz
	5o=
X-Received: by 2002:a05:600c:350a:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-4953c28868emr41628395e9.34.1784134563454;
        Wed, 15 Jul 2026 09:56:03 -0700 (PDT)
Received: from localhost (p200300f65f47db04249e031dea91a10d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:249e:31d:ea91:a10d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4953c6ff429sm47318815e9.1.2026.07.15.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:56:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Imre Kaloz <kaloz@openwrt.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Alban Bedel <albeu@free.fr>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matt.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Doug Berger <opendmb@gmail.com>,
	Keerthy <j-keerthy@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	=?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Michael Walle <mwalle@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-aspeed@lists.ozlabs.org,
	asahi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-unisoc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Michael Buesch <m@bues.ch>,
	William Breathitt Gray <wbg@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 00/21] gpio: Improvements around device-id arrays
Date: Wed, 15 Jul 2026 18:55:05 +0200
Message-ID: <cover.1784133987.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8054; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IWUCunGUaTCNiIjJZFExRrEmVa81OfH9Xay6Y9Sp9+8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqV7tpcWa4IDqdHE07WRN6KbaBUpPQqFeHKz38l NPYom/XImOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCale7aQAKCRCPgPtYfRL+ TtTaB/wMHdo4jeTAu8TDocMrZIkg854g5QFjcfbVE54N17jnr4AIRFzaeHw5Ef3dkM+guUxSwmj F5MR8eG3l1tF9YtUNmlhbx/vfxy40WhQn9DtmnjtWzwMlcrq2Bx1Qy3dAIUKRmWu8OBHmQoLETO JQ4Z0G/Aungdh91TZCoSgDUdjGBT9AqikXKikNh82DMEMiG8tx14PL5vabsoJ+RX+kgTyt3svCn U25sKCqazurzcIFFDvuLBrl46NkLy88JS0XSCIhIpvTjh0oHlkKksNl1o0uzGB+W2A9BEDa799A SZq7t3HXFBTrZVb4r5+uP0V69VjegzndPUWsZzWqJxaovWlm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

as with v1 the original motivation for this series are the patches that
convert the arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Then by not closing the eyes for small issues
spotted while working on that, this series grew a bit.

Changes since v1 (available at
https://lore.kernel.org/linux-kernel/cover.1784013063.git.u.kleine-koenig@baylibre.com):

 - Trivially rebase to today's next/master
 - The first two patches are new. My script didn't match on device-id
   arrays that are marked with __maybe_unused, so the drivers touched in
   these two patches are adapted further down, too.
 - Fixed capitalisation of PCI (Andy), did the same for ACPI
 - Sort the ACPI device-id arrays by .id in the "unify" patch (only one
   instance in gpio-dwapb.c was unsorted), suggested by Andy.
 - Found a few other inconsistent device_id arrays that my script didn't
   match (due to .driver_data not being a single expression or a comment
   in the terminator or more than one array in a single file)
 - Fixed cast expressions in drivers/gpio/gpio-mvebu.c to please
   checkpatch
 - Dropped the dmi MODULE_DEVICE_TABLE patch
 - Added review tags from v1

Checkpatch only reports two undocumented device-tree compatibles. I felt
free to ignore these as this is a pre-existing issue and out-of-context
for this series.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (21):
  gpio: Remove __maybe_unused annotations from acpi_device_id arrays
  gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
    array
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: Add missing ACPI module annotations
  gpio: sodaville: Add missing PCI module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
  gpio: pl061: Use empty initializer for amba_id terminator
  gpio: Use named initializers for acpi_device_id array
  gpio: Use named initializers for spi_device_id array
  gpio: virtio: Use a named initializer for virtio_device_id array
  gpio: pcf857x: Use named initializers for of_device_id array
  gpio: Unify style of acpi_device_id arrays
  gpio: Unify style of of_device_id arrays
  gpio: max77620: Unify style of platform_device_id arrays
  gpio: Unify style of spi_device_id arrays
  gpio: Unify style of pci_device_id arrays
  gpio: Unify style of various *_device_id arrays

 drivers/gpio/gpio-74x164.c          |  4 ++--
 drivers/gpio/gpio-adnp.c            |  4 ++--
 drivers/gpio/gpio-aggregator.c      |  2 +-
 drivers/gpio/gpio-altera-a10sr.c    |  2 +-
 drivers/gpio/gpio-altera.c          |  4 ++--
 drivers/gpio/gpio-amd8111.c         |  2 +-
 drivers/gpio/gpio-amdpt.c           |  8 ++++----
 drivers/gpio/gpio-aspeed-sgpio.c    | 10 +++++-----
 drivers/gpio/gpio-aspeed.c          | 10 +++++-----
 drivers/gpio/gpio-ath79.c           |  2 +-
 drivers/gpio/gpio-bcm-kona.c        |  1 +
 drivers/gpio/gpio-blzp1600.c        |  4 ++--
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  6 +++---
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  8 ++++----
 drivers/gpio/gpio-dwapb.c           | 14 +++++++-------
 drivers/gpio/gpio-em.c              |  4 ++--
 drivers/gpio/gpio-ep93xx.c          |  1 +
 drivers/gpio/gpio-ftgpio010.c       |  3 ++-
 drivers/gpio/gpio-fxl6408.c         |  2 +-
 drivers/gpio/gpio-graniterapids.c   |  4 ++--
 drivers/gpio/gpio-grgpio.c          |  2 +-
 drivers/gpio/gpio-gw-pld.c          |  4 ++--
 drivers/gpio/gpio-hisi.c            |  6 +++---
 drivers/gpio/gpio-hlwd.c            |  4 ++--
 drivers/gpio/gpio-imx-scu.c         |  1 +
 drivers/gpio/gpio-ixp4xx.c          |  4 ++--
 drivers/gpio/gpio-ljca.c            |  4 ++--
 drivers/gpio/gpio-loongson-64bit.c  |  4 ++--
 drivers/gpio/gpio-lp3943.c          |  2 +-
 drivers/gpio/gpio-lpc32xx.c         |  4 ++--
 drivers/gpio/gpio-macsmc.c          |  4 ++--
 drivers/gpio/gpio-max3191x.c        | 12 ++++++------
 drivers/gpio/gpio-max7301.c         |  2 +-
 drivers/gpio/gpio-max7360.c         |  8 ++++----
 drivers/gpio/gpio-max77620.c        |  4 ++--
 drivers/gpio/gpio-max77759.c        |  2 +-
 drivers/gpio/gpio-mb86s7x.c         |  2 +-
 drivers/gpio/gpio-ml-ioh.c          |  2 +-
 drivers/gpio/gpio-mlxbf.c           |  6 +++---
 drivers/gpio/gpio-mlxbf2.c          |  6 +++---
 drivers/gpio/gpio-mlxbf3.c          |  4 ++--
 drivers/gpio/gpio-mm-lantiq.c       |  2 +-
 drivers/gpio/gpio-mmio.c            |  3 +--
 drivers/gpio/gpio-mockup.c          |  4 ++--
 drivers/gpio/gpio-moxtet.c          |  4 ++--
 drivers/gpio/gpio-mpc5200.c         |  9 +++++----
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++++------------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           | 13 +++++++------
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 +++++-----
 drivers/gpio/gpio-pca953x.c         |  4 ++--
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++++-------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 +++++++++++---------
 drivers/gpio/gpio-qixis-fpga.c      |  3 +--
 drivers/gpio/gpio-rcar.c            |  2 +-
 drivers/gpio/gpio-rda.c             |  2 +-
 drivers/gpio/gpio-realtek-otto.c    |  2 +-
 drivers/gpio/gpio-rockchip.c        |  4 ++--
 drivers/gpio/gpio-sama5d2-piobu.c   |  2 +-
 drivers/gpio/gpio-sifive.c          |  2 +-
 drivers/gpio/gpio-sl28cpld.c        |  2 +-
 drivers/gpio/gpio-sodaville.c       |  3 ++-
 drivers/gpio/gpio-spear-spics.c     |  3 ++-
 drivers/gpio/gpio-sprd.c            |  2 +-
 drivers/gpio/gpio-stmpe.c           |  2 +-
 drivers/gpio/gpio-stp-xway.c        |  2 +-
 drivers/gpio/gpio-tegra.c           |  6 +++---
 drivers/gpio/gpio-tegra186.c        | 26 +++++++++++++-------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 13 +++++++------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 ++++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  4 ++--
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  2 +-
 106 files changed, 265 insertions(+), 247 deletions(-)


base-commit: b8809969e1d7a591e0f49dd464a5d04b3cf02ab1
-- 
2.55.0.11.g153666a7d9bb


