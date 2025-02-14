Return-Path: <linux-aspeed+bounces-723-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8655BC021A4
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 13:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvYW61Wfsz3bVW;
	Sat, 15 Feb 2025 00:56:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a02:1800:110:4::f00:11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739541394;
	cv=none; b=miw7TSoLw2d12Xqsy1UNVvTYr3Pud6keqrGpgDznkOa6n8DczSqQg4ktE9J2sGmF2Pu8HPqWTMfrZTc4l6uI8Hnkw098V0ldLgfQcHDx536tzyWIkXxbPWT9x079LgUTWVXluBA4oimDtGv+nOkLxdgDzewmK1YqwLsGUatOBiVxUQQD+bThCVV/hSp2QVXNCOkBnL6fq8Cy/wYDeXrug1tgkTaQhVGytOps6KgySL7q90htiRhGlkaF2dXhwoESTK991kBmQrG9rYiwDlBwQ4EH7NhWyhUI/kUMYyOnD13RhOrB+5jKzpeI04e2S56EVd8eEur2sTyWaLrK3UMDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739541394; c=relaxed/relaxed;
	bh=GDyTzgU1PmXELoym+xbGW8+kZOYpPi+FROeC2ty0Qtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPSInAT/xDIvmOE+w6q2mtUuGnNqSZkKLyQ1+hniprsw6oELNqZKVSKKAL2zZaXDRj72l/7D13YQdDGPhp4zBPIgnMIVdcoUrmiczjQB9LiOfr2Rv2ZMEPH2Kkxj0hhbOLooz19x+MEEjRcbG/mcBf83BdqJPHP/COAKju4nJCQfF7om0AIgmJnBSNm4u/vgY8WM6qpqWg+F8772BAQRBrwlR2Ihiq/dZPLiKL9URuwja+n6ddzLlETVj8N3FZX1jvJC+f0g563qAl1da5ovrEKkTmZVjCFfuXIGgj3nZdp8r1oszV6Tn/JtUm+eahxjDgJ0op4gNnJTyf22glsKsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2a02:1800:110:4::f00:11; helo=weierstrass.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=weierstrass.telenet-ops.be
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=weierstrass.telenet-ops.be (client-ip=2a02:1800:110:4::f00:11; helo=weierstrass.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [IPv6:2a02:1800:110:4::f00:11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvYW53hzFz30Yb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 00:56:32 +1100 (AEDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4YvYVx5br0z4wy1N
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 14:56:25 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by baptiste.telenet-ops.be with cmsmtp
	id DRvu2E00H1MuxXz01RvuSz; Fri, 14 Feb 2025 14:56:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAL-00000006p2o-1GsL;
	Fri, 14 Feb 2025 14:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAc-00000000qEs-2BGZ;
	Fri, 14 Feb 2025 14:55:54 +0100
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
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 4/4] soc: renesas: Use bitfield helpers
Date: Fri, 14 Feb 2025 14:55:53 +0100
Message-ID: <77384c0a6660b90c5c9f1eaa9d1f5ce32f3330a3.1739540679.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the field_get() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - Drop RFC, as a dependency was applied.
---
 drivers/soc/renesas/renesas-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index df2b38417b8042fc..8030b9a62ec46668 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014-2016 Glider bvba
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -512,8 +513,7 @@ static int __init renesas_soc_init(void)
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


