Return-Path: <linux-aspeed+bounces-4769-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF144C5DF7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 08:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDdp38XGz2y83;
	Fri, 21 Aug 2026 18:54:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302494;
	cv=none; b=XOI08c7mrjlrzjP+TuPtra6FY6D4p2weW+1mgdXJVY2OB+n2wXdiMwXww9zVNyHwMTQ9bE9r5M/E4TvMUtDY66R/JUjJ2RnOklaUWzqu44qh/50S+uC0mIDvGKg6HrsaTna5TcTwQZCMN8k5yCFC9yyw6YzY55OWF/n0HW8Xs4r7M1iq7c7kd+aE5BiKxCGOYX347zNM4V+EBrDEhBmOLF8qaKKbJkWX7EH4xB7tRzKFTRXt9auc0kk52sFGlG78dqY8UD6Pj2WRn3kpkOKXf18y7e08/Ofz54a/klw7j3+fFwohgP2t3+QzfnXI9AM2jrd1M8Niuj0BKEZ2o9XtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302494; c=relaxed/relaxed;
	bh=YXBXonxdki/yWapcMtRzH7OUwshKvPwDPA/+AEnX4xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib6ny6hz92B15K+pzNl7xYKnbPvzOtMjjwNWaxYCyt96cSHeRNGyeGVU0gbVgAsgl9KKHpsx9YAVm447+ZWEY+LM0vSbgtmUWMWu0l2/6hioh4k6Ko6SLjr+tF9aXHeJ5Kkw3NvhsI45+HC0LocYPjsp8JeXdGdClKKj8roNt/yW0pBEWrXNLe3AK0hfOkhV+VO1TEZREWh64j4wzsNSfwuDc3RnzMP27MmoFcACPGau9Wb0A0Oof2Q1Z0WP2yUu2XgmLm/z4wxdJmKFUe+ALZ6CSgluWMGsj0opT3bU1yFqab8XH+d1c/0iUuxajFHm+nrU75O1WKkqnzEwduCYVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDdn46R5z2xWt;
	Fri, 21 Aug 2026 18:54:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C3DF60A73;
	Fri, 21 Aug 2026 08:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A21F000E9;
	Fri, 21 Aug 2026 08:54:35 +0000 (UTC)
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
Subject: [PATCH 02/45] clk: at91: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:12 +0200
Message-ID: <f402b659481b7e5abe90340bb43adc427cdfe70f.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/at91/clk-audio-pll.c | 4 ++--
 drivers/clk/at91/clk-h32mx.c     | 2 +-
 drivers/clk/at91/clk-main.c      | 2 +-
 drivers/clk/at91/clk-pll.c       | 2 +-
 drivers/clk/at91/clk-plldiv.c    | 2 +-
 drivers/clk/at91/clk-slow.c      | 2 +-
 drivers/clk/at91/clk-smd.c       | 2 +-
 drivers/clk/at91/clk-usb.c       | 6 +++---
 drivers/clk/at91/sckc.c          | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index 732037bfbda836fe..26875ad0cce79ae0 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -486,8 +486,8 @@ struct clk_hw * __init
 at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
 				const char *parent_name)
 {
+	struct clk_init_data init = {};
 	struct clk_audio_pad *apad_ck;
-	struct clk_init_data init;
 	int ret;
 
 	apad_ck = kzalloc_obj(*apad_ck);
@@ -517,8 +517,8 @@ struct clk_hw * __init
 at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 				const char *parent_name)
 {
+	struct clk_init_data init = {};
 	struct clk_audio_pmc *apmc_ck;
-	struct clk_init_data init;
 	int ret;
 
 	apmc_ck = kzalloc_obj(*apmc_ck);
diff --git a/drivers/clk/at91/clk-h32mx.c b/drivers/clk/at91/clk-h32mx.c
index 12bd112d3c509fe6..8d5488223e4937ef 100644
--- a/drivers/clk/at91/clk-h32mx.c
+++ b/drivers/clk/at91/clk-h32mx.c
@@ -97,7 +97,7 @@ at91_clk_register_h32mx(struct regmap *regmap, const char *name,
 			const char *parent_name)
 {
 	struct clk_sama5d4_h32mx *h32mxclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	h32mxclk = kzalloc_obj(*h32mxclk);
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index ab515239adcf49e6..6074ed2a16cede94 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -298,8 +298,8 @@ at91_clk_register_main_rc_osc(struct regmap *regmap,
 			      const char *name,
 			      u32 frequency, u32 accuracy)
 {
+	struct clk_init_data init = {};
 	struct clk_main_rc_osc *osc;
-	struct clk_init_data init;
 	struct clk_hw *hw;
 	int ret;
 
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index b89f60cf02416eb6..1b9a37a9e0701b56 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -318,7 +318,7 @@ at91_clk_register_pll(struct regmap *regmap, const char *name,
 {
 	struct clk_pll *pll;
 	struct clk_hw *hw;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int offset = PLL_REG(id);
 	unsigned int pllr;
 	int ret;
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index 5f93aead03fa5810..135ca0abeb18898f 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -86,9 +86,9 @@ struct clk_hw * __init
 at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 			 const char *parent_name)
 {
+	struct clk_init_data init = {};
 	struct clk_plldiv *plldiv;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	plldiv = kzalloc_obj(*plldiv);
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index f0cad50e490bf16e..dc0009ca2cef55b8 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -42,8 +42,8 @@ at91_clk_register_sam9260_slow(struct regmap *regmap,
 			       int num_parents)
 {
 	struct clk_sam9260_slow *slowck;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	if (!name)
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 77f2b8fe6cabd5fb..4eff52a9798ba443 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -113,9 +113,9 @@ struct clk_hw * __init
 at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
+	struct clk_init_data init = {};
 	struct at91sam9x5_clk_smd *smd;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	smd = kzalloc_obj(*smd);
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index b4dc86193e09fbd0..0e4c0367c1afa77c 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -224,9 +224,9 @@ _at91sam9x5_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char **parent_names, u8 num_parents,
 			     u32 usbs_mask)
 {
+	struct clk_init_data init = {};
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	usb = kzalloc_obj(*usb);
@@ -275,9 +275,9 @@ struct clk_hw * __init
 at91sam9n12_clk_register_usb(struct regmap *regmap, const char *name,
 			     const char *parent_name)
 {
+	struct clk_init_data init = {};
 	struct at91sam9x5_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	usb = kzalloc_obj(*usb);
@@ -394,9 +394,9 @@ struct clk_hw * __init
 at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 			    const char *parent_name, const u32 *divisors)
 {
+	struct clk_init_data init = {};
 	struct at91rm9200_clk_usb *usb;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	usb = kzalloc_obj(*usb);
diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 776118f14867de02..fc5ca22d181a7502 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -231,9 +231,9 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      unsigned long startup,
 			      const struct clk_slow_bits *bits)
 {
+	struct clk_init_data init = {};
 	struct clk_slow_rc_osc *osc;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	if (!sckcr || !name)
-- 
2.43.0


