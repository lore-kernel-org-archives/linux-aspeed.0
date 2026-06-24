Return-Path: <linux-aspeed+bounces-4294-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F6CCDB479
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 05:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glW9v0BlFz2yYy;
	Wed, 24 Jun 2026 15:45:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782279922;
	cv=none; b=EAHhNZI4s3d6gZBm7Oachljzu9KSj1H+Vb9KQJz2iIUVpWAlGBjpm8Ee68OptU5D2ULb8Y84rN41pmro9BjPRrfR7XnB4OVq+ib+8xHoNX6VTjcaWJxaci62Fcp2e4pEk12JMaLzDXiyoaMWDjBf2M4U/urDCH5mKc23LBDd/p89Pv5ICnJCgdRvPwHOjhXRuF4Y7802mzl174BGMuczyNKL1XJgFcmCvsGidDZ1Ku5SUkRRuu4Bs3OfqcM9FRI8PwKr67qKgOHOMxBWN+4tT8uEC/hGzWugXo1FO6M9Vn6POB2V4Nhy80j5HFK/3raV5v8tm0cHflYQjEwr/xFd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782279922; c=relaxed/relaxed;
	bh=iDySdxnRkntHDclVVEKN1JxfjPXVhGAU814UjzYn0nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mHIzqe0m+W2YquYyPWjmTRkhzdDDlsgvwYKn+qUQI03n7BHmdPf9GBeQpRlSEJs7qnvrBkH7XcuBRX8uQiJvAHP3x5ncCkpMq7aWXDN997otTYMpXm5HGY4NZUyHvtv2vHLBCyI0izT8JxA/1UasyqFFv2NVtp7A7KHgxc65N88xfMKheRk0DfJiwBDDPWub4RO6ZorH5Lsv2ES508/nWW6kRiKcnna+ogPFfH2dre8OBorXWUVVFsf3fV5V8p7PuMxJCvUk1VIIPX0WO+W3Aw6DUvgxGEZggV514YO7WvAjoYVuWXlASM46VEpGIiy/oAVimPZv1KGZSIqSRCJc8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glW9t1xl0z2yQn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 15:45:22 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Jun
 2026 13:45:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Jun 2026 13:45:01 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 24 Jun 2026 13:45:00 +0800
Subject: [PATCH 2/2] clk: aspeed: add AST2700 PECI clock
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-peci_clk-v1-2-ee28b92e22e9@aspeedtech.com>
References: <20260624-peci_clk-v1-0-ee28b92e22e9@aspeedtech.com>
In-Reply-To: <20260624-peci_clk-v1-0-ee28b92e22e9@aspeedtech.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782279900; l=2202;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=JaGTBdxpHJ5fN4jX4hONzuI8SeSX32dT0OINEwJOlW0=;
 b=wx53gZa51rQIOOSRp0P/kkRu9+ktuqQtS5K609XIMHAwbayPtB5QtVf4naHm8A0llGtrfkO95
 tE4mAvNyW87CL9CLtBeyFKTQlqTIJG7T9HFgER1nGU/HP8s2wgzxj01
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Register the SoC1 PECI clock as a mux selected by SCU1_CLK_SEL2 bit 16,
choosing between the 25MHz CLKIN and HPLL/4. Add the HPLL/4 fixed factor
clock to serve as the second mux parent.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/clk/aspeed/clk-ast2700.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/aspeed/clk-ast2700.c b/drivers/clk/aspeed/clk-ast2700.c
index 8b7b382f6f3e..5f499ec0e1d1 100644
--- a/drivers/clk/aspeed/clk-ast2700.c
+++ b/drivers/clk/aspeed/clk-ast2700.c
@@ -273,6 +273,13 @@ static const unsigned int sdclk_parent_ids[] = {
 
 static const struct clk_hw *sdclk_parent_hws[ARRAY_SIZE(sdclk_parent_ids)];
 
+static const unsigned int peciclk_parent_ids[] = {
+	SCU1_CLKIN,
+	SCU1_CLK_HPLL_DIV4
+};
+
+static const struct clk_hw *peciclk_parent_hws[ARRAY_SIZE(peciclk_parent_ids)];
+
 #define FIXED_CLK(_id, _name, _rate) \
 	{ \
 		.id = _id,	\
@@ -458,6 +465,7 @@ static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initconst = {
 	PLL_CLK(SCU1_CLK_HPLL, CLK_PLL, "soc1-hpll", SCU1_CLKIN, SCU1_HPLL_PARAM),
 	PLL_CLK(SCU1_CLK_APLL, CLK_PLL, "soc1-apll", SCU1_CLKIN, SCU1_APLL_PARAM),
 	PLL_CLK(SCU1_CLK_DPLL, CLK_PLL, "soc1-dpll", SCU1_CLKIN, SCU1_DPLL_PARAM),
+	FIXED_FACTOR_CLK(SCU1_CLK_HPLL_DIV4, "soc1-hpll_div4", SCU1_CLK_HPLL, 1, 4),
 	FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV2, "soc1-apll_div2", SCU1_CLK_APLL, 1, 2),
 	FIXED_FACTOR_CLK(SCU1_CLK_APLL_DIV4, "soc1-apll_div4", SCU1_CLK_APLL, 1, 4),
 	FIXED_FACTOR_CLK(SCU1_CLK_CAN, "canclk", SCU1_CLK_APLL, 1, 10),
@@ -481,6 +489,8 @@ static const struct ast2700_clk_info ast2700_scu1_clk_info[] __initconst = {
 		uxclk_parent_hws, SCU1_CLK_SEL2, 0, 2),
 	MUX_CLK(SCU1_CLK_HUXCLK, "huxclk", uxclk_parent_ids, ARRAY_SIZE(uxclk_parent_ids),
 		uxclk_parent_hws, SCU1_CLK_SEL2, 3, 2),
+	MUX_CLK(SCU1_CLK_PECI, "peciclk", peciclk_parent_ids, ARRAY_SIZE(peciclk_parent_ids),
+		peciclk_parent_hws, SCU1_CLK_SEL2, 16, 1),
 	DIVIDER_CLK(SCU1_CLK_SDCLK, "sdclk", SCU1_CLK_SDMUX,
 		    SCU1_CLK_SEL1, 14, 3, ast2700_clk_div_table),
 	PLL_CLK(SCU1_CLK_UARTX, CLK_UART_PLL, "uartxclk", SCU1_CLK_UXCLK, SCU1_UXCLK_CTRL),

-- 
2.34.1


