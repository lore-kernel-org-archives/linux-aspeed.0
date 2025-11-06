Return-Path: <linux-aspeed+bounces-2768-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5A7CCFA03
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Nov 2025 13:35:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2NVr1wJwz300F;
	Fri,  7 Nov 2025 00:35:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762436148;
	cv=none; b=Lr8+YTmrfEsfYbmggPOFYZHxaO/QWFtVAnaiUec4kfoO258cXOdrkHstpDUIDyAdPYnZXbG9DUioV5mnb9hjCVuGkLUv60sReeA09vaivlVAPE1U7AkSkI9SNJmTKpU1/ZoE2Loq083elYjf1RKEsF8Lq9tG0V21D3WYyp2sAG8OEOCRpkmOkl2ss9HkkdRgxEnJ3JOlZ5eiSkatfycfFHgn6tNxeT0TVn5NsGBKi9eKLa6I74XhYxRPpL67fWbydwG/A8iNG4Df+bpXmuLoW9OwAx5ZO2idewzY7uo0kDfIQJWBBqGVQQtCsvJNUGaAzmrpWZNSrYqBTggtdNSRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762436148; c=relaxed/relaxed;
	bh=UNdHS6Ab9Mp/daFaDRIseOid7JYOByYqEUQfBpEhGB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAEscTxUFA20yju1X4uLFNHEecA6dnTqK/kNGBlWDjBfBYwHOJnTR1NKU3V+3A2XgrKA9iQkUlh0o+gs8yy7bysfbFh6NUt9vNu9TnaiQwxR63VhTtm6yDQCw5ydaoAQoK9RZr7JAAYVhq6+mytvcchI+RZM/cKe43t2NfnQKpDsMB+D1KJoxlzVWCRazNrg4KB2MtskkgX70tuAGL0XTQSsPplfH1dkdvU6zFOvj+9cAO1MIkekPDmOJdH1ve51EfqDXm27NQDj4n5teGf7JWerekjwWE9u1aMhonUIPVMVrzXe1uIhybQlJ0WA1kUrn7C771bgRVnDKwphsdt0Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=kmvc=5o=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2NVq3LwDz2xR2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 00:35:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F8C360223;
	Thu,  6 Nov 2025 13:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0913AC4CEFB;
	Thu,  6 Nov 2025 13:35:34 +0000 (UTC)
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
Subject: [PATCH v6 07/26] pinctrl: ma35: #undef field_{get,prep}() before local definition
Date: Thu,  6 Nov 2025 14:33:55 +0100
Message-ID: <0840ef3c986f6474a980c1e3e5e95aea803a3581.1762435376.git.geert+renesas@glider.be>
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v6:
  - Add Acked-by,

v5:
  - New.
---
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index cdad01d68a37e365..925dd717c9deead5 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -82,7 +82,9 @@
 #define MVOLT_3300			1
 
 /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#undef field_get
 #define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
 
 static const char * const gpio_group_name[] = {
-- 
2.43.0


