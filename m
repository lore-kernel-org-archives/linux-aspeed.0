Return-Path: <linux-aspeed+bounces-1372-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63122C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 07:37:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHHYP6F9cz307q;
	Wed, 11 Jun 2025 17:37:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749627433;
	cv=none; b=l3LE0QwLM8Fz1vYtimPc4Q1LRN04jxs7K6R4DKRmHrLNXR0vop3K/bUbMM6PXdEIwPOm6lQjQ3lfAiegjUa9eIxGulxzVrLR1SUR6A8Jwivye4MbVKgRYsqSVn8G6Hby0JyL+kHquOvWug8ph3IaksdZRBYAUOVqOhRjHkV0BvhKnicIofPQLG49WocLCH0KFGiVJidafVp2oQsIv6kYL16GP73jHmzjIkivqSia0WwS0afhhvYhtImN9yCC75R1x+oFbJ9Tc+QMyYF9xvmVwqqekwd83FBI8wn4SEynV0ytyqNubzh5WaUAQhb0sjFLf+dHOVHg+uWvViSG5GPLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749627433; c=relaxed/relaxed;
	bh=yH95aWPETOayyguISLe0UKP6EZMp5a53bp56Flj3zO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnjFpei4ErXpXy8etnLUWDG3F+ecnQ/lZxYN3oKhX2uXALRGfpzsH5Ld8tgwSVilEVWylQRW09biG6qgV9xVL39z8xiPSwgkzRMzBK5x9f84UJpU0BQZdfFUrCbHzTiVdPvM9GcnDMI0TyJ9ns8K8RoLcXHGWBgIL5R6giPwRxnqM3vDW7P3DzrdNS0tB9HlBiUOafD7+306CyYNFc8GlcTMKSotdO7irUAIPmIi5gXgZA+o59VRlTex73k81lO6hR7WMArwxOMzAynXjBZPwSm6N8Og98TZHFiLNIY9Gg1j9yaooOodfBqox/27HCqRXI+f/WzyTKVpPo5WcwDPiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHHYP1mPzz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 17:37:13 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 11 Jun
 2025 15:31:40 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 11 Jun 2025 15:31:40 +0800
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
Subject: [PATCH v10 1/3] dt-binding: clock: ast2700: modify soc0/1 clock define
Date: Wed, 11 Jun 2025 15:31:37 +0800
Message-ID: <20250611073139.636724-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
References: <20250611073139.636724-1-ryan_chen@aspeedtech.com>
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


