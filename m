Return-Path: <linux-aspeed+bounces-2771-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCD7CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 13:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2NWR1v7Tz2yvk;
	Fri,  7 Nov 2025 00:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762436179;
	cv=none; b=WOIhlcLyYeofPW0UNxeg/Fbuj7x6U5uRUqeqSvbneIz3a6MFCCDCYycGXNSGxDCPkclsUgky2cd9jn8WZacYrzUB92r5fKzIaIOnYEt7wrEjExiFPzyX+3YTOkHpneTWBKNJwk6g+f1hC8blLQUsqFUxo4i02MNWID0OX2kRJLO8PFrGgbN19gC8DOM04kgLOr5m9Y8GnlfVDk0TOWZdaGg1WTm2kkrtUhSmqKczKZJ+PEUt3Z0MUnVB3ThL4HjmSxt5c0tI9L9rbtM7GLdR1hy0oE1K0Q6lSvw2OC6GPw0qM4UOZfBeEEmtHwSG8dZIKH4xq00VfBRvl6g6OOzp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762436179; c=relaxed/relaxed;
	bh=JswfHKfwdmI9vemtt+rpI0Ouyx8T43hzLd3IkayyBOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbS+qU+M5p/8tF8SGf+BlLR2H5DcoKme+NRdkn9LZHyTQEdzrXZto1w6Wo1tfyPa0Dt8kYxloXP1s6Bzu8dwvFSRefLYu11y5VFy5FcgdvXVGV7scYomDLz07OIR2wCzJQ4WrTwzhOkp4tkNj4MrJnFvFzKcmP1rYJ6GT5HTuHj4GrI2D4SFh5H3v67AW13GIERx+owl8t5SEdlzLW4b/n/Qr53v8PpimQdM1lJaKYCaWzMbN+0+0qiTcBA8rN7KP7iedqPSFCRwEb6h9tP2OOeczoOpXoaNq3G2JEM9wgNo2ukL5bqCIb38SQorxkyGzueWR232Tf93mbrha0jDBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2NWQ3Hypz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 00:36:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E19C601F7;
	Thu,  6 Nov 2025 13:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E416C116C6;
	Thu,  6 Nov 2025 13:36:05 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yury Norov <yury.norov@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v6 10/26] iio: imu: smi330: #undef field_{get,prep}() before definition
Date: Thu,  6 Nov 2025 14:33:58 +0100
Message-ID: <54c739d05673e512d091bf78e54cd00e3655d7d4.1762435376.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
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
Content-Transfer-Encoding: 8bit

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - No changes,

v5:
  - New.
---
 drivers/iio/imu/smi330/smi330_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index d9178725ade3da83..a79964fe68fadf47 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -68,7 +68,9 @@
 #define SMI330_SOFT_RESET_DELAY 2000
 
 /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define SMI330_ACCEL_CHANNEL(_axis) {					\
-- 
2.43.0


