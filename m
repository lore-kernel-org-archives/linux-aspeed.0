Return-Path: <linux-aspeed+bounces-4794-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5FFC5DF7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 09:01:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDn84b9Yz2yvP;
	Fri, 21 Aug 2026 19:01:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302876;
	cv=none; b=N8im9oyI3jt6iUJaZ9qDxZtjRzJOupuniT242BnvmaXQud1EudGjfQtyVPAovaT4Zcik5G9f7TepFOhK3zCuh5JXJU4RBRLfuDzgdx/KwBuOHLb6AAIczntfNhFne2DVRZn7J77szpT2zOmot86tzRms6m75VnsfMt42PblZ2VFpuoinn9eSRq1o+lK/Tz70YT3U4i47HOofhorovJ3Um13Pezd/OlfdygEeUS/P7mlvPzIz3oBvdx9YvGS06giu1H4qDgsRaA6hCbpHDEl9FB4h7Zs4Xsdzl/TKrLDOm7MZFdtam18s1Yh9H0GBi+KTCKzrzyk+vDXl2w3CHwwOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302876; c=relaxed/relaxed;
	bh=05gTl57+h9xghNBWG0C/kPdhcBSMafMBqYK4LsWo/hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEzuVT0aHmET/UJwX/aoOLFhtCCmdbm1gowVhesQvBAMZkwjWAIF5TSvfyyK3aj3RBwtf2JgoSN1cZzT6B8Ean8HWRtkrr3mJIN5n13lkaafctPPhFhivIswBs+U2CHqUt23gLdPWFU16yEZd4tJrfFeRH44OrqkI9QKc2xsBltwIw71KQCIyTZzLBZEdIOpUL4qqrpBbfwwpcY0aU+mLVYsDBh5xSs9wT/Pv6Q3VrP2HPIYJSDgQFu+KWLbj7+KcL3eB4KEfV24bMlQRHnePM8g9ChLGOV/t2+4DPGhi6UhVc0Pcmn8vmHjHMKtj6Vu5J7iwlNd728IV2U58xTJYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDn75Wknz2yty;
	Fri, 21 Aug 2026 19:01:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA286618A0;
	Fri, 21 Aug 2026 09:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D868B1F00A3A;
	Fri, 21 Aug 2026 09:00:58 +0000 (UTC)
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
Subject: [PATCH 27/45] clk: renesas: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:37 +0200
Message-ID: <b3473adc50c71aec5bc5f7ce6f5cda1727e26635.1787239813.git.geert+renesas@glider.be>
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
Boot-tested on RZ/Five.
---
 drivers/clk/renesas/rzg2l-cpg.c | 18 +++++++++---------
 drivers/clk/renesas/rzv2h-cpg.c |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 88d74858687d4866..50b64eb3eafebe71 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -580,7 +580,7 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 			      struct rzg2l_cpg_priv *priv)
 {
 	struct sd_mux_hw_data *sd_mux_hw_data;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *clk_hw;
 	int ret;
 
@@ -831,9 +831,9 @@ rzg2l_cpg_dsi_div_clk_register(const struct cpg_core_clk *core,
 			       struct rzg2l_cpg_priv *priv)
 {
 	struct dsi_div_hw_data *clk_hw_data;
+	struct clk_init_data init = {};
 	const struct clk *parent;
 	const char *parent_name;
-	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
@@ -916,8 +916,8 @@ static struct clk * __init
 rzg3l_cpg_lvds_div_clk_register(const struct cpg_core_clk *core,
 				struct rzg2l_cpg_priv *priv)
 {
+	struct clk_init_data init = {};
 	struct clk_fixed_factor *ff;
-	struct clk_init_data init;
 	const struct clk *parent;
 	const char *parent_name;
 	int ret;
@@ -1031,9 +1031,9 @@ rzg3l_cpg_dsi_div_clk_register(const struct cpg_core_clk *core,
 			       struct rzg2l_cpg_priv *priv)
 {
 	struct g3l_dsi_div_hw_data *clk_hw_data;
+	struct clk_init_data init = {};
 	const struct clk *parent;
 	const char *parent_name;
-	struct clk_init_data init;
 	struct clk_hw *clk_hw;
 	int ret;
 
@@ -1128,7 +1128,7 @@ rzg2l_cpg_pll5_4_mux_clk_register(const struct cpg_core_clk *core,
 				  struct rzg2l_cpg_priv *priv)
 {
 	struct pll5_mux_hw_data *clk_hw_data;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *clk_hw;
 	int ret;
 
@@ -1255,8 +1255,8 @@ static struct clk * __init
 rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
 			  struct rzg2l_cpg_priv *priv)
 {
+	struct clk_init_data init = {};
 	const struct clk *parent;
-	struct clk_init_data init;
 	const char *parent_name;
 	struct sipll5 *sipll5;
 	struct clk_hw *clk_hw;
@@ -1381,9 +1381,9 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 			   struct rzg2l_cpg_priv *priv,
 			   const struct clk_ops *ops)
 {
+	struct clk_init_data init = {};
 	struct device *dev = priv->dev;
 	const struct clk *parent;
-	struct clk_init_data init;
 	const char *parent_name;
 	struct pll_clk *pll_clk;
 	int ret;
@@ -1525,8 +1525,8 @@ static struct clk * __init
 rzg3l_cpg_dsi_mux_clk_register(const struct cpg_core_clk *core,
 			       struct rzg2l_cpg_priv *priv)
 {
+	struct clk_init_data init = {};
 	struct clk_mux *mux_data;
-	struct clk_init_data init;
 	int ret;
 
 	mux_data = devm_kzalloc(priv->dev, sizeof(*mux_data), GFP_KERNEL);
@@ -2265,10 +2265,10 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 			   const struct rzg2l_cpg_info *info,
 			   struct rzg2l_cpg_priv *priv)
 {
+	struct clk_init_data init = {};
 	struct mod_clock *clock = NULL;
 	struct device *dev = priv->dev;
 	unsigned int id = mod->id;
-	struct clk_init_data init;
 	struct clk *parent, *clk;
 	const char *parent_name;
 	unsigned int i;
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 917fc737f254b916..7003d59ac34b1179 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -338,7 +338,7 @@ rzv2h_cpg_plldsi_div_clk_register(const struct cpg_core_clk *core,
 {
 	struct rzv2h_plldsi_div_clk *clk_hw_data;
 	struct clk **clks = priv->clks;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const struct clk *parent;
 	const char *parent_name;
 	struct clk_hw *clk_hw;
@@ -582,7 +582,7 @@ rzv2h_cpg_plldsi_smux_clk_register(const struct cpg_core_clk *core,
 				   struct rzv2h_cpg_priv *priv)
 {
 	struct rzv2h_plldsi_mux_clk *clk_hw_data;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_hw *clk_hw;
 	struct smuxed smux;
 	int ret;
@@ -711,7 +711,7 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *core,
 			   const struct clk_ops *ops)
 {
 	struct device *dev = priv->dev;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const struct clk *parent;
 	const char *parent_name;
 	struct pll_clk *pll_clk;
@@ -1229,7 +1229,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
 {
 	struct mod_clock *clock = NULL;
 	struct device *dev = priv->dev;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *parent, *clk;
 	const char *parent_name;
 	unsigned int id;
-- 
2.43.0


