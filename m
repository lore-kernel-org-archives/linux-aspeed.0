Return-Path: <linux-aspeed+bounces-2653-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B09ACCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 18:44:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwMr507jQz2ypW;
	Tue, 28 Oct 2025 05:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761590692;
	cv=none; b=mGO1oTe9FK+p01er21c4aQOt0ZnG/r2fAGcsD5bQj9/pas6qt98bMW6xYF4UYaSxlkijJhSzUbuZqJYHOWGLmts7D+TAs/VACH1xvJqlEB25UenwtxGJB17/EX1QHtCCEb3MidB3QKtQK86q8IV4TuDin1pbKlOcKa/4Wp6Wl4cNAoXML243qKAUcBA1WPm7kjf58tAvOUxPOWHmx0q4QJo5U8ExMjaJF6TGSnadGa3ZBaPVgZGHgKcxe/fPEPCgQWATUuSmQQlyICUwaRoFq69ghRbnnPYhC4nvupf9FMjQJgB76mp5KSs0y0odgU1o1DT2KXMEXLOZ07UPqxGnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761590692; c=relaxed/relaxed;
	bh=eYyLpKPAljbxO/F1ClhOFRM69txNgo0zgYjGtspJ1NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWI1wTJcxuEfKgxiLHkSZx+91/yHn+nH14u2vjjjHK/dobsAVjIprLpeep9bgXE3l9BS2O1XfnSNxMq5vpxcdnp+fiv/rYVfhpmV4Y4m4mfKzBwgXOmiXsTg4EWvyknIn6CrV5SrjifLjq+LCvV7Naz0QWQA5NFprJneTJB9dGz2VArziGtPgtNZ2DtA0tLXkySyyrblHIdEac/z4gzcggqix6BjqWDPdWHhDheTC4R5M62U6ofrKKQaPlHIxv4EPI0RPl7aS9z9iIIDcGIGCB5CGw/Fee68eG5uFBfk9iVcxoXd+UKEjJPwGra+SMBLJy7jo8bO0af5rIdQpocRFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwMr41f7Zz2yjy
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 05:44:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1724861CC9;
	Mon, 27 Oct 2025 18:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7643C4CEF1;
	Mon, 27 Oct 2025 18:44:40 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
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
	Yury Norov <yury.norov@gmail.com>,
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
	Jianping Shen <Jianping.Shen@de.bosch.com>
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
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 17/23] iio: mlx90614: Convert to common field_{get,prep}() helpers
Date: Mon, 27 Oct 2025 19:41:51 +0100
Message-ID: <8ea8d9d6c33d9589e8761f6000639546f1bd5148.1761588465.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
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


