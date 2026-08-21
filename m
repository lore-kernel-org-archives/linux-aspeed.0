Return-Path: <linux-aspeed+bounces-4795-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08139C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 09:01:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDnR1Wt6z2yvb;
	Fri, 21 Aug 2026 19:01:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302891;
	cv=none; b=QfTSHkrGQ1oxkMW+2kX95L+wIoxw4GVfZj97k2IMM7SJilObGDzTVT620F8w7TXxNjz9kd59ph3YXWbIsBG3SvtCiFM9g32Y+HFw08ot18SvJ4NKQyCyUn5CL2VCGsmAX99pE7DPGUZTAU0wy5hsQrq4eANJbqp2I4Ph1vtVxRfnqcGw+N+/Cpy/bw+dy1Vw/4P8WoXiyEQiJsxGIrW317Vk13mA9Bx8a3I0pf9PWBhQLOlgJq8NVKm7JxWzFJTkN719AkT666fUO8kEcRvvwROQQ6guJW/Bs4/QsiknqN5wfaTtQCQ4xL2CzuRhXkWbzz6gdBEUI0MxvEbVfS8NIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302891; c=relaxed/relaxed;
	bh=FtnjRRrO53tBGjyA0IvZ/MJnJC8JbX3FazwHIo/vkoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuQvOMcGoa+Yl9V5LkqwejGiDWRTPz1kZWFcbP8kFEHunkE716PAhD4J2yv/XIIes1j/r725NFS9YAHKpQ9PLCp6PPKnFshgrEKhvSGSFG2I8Q2yscY+Ya9KkB2dqBX8ypICHYp1miqXHnUE0TwVTJzMi3w0h7X+YC43sEM65rbY4zQjYlsem114xMN49hQ1qVjvWuU2ZIhnyspbL3Cq+t/T2TMqH4hUBDE3ob4MU5bZXrLS/4ZjyhvoAPfQvFB1c9ujaKJ9euLxbVGnaj/zvcMc7nC2jGDhdiIJOgU0TZgCFHomkwPyqiPMpmSlZGDDeFsVDxHKyk33Ks9XAvyaow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDnQ2lFBz2yvY;
	Fri, 21 Aug 2026 19:01:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C006745062;
	Fri, 21 Aug 2026 09:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB911F000E9;
	Fri, 21 Aug 2026 09:01:13 +0000 (UTC)
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
Subject: [PATCH 28/45] clk: rockchip: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:38 +0200
Message-ID: <49127c1f7529acccb17e1408db9f21f6d15aee2b.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/rockchip/clk-cpu.c       | 2 +-
 drivers/clk/rockchip/clk-ddr.c       | 2 +-
 drivers/clk/rockchip/clk-gate-grf.c  | 2 +-
 drivers/clk/rockchip/clk-inverter.c  | 2 +-
 drivers/clk/rockchip/clk-mmc-phase.c | 2 +-
 drivers/clk/rockchip/clk-muxgrf.c    | 2 +-
 drivers/clk/rockchip/clk-pll.c       | 2 +-
 drivers/clk/rockchip/clk.c           | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 6205af9ba88a8def..eb6b8b878e4dbeea 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -304,7 +304,7 @@ struct clk *rockchip_clk_register_cpuclk(const char *name,
 			int nrates, void __iomem *reg_base, spinlock_t *lock)
 {
 	struct rockchip_cpuclk *cpuclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk, *cclk;
 	int ret;
 
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index 81ae8a4ee30ed95c..fbb702d0b9d996d5 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -97,7 +97,7 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 					 spinlock_t *lock)
 {
 	struct rockchip_ddrclk *ddrclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	ddrclk = kzalloc_obj(*ddrclk);
diff --git a/drivers/clk/rockchip/clk-gate-grf.c b/drivers/clk/rockchip/clk-gate-grf.c
index 88e409e91a636aa1..458314a2569181d1 100644
--- a/drivers/clk/rockchip/clk-gate-grf.c
+++ b/drivers/clk/rockchip/clk-gate-grf.c
@@ -73,7 +73,7 @@ struct clk *rockchip_clk_register_gate_grf(const char *name,
 		u8 gate_flags)
 {
 	struct rockchip_gate_grf *gate;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	if (IS_ERR(regmap)) {
diff --git a/drivers/clk/rockchip/clk-inverter.c b/drivers/clk/rockchip/clk-inverter.c
index bf9072ed9fd4daed..e6c7dad60e966288 100644
--- a/drivers/clk/rockchip/clk-inverter.c
+++ b/drivers/clk/rockchip/clk-inverter.c
@@ -75,8 +75,8 @@ struct clk *rockchip_clk_register_inverter(const char *name,
 				void __iomem *reg, int shift, int flags,
 				spinlock_t *lock)
 {
-	struct clk_init_data init;
 	struct rockchip_inv_clock *inv_clock;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	inv_clock = kmalloc_obj(*inv_clock);
diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 4efd22953f3e0533..d92bea75faf73767 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -205,8 +205,8 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 				struct regmap *grf, int grf_reg,
 				int shift)
 {
-	struct clk_init_data init;
 	struct rockchip_mmc_clock *mmc_clock;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	int ret;
 
diff --git a/drivers/clk/rockchip/clk-muxgrf.c b/drivers/clk/rockchip/clk-muxgrf.c
index ccbb1379501ab474..ecdc77654813a3c3 100644
--- a/drivers/clk/rockchip/clk-muxgrf.c
+++ b/drivers/clk/rockchip/clk-muxgrf.c
@@ -59,7 +59,7 @@ struct clk *rockchip_clk_register_muxgrf(const char *name,
 				int shift, int width, int mux_flags)
 {
 	struct rockchip_muxgrf_clock *muxgrf_clock;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	if (IS_ERR(regmap)) {
diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 706ca4b344d399a3..7204b09243d483ae 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -1069,7 +1069,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		unsigned long flags, u8 clk_pll_flags)
 {
 	const char *pll_parents[3];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct rockchip_clk_pll *pll;
 	struct clk_mux *pll_mux;
 	struct clk *pll_clk, *mux_clk;
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index ee8c79b938d3c15b..10df21178ba483e2 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -257,7 +257,7 @@ static struct clk *rockchip_clk_register_frac_branch(
 
 	if (child) {
 		struct clk_mux *frac_mux = &frac->mux;
-		struct clk_init_data init;
+		struct clk_init_data init = {};
 		struct clk *mux_clk;
 		int ret;
 
-- 
2.43.0


