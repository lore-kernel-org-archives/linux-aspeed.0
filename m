Return-Path: <linux-aspeed+bounces-2649-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB1CCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 18:44:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwMqM1wV7z2yTK;
	Tue, 28 Oct 2025 05:44:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761590655;
	cv=none; b=QeNzXANrwfOdCqzsZgyOe7x9VrrI13wUebimQge6M/AtAEUEGm1P4wZ18PWUihN3G9S1fZuGjGAYlIjXQvBta3Og+im4TaSW4XyC8CzB4IKaDBRBfEWe/L26f5GMvhR0Kd1xJtsPclLzOWXHaoERPjfYmVjZsPg/5sRhy8iZwfoHraCYYyqXaRw+kLIG9HCqSYP7qeKPMq+zG586emtPjEholIMWojMNudqzsDeQFktWKDV+XkfHKTL3DWZbMiARBVqggES9EC2g9nIG4cvgKDwpLU8yvVoK+xbKPhpSKasg20nvR2gLH1BJRbzJnoISiQNujSfLO2XXRX1Ija+47g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761590655; c=relaxed/relaxed;
	bh=Wwt0YEM3d1YAxW4139emDym4mWkfodr5fpnobKgClZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf5u8FtdVp5PG8/MZ0n6tKZW+DU/whBFRfDxCeOmYGeJpxNUO8t7fiO5pNWXjuWcogxDc+57b+gt1nGpFLV7yUCXgKpobc+lKQ9B2j8BccVKdxL7fEqOLLwZmJXr3evQtbE5bBRZXo4X3F6g0S+vBbMWBzHconyQ1x2OmVzVibG2TIKWjQRrSlqPGZu0eGLHnELQaPFRUcfcUzF7gQyDFlLl95NzHcpHmyzFAED0imS+nfULNlA43hz+2vHO1yEb/F3afNZn+wphbEfg8gI72aflNUPGTbhnfakTUer4SBzbKnSVz0Ganem2UAc0f01/sDmV2jusQoc4sy82mctxkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwMqL2v4vz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 05:44:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 72BFC615E7;
	Mon, 27 Oct 2025 18:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C14BC4CEF1;
	Mon, 27 Oct 2025 18:44:03 +0000 (UTC)
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
Subject: [PATCH v5 13/23] crypto: qat - convert to common field_get() helper
Date: Mon, 27 Oct 2025 19:41:47 +0100
Message-ID: <2556adf9d1dca0077d03785bef1f7592936c16c8.1761588465.git.geert+renesas@glider.be>
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
 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
index 6186fafb4a7b0dab..4ccc94ed9493a64c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
@@ -1,19 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 Intel Corporation */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/sprintf.h>
 #include <linux/string_helpers.h>
 
 #include "adf_pm_dbgfs_utils.h"
 
-/*
- * This is needed because a variable is used to index the mask at
- * pm_scnprint_table(), making it not compile time constant, so the compile
- * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
- */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 #define PM_INFO_MAX_KEY_LEN	21
 
 static int pm_scnprint_table(char *buff, const struct pm_status_row *table,
-- 
2.43.0


