Return-Path: <linux-aspeed+bounces-2499-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E55ECCD19A
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 10:55:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp1tr692kz3cdG;
	Fri, 17 Oct 2025 21:55:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760698516;
	cv=none; b=SODxS9tfK9VWCM0Ed2HF3i73jqCbkfqCt252JrJifW4FvKrSOsdueOiISo7KI9xsBk/W/3h0E1sPcSbXj97ju5iHrADC1yY13WUGspGNwbfRv0mnHhpfku0HkLj+7UqCt1GayQqGjdhodXyKUOsoCfpjhZwFqo+JIg/0+RGBqh1hPKYRRGldMUurE56HbMam0ssxzBimn6ge4ddd9BXvcoz+HQT7KGF5+CZLHsfeJZpZMOpmkbL1591hXN4+O1BDiawMU97zurA2NdgP2ov/usQnDXTbF4gOwpOD4sMsbJSvu0S2pgJsz07+tJ4KLayHU7cyBKRIX1RsaoVLXxjfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760698516; c=relaxed/relaxed;
	bh=UqDMqcLaSuOZjYcQxjlOyjQ/ixzFwx9kczBw1P1xlJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWSChEECQ4wJxkasRkHh4ma/8gmASJIbIBwqTwMGuBS/C+Q0x0FWP/GVXJSJRly/9R+KwU0o8nTUZ3EIgphLpPJi5SQyMFNCuOXd/kqz/D34iqrULwMekguetrKjtJ1OVoguCtESft7q7hvYbgPlaC7H6oVy2wzU/jierOOggzGR+id6+EojZFkBJ5k8eavlOopI3APiWHR22/QE8ZRinwZsYc2S92lCU1aIrd+8YYDbe2/uuCLGiQkhf9fTip7H4FdMcw716QQjvfK+8/UT4nDYFbZiQVe6NWQyf5o17SEc7+YFdK5/nyQHDEsEiHV+hCPIc6NETeJnyxQzb0KTCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=fde1=42=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=fde1=42=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp1tr2QQJz3ccF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 21:55:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E37E642CD;
	Fri, 17 Oct 2025 10:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442C9C4CEFB;
	Fri, 17 Oct 2025 10:55:05 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 4/4] soc: renesas: Use bitfield helpers
Date: Fri, 17 Oct 2025 12:54:12 +0200
Message-ID: <5182a66c22d80efd3fa7ccedf62554d9f95c0a40.1760696560.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760696560.git.geert+renesas@glider.be>
References: <cover.1760696560.git.geert+renesas@glider.be>
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

Use the field_get() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,

v3:
  - No changes,

v2:
  - Drop RFC, as a dependency was applied.
---
 drivers/soc/renesas/renesas-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 1eb52356b996bdd7..ee4f17bb4db45db7 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014-2016 Glider bvba
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -524,8 +525,7 @@ static int __init renesas_soc_init(void)
 							   eshi, eslo);
 		}
 
-		if (soc->id &&
-		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
+		if (soc->id && field_get(id->mask, product) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			ret = -ENODEV;
 			goto free_soc_dev_attr;
-- 
2.43.0


