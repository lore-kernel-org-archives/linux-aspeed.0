Return-Path: <linux-aspeed+bounces-722-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA3C021A6
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 13:56:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvYW51dYsz30XR;
	Sat, 15 Feb 2025 00:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.130.132.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739541393;
	cv=none; b=U5CQUabpN8ehPzmd+CWQJ85JcLMv95TY0m2855gjIf9cZTKL206MJcR++De5u5N/J/t4RW8l/zcdxI3xNo6M/R3tzHDB2EiXE1ImsIKNBrT1uDKJV+DTRw9DxVuHP+ETQQbR4DLnLDxlnmmvwjX3c9QbORalwNv2js7/qdT+87jMYrgS6bl1ViANmwtIejs3IQ0WT07YNU8XWqPvesNhHZOh2IUyqZIKKJHOrk6wH9eiRmSPN0IWYmecnbEWjazPq3iXtX/4XP0CYA98GywZrFOTyCLGm3va3MfuA6COPvTuSveqRMm2wBrZPY0aKfAY98PDVtpv8bQ0rkYdQ0v3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739541393; c=relaxed/relaxed;
	bh=eeUwrRpD2YC1sE1xYDTYmrhZ9ZUlADLpQEgAOjhP27A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqnLA06CFDPut3nGJrZTlZn+jAsIYA0WItiPJcX47LQRpWWUufz7JnnmGFZyn6T5Yjk2WYYYs0kbScyy7/VSXhzPWp87VzTClKxFnpeIlEEFiF3zXnyfQ3qn+cKNuE8UdrTcDNsMW/MH8n3HlxvR78mQyaQxxXO0UeAUk6gbMh47LggSIJMiCnZ/q19WdGHpGaah0BfD8kTbl3IIaHOUtMh7gRhxyONZ3gmRHlT0dcMGtWedVqAxojeAR3ia0o9BsQxrbP91T7iorMMVf4zqcENcnoW3k1pLHfIRtBGVT9m6HiRBa4mV2942C15fxdJzywPxFv41oKTLp/RYm/mFSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=195.130.132.48; helo=cantor.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=cantor.telenet-ops.be
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=cantor.telenet-ops.be (client-ip=195.130.132.48; helo=cantor.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvYW416XLz30Yb
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 00:56:30 +1100 (AEDT)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4YvYVy3hWVz4x2sh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 14:56:26 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by michel.telenet-ops.be with cmsmtp
	id DRvu2E00N1MuxXz06RvuMa; Fri, 14 Feb 2025 14:56:25 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAL-00000006p2i-19TY;
	Fri, 14 Feb 2025 14:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAc-00000000qEo-22dS;
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
Subject: [PATCH v3 3/4] clk: renesas: Use bitfield helpers
Date: Fri, 14 Feb 2025 14:55:52 +0100
Message-ID: <425fa9bb496eecc3fd7fb4bd8e6a98de18c14756.1739540679.git.geert+renesas@glider.be>
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

Use the FIELD_{GET,PREP}() and field_{get,prep}() helpers for const
respective non-const bitfields, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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
index 027100e84ee4c429..ca8f6a68771628fb 100644
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
index 31aa790fd003d45e..a63114a1d431968f 100644
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


