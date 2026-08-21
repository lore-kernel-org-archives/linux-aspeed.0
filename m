Return-Path: <linux-aspeed+bounces-4801-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2068DC5DF8C
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 09:03:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDqB26WWz304l;
	Fri, 21 Aug 2026 19:03:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302982;
	cv=none; b=PBraRxS7jKVuNAhG02mkb6kzgKC/2OVD9OgEevjJNwflzu+0hGy04zs/WTTA0IkpnGVqahAAQinMu+8Lzvs9/b2dxGrlzY/YQxAlxC1fBAh6vriSJTSe5KxaLcBO7s1vJzpsyjAaIVI0shDS81VyDmeAYe394NtdoJ4xS7W+DMq8NBATlu01yZnPkKI+vPB5L4Pa77EX0IaoY++7lDUEalgI1qqgNvBhEJrhHAn4XEQ9elRmRetcbwfegZcR6rmFk89Ubfv6+u9juy2Z2NsnUtb5u6H+Ax4eiEgffdh6OaCj6xNf/Ax/QsnFgs5VzXuYMSzcf2Kui77jMnPosjen/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302982; c=relaxed/relaxed;
	bh=6E5fG2+nEik0ay/c+1HINFkbMjG4z3r5bpfH0fvjLhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfUVX7S/N+cwuzkWRk4r5tAcc+VXYePLjloF+3Xt8AARPbCmnGm2ZLoQSB1zOHmoQJFueySoK/90GNql/B1erNKxi+ChzbMAk/mRrOF5Czki4pi3Pozd1OL83gvyM/HMf/L9Kj5Cb6CV4iv4fTP6SI8EqaMFsH0ZOpLh2t9kz6wyJr1r0FwyJRwXppt+Ieu1Dywt8K3ZycavEL61vmAUCv3vkZ8OuMPiXlGaJiJILmrhYU3y1MGFfwBksc5Ohw7bdwCtyf+vvzr+EI4vYzmv+PZevU2wLWBLkeE4knLNdL2WYkqV8HSgBFAdEcZlQ6kMnd13rK0h8xvXsJ0NnNsBuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDq92zchz302l;
	Fri, 21 Aug 2026 19:03:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B4156189B;
	Fri, 21 Aug 2026 09:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856551F000E9;
	Fri, 21 Aug 2026 09:02:44 +0000 (UTC)
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
Subject: [PATCH 34/45] clk: stm32: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:44 +0200
Message-ID: <0b80535e9cfdc96d43169e5023e3a92a8f2252d6.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/clk-stm32f4.c        | 4 ++--
 drivers/clk/clk-stm32h7.c        | 2 +-
 drivers/clk/stm32/clk-stm32mp1.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 565b4d99bebb06e8..6603d4815514151a 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -485,8 +485,8 @@ static struct clk *clk_register_apb_mul(struct device *dev, const char *name,
 					const char *parent_name,
 					unsigned long flags, u8 bit_idx)
 {
+	struct clk_init_data init = {};
 	struct clk_apb_mul *am;
-	struct clk_init_data init;
 	struct clk *clk;
 
 	am = kzalloc_obj(*am);
@@ -810,8 +810,8 @@ static struct clk_hw *clk_register_pll_div(const char *name,
 		struct clk_hw *pll_hw, spinlock_t *lock)
 {
 	struct stm32f4_pll_div *pll_div;
+	struct clk_init_data init = {};
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	/* allocate the divider */
diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
index 82e0789cf189c7cb..c6afa9b202351c04 100644
--- a/drivers/clk/clk-stm32h7.c
+++ b/drivers/clk/clk-stm32h7.c
@@ -462,8 +462,8 @@ static struct clk_hw *clk_register_stm32_timer_ker(struct device *dev,
 		u8 dppre_shift,
 		spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct timer_ker *element;
-	struct clk_init_data init;
 	struct clk_hw *hw;
 	int err;
 
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 2d9ccd96ec98c05e..b265e3f3e94c2805 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -902,8 +902,8 @@ static struct clk_hw *clk_register_pll(struct device *dev, const char *name,
 				       unsigned long flags,
 				       spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct stm32_pll_obj *element;
-	struct clk_init_data init;
 	struct clk_hw *hw;
 	int err;
 
@@ -1041,8 +1041,8 @@ static struct clk_hw *clk_register_cktim(struct device *dev, const char *name,
 					 void __iomem *timpre,
 					 spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct timer_cker *tim_ker;
-	struct clk_init_data init;
 	struct clk_hw *hw;
 	int err;
 
-- 
2.43.0


