Return-Path: <linux-aspeed+bounces-592-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F50BC0218F
	for <linux-aspeed@archiver.kernel.org>; Fri, 31 Jan 2025 13:54:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yky6d5Y0wz30Gq;
	Sat,  1 Feb 2025 00:54:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a02:1800:110:4::f00:10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738331641;
	cv=none; b=g7bjoaGvuah14445CBMi3OT4OGj2+aZDETvAf5/6Z12b/RPhz+EB91IrdNMKx2etySxjE09I0GRLimyHe0I8q6xazGxNycpSrFk4VMdyGHXaGWYo/q+ZWGrpNq3LsG2MrSgLGiEblrYiIwaHwO114nP1plzDtnuQmGlRjhWX5l6j57F/PVf6feRLVrbPq2TAT8cATnpASKDtg+orFBHmC4srxcS74/I5+KBRyneFlzLZrLXK/aiLnle96bssEtxdgsS9EHi88YXVa/TQe6U4WbQMdnixgT2P3BQY8nLSFMiYaRU/Lj+9ybq2KzIPtosjd/IH9DWmESUHpR1dvzEBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738331641; c=relaxed/relaxed;
	bh=TeurSNr9cTt2IAHjmh8Xc+wfWjhBL/fvxk2BRWaGofA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdWZa/TsEfsOdyeqptZ+0ufayzK7LJ1Zjvcj7vwQHJO6UdzgDtgBGGoGHgCwZtQnz7DA40WfpF12OVme7gvMmHl48x3DJjXe2jkRtn2t0V8a5Ca884mUpnoCxbXgjiNdVxFjU76VHB2eElMiZHqjYOCQh7woYTPzbXkpDyExWbHgPXTUsZ4quSm0/jEf2e02D9+jAhlvbmQEf5H8wa17L3a1aLf8U8puK6TrXhhEO8nn4UkmQM9YkzjM6MNxnvNQfuXqitW+jepKlxNbLuMPkoAbBcKoheTj4UbfkPohce/BGeBL7wcwMREjDpZJibJB4kq5jcYzqbNvN/P0SXmiKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2a02:1800:110:4::f00:10; helo=riemann.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=riemann.telenet-ops.be
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=riemann.telenet-ops.be (client-ip=2a02:1800:110:4::f00:10; helo=riemann.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 389 seconds by postgrey-1.37 at boromir; Sat, 01 Feb 2025 00:54:00 AEDT
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [IPv6:2a02:1800:110:4::f00:10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yky6c6PP2z2yJL
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Feb 2025 00:54:00 +1100 (AEDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4Ykxz11g7zz4x5Vh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Jan 2025 14:47:25 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a916:3147:9f19:c260])
	by michel.telenet-ops.be with cmsmtp
	id 7pmw2E00F0naHe806pmw9p; Fri, 31 Jan 2025 14:47:24 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrM6-0000000FHy2-2GRm;
	Fri, 31 Jan 2025 14:46:56 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tdrMG-0000000DFVY-2Fc9;
	Fri, 31 Jan 2025 14:46:56 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
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
	Alex Elder <elder@ieee.org>
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
Subject: [PATCH v2 3/3] soc: renesas: Use bitfield helpers
Date: Fri, 31 Jan 2025 14:46:53 +0100
Message-ID: <cbec042a7e7fd12673b2d20cca325b096421fc83.1738329459.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738329458.git.geert+renesas@glider.be>
References: <cover.1738329458.git.geert+renesas@glider.be>
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


