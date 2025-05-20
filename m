Return-Path: <linux-aspeed+bounces-1226-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1068C5479B
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 11:06:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1sDj3q6gz3blT;
	Tue, 20 May 2025 21:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747733769;
	cv=none; b=hPhF+KaiyMv+9K5fgt2TzqdO3j8DLCU8BznzyCnnNh6KjpV3pYP36M6YmqxXogkiTY2ApV5h2zW18/3BIEDDp96hBWKTuQVtDloxRxStvQn9Lf76hCcbdSTO9+KMI+LBwfcipGw/d3n6aIai/RXZWIOah6mNzUxOeEiDjTihVx2S+H2zRYZKYvyrTRYqxqXXHJYqhNKssL6x37p2UMFdA4KfBj+rxwgoaMJdQxyd5x7ndO9gEFlmEx0xpqwTBOvyZyp+Q42Z1LNs/axX8VIoTn6CqiVVt17qjtbw3ImIyneBtVvTnJZT3tXo464lFImnHp/oPzWrx1/6hOwk+MRggw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747733769; c=relaxed/relaxed;
	bh=5LKba7DknBhbjPo7db2iJgXAGczza2OID/T8xJSknic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lldCzjk8NnkOgXGJNCh4JwGHysrLdFRjIkIM1bpIJ0doFaiYDhyqZj8urrhh3ND9nXJXKI16ry9SOfcoeWsbktTIIbQ2ZpOpPfIp2KRjgwfozLM76MI5WLnVSE3DreAZHllFcCU08m40V4jTUlThzdHAQ4tqt9nTfc4cXpNFTKa+4SGzIcwJ6oHfxuB8v2eb/Xx9OTKYJg65/489/RVaVWFGc0LlZjOpbzlb/ZXg7LLD7WwcdND6ZOGfY2wvVz/lO8Z69uX0pWbSITKFtBYXryyogL0e8UWK+U7zUaphTyB/YVLhZSGF8jhBHiltC4gfzAAog8Xtao3CzYyf98ctZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1qDn0c0Tz2yrN
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 May 2025 19:36:09 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 17:28:49 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 17:28:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net 4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
Date: Tue, 20 May 2025 17:28:48 +0800
Message-ID: <20250520092848.531070-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
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


