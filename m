Return-Path: <linux-aspeed+bounces-1950-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01982C87FCF
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:52:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBH2FVqz30Vr;
	Thu, 14 Aug 2025 09:51:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755066805;
	cv=none; b=ZYVjTCw6unrkFSW0JxtWUv+/DY5B0I7pv3bbUMtnbsd3PPAznv97r+80zFVHJCtesIllXsdIf0JDMrAIrKqfjv3X1K6v1+BnmajkZiI83ttkT83A9t4yomPEDGNKvZzUvHWD37OfVgUlQomuJ69EVdrSL7T2MiB+v/Fg/BqHXpxAbbRo+S5SqTIR8aGa6GKgSKMVEN8XwzCtMJuwbowne28SHmveIy4MowuPgctMBlBESxz3s/UecyvBDCYsK9uEtgj1zeJX/ag0tdzarh7Es6dXOVn7hhgsvwAbLx5hY5zNQs6lxR/bwRD6+OP+uylmAgalhXPTcKgtI6lXrfxapg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755066805; c=relaxed/relaxed;
	bh=iT3KCsLgivunHOFUpgDg99pNSz/dlQyWHmvH1YK1bSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DErHtzLfcqU5f6Z0QvFfA1n7oTgoosYgiNLK3YXBuQAm+HWxj4vcRI2o2oDBRpcRzUEFPkbz+1+UqjCc/fyqAknz1H3hkDRb6VQFHNUcGAtsqJgl7FlY8jDtHyY3WxH/3Cc/WoyGlf0jwM8LEjuz+wzH2H/7xbjOKWDGprge9g4WNDJ7Vp5UXCIrfsCfCuX6t9sofF1TUWb4afEyXB2LYGbfLZCM3UZs2QAggelndTlkE6skbLYUsS1NRQRpDdvZZI18YSK2RpUBtEADAwoOE1J7gA+M9b/94xVRpEjmFkHycr2bKYHuCm7JPy0N9xtnM8VFN4fi+7GQatzgTS4VDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1z8g6rDrz30Vs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 16:33:23 +1000 (AEST)
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
Subject: [net-next v2 4/4] net: ftgmac100: Add RGMII delay configuration for AST2600
Date: Wed, 13 Aug 2025 14:33:01 +0800
Message-ID: <20250813063301.338851-5-jacky_chou@aspeedtech.com>
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

In AST2600, the RGMII delay is configured in SCU register.
The MAC0/1 and the MAC2/3 on AST2600 have different delay unit with
their delay chain.
These MACs all have the 32 stage to configure delay chain.
      |Delay Unit|Delay Stage|TX Edge Stage|RX Edge Stage|
------+----------+-----------+-------------+-------------+
MAC0/1|     45 ps|        32 |           0 |           0 |
------+----------+-----------+-------------+-------------+
MAC2/3|    250 ps|        32 |           0 |          26 |
------+----------+-----------+-------------+-------------+
The RX edge stage of MAC2 and MAC3 are strating from 26.
We calculate the delay stage from the rx-internal-delay-ps of MAC2/3 to
add 26. If the stage is equel to or bigger than 32, the delay stage will
be mask 0x1f to get the correct setting. The delay chain is like a ring
for configuration.
So, the rx-internal-delay-ps of MAC2/3 is 2000 ps, we will get the delay
stage is 2.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 86 ++++++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h | 12 ++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index a98d5af3f9e3..02f49558bed8 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -25,6 +25,9 @@
 #include <linux/if_vlan.h>
 #include <linux/of_net.h>
 #include <linux/phy_fixed.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
 
@@ -1812,6 +1815,86 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static void ftgmac100_set_internal_delay(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *scu;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
+	int dly_mask;
+	int dly_reg;
+	int id;
+
+	if (!(of_device_is_compatible(np, "aspeed,ast2600-mac01") ||
+	      of_device_is_compatible(np, "aspeed,ast2600-mac23")))
+		return;
+
+	/* If lack one of them, do not configure anything */
+	if (of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay)) {
+		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
+		return;
+	}
+	if (of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay)) {
+		dev_warn(&pdev->dev, "failed to get tx-internal-delay-ps\n");
+		return;
+	}
+	id = of_alias_get_id(np, "ethernet");
+	if (id < 0 || id > 3) {
+		/* If lack alias or out of range, do not configure anything */
+		dev_warn(&pdev->dev, "get wrong alise id %d\n", id);
+		return;
+	}
+
+	if (of_device_is_compatible(np, "aspeed,ast2600-mac01")) {
+		dly_reg = AST2600_MAC01_CLK_DLY;
+		if (rgmii_tx_delay > AST2600_MAC01_CLK_DLY_MAX) {
+			dev_warn(&pdev->dev, "tx-internal-delay-ps %u is out of range\n",
+				 rgmii_tx_delay);
+			return;
+		}
+		if (rgmii_rx_delay > AST2600_MAC01_CLK_DLY_MAX) {
+			dev_warn(&pdev->dev, "rx-internal-delay-ps %u is out of range\n",
+				 rgmii_rx_delay);
+			return;
+		}
+		rgmii_tx_delay /= AST2600_MAC01_CLK_DLY_UNIT;
+		rgmii_rx_delay /= AST2600_MAC01_CLK_DLY_UNIT;
+	} else if (of_device_is_compatible(np, "aspeed,ast2600-mac23")) {
+		dly_reg = AST2600_MAC23_CLK_DLY;
+		if (rgmii_tx_delay > AST2600_MAC23_CLK_DLY_MAX) {
+			dev_warn(&pdev->dev, "tx-internal-delay-ps %u is out of range\n",
+				 rgmii_tx_delay);
+			return;
+		}
+		if (rgmii_rx_delay > AST2600_MAC23_CLK_DLY_MAX) {
+			dev_warn(&pdev->dev, "rx-internal-delay-ps %u is out of range\n",
+				 rgmii_rx_delay);
+			return;
+		}
+		rgmii_tx_delay /= AST2600_MAC23_CLK_DLY_UNIT;
+		/* The index of rx edge delay is started from 0x1a */
+		rgmii_rx_delay = (0x1a + (rgmii_rx_delay / AST2600_MAC23_CLK_DLY_UNIT)) & 0x1f;
+	}
+
+	if (id == 0 || id == 2) {
+		dly_mask = ASPEED_MAC0_2_TX_DLY | ASPEED_MAC0_2_RX_DLY;
+		rgmii_tx_delay = FIELD_PREP(ASPEED_MAC0_2_TX_DLY, rgmii_tx_delay);
+		rgmii_rx_delay = FIELD_PREP(ASPEED_MAC0_2_RX_DLY, rgmii_rx_delay);
+	} else {
+		dly_mask = ASPEED_MAC1_3_TX_DLY | ASPEED_MAC1_3_RX_DLY;
+		rgmii_tx_delay = FIELD_PREP(ASPEED_MAC1_3_TX_DLY, rgmii_tx_delay);
+		rgmii_rx_delay = FIELD_PREP(ASPEED_MAC1_3_RX_DLY, rgmii_rx_delay);
+	}
+
+	scu = syscon_regmap_lookup_by_phandle(np, "scu");
+	if (IS_ERR(scu)) {
+		dev_warn(&pdev->dev, "failed to map scu base");
+		return;
+	}
+
+	regmap_update_bits(scu, dly_reg, dly_mask, rgmii_tx_delay | rgmii_rx_delay);
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1977,6 +2060,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		/* Configure RGMII delay if there are the corresponding compatibles */
+		ftgmac100_set_internal_delay(pdev);
 	}
 
 	/* Default ring sizes */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..a9f0f00ac784 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,16 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+/* Aspeed SCU */
+#define AST2600_MAC01_CLK_DLY	0x340
+#define AST2600_MAC23_CLK_DLY	0x350
+#define AST2600_MAC01_CLK_DLY_MAX	1395	/* ps */
+#define AST2600_MAC01_CLK_DLY_UNIT	45	/* ps */
+#define AST2600_MAC23_CLK_DLY_MAX	7750	/* ps */
+#define AST2600_MAC23_CLK_DLY_UNIT	250	/* ps */
+#define ASPEED_MAC0_2_TX_DLY		GENMASK(5, 0)
+#define ASPEED_MAC0_2_RX_DLY		GENMASK(17, 12)
+#define ASPEED_MAC1_3_TX_DLY		GENMASK(11, 6)
+#define ASPEED_MAC1_3_RX_DLY		GENMASK(23, 18)
+
 #endif /* __FTGMAC100_H */
-- 
2.43.0


