Return-Path: <linux-aspeed+bounces-2650-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFF7CCF9E0
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 18:44:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwMqX3XHWz2yjs;
	Tue, 28 Oct 2025 05:44:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761590664;
	cv=none; b=bePVj9DuFWVPABVKvt3x2dVdKnyo2pRS123UhsPExu0+C35kcmSk2EVi/0ae7kqHANR4kphf2LA3bZvvnJI7wTP+2AOwcZWaABfVhrC77bddtBnS9nVjP9nbBhgMMQeocrbV+tY5PlXkWFq9jdnQNZo0ZwZZtCAlrQFEGti4iCUvYF1vTgCj7/OI1xqlM/alExnJlLxj6ylmfclFfDooNcEQckyieK3FeI6roopZN/IV+oxCPqh/WOCk88TLIxkmYp0x4hzIrsYlHCrqAU2ORewZkbBRtC3xrRINaVh67+YA9EV85YNAuta1auWgMpRlPuzST9byNUSPvub8eNWKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761590664; c=relaxed/relaxed;
	bh=QpuTQqW14PfUif2jPSDXC43QfDEGQgEW8TtytnR7kq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgem0iUS2Vq04qE2NBfQhQKloLYkROR/kI1FqVGHLOTn+hHQfTtIGLSgpXcfhtLhLyAxXSGvRdVZXLqKLT3Ew2hS0G0NpCa1aME/etp/A5c812xxi503xvTxfICsNhbmMnnZh9IenUDrcGSORU/y9eOSzvMTzVNmPhkaudGSZDorq07Yuz6CH79WmJcDWPFvcNQe6ph1gmsLqtro8zHyxXzwNs9v9vzlZ3IUnLR5EckHMq1ACVt/c3ppNVepldGZoqR0bnNUc7/TMC6qcl6DosW+35HeCHFVntLekX4tnNQH013mooMrTUYk/x0fCvMwJSXsnhUe5Q60jZcIFrx4qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwMqW6fjtz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 05:44:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6B6340284;
	Mon, 27 Oct 2025 18:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88213C4CEFD;
	Mon, 27 Oct 2025 18:44:12 +0000 (UTC)
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
Subject: [PATCH v5 14/23] EDAC/ie31200: Convert to common field_get() helper
Date: Mon, 27 Oct 2025 19:41:48 +0100
Message-ID: <73dc9c3cd24bc368eaa42a045e8b4a2c37d661eb.1761588465.git.geert+renesas@glider.be>
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

Drop the driver-specific field_get() macro, in favor of the globally
available variant from <linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Extracted from "bitfield: Add non-constant field_{prep,get}()
    helpers".
---
 drivers/edac/ie31200_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 72290f430126c631..dfc9a9cecd74207d 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -44,6 +44,7 @@
  * but lo_hi_readq() ensures that we are safe across all e3-1200 processors.
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
@@ -139,10 +140,6 @@
 #define IE31200_CAPID0_DDPCD		BIT(6)
 #define IE31200_CAPID0_ECC		BIT(1)
 
-/* Non-constant mask variant of FIELD_GET() */
-#undef field_get
-#define field_get(_mask, _reg)  (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 static int nr_channels;
 static struct pci_dev *mci_pdev;
 static int ie31200_registered = 1;
-- 
2.43.0


