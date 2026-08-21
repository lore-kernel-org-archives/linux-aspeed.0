Return-Path: <linux-aspeed+bounces-4806-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E236C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 09:04:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDrd4R58z3bqM;
	Fri, 21 Aug 2026 19:04:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787303057;
	cv=none; b=RIob09Ge39cFMm5jfaYRdUHtYVAZtvwTt655z28qiuxG9pOkdr7JqNvNpygHxYOg0tKJcXW5TLVW7PHbAtaUGB9uN2sV+KuWwQZyVaUMiiGrHKGFriZH2Xo+6b1zdm9tIwVz4WO0vbO0gyXYdNpkAoh9r+R57jPhC2HA8x0q55OIhYZT/8Hr++Tpfp5kjw3xSjJCKYMbh0aKD4hO2aGdkJP+FRFtxrag5veKksZL0DBQ66hPr5Fy1lmDLD+AqPrNUVsF5/ADcFqUKuG5WDLiAnlAxMKoMk3m2+X5JjW/OmRbMYeODrZlpHoG9AmbGclbp3IgVODazKGN/Rd8ap0rJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787303057; c=relaxed/relaxed;
	bh=Usy3PgSBIh1QSQ6laEpUYZGvqSHbiAzqMCe9pFrPVU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4GbDA/FeG1NeUCJdLqbiCBQ5EiWt9YG8xaDmq84G60BI6jhIhRem8dN2mfifFf7M/nsdagbh5q3pdKSpRtzomOwdyYpd23txEGXBFQfjM0b/y9fVugGqFM0n4kOxzMPExUZ+auMnD8kDL2bZ9DWW7zy4ii4c5z3qANXSHlc69IbTx9EDVyIahgPCBMkRr0mzN8Q+Mj2KmSy3ekinLId1QRZN6i5Wn4/hrQxdvscgzBxU+IT+PBu0YV6P0HSkofx32uajudY601409321jV7ocj2eEXQSJSonBv9MuGvS+qdJN8GDF3JlcPwkNU/t1dDQDBIXYs9EbSXvUmC09DWNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDrc5LMlz30gX;
	Fri, 21 Aug 2026 19:04:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3B4C618D2;
	Fri, 21 Aug 2026 09:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49841F00A3E;
	Fri, 21 Aug 2026 09:03:59 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Linus Walleij <linusw@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <david@lechnology.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	arm-scmi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	soc@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 39/45] clk: ux500: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:49 +0200
Message-ID: <bd84df92640a05a1a73a8bc775b2d50568a9d0ec.1787239813.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787239813.git.geert+renesas@glider.be>
References: <cover.1787239813.git.geert+renesas@glider.be>
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

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/clk/ux500/clk-prcc.c    | 2 +-
 drivers/clk/ux500/clk-prcmu.c   | 4 ++--
 drivers/clk/ux500/clk-sysctrl.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index dce235df2576dfb2..dde72d2fd0ac67ae 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -97,8 +97,8 @@ static struct clk *clk_reg_prcc(const char *name,
 				unsigned long flags,
 				const struct clk_ops *clk_prcc_ops)
 {
+	struct clk_init_data clk_prcc_init = {};
 	struct clk_prcc *clk;
-	struct clk_init_data clk_prcc_init;
 	struct clk *clk_reg;
 
 	if (!name) {
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index ac96c46bd1bbf76b..d89f3b634f8bbd26 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -200,8 +200,8 @@ static struct clk_hw *clk_reg_prcmu(const char *name,
 				    unsigned long flags,
 				    const struct clk_ops *clk_prcmu_ops)
 {
+	struct clk_init_data clk_prcmu_init = {};
 	struct clk_prcmu *clk;
-	struct clk_init_data clk_prcmu_init;
 	int ret;
 
 	if (!name) {
@@ -357,8 +357,8 @@ struct clk_hw *clk_reg_prcmu_clkout(const char *name,
 				    u8 source, u8 divider)
 
 {
+	struct clk_init_data clk_prcmu_clkout_init = {};
 	struct clk_prcmu_clkout *clk;
-	struct clk_init_data clk_prcmu_clkout_init;
 	u8 clkout_id;
 	int ret;
 
diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index ba3258c88d28e101..2127a949e56ccf27 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -127,8 +127,8 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
 				unsigned long flags,
 				const struct clk_ops *clk_sysctrl_ops)
 {
+	struct clk_init_data clk_sysctrl_init = {};
 	struct clk_sysctrl *clk;
-	struct clk_init_data clk_sysctrl_init;
 	struct clk *clk_reg;
 	int i;
 
-- 
2.43.0


