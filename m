Return-Path: <linux-aspeed+bounces-1022-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D78C35FFA
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 23:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGr7H3WrLz2yqW;
	Tue, 18 Mar 2025 10:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742180386;
	cv=none; b=PMkhuS6wq5GKLn1UAt7w6c+zWPG1knSWNXQDYP3cdgIx6DeFhBQQ6fpToCp1tXcI/4G6efY1a6yYNWejpYEVY6wQPJTjg5VJ4CVnF5JChAGnXC2WhZgTdPAgkAYhTds1KjjdtO0Qt0fWU9RAqyaS+93jCANxI6thiVP6qElX5TXI94BbpV+JyJggn7XizCg+QY+BcwmuEwDU0kvWIrotmWW4BQXJy9QbNorkGM5tLDjzKd5JMYzX5yIAaiedCYWnz2aRVQUU1Cbcm4zMv/8yHYzpbMQaYmT0E9cS0syOTQojpfa3v8ENNlqO31lKLo3SLFjD9Tyxu3eXSdBTeZZ3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742180386; c=relaxed/relaxed;
	bh=dfPNm4gjbKk/wSrXYiTAOhvmCS7f3bgH/l7AyRMHyTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvld85UJ9Cts6F6M86p57heijqZAmYV9kTne1hgk7Vjdz4q2cweVeC9m+84z8ikqXWdsL/yBKflMpOhwGazInE847rLbWD4hnyeb8gp3sjHdybEGqgkE7i2OWWyaD6mJgDkFDKZXIUjOmrfJs7oUNHDMbOWQmspy1CIRSHK8p3NuMtIxYQDwWGrzo22BfV32jzLJ4Xvm3M0jXlbHJ4I+baS/fqbq0iwpngI5LRi+fCmhVXNla/Yo8+zvsAlorkrk5+A17wIIzA/rWpe10I0NED/rR4iObI18f3DlIDuAtNtRUmXtPOW5/8TR5CgmqNXYeBk9y8+wlk6O0tdT4HsMLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGKSy0zFJz2yRl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 13:59:46 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 4/4] net: ftgmac100: add RGMII delay for AST2600
Date: Mon, 17 Mar 2025 10:59:22 +0800
Message-ID: <20250317025922.1526937-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
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

Use rx-internal-delay-ps and tx-internal-delay-ps
properties to configue the RGMII delay into corresponding register of
scu. Currently, the ftgmac100 driver only configures on AST2600 and will
be by pass the other platforms.
The details are in faraday,ftgmac100.yaml.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 88 ++++++++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h | 12 ++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 17ec35e75a65..ea2061488cba 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -27,6 +27,9 @@
 #include <linux/phy_fixed.h>
 #include <net/ip.h>
 #include <net/ncsi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
 
 #include "ftgmac100.h"
 
@@ -1812,6 +1815,88 @@ static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
 	return ret;
 }
 
+static void ftgmac100_set_internal_delay(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct net_device *netdev;
+	struct ftgmac100 *priv;
+	struct regmap *scu;
+	u32 rgmii_tx_delay, rgmii_rx_delay;
+	u32 dly_reg, tx_dly_mask, rx_dly_mask;
+	int tx, rx;
+
+	netdev = platform_get_drvdata(pdev);
+	priv = netdev_priv(netdev);
+
+	tx = of_property_read_u32(np, "tx-internal-delay-ps", &rgmii_tx_delay);
+	rx = of_property_read_u32(np, "rx-internal-delay-ps", &rgmii_rx_delay);
+
+	if (of_device_is_compatible(np, "aspeed,ast2600-mac")) {
+		/* According to mac base address to get mac index */
+		switch (priv->res->start) {
+		case 0x1e660000:
+			dly_reg = AST2600_MAC12_CLK_DLY;
+			tx_dly_mask = AST2600_MAC1_TX_DLY;
+			rx_dly_mask = AST2600_MAC1_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC1_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC1_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e680000:
+			dly_reg = AST2600_MAC12_CLK_DLY;
+			tx_dly_mask = AST2600_MAC2_TX_DLY;
+			rx_dly_mask = AST2600_MAC2_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC2_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC2_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e670000:
+			dly_reg = AST2600_MAC34_CLK_DLY;
+			tx_dly_mask = AST2600_MAC3_TX_DLY;
+			rx_dly_mask = AST2600_MAC3_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC3_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC3_RX_DLY, rgmii_rx_delay);
+			break;
+		case 0x1e690000:
+			dly_reg = AST2600_MAC34_CLK_DLY;
+			tx_dly_mask = AST2600_MAC4_TX_DLY;
+			rx_dly_mask = AST2600_MAC4_RX_DLY;
+			rgmii_tx_delay = FIELD_PREP(AST2600_MAC4_TX_DLY, rgmii_tx_delay);
+			rgmii_rx_delay = FIELD_PREP(AST2600_MAC4_RX_DLY, rgmii_rx_delay);
+			break;
+		default:
+			dev_warn(&pdev->dev, "Invalid mac base address");
+			return;
+		}
+	} else {
+		return;
+	}
+
+	scu = syscon_regmap_lookup_by_phandle(np, "scu");
+	if (IS_ERR(scu)) {
+		dev_warn(&pdev->dev, "failed to map scu base");
+		return;
+	}
+
+	if (!tx) {
+		/* Use tx-internal-delay-ps as index to configure tx delay
+		 * into scu register.
+		 */
+		if (rgmii_tx_delay > 64)
+			dev_warn(&pdev->dev, "Get invalid tx delay value");
+		else
+			regmap_update_bits(scu, dly_reg, tx_dly_mask, rgmii_tx_delay);
+	}
+
+	if (!rx) {
+		/* Use rx-internal-delay-ps as index to configure rx delay
+		 * into scu register.
+		 */
+		if (rgmii_tx_delay > 64)
+			dev_warn(&pdev->dev, "Get invalid rx delay value");
+		else
+			regmap_update_bits(scu, dly_reg, rx_dly_mask, rgmii_rx_delay);
+	}
+}
+
 static int ftgmac100_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1977,6 +2062,9 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
+
+		/* Configure RGMII delay if there are the corresponding properties */
+		ftgmac100_set_internal_delay(pdev);
 	}
 
 	/* Default ring sizes */
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..d464d287502c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -271,4 +271,16 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+/* Aspeed SCU */
+#define AST2600_MAC12_CLK_DLY	0x340
+#define AST2600_MAC1_TX_DLY		GENMASK(5, 0)
+#define AST2600_MAC1_RX_DLY		GENMASK(17, 12)
+#define AST2600_MAC2_TX_DLY		GENMASK(11, 6)
+#define AST2600_MAC2_RX_DLY		GENMASK(23, 18)
+#define AST2600_MAC34_CLK_DLY	0x350
+#define AST2600_MAC3_TX_DLY		AST2600_MAC1_TX_DLY
+#define AST2600_MAC3_RX_DLY		AST2600_MAC1_RX_DLY
+#define AST2600_MAC4_TX_DLY		AST2600_MAC2_TX_DLY
+#define AST2600_MAC4_RX_DLY		AST2600_MAC2_RX_DLY
+
 #endif /* __FTGMAC100_H */
-- 
2.34.1


