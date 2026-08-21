Return-Path: <linux-aspeed+bounces-4772-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091DC5DF7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 08:55:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRDfg6T6xz2y83;
	Fri, 21 Aug 2026 18:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787302539;
	cv=none; b=fVi+iwD0nZvr7Q7TSKF1M8aHbXFzm6x22n5GuzFOQ2ZBLdeJnuYB+xwcAkSK5V2yIzcZnJCfkpa9ctBQCc8lks6gOj7+mC6DWXLyWbLvR0Ganrl1biA6eqsrnclGsA/tyXJaosZTDw4Q/8utu11gfrLHGNnWj+4EF33VgFG1fcp7dQiqwiZ+VqXejTP4WUbH+GZbNrOfZ/Paf2D/W1Oac57i4T2+lmY6lyKwJNSMpm8356ps9VvvioJ03+N7jre+D/orrLNPKcV+P+2N5AQyIEfj+bbKgEuTYBf43jOzmhbiCm/XsQ7qo5SNx5258aPUO9xVkEhG27L5FaSzs2CQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787302539; c=relaxed/relaxed;
	bh=ExR3Ha4kXXEp9mVX2zskQEdxDAXbtZhqxb8u+CTSkyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng36qbiKZHVL+b1xeFWOVwXHHtgfsQw+y/ElHrv8YPEitHXzGFUsmfSKuXAJh1S63PbQh6YzujS9Nw4wQDdIHoJKxe0TcLDRagUgjacjMYpCh3C415156gEvcuA60v8T27H7iP6zOnEOhPD9Uyr79a0xGe6LtFTc8c0e45xSPMeIWGTFLTGbHFSGQsuCW1rricykVPNHlTXtKROjWp1Mk+NyKL6xFoDIH2vPIRlYXGEzfAbciB99r87pVInEqbdjZVWL4wl6kBs1f1wQKRD1tg6nWucVEI8A2YGgkiDvpwJOSd3WCHicOt+ElCt1/pMy3j+vHJSX+lFvf4gYlknQeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=h7h1=go=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRDfg04Hyz2xtt;
	Fri, 21 Aug 2026 18:55:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1E30A6187A;
	Fri, 21 Aug 2026 08:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23181F00A3D;
	Fri, 21 Aug 2026 08:55:21 +0000 (UTC)
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
Subject: [PATCH 05/45] clk: cdce925: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 10:53:15 +0200
Message-ID: <308a33a0e63241d94ee08a08a6de6cffa739556e.1787239813.git.geert+renesas@glider.be>
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
 drivers/clk/clk-cdce925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 30d0493c771818ff..4d49cc1659c07be2 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -620,7 +620,7 @@ static int cdce925_probe(struct i2c_client *client)
 	struct device_node *node = client->dev.of_node;
 	const char *parent_name;
 	const char *pll_clk_name[MAX_NUMBER_OF_PLLS] = {NULL,};
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	u32 value;
 	int i;
 	int err;
-- 
2.43.0


