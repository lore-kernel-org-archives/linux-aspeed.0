Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC0606A31A
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ovDlljDR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD7vG4XfPz2ySl;
	Tue, 27 Oct 2026 09:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793032173;
	cv=none; b=c+c1ZPm6SQEdiAhRrHGF0deof3ifx1x4UwTYaL8/+IVo7ligFh8buKghVJNb0Q5pXrSy1JBUxpjAo1wOYgAL+GhUcwvF9I2dDP2IfXGb8ihedNc/I8y7mjPK4uqnf8DhaLD6gb6uNTtQpKZmhsH6HHyH+JcUKaqU000b6wUaTRxIRFgwCW/C/8s4clfuxHNr5Nox1/M3pHFBF7gIyHridE5ognxc6HPZYL7leP4kGlsBfB6RaTd9pCatYP8FKfSLyfu0zgtfdfp4JhtR66k5UFPtyGsAmAdyTJW//qfa7JX97qJ2IUiwuwnb8kIFO8ggu07Zvgzq1QvHxJwa67iHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793032173; c=relaxed/relaxed;
	bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aFdKq1BpyuTSBiCmVhxkwqVnGpDbm3X7YlXXCiqy/qrrVHpbaX3tvVRv/k1vetf/pR0h+uEPgELMPIuH4zydMjsIu0N2EPFjc4zvHSUtGQ5wY13v5KbDAJmjuL3ZG3p/CigKZ+8h4P8DB/qI8DY5NuRL9fXGc4zh5lanENP1f2/kd8l1xyB3q6TZZOVnZ6qH11TQJ5kInk0qu6CzvTYjNTvxqwwrkaJLK8PuaVgkjgK/leVz38Me9EzfM/4YKrMS/qlagRgJ/HqF6XsDXk/FAqy0TXsh4CIBT6c4bZUSQ1DjfUs1FhTSWy2GVpRbvuBHwretE4nw2zQE2oIpuIkVCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ovDlljDR; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ovDlljDR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzbr74znz2yRn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 03:29:27 +1100 (AEDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so13862925e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032163; x=1793636963; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
        b=ovDlljDRL+H/teeQ9l6U4KYBzpmhJbaM5CxjsdQMTbw7cWP+DJ+LvC/iE40c82yvns
         wnllhg0X9/582KqrW5a3yUqB403rloyMN1t4eLHm1z+50twLUJ3F3gDgpMPfHibzBRXr
         +na0dP1g3OSMRmRCIRYErj+3fzbM+tYEE3Vh4wAI4GfWV10mPEIZyoixMEPbj6OcQIqA
         EjrLyT1xbYAFd8CNA9+WWMW2roAx78kLXmzbYXHUN2TurTvKrH4bWNpUeluPV0xUozka
         DV9Vve9nzZzpJ3aLKK2pcD0765gGbtWFvLU4CrUBEkEb7Rm2Iq1EzKPnPEUgnHIK5HBq
         aBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032163; x=1793636963;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITqbDSTjwjfbrrpkyujx4v8CTbfspgT4IGjU+cO6egY=;
        b=YpyRMQi25AaQDTpCG9ssYNS0b3fBLTYm0sQFjd4Gwy08isHjZ1rg+2ExkQv3vTnd7k
         BPP30pBt7Fjbwc8WAjc2OsQ8jkDfdABTSGHKd9D9V5M68dF0xUmBHkINUbaIZ88MGko4
         TXkj6k5YmMjPt9ldXQFm4RbpxU7b3gpTnr4ONBv6flFruEzIDQ/zfs+WtfALGz5VSbY7
         FP4vtZEH2oiK9WGIn5AjEi7TqKS8KGJIxBFNVQsPwQ0VQXFTxSrYQpNzK+3MuxgwvEee
         XpwRqKkpOmEXrkQBPrIoZ3sLIreldGH19cxhnqQhuTJjFcP6jFUA8DE+baK4w2Dqw4R4
         IMUA==
X-Forwarded-Encrypted: i=1; AKwUvBxuNANB3o0Y7aZOPezwwxx89PBUhY1b7upgeUeMgqHeqlJn6BcNMP4xb/fn/rE9Zd14mUbxTgjg0QvnJuU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLLMKMwZOXsjcOjLHun/626Yh/+MeHCuoQV9SYDLm4RBiFx3Q5x
	gkLQdARqUWFzzANZLlxcPvTdHl0aB9g30TL/znmybQ8Zg7plcQ+2/zzoDY163VHmkdk=
X-Gm-Gg: AYBFou23o5mjunrqcJki3R3WSFmT1AivzYsz872nPvf2fW5GobMZXoKsV0WYs9+vISi
	aLyNoniwN0urkzL3dMbbQMnqs71GNTGi5KLS7AEvSsLlg5dCoNd+62fqh3Ycr+4bQ3Tu3aXz9E8
	IacBcTJS/1NikAEZudHKekBukwBaRLXByJyvxmkBseku8R+LjI6o7aqI3VPtAn1n+iJ4ekOmb+3
	Y/DUW2JblRlELu+5OFdyGpfJR5q8yFR6A6Gdg6pQjyX+vgYkaUpZk2pXuD/yv3SkDQMvHTmxU4L
	OQnKwAFzjrO3bzaJ/9vR7MI7f3c0YdUs0GFDhPErmdGvliK/1ro6ZxOPHew06tNQ0Hom9WOBrf/
	mXcQct4IOqeMqw+EEhhyE/zr/iX2rswQjRcYlpS87PdPe8X/VyXBq6a+nLK+RlUOaS/76XT06dM
	2J4UIzrLmVNZeUfNjazHWFdxneqS61WQkJt9hnZaOJLL+W0QwBhM8cA9iVY8PvPM4OOJvcT0hUf
	sBAZdDkdvp3le+FW2azD3bnD8AQCEUo2MQtt1f58a3s4qdjMB2Kw2xdBuj5xItAQwI1QqOfaT9y
	J4mo7HZUOguDg4DV+2YnVXWo6Kx2wBCiyDD9jvmtEyk=
X-Received: by 2002:a05:600c:474a:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a35acb9afamr139448685e9.33.1793032162560;
        Mon, 26 Oct 2026 09:29:22 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecd8dcfsm17304483f8f.50.2026.10.26.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Shen <shenyang39@huawei.com>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ray Jui <rjui@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
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
	Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	virtualization@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v3 00/22] gpio: Improvements around device-id arrays
Date: Mon, 26 Oct 2026 17:28:11 +0100
Message-ID: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8375; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=/oBogVX4W/l/tSbRcbLeyK5GzZPZsHFXHxISWg2r7FU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33+c3CfzXRBmptFu1GW2GtVslcFR47MrFB6ag QI8Xzy686OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/nAAKCRCPgPtYfRL+ TixACACdtBFK6kNYWLMcAtstDryOYl7PdfPG1N2WQbOF3hzVRHuidZJEElOlxQOHOxjmH5QxfjG oK6tEHPvQpPYGNE6X2ddRlR3vKhFUQXZie3uQhpRkFU+T2B/9DaN4bQiSXUkhXTzFYvqdfGt+bx UbRl8w0O3UDWE1J1O3+WraRa9pLQ1EiCUZzbGW6h1FRI28X6Atl+O3zYxu2WImvV46mPVm5T7XZ b0jHMwW4knA+B/zWMTvL7A92KmAeoLFPWwfaif9ujRL8DnOG5TkQO7aEpnmwLg6WGA9ruZ09COA LKAAW+CtN1A3UjlRp4pFGny5ogYUqSyfQs1hycndKa4RLwtW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

as with v1 and v2 the original motivation for this series are the
patches that convert the arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Then by not closing the eyes for small issues
spotted while working on that, this series grew a bit.

Changes since v2 (available at
https://lore.kernel.org/all/cover.1784133987.git.u.kleine-koenig@baylibre.com/)

 - Rebase to current next/master (new changes to
   drivers/gpio/gpio-mlxbf.c, drivers/gpio/gpio-mlxbf2.c,
   drivers/gpio/gpio-74x164.c)
 - Fix a few commit logs to reference the right *_device_id names
 - Drop all tags for Andy
 - Drop a questionable MODULE_DEVICE_TABLE(acpi, ...) for drivers/gpio/gpio-usbio.c

Checkpatch only reports two undocumented device-tree compatibles:

	WARNING: DT compatible string "apm,xgene-gpio-v2" appears un-documented -- check ./Documentation/devicetree/bindings/
	WARNING: DT compatible string "marvell,pxa1928-gpio" appears un-documented -- check ./Documentation/devicetree/bindings/

I felt free to ignore these as this is a pre-existing issue and
out-of-context for this series.

Andy didn't like how this series is split into patches before, I do. I
think it's not possible to please everyone's opinion regarding minimal
changes per patch vs grouping similar changes in patches and about what
is considered churn. I'm happy about every patch in this series that
goes in, so feel free to apply patches that you like and that don't get
resistance even if other's do. If patches don't apply, just drop them,
I'll catch up on them eventually.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (22):
  gpio: Remove __maybe_unused annotations from acpi_device_id arrays
  gpio: fxl6408: Remove __maybe_unused annotations from of_device_id
    array
  gpio: Drop unused assignment of acpi_device_id driver data
  gpio: max7301: Drop unused assignment of spi_device_id driver data
  gpio: mmio: Drop unused assignment of platform_device_id driver data
  gpio: ljca: Drop unused assignment of auxiliary_device_id driver data
  gpio: xgene: Add missing ACPI module annotation
  gpio: sodaville: Add missing PCI module annotations
  gpio: Add missing OF module annotations
  gpio: pxa: Add missing platform module annotations
  gpio: pl061: Use empty initializer for amba_id terminator
  gpio: Use named initializers for acpi_device_id array
  gpio: pcf857x: Use named initializers for of_device_id array
  gpio: bd73800: Use named initializers for platform_device_id array
  gpio: Use named initializers for spi_device_id array
  gpio: virtio: Use a named initializer for virtio_device_id array
  gpio: Unify style of acpi_device_id arrays
  gpio: Unify style of of_device_id arrays
  gpio: max77620: Unify style of platform_device_id array
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
 drivers/gpio/gpio-aspeed-sgpio.c    | 10 ++++-----
 drivers/gpio/gpio-aspeed.c          | 10 ++++-----
 drivers/gpio/gpio-ath79.c           |  2 +-
 drivers/gpio/gpio-bcm-kona.c        |  1 +
 drivers/gpio/gpio-bd73800.c         |  4 ++--
 drivers/gpio/gpio-blzp1600.c        |  4 ++--
 drivers/gpio/gpio-brcmstb.c         |  2 +-
 drivers/gpio/gpio-bt8xx.c           |  2 +-
 drivers/gpio/gpio-cadence.c         |  6 +++---
 drivers/gpio/gpio-creg-snps.c       |  5 +++--
 drivers/gpio/gpio-davinci.c         |  8 ++++----
 drivers/gpio/gpio-dwapb.c           | 14 ++++++-------
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
 drivers/gpio/gpio-max3191x.c        | 12 +++++------
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
 drivers/gpio/gpio-mpc5200.c         |  9 ++++----
 drivers/gpio/gpio-mpc8xxx.c         | 25 +++++++++++-----------
 drivers/gpio/gpio-mpfs.c            |  1 +
 drivers/gpio/gpio-mpsse.c           |  3 +--
 drivers/gpio/gpio-msc313.c          |  1 +
 drivers/gpio/gpio-mt7621.c          |  2 +-
 drivers/gpio/gpio-mvebu.c           | 13 ++++++------
 drivers/gpio/gpio-mxc.c             |  2 +-
 drivers/gpio/gpio-mxs.c             |  4 ++--
 drivers/gpio/gpio-nomadik.c         |  7 ++++---
 drivers/gpio/gpio-novalake-events.c |  4 ++--
 drivers/gpio/gpio-npcm-sgpio.c      |  6 +++---
 drivers/gpio/gpio-octeon.c          |  2 +-
 drivers/gpio/gpio-omap.c            |  2 +-
 drivers/gpio/gpio-palmas.c          | 10 ++++-----
 drivers/gpio/gpio-pca953x.c         |  4 ++--
 drivers/gpio/gpio-pca9570.c         |  2 +-
 drivers/gpio/gpio-pcf857x.c         | 26 +++++++++++------------
 drivers/gpio/gpio-pci-idio-16.c     |  3 ++-
 drivers/gpio/gpio-pcie-idio-24.c    |  8 +++++---
 drivers/gpio/gpio-pisosr.c          |  4 ++--
 drivers/gpio/gpio-pl061.c           |  2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c   |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 ++++++++++--------
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
 drivers/gpio/gpio-tegra186.c        | 32 ++++++++++++++---------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 12 +++++------
 drivers/gpio/gpio-vf610.c           |  4 ++--
 drivers/gpio/gpio-virtio.c          |  4 ++--
 drivers/gpio/gpio-visconti.c        |  2 +-
 drivers/gpio/gpio-waveshare-dsi.c   |  2 +-
 drivers/gpio/gpio-xgene-sb.c        |  6 +++---
 drivers/gpio/gpio-xgene.c           | 10 +++++----
 drivers/gpio/gpio-xgs-iproc.c       |  2 +-
 drivers/gpio/gpio-xilinx.c          |  4 ++--
 drivers/gpio/gpio-xlp.c             |  6 +++---
 drivers/gpio/gpio-xra1403.c         |  6 +++---
 drivers/gpio/gpio-zevio.c           |  5 +++--
 drivers/gpio/gpio-zynqmp-modepin.c  |  2 +-
 drivers/gpio/gpiolib-acpi-quirks.c  |  2 +-
 107 files changed, 269 insertions(+), 252 deletions(-)


base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.56.0.rc1


