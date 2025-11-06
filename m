Return-Path: <linux-aspeed+bounces-2780-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84680CCFA05
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 13:37:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2NYC6WWLz2xS2;
	Fri,  7 Nov 2025 00:37:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762436271;
	cv=none; b=UZyvaXfoTLk6hsHQtgZ/gVw4KtTmabDMEibmLf2kW4xcuae5lzPLaFaKkqJrPvtX8g0gB8loILhnoQzKRs1PDw0WyVVmi4UF8vu3P0XYQJt0BLAYY+x0q4lAvA5zn8JBdbvNJ5Ye7mkBUvMmkYSRClfKWxdLLwEjjEkHliJSLYAeD8JLT1oKw5KMY1tA/ZmEX2WikFk54TuF5KqjvKnE8rewXMOfitSGwooQ43FGRuUHqeHF7Or5jxvx6P7ecpv9u4ok2z4lkfNLUG3XBHEXIRUI+djuB54wVS04uIhP6NVWu930xSNMb0WTWremaCy9G6jKWBQyfj/UFOopFFWqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762436271; c=relaxed/relaxed;
	bh=JW/QMxbqQX0DlbFiAucDxG2kyctSlsf3XPw5E0xtJQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQrBYU8kr7vdi+52PeOpqs69SbUPScstgFgE2U7OEj1WLfb5xQXLiSBrZmgO9LK53J1G+BdrvZ0AT3ZiqMAIKkev6GC+pxIL/BrmAHwJrVq2+4bLjizuJsZNxu7Gw1+OIxwhUwZpDtiExSTg3Y+ZW+UUuY3NclRdMwStJVAm5R9/MfRSxqqdEGBiHQ1vO+swh8Md+sEID6GoZQ6qWzcfT25Vhez/0QPkEgT33+tACILPraWSTkv+7/sidsf+ceHPQN4/3Zec7jmhT+IqIw7bBbIZRuaUZJB7QSLrfMcXRY6EJopHhb/o5dQK6tr/lFgTZgevVRuREFt3KbZq9baT9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2NYC1SZhz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 00:37:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 98B7644800;
	Thu,  6 Nov 2025 13:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA7CC116C6;
	Thu,  6 Nov 2025 13:37:39 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 19/26] iio: mlx90614: Convert to common field_{get,prep}() helpers
Date: Thu,  6 Nov 2025 14:34:07 +0100
Message-ID: <007e72b33aee33726e161acd9d92f801b7051838.1762435376.git.geert+renesas@glider.be>
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
---
v6:
  - No changes,

v5:
  - Extracted from "bitfield: Add non-constant field_{prep,get}()
    helpers".
---
 drivers/iio/temperature/mlx90614.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index de5615fdb396aa3c..1ad21b73e1b44cb0 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -22,6 +22,7 @@
  * the "wakeup" GPIO is not given, power management will be disabled.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -68,12 +69,6 @@
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#undef field_get
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 struct mlx_chip_info {
 	/* EEPROM offsets with 16-bit data, MSB first */
 	/* emissivity correction coefficient */
-- 
2.43.0


