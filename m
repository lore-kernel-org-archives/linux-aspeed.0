Return-Path: <linux-aspeed+bounces-2214-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70335CAC593
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Sep 2025 05:22:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNN9Q11x6z3chq;
	Fri, 12 Sep 2025 15:22:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757654570;
	cv=none; b=M60jTyiC4QFvZsZxs2QRJk0hPDTYKuGdHuoc9FzK3VBkaXUuJ2uxqSWrVKlEe5fA6w8kex55u29gnHJW3vjG6ZR4rdcZrTYI+LMsvSWxOVYtecOcoHFab5s/8y4bPUX0tAmDRZoJ/U73a1dC0IotIBis3RquqhNKAfXCIG1z8kLHRKv5VeIpIN50yKYqedeKJiSZlZmrm7JJERcDBpeOhIF1MPIzaHYVdswLTpPekWDwS7Nw5sF5SYCh6FXR62BvjIY/H/Ndxog1ht7uC6YZEl/BlrzA3s7K5U5W6BzR+NqV2aCzC5RkcY15GpJLx/vDaIs3J8+lJNQzqgUJzpPGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757654570; c=relaxed/relaxed;
	bh=IQx+mwF16Ws2c3BMSABJS0KO6FKXd3VLzeSfwnur18Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NF+3zL4n7mHbTWK7jR8WETwAZXiYxClFxUyKfr/xdtVHUfSTAQAy2rF+XZxyJBMSdycDu+4PZw7gL0tkXGiFILMaSOCEmnvHUPsnJzwTIKv5ODMjWvBEQaM0o7stQ/GMEMcGvIzozvcBUMn3o0mvTEejo8NcJihXl5LaKvZbVsVkfBw0afBggDLoi2opYu2oHiXgJLrrdAowTCRnsjL1RrCr8xsHDqw2hPuK4OUzlLfUZlPtVIauJzqkWJ+ydwoYgX/PgKVasTju+uOD4f/FWfN65+Uaoo3SZ1O8Kx+wgHNWtLiuH0RCwhSOVfc2lEOAPdwIX115UbKXfWfnW1IbPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cNN9P4CCJz2xnr
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Sep 2025 15:22:49 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 12 Sep
 2025 13:22:31 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Sep 2025 13:22:31 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, "Rom
 Lemarchand" <romlem@google.com>, William Kennington <wak@google.com>, "Yuxiao
 Zhang" <yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v13 1/3] dt-bindings: clock: ast2700: modify soc0/1 clock define
Date: Fri, 12 Sep 2025 13:22:29 +0800
Message-ID: <20250912052231.1944937-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912052231.1944937-1-ryan_chen@aspeedtech.com>
References: <20250912052231.1944937-1-ryan_chen@aspeedtech.com>
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


