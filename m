Return-Path: <linux-aspeed+bounces-1686-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5169FC83F22
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 03:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfDB96SGyz2yRD;
	Sat, 12 Jul 2025 13:11:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751957767;
	cv=none; b=IU/xrPPy/+OC0iVrGK7+6HX9+e4vzcC9n+16uHDEWwjBtKK4sLT+8Ol6mL+YkNDAy67c9/sKEDI6+78AkIFlclJanyFZ6uJ7orC6lkiDa4YW9/VS115X3lmdrgc3UWZZJAOl6pzSGAmklFGC6EXqtTGnU8k3Ae0KjMmCKqd0TtmKdFVLp7mN7PAruAEvEV5qOXy1QDT2avdq26FW34VkU5fvL4l3kUN1reDi4bT+l9+wz3Cs9MzJBr2Zx/6fB2FcAiZVzqhHStvvKYff7ORMi/Mroqq0mn0TuNymlybbPWSGt3FqvytC/N3Dx0wUIICdx8529jW1NLhXAA6saNLEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751957767; c=relaxed/relaxed;
	bh=WEv+ejLgluG2KK+a80vQYjLIFkKXgegHsi+Qlx0dVhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiYjMQTTGj82Pk9aLB7kPCgENmVE3pL1cAsUJGsCNrtXIK1prQlz1yWECKHIxUKKjmb9a90Y6TmLQTNn/m6TtuGofd15ynCWSds+O4VG+x+Ivae1eOJs/+phinEojaMCxyBNG/At2o+reTHJC/sxnvbYWbbnx2sb0DW/sRAWD1XqCZTfAH4SNEUMy5800nXRqtyaEXkFh3f6tMTizF7020T6+5qOKqzL+bAk5leArzow4rR3uMxbGlHrvuQ7v23Dg/GvJ31tFjY/3MBoGIeCMSSfD7yjw/nyFTswho3Scg8zlxANJPuTzWoOO2o5Agzqqs+FayMjCrhoXo7+qWjm2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbsMW3Q5yz3bTf
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 16:56:07 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 14:55:44 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 14:55:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v3 4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
Date: Tue, 8 Jul 2025 14:55:44 +0800
Message-ID: <20250708065544.201896-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
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
index a98d5af3f9e3..05b8e3743a79 100644
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


