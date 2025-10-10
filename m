Return-Path: <linux-aspeed+bounces-2410-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CA1CCD18D
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 07:26:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjdZb04dFz2xjv;
	Fri, 10 Oct 2025 18:25:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760081158;
	cv=none; b=diE4U8gAR+d0tFRdtzklHGt1O78ZZb4pcTXVQbv4bEw2YFqE7KhFc46vKYPSfyQJYY2UFUCuHEaJ2GqoXjXEiMTGgggCmyuQF/ZX+OYXVlD0BjaRjzMbYrxzyUvXLSkBnFkvu+vO+Lw/Xyrtp1cfzRfzzqTw/TbIuTpek5B78Lii1QQY8Fl3rdC2ZInU5L1w1sP0pv42C4UPn1O3u8E3lMgUweBIiJPVBUwiBJ6CLY2ud7ldLqk33nJq5idKA2pP/5IvWxLc4itFaBt0afkUKVV3XexPXkDvxQNfEqF2dA7rC2hQhcHshO6LIMinh7DoD7FygdaU8PG8i7EjTucnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760081158; c=relaxed/relaxed;
	bh=IQx+mwF16Ws2c3BMSABJS0KO6FKXd3VLzeSfwnur18Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlOu1zKEKXlNi5AHr5IxiWoIKjcEvTyXLkf6sYWqMWQGD7b1cKMqZ7EsDYBN4Z+yA1/6lQCPBJ+WuLCRnuENk/jM8WNsBFwl1Xbcbp2u/CYDFlrY9XiVWIMDRi+I4o3SJElsSm2yPtyPMvLcvRPOepG+Basv/tu1Vdox15AWsIkRIN29OWZzdka74vZkjxP7hPO6Sb1R1tqJMZOEw1xxcoU7KEQ7AoFsoNZ+4XQnJTy8CUXIoJuefOtLs2jRzGDkp9bs+Ru930LaRlF17BHJS8QOlPvtDD7He8B191M0FpomklEbX1Kaep6GNAsg2WkHYXNl2Ct4/jIt/Go58SQh1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjdZZ3QyCz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 18:25:58 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 10 Oct
 2025 15:25:40 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 10 Oct 2025 15:25:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>,
	"Andrew Jeffery" <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mo Elbadry
	<elbadrym@google.com>, "Rom Lemarchand" <romlem@google.com>, William
 Kennington <wak@google.com>, "Yuxiao Zhang" <yuxiaozhang@google.com>,
	<wthai@nvidia.com>, <leohu@nvidia.com>, <dkodihalli@nvidia.com>,
	<spuranik@nvidia.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v15 1/3] dt-bindings: clock: ast2700: modify soc0/1 clock define
Date: Fri, 10 Oct 2025 15:25:38 +0800
Message-ID: <20251010072540.666673-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010072540.666673-1-ryan_chen@aspeedtech.com>
References: <20251010072540.666673-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain

-add SOC0_CLK_AHBMUX:
add SOC0_CLK_AHBMUX for ahb clock source divide.
mpll->
      ahb_mux -> div_table -> clk_ahb
hpll->

-new add clock:
 SOC0_CLK_MPHYSRC: UFS MPHY clock source.
 SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
 SOC1_CLK_I3C: I3C clock source.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/aspeed,ast2700-scu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
index 63021af3caf5..bacf712e8e04 100644
--- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -68,6 +68,9 @@
 #define SCU0_CLK_GATE_UFSCLK	53
 #define SCU0_CLK_GATE_EMMCCLK	54
 #define SCU0_CLK_GATE_RVAS1CLK	55
+#define SCU0_CLK_U2PHY_REFCLKSRC 56
+#define SCU0_CLK_AHBMUX			57
+#define SCU0_CLK_MPHYSRC		58
 
 /* SOC1 clk */
 #define SCU1_CLKIN		0
@@ -159,5 +162,6 @@
 #define SCU1_CLK_GATE_PORTCUSB2CLK	84
 #define SCU1_CLK_GATE_PORTDUSB2CLK	85
 #define SCU1_CLK_GATE_LTPI1TXCLK	86
+#define SCU1_CLK_I3C				87
 
 #endif
-- 
2.34.1


