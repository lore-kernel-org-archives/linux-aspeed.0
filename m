Return-Path: <linux-aspeed+bounces-817-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D842C021B8
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Feb 2025 09:55:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z1bhD5kLnz2yVv;
	Mon, 24 Feb 2025 20:55:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740390924;
	cv=none; b=ZQ/NvAR3awn+nVoNW2Yq71HPtBm8AMQ4r62sPVKMDGfI4pbeb9R0IKmFmvD6d9iZ5M6qcO0ec/HFmSAj5TD1mehmO/L+0I8wlh2zYdbKu0cU7B+NrEbTbswqRxgRub0ZUB/VjNRPijLBlIbQjiGo3dGhRdOy587JKa2TYG/GDtJNG0B2buAYzg5WMh5tmDSSxzri7mBc2LZqFqCIjZOBe7SyCprf4Mt0u+B45WViHsy8fgSO0pDOEIMQVgwa6rMZ2pnEhmtvVCJGkkBHXvNu5a0VJTXk39BvSpVDvQ/3ASrhUlQTUTf6yBt9BdgPWnRBdsVpgBlaZitdsm/KLb5whA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740390924; c=relaxed/relaxed;
	bh=DUeLil7NYb5vFj2LmQhnckZiCgj3SfnkLx7lSucrD3s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTPiww9mW5WeU7KVgIUMmOaxQOb24+5q642KiiTqOkTBQtYTxLhefbiuZ6/lP4RkPxuuOeE4h/CZNRq9++6y2CSVXBO39OeWsFuCxFxik6qrTZg6r9n3buj/m4EpG+K1jfuRZ423jx28xmYkr+plHpayHtMIGU3GJNxC14s3M4cjWKpCmf5ljIeswb011G+VuTOlC63HtwnbF/Vle7sH1/+2AdQw3cgYaK/AHPIbO6mGSWLmTOX1+SEgvJCD7FGfX/sL5OX6GqxNPqraWhsyYAMvhtm12PGVMUxwEIQ512ie/8h7k5cXp5BR1zYnFlpFbP/hVhCsbAkdqn1KR7h1Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z1bhD25Ynz2yDH
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Feb 2025 20:55:24 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 24 Feb
 2025 17:55:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 24 Feb 2025 17:55:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/3] dt-binding: clock: ast2700: modify soc0/1 clock define
Date: Mon, 24 Feb 2025 17:55:04 +0800
Message-ID: <20250224095506.2047064-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
References: <20250224095506.2047064-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain

-remove redundant SOC0_CLK_UART_DIV13:
SOC0_CLK_UART_DIV13 is not use at clk-ast2700.c, the clock
source tree is uart clk src -> uart_div_table -> uart clk.

-Change SOC0_CLK_HPLL_DIV_AHB to SOC0_CLK_AHBMUX:
modify clock tree implement.
older CLK_AHB use mpll_div_ahb/hpll_div_ahb to be ahb clock source.
mpll->mpll_div_ahb
                  -> clk_ahb
hpll->hpll_div_ahb

new use SOC0_CLK_AHBMUX for more understand clock source divide tree.
mpll->
      ahb_mux -> div_table -> clk_ahb
hpll->

-new add clock:
 SOC0_CLK_MPHYSRC: UFS MPHY clock source.
 SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
 SOC1_CLK_I3C: I3C clock source.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 include/dt-bindings/clock/aspeed,ast2700-scu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
index 63021af3caf5..c7389530629d 100644
--- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -13,18 +13,17 @@
 #define SCU0_CLK_24M		1
 #define SCU0_CLK_192M		2
 #define SCU0_CLK_UART		3
-#define SCU0_CLK_UART_DIV13	3
 #define SCU0_CLK_PSP		4
 #define SCU0_CLK_HPLL		5
 #define SCU0_CLK_HPLL_DIV2	6
 #define SCU0_CLK_HPLL_DIV4	7
-#define SCU0_CLK_HPLL_DIV_AHB	8
+#define SCU0_CLK_AHBMUX		8
 #define SCU0_CLK_DPLL		9
 #define SCU0_CLK_MPLL		10
 #define SCU0_CLK_MPLL_DIV2	11
 #define SCU0_CLK_MPLL_DIV4	12
 #define SCU0_CLK_MPLL_DIV8	13
-#define SCU0_CLK_MPLL_DIV_AHB	14
+#define SCU0_CLK_MPHYSRC	14
 #define SCU0_CLK_D0		15
 #define SCU0_CLK_D1		16
 #define SCU0_CLK_CRT0		17
@@ -68,6 +67,7 @@
 #define SCU0_CLK_GATE_UFSCLK	53
 #define SCU0_CLK_GATE_EMMCCLK	54
 #define SCU0_CLK_GATE_RVAS1CLK	55
+#define SCU0_CLK_U2PHY_REFCLKSRC 56
 
 /* SOC1 clk */
 #define SCU1_CLKIN		0
@@ -160,4 +160,5 @@
 #define SCU1_CLK_GATE_PORTDUSB2CLK	85
 #define SCU1_CLK_GATE_LTPI1TXCLK	86
 
+#define SCU1_CLK_I3C	87
 #endif
-- 
2.34.1


