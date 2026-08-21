Return-Path: <linux-aspeed+bounces-4775-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB12C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 08:56:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDgY0Lblz2yFt;
	Fri, 21 Aug 2026 18:56:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302584;
	cv=none; b=PMlIO7pbookY+B49T7RW6yORI29Q/3Qa16kZWdI34WXNJDvQg1UWnU+KLqJXbNQ9MyrejOE1tHrmx/qugQpsfWVLLfpmDQ+qWKrwZz6i5q1WQyi9v7nxl9DBoeNvIGBuIOq/tCLGfHJKiJ3ShDo0argVlpyYNSNaEsMMxZRaOLrIQQCj8butplPoYD1Txml/K45B2qUYtXF/wjw8di4mxCFv2Aj0wJYoanDVz/Vk397XgK+4/EkBrCcU9eQZXJ35MRTpomyODUwenEjDLuEVwCpKGvjj8RluA/BHLyzSLKOeSiQOVp9P5KbHP3AYTx/Qe53FL44tDKgXn/4/aBnbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302584; c=relaxed/relaxed;
	bh=R9u7lZYYlv+jpnW9eq1qoOhjFLXyVrFARYd3PLbz7IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZITe/n35cY9Eviz/gfV8w9Bnyb5MdH2MJsiOiP/WroAdQ/ALHBw/5iE2Rcc1uvsD4lu5KqKkqeCyzdZehzFJRY1g1+kfnJ3cPxpT5TfeN35wNIapveb09I1rSQoUGwYYbphMvnQWGUUt1GrK2UmTOg76ymizVN6iMroBgzyaxqZlj1P1GeVSyv+l+CyqYikUW3azZGlE0NAyd7B80AyGaSOl1/faR2otMF/f4ibCJw5eX56o7/xcxci1RzrLm0cWNxwwMLrPHYAFLLgsscJ7vYfH99Cbt2jG5HsJJw/onec8Vne47iOkslLByRu0dP+ngUzCAHxlzd/FNcU3ck9Rlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDgX1sPXz2yDm;
	Fri, 21 Aug 2026 18:56:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7400E4390C;
	Fri, 21 Aug 2026 08:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27A51F000E9;
	Fri, 21 Aug 2026 08:56:07 +0000 (UTC)
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
Subject: [PATCH 08/45] clk: davinci: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:18 +0200
Message-ID: <f3b503ff3fda049988c3e16071bbbfabf1b04629.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/davinci/da8xx-cfgchip.c | 4 ++--
 drivers/clk/davinci/pll.c           | 2 +-
 drivers/clk/davinci/psc.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index a5109fe8b16e9b40..9d7fced898ae07fc 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -91,7 +91,7 @@ da8xx_cfgchip_gate_clk_register(struct device *dev,
 	struct clk *parent;
 	const char *parent_name;
 	struct da8xx_cfgchip_gate_clk *gate;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	parent = devm_clk_get(dev, NULL);
@@ -241,7 +241,7 @@ da8xx_cfgchip_mux_clk_register(struct device *dev,
 {
 	const char * const parent_names[] = { info->parent0, info->parent1 };
 	struct da8xx_cfgchip_mux_clk *mux;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index f73b0ac5d8a08bf1..0e58b02d7acaf175 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -371,7 +371,7 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	char pllout_name[MAX_NAME_SIZE];
 	char postdiv_name[MAX_NAME_SIZE];
 	char pllen_name[MAX_NAME_SIZE];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct davinci_pll_clk *pllout;
 	struct davinci_pllen_clk *pllen;
 	struct clk *oscin_clk = NULL;
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index ff603520d56f94d6..73dce7ce2be6cc88 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -234,7 +234,7 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 			  const char *parent_name, struct regmap *regmap,
 			  u32 md, u32 pd, u32 flags)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct davinci_lpsc_clk *lpsc;
 	int ret;
 	bool is_on;
-- 
2.43.0


