Return-Path: <linux-aspeed+bounces-4811-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A303C5DF87
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 09:05:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDt46v6Vz3bsy;
	Fri, 21 Aug 2026 19:05:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787303132;
	cv=none; b=F3wVDxLez71D95K4weSpEVBHsD6tQ3I+BZmRJAAu30pXFI8ITXwt0rM9/NJBb42rq5EkPN/hWnPCGwrf5W7Bap+QcV7r02zqxRE1YSVokn5SEb8kCgzTUQ7gs1i5wHHGy7iu8jlLjlQ9pPQtZMHXfYBGiKK1f2k+xqwNntSud++1IeJWN61q2xEMKaj/kC3G9KZfKNx18zeYbRgY4Zpz8/enCvAe5ctjpjv1WytMsxNGxHIM13UBNXtlbfjjRh8MzBDYXsaLFXM2zFm2kntZDpm+rZZYmIl9rp1fkQQ7IitwPfrJaJkdM6ZxYnvUqyzdYEUQxjZ4/EtedNORQ4vNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787303132; c=relaxed/relaxed;
	bh=f5Hzvca94/MpqPmGFa6vAWEDRGZpUXT7cxp37bpGpu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz5OLrB8wH9GU1Kq3KmyLhFPOVJQwBC+/1YZeCbKw365wQiEl6DbvWv+9rT3IMStjVfXtf8LZ5zSfQdRgn4pyC5SPQf6wzlfMnAfSMEtOPkQFGM9EWbNOizZPj1WQJQL5Xehajqd/jq59h0dG4rnp5o+avy48Qcuw82SrLiYXJkBMt0JiLyvuFRYPUnfQF7FTnwlJBwqAzyrRA2XqTYyvekUyAJ9PB8ceQwkMZPENYEg6/eBYrHGwBr84gX7lQCIArfhDOakgIokdufdusTCY+PhxXc8qgsydC3Wivt5fPDYD6WoiW57sfn4ceKn9T1q8Mvi1+rlSCeiTfh28GWPUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDt40dx8z3bsT;
	Fri, 21 Aug 2026 19:05:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D1EC618F9;
	Fri, 21 Aug 2026 09:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437761F00A3E;
	Fri, 21 Aug 2026 09:05:15 +0000 (UTC)
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
Subject: [PATCH 44/45] clk: xilinx: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:54 +0200
Message-ID: <cf858f84a9d517745fb53981f02f9c3dcd65a14f.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 6 +++---
 drivers/clk/xilinx/xlnx_vcu.c              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index edf8c0eaca27cab4..4e5b9cb3754b9a18 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -936,9 +936,9 @@ static struct clk_hw *clk_wzrd_register_divf(struct device *dev,
 					  u32 div_type,
 					  spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct clk_wzrd_divider *div;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
@@ -980,9 +980,9 @@ static struct clk_hw *clk_wzrd_ver_register_divider(struct device *dev,
 						 u32 div_type,
 						 spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct clk_wzrd_divider *div;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
@@ -1026,9 +1026,9 @@ static struct clk_hw *clk_wzrd_register_divider(struct device *dev,
 					     u32 div_type,
 					     spinlock_t *lock)
 {
+	struct clk_init_data init = {};
 	struct clk_wzrd_divider *div;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index f14bda375e353e6a..ccd9d7c0b18098a5 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -406,9 +406,9 @@ static struct clk_hw *xvcu_register_pll(struct device *dev,
 					const char *name, const char *parent,
 					unsigned long flags)
 {
+	struct clk_init_data init = {};
 	struct vcu_pll *pll;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 
 	init.name = name;
-- 
2.43.0


