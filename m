Return-Path: <linux-aspeed+bounces-1349-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CDFC71133
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 03:06:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bH9Xk0VPhz30Lt;
	Wed, 11 Jun 2025 13:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749518672;
	cv=none; b=EQxY1rv09H+0gYVUQMTiXeDuJwRRM9GbCe8iE8vADNzjTzSpqCj58f3V/H9MD52ZUxCFF5uTa1mKVYb4yL7dtVgHjDTEJtOTti3/tEkYcaPrLSTGwczli9wobV/qEBEz777bU4m9WexXG38WH0gJM7TyUAeqeiGOlRJng+OwP3J2Th/dW5Z0RE0RFn6W0m0JCgAK93MwrVsBKQ30q6HlEi0ih0Pls1+vT8WJBkyVoDFzbHag+k96RjITGfpSPQoqw3YsuHyGhx/lGxz92JkOLB1SkUvvP9WJqf6Vw6RbNmoFdmCYBkq1x2tFdA9oDL0iCTlYgOuaQhhQz02PJ+wkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749518672; c=relaxed/relaxed;
	bh=5LKba7DknBhbjPo7db2iJgXAGczza2OID/T8xJSknic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft/VySSicgozopz4F3WVQ2/sp+6vlYgQrpVzCb5/ejGbpUc5iwSRoNlPgeXu6LQkfMzCWqaCJ9f/HRvBr0q7eR3uVzjzhz9cid6ahsM7fXPr+MHzu2oI1MqE06hYHKurNFUCuzqyYPYXsvEpxUCFW/g36zM8Z1Vkhsv6I8eRI8rqYwzWZ/Ka4boUNzfEqbfvIcJeycaydCfnaB5ugW/vK4qF90pSJWo2lgRyyZASTi0OuDH71udY9Ysjr4+E6Zs9wfjjSdsyckrgn3mxj92RKot2Xz2pQ41121yusoRc1pOYOgX0f0U/5L1H+Rj1Q6YTVh5nq//92SMgM/h2ixgi5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGWKq5Tlrz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 11:24:31 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 09:24:07 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 09:24:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net-next v2 4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
Date: Tue, 10 Jun 2025 09:24:06 +0800
Message-ID: <20250610012406.3703769-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
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

On Aspeed SoCs, the internal MAC reset is insufficient to fully reset the
RMII interface; only the SoC-level reset line can properly reset the RMII
logic. This patch adds support for an optional "resets" property in the
device tree, allowing the driver to assert and deassert the SoC reset line
when operating in RMII mode. This ensures the MAC and RMII interface are
correctly reset and initialized.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 17ec35e75a65..01c4db6e5b91 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -101,6 +102,8 @@ struct ftgmac100 {
 
 	/* AST2500/AST2600 RMII ref clock gate */
 	struct clk *rclk;
+	/* Aspeed reset control */
+	struct reset_control *rst;
 
 	/* Link management */
 	int cur_speed;
@@ -148,6 +151,23 @@ static int ftgmac100_reset_and_config_mac(struct ftgmac100 *priv)
 {
 	u32 maccr = 0;
 
+	/* Aspeed RMII needs SCU reset to clear status */
+	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
+		int err;
+
+		err = reset_control_assert(priv->rst);
+		if (err) {
+			dev_err(priv->dev, "Failed to reset mac (%d)\n", err);
+			return err;
+		}
+		usleep_range(10000, 20000);
+		err = reset_control_deassert(priv->rst);
+		if (err) {
+			dev_err(priv->dev, "Failed to deassert mac reset (%d)\n", err);
+			return err;
+		}
+	}
+
 	switch (priv->cur_speed) {
 	case SPEED_10:
 	case 0: /* no link */
@@ -1968,6 +1988,12 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 	}
 
+	priv->rst = devm_reset_control_get_optional_exclusive(priv->dev, NULL);
+	if (IS_ERR(priv->rst)) {
+		err = PTR_ERR(priv->rst);
+		goto err_phy_connect;
+	}
+
 	if (priv->is_aspeed) {
 		err = ftgmac100_setup_clk(priv);
 		if (err)
-- 
2.34.1


