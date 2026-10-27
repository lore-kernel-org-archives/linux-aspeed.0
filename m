Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5FB606A322
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R8iE33Se
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDm8B2G0kz3bf8;
	Wed, 28 Oct 2026 09:56:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793098231;
	cv=none; b=Z7L8RIHUvf9khjU1M0lwiPsdICUBtXvgQf9W+E0WTQlZeu9QXm/uckXE+uy5G8rBMOr1uaXCIsU4ZJn9EPiRTBOLy9aWS+PEtfGycB3jC7cX/+1W8VQBLP1hgOCvCGdNTxljV3cR8V1P2iuh3yYqGgePHX6EhVP37trOf98BZLVzG2HgraXp5lVOtRA+RmRhTWSkxSiLVYr69H1RXvcir8FJ4Ji9cwmRyONlWs0+JJAZCdeCljGGTBbzBdOyEhPIfbq5zW1QL4WobLcQsIL8yBWQQtrOVZl50BOozL/AWgX7QEzok1xXxGQ+ZnuZlGpOLax49u+t2uPBPRnr7LL1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793098231; c=relaxed/relaxed;
	bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UFwBYkuiO2KHH3FVq7EEXYxxg9+xuQC78G+bhvCg9W7wZLJ6Xq9RHgn54c5VvhMvFgb8eWa5zhG/Lfjmr5ZOy2rH5tn6jfchIt8BNgZKLOS+Zjb+2ICYQMqkDyULAW8qeCIPYzYpq5u7AEj/fQPZxiMgvqPi2C5owSiRnG0dx0ksd/GWdD1kC1ppu8/YYmBtiP25pWTo8g5PCscBfzfVnuGVKaDOkbFBHzak9q1Ly5YMJ6JzMrqZQJnsJpTKGYIz0QYj6V6LuFaA6c9aqm51bumJoJs5xvdtglH82CCQ7M9uikq4SQytX+gF+Ka7Ghg5l7hxicAwHL8XyXujjrWp6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R8iE33Se; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=R8iE33Se;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDS2B2gWhz2ySk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 21:50:24 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso546940f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 27 Oct 2026 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793098216; x=1793703016; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
        b=R8iE33Se+hRRzZwB4xEKPU7uAmCTtu8EBa8+QY4st/Lu4NR+KTOAcQnzz+JPTysGlh
         mBs+62j6EA8hnfcZH6AMDsAbOPHl/iSxSn4CKy4goxCdL/Uw3VneqBT7f/9DCHTNPRht
         GC7KR6LB7EAykHEYMHcEys5LTlUgs3BDmMw/bkyAktFuRDGi/fuG8D3js1IUMYNfJBX1
         nV/hJoK37/0b4W82dbqOL9iiWX/lWiq41ybMwssRf4rZjPsxdC6uZSxLLcF0DyHOcGt5
         /ihtKUmm+dZOf7BTY3f9X9xUlbnJf2jU7YuS4mOOulMs1gwJDc/IH1BbSADgUFHLNhdu
         KmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098216; x=1793703016;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFZzZHqRNst1BMPTvXE87RueOS4Ft9OJQfvt5VLbbcE=;
        b=nAoyl3ZoX60A6sGmX/qAxej39N0lLirxsIhY7nrLtp4ujwEpLQJZqLq3YzBZ6BPPoq
         GQK1r8Pue13kJ/58qY6+04O0Sae3F68kq9/Q8g3OB+TkVrktslNNjGuVz6FY4Q2dEBQV
         FqeGA8/WEg7ZQZtlc1Oy33+s0p0YmPPdLiqYtN4YfQLxJjhABCthmj0G3Kaz3yzMz//Q
         uBUc0N8xq53N20jso9zvMJVt1gLJ8SRrpirEOOaA+YZPSdRDO8e2Y/gnrGHAocdkRm5M
         a+HnqB/PnKn0GvawC7ilWjoJlkDPUfSQQP7/FfnthgooahVbxVd2ZAe3TV864p5oYxM9
         JYQg==
X-Forwarded-Encrypted: i=1; AKwUvBx7Bd83EPvr7mszyQDZTD0Z76P1Ku5h48oboVHqHwGjf8+U5HUF8opXwEiQ/0ZbyW5YEHbtZxUEUbErX7U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK2rol0hNgr0zPJ2xLGVUrVQ7Kr4RJ9lxWgBSi9a+L8XbHTlQJz
	cARc4/QrS0w/pEf8ecPLzfHyNEg+8NPh1Bi6iaWve0IAMMnN/DliOknkTFeezWOheVM=
X-Gm-Gg: AYBFou0NJA/kKHjYWrqUpbpQfTjg/yESTk4ZsATgBIsYURKpkKsLm2BNwzlbFMieZQL
	+4IDoI9eK45fcXVmrowG7iiduo0BsIzwRLhvH9tdC3KKODOZHQsAhXYkGePngsIgvgLzQNCpJBH
	e/6uWSYjDxBzJKJcgGcvwIGMQY0a2Yx+VfwP7gB3zHOUFGRG+K41qcAVHDOAdKCQMW0+GYCQOCN
	+Bq1d69TO+eAQ4225SZJSAy7AzFd000XdumD4gaF+qFQDxmcvnXstbngv72mqQpHeYfcT4acq86
	wRGauJxINCheCbiUIkdGFtUxWztd26OYzghjrtoNZUAa0Et2c+a1fGfeKV4HqGevaRWnLH3Y6Tq
	7WCW386ok6mG7lNyVDTC158NzioypscER1AlAaJGdyvPEF+5ioCTGfl2HZVlToXtPPowEj262Dp
	xgLKdUK1dcOt7ONJC5nRFUrd19/If/KTKZy7YeiRmZ4TC7N1nqGgwbkKQgJry1T/F3Bu0hSfWVz
	OBq49H9/ahMfzHqac6qNiSbL0UNbLMe8gsn69xSib6z7y3aIQGXN+aE+95wmQzPHxMRpQJQBEiW
	K2dj4XABFQFVSG+shDctssmErgppxb69ze4weoiMfb4=
X-Received: by 2002:a05:6000:438a:b0:48e:884:affb with SMTP id ffacd0b85a97d-48e55a51758mr5422454f8f.24.1793098215724;
        Tue, 27 Oct 2026 03:50:15 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ebd48e0sm22735578f8f.38.2026.10.27.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:50:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-hwmon@vger.kernel.org,
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
Subject: [PATCH v4 00/23] gpio: Improvements around device-id arrays
Date: Tue, 27 Oct 2026 11:48:37 +0100
Message-ID: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8137; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=k1gONcl2UIxBepDw11jo8AHu6ai+O1G0nVgkSy8JdIE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq4IGGNXr36bKoBw2PaxVdVtkUGC9jXmJpRnHf2 Csas+gKAK2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCauCBhgAKCRCPgPtYfRL+ TniYCACv6CLczaP+IEWqqjNz0H2IDCNFuAhnXKDLb4106wpApOzW0y6gufg8fEnzsamxLLEBdjV dqq25XfWZfdmZg3FMHHPJqnBr5fh7Zg46EwNe1jZvPkIkqY78ho7ESao5AKRIVqqTbQRpIaZEgz NNeJQhmaiL16rAeAP+okNpbCcIyWa33O12ZEutJCFYTQrA6235nE9ZSMLfl07igU0+tu+iunwWQ mCsDqRmK3fija+zCgkc0dIt3ssbXfQa1/DrtcjbcwgL9Jsq5zWCdDhzr7Rb8pliP+Uu/VBJJxty 27ri9KePaXD/wGvqViL+tL8IZZtej2Vgp0hRAsZI/QNPpgp7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

the original motivation for this series are the patches that convert the
arrays to use named initializers, see
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the idea behind it. Looking left and right a bit while implementing
that, the series grew a bit.

Changes since v3 (available at
https://lore.kernel.org/all/cover.1793030820.git.u.kleine-koenig@baylibre.com):

 - Picked up review tags (b4 even found some from v2)
 - Add a 2nd MODULE_DEVICE_TABLE(of, ...) in drivers/gpio/gpio-mpc5200.c
   (My grep didn't handle >1 driver per file well), noticed by Sashiko
 - New patch to use named initializers for auxiliary_device_id arrays
 - Fix code style of of_device_id array in drivers/gpio/gpio-grgpio.c
   (My script doesn't handle of_device_id::name) and
   drivers/gpio/gpio-ppc44x.c (didn't exist yet when I sent v2 and
   failed to notice that for v3)
 - Fix code style of auxiliary_device_id array in
   drivers/gpio/gpio-shared-proxy.c, missed as I didn't have a script
   for auxiliary_device_id before.
 - Dropped a few broken email addresses from Cc:

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (23):
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
  gpio: Use named initializers for auxiliary_device_id arrays
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
 drivers/gpio/gpio-elkhartlake.c     |  2 +-
 drivers/gpio/gpio-em.c              |  4 ++--
 drivers/gpio/gpio-ep93xx.c          |  1 +
 drivers/gpio/gpio-ftgpio010.c       |  3 ++-
 drivers/gpio/gpio-fxl6408.c         |  2 +-
 drivers/gpio/gpio-graniterapids.c   |  4 ++--
 drivers/gpio/gpio-grgpio.c          |  6 +++---
 drivers/gpio/gpio-gw-pld.c          |  4 ++--
 drivers/gpio/gpio-hisi.c            |  6 +++---
 drivers/gpio/gpio-hlwd.c            |  4 ++--
 drivers/gpio/gpio-imx-scu.c         |  1 +
 drivers/gpio/gpio-ixp4xx.c          |  4 ++--
 drivers/gpio/gpio-ljca.c            |  4 ++--
 drivers/gpio/gpio-loongson-64bit.c  |  4 ++--
 drivers/gpio/gpio-lp3943.c          |  2 +-
 drivers/gpio/gpio-lpc32xx.c         |  4 ++--
 drivers/gpio/gpio-ltc4283.c         |  2 +-
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
 drivers/gpio/gpio-mpc5200.c         | 10 +++++----
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
 drivers/gpio/gpio-ppc44x.c          |  2 +-
 drivers/gpio/gpio-pxa.c             | 20 ++++++++++--------
 drivers/gpio/gpio-qixis-fpga.c      |  3 +--
 drivers/gpio/gpio-rcar.c            |  2 +-
 drivers/gpio/gpio-rda.c             |  2 +-
 drivers/gpio/gpio-realtek-otto.c    |  2 +-
 drivers/gpio/gpio-rockchip.c        |  4 ++--
 drivers/gpio/gpio-sama5d2-piobu.c   |  2 +-
 drivers/gpio/gpio-shared-proxy.c    |  2 +-
 drivers/gpio/gpio-sifive.c          |  2 +-
 drivers/gpio/gpio-sl28cpld.c        |  2 +-
 drivers/gpio/gpio-sodaville.c       |  3 ++-
 drivers/gpio/gpio-spear-spics.c     |  3 ++-
 drivers/gpio/gpio-sprd.c            |  2 +-
 drivers/gpio/gpio-stmpe.c           |  2 +-
 drivers/gpio/gpio-stp-xway.c        |  2 +-
 drivers/gpio/gpio-tc9563.c          |  2 +-
 drivers/gpio/gpio-tegra.c           |  6 +++---
 drivers/gpio/gpio-tegra186.c        | 32 ++++++++++++++---------------
 drivers/gpio/gpio-thunderx.c        |  3 +--
 drivers/gpio/gpio-tps65218.c        |  2 +-
 drivers/gpio/gpio-ts4800.c          |  4 ++--
 drivers/gpio/gpio-ts4900.c          |  2 +-
 drivers/gpio/gpio-twl4030.c         |  4 ++--
 drivers/gpio/gpio-usbio.c           | 14 ++++++-------
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
 112 files changed, 278 insertions(+), 260 deletions(-)


base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.56.0.rc1


