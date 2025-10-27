Return-Path: <linux-aspeed+bounces-2658-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3212CCCF9E0
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 18:45:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwMry57HSz30Ff;
	Tue, 28 Oct 2025 05:45:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761590738;
	cv=none; b=E2Uxhn16QzcAfdRo3lumE91OhK25qAs3XD9O44UXeboYP2NjgvYcs/eaoq/uMeroCj5Gtm22WxKPVIk0m9Yw1UyFSzCW4uIaAUJLLBznJxCYdl5tZA20NYwgogca85Bd1zNaJZcfJgW8AlGeovRUzj1TkWzhwSYB4mIIc/jqOHgE+/0Z+zyHkQMPJV3qLg+9xR1Q5BlnGqxw8raEER6vgUQhb6nKSgSQUNCgVGHMnE67MTUZ2yHcwGheVl6h1iuN0UQZoGBde/Dcjih/DeLDTjDcywaCo5kej1Pyhp3Jil3Ejh8yzQLKdKp2ADIyuxQw6NMiA9zQv4Z0HqDeqTdkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761590738; c=relaxed/relaxed;
	bh=ApMzuYXUeDGoceR0nBR2nhDnaW2sB8izjwwq4UB0xCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1ILZd0pdk30wMqnzlTCapZxpNobFrP/4j9Ipnu4CkrYujcbf5dBUNzwS/iCoptvTsuz7IAechYgK1D3Xgi8ywrb/zD1uvwGwWGOuk3CHEn4R86s1lUhJe55DZriCDILkR4NH7Ecw/rBG7qNqTj7u3ypeJ/G2nNzg/XoyzQZp5mM6oTqCYdZVQ2E6xETxrmhbJIAsu8m7qNIcWDUoAyxxFd1O2YwH4R4RB1lQVJ6XTfGIkA98NCVpi8dLo2FbWA90t4A38vR7NqIJiRHTS6H4Yvp8wYyqzr1MDCvUnDspV8iaFa8nU379MVvm3UdAsElLpZa9M3hEgOgnabKqUO9KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=nyk2=5e=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwMry02Sfz3046
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 05:45:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1191A61CD2;
	Mon, 27 Oct 2025 18:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD0FC4CEFD;
	Mon, 27 Oct 2025 18:45:26 +0000 (UTC)
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
Subject: [PATCH v5 22/23] clk: renesas: Use bitfield helpers
Date: Mon, 27 Oct 2025 19:41:56 +0100
Message-ID: <362ca57b994141c4747596d9da432057e09e7713.1761588465.git.geert+renesas@glider.be>
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

Use the FIELD_{GET,PREP}() and field_{get,prep}() helpers for const
respective non-const bitfields, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - No changes,

v4:
  - No changes,

v3:
  - No changes,

v2:
  - Rebase on top of commit 470e3f0d0b1529ab ("clk: renesas: rcar-gen4:
    Introduce R-Car Gen4 CPG driver").
---
 drivers/clk/renesas/clk-div6.c      |  6 +++---
 drivers/clk/renesas/rcar-gen3-cpg.c | 15 +++++----------
 drivers/clk/renesas/rcar-gen4-cpg.c |  9 +++------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 3abd6e5400aded6a..f7b827b5e9b2dd32 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -7,6 +7,7 @@
  * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -171,8 +172,7 @@ static u8 cpg_div6_clock_get_parent(struct clk_hw *hw)
 	if (clock->src_mask == 0)
 		return 0;
 
-	hw_index = (readl(clock->reg) & clock->src_mask) >>
-		   __ffs(clock->src_mask);
+	hw_index = field_get(clock->src_mask, readl(clock->reg));
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
 		if (clock->parents[i] == hw_index)
 			return i;
@@ -191,7 +191,7 @@ static int cpg_div6_clock_set_parent(struct clk_hw *hw, u8 index)
 	if (index >= clk_hw_get_num_parents(hw))
 		return -EINVAL;
 
-	src = clock->parents[index] << __ffs(clock->src_mask);
+	src = field_prep(clock->src_mask, clock->parents[index]);
 	writel((readl(clock->reg) & ~clock->src_mask) | src, clock->reg);
 	return 0;
 }
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 10ae20489df9abd8..b954278ddd9d8aa8 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -54,10 +54,8 @@ static unsigned long cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct cpg_pll_clk *pll_clk = to_pll_clk(hw);
 	unsigned int mult;
-	u32 val;
 
-	val = readl(pll_clk->pllcr_reg) & CPG_PLLnCR_STC_MASK;
-	mult = (val >> __ffs(CPG_PLLnCR_STC_MASK)) + 1;
+	mult = FIELD_GET(CPG_PLLnCR_STC_MASK, readl(pll_clk->pllcr_reg)) + 1;
 
 	return parent_rate * mult * pll_clk->fixed_mult;
 }
@@ -94,7 +92,7 @@ static int cpg_pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	val = readl(pll_clk->pllcr_reg);
 	val &= ~CPG_PLLnCR_STC_MASK;
-	val |= (mult - 1) << __ffs(CPG_PLLnCR_STC_MASK);
+	val |= FIELD_PREP(CPG_PLLnCR_STC_MASK, mult - 1);
 	writel(val, pll_clk->pllcr_reg);
 
 	for (i = 1000; i; i--) {
@@ -176,11 +174,7 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 					   unsigned long parent_rate)
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
-	unsigned int mult;
-	u32 val;
-
-	val = readl(zclk->reg) & zclk->mask;
-	mult = 32 - (val >> __ffs(zclk->mask));
+	unsigned int mult = 32 - field_get(zclk->mask, readl(zclk->reg));
 
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
 				     32 * zclk->fixed_div);
@@ -231,7 +225,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	cpg_reg_modify(zclk->reg, zclk->mask, (32 - mult) << __ffs(zclk->mask));
+	cpg_reg_modify(zclk->reg, zclk->mask,
+		       field_prep(zclk->mask, 32 - mult));
 
 	/*
 	 * Set KICK bit in FRQCRB to update hardware setting and wait for
diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
index fb9a876aaba5cbcd..db3a0b8ef2b936bb 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.c
+++ b/drivers/clk/renesas/rcar-gen4-cpg.c
@@ -279,11 +279,7 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 					   unsigned long parent_rate)
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
-	unsigned int mult;
-	u32 val;
-
-	val = readl(zclk->reg) & zclk->mask;
-	mult = 32 - (val >> __ffs(zclk->mask));
+	unsigned int mult = 32 - field_get(zclk->mask, readl(zclk->reg));
 
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
 				     32 * zclk->fixed_div);
@@ -334,7 +330,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	cpg_reg_modify(zclk->reg, zclk->mask, (32 - mult) << __ffs(zclk->mask));
+	cpg_reg_modify(zclk->reg, zclk->mask,
+		       field_prep(zclk->mask, 32 - mult));
 
 	/*
 	 * Set KICK bit in FRQCRB to update hardware setting and wait for
-- 
2.43.0


