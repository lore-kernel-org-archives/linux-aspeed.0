Return-Path: <linux-aspeed+bounces-1948-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A1FCA0EE0
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBG0gGrz30Tf;
	Thu, 14 Aug 2025 09:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755066801;
	cv=none; b=FxSBTIxFhprS8HAug/nxoX0+F6aVDukv+M/EtvsLawNzjPlauwY49SHJZm1Amy5TNyoKBrrTFYq1iF2CH2e7sBWWSzKqJDSLwYbunNtwoACS/+SAd6PcDD2h2FVp3rLUhPScm0ZNLhvXy7EsO8rhCeOm+XQXsOOyrAMH/d+wZD2++T7u1U73Uclf93VAzcDmfcMt/EmR2Nozxj6qAVHNaQHaRLgjS+/u5glFSHFxAMB0lZDBgpq2nmeMvtwCyQHJ4+EpL4CIqVnpXsyi4Pqpi4dUItnJZl4Qt/fqqw3RMR82STEY3i2wu1itTH7uP8+ywoM8X7s1xTuEpSH0+/+N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755066801; c=relaxed/relaxed;
	bh=r9QekULDTpKT2sp/tU5XfRCPn/3eOKEKt4xinUDGYWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zw91NgPKf6CyGittu89dpwNCrWW4jgYzhu5rQt6zzQfpYqFO3l7FzPslQ3x5yXHhwc7fLvhO17CSBw1SfgI6vXmHm2uLbdQBzQUXZIlbVSCk01Krp0O9xrVZ23HRLInIMs/FsS0FoqhA7NSA5iTCV2foz74pDpIrbiQPSaLahiU7dAZLef0xHCOLHD1xgpqr+HP0Z6PA6+Fm7upWObd+sJ0fLb3wyrYb6iZzF+0UVrQO2liTG+wc2eEmYGZQcJaPgGfRP6mlm/oRx+aWO2/BpgvCZ7wLMDJ/jcKxwtMD9MB1w//Gh4WHAlysjfipjVka2pBZUlvrixcfiZp/qdjDGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1z8c4xWMz30Vs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 16:33:20 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 2/4] ARM: dts: aspeed-g6: Add ethernet alise and update MAC compatible
Date: Wed, 13 Aug 2025 14:32:59 +0800
Message-ID: <20250813063301.338851-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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

For RGMII delay setting, the MAC0 and MAC1 use the SCU0x340 to configure
the RGMII delay. We use the ethernet alise to identify the index of MAC.
And add the new compatible for MAC0/1 and MAC2/3 to calculate the
RGMII delay with different delay unit.
Finally, the RGMII delay of AST2600 is configured in SCU region and add
the scu phandle for configuration.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..6be17b18da46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -40,6 +40,10 @@ aliases {
 		mdio1 = &mdio1;
 		mdio2 = &mdio2;
 		mdio3 = &mdio3;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+		ethernet3 = &mac3;
 	};
 
 
@@ -232,34 +236,46 @@ mdio3: mdio@1e650018 {
 		};
 
 		mac0: ethernet@1e660000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac01",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac1: ethernet@1e680000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac01",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac2: ethernet@1e670000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac23",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
 		mac3: ethernet@1e690000 {
-			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
+			compatible = "aspeed,ast2600-mac23",
+				     "aspeed,ast2600-mac",
+				     "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
+			scu = <&syscon>;
 			status = "disabled";
 		};
 
-- 
2.43.0


