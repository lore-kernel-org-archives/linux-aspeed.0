Return-Path: <linux-aspeed+bounces-3069-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D9D3E796
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 06:25:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRjHz3wyBz2xqh;
	Thu, 11 Dec 2025 17:25:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765434319;
	cv=none; b=WWPzXvEE8RS2CquqAjMtygeSX3OTNJhwy7x72BEF5BMUnVvBMi1d0vgBlvXOPcU2F4hJGZ5Z/GbcHX/U1m5B4El0hdVqTnOfTxVcGiKDvQkrXD1t87xDTVko9bIBmD7FNQqDMIAFB0W1uoP/K72Pbj101DDT6sot63IOMB696tVZexiUpZ5atjUSToTfzkawi/OS8p2OKcNLh5NnXZm27etC0r/4k4eL/MoWLCnrcXBZnu1PaMu6XjEHMeL5HuK1nnFsHO15G59pvAbFDOxQ4oIfCsV2Q1WX9co676B8tGEptbOK2HbbCRX1Ztt5Zf+hKq8/zrKStflVeOcN//wpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765434319; c=relaxed/relaxed;
	bh=YdZGVqE9PqA/mLAx8V/qbBE6zEOyRZ8J6A65YgupoeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=bIezRD6nNnMcEikxWBHUXeiE5xSwl7tEmPk0u2xHaG+7Xy9/hHn44nVRTuxhZH+3mxG+p/aGLB24lUsB13QCP4xbwQgrFVb9SpM4GFRTcybGbsnGnh+RDtr2FoV0eZVCqVd4riTJEX0+7VJLkwHj/co0MQ9H3LKswRFBK58n4eQ0Nqtgl4UC0JgCFtXYLnOPjysJ8Y8kgUvJEoQNM23ZCxU/WT96LcqfZKBhyf2l/isoPR8yYhzVDoiAp7X8N1XCObAeC1qI63c9ZMIIDDFu0SEz6fbbCJtcqRZHhFEZCVQsVKWYFFFnuwwPA5Zi4hsdMj2Z2X3iNUQLsi3Oge64aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRjHy5Jldz2xLR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 17:25:17 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Dec
 2025 14:25:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Dec 2025 14:25:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 11 Dec 2025 14:24:58 +0800
Subject: [PATCH net v3] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251211-aspeed_mdio_add_dummy_read-v3-1-382868869004@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIALljOmkC/43NQQ7CIBAF0Ks0rMUwaCl15T2MIVimlgWlgUpsm
 t5dghsTE+Pyz5+8v5KIwWIkp2olAZON1o85HHYV6QY93pFakzPhjNfAmaQ6TohGOWO90sYo83B
 uUQG1obVs9E1KJiU0JANTwN4+C34hI87kmo+DjbMPSxlMUKp/7AQUKNMgBWjDQcD5/TxjN+w77
 4qd+KfX/vR49upeMAHiCK1sv7xt214iS3GuHgEAAA==
X-Change-ID: 20251208-aspeed_mdio_add_dummy_read-587ab8808817
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Potin Lai
	<potin.lai@quantatw.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765434301; l=2016;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/F4kIXDvh45WJxiCbdIwAGVfMvFPrac8MDCbVP75p2g=;
 b=oJptiug7G0Gd4SocdRv+VJ4ONlyM5fmP7zoWOeQc6wU3FZ/KkhT4lxdo14vQWCOtkRhz67Y2g
 97WIqf9bH2XBjn3dkbiQSY0jjL20PVv1/htH/ayyKn+s8t/nwgFZKHH
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The Aspeed MDIO controller may return incorrect data when a read operation
follows immediately after a write. Due to a controller bug, the subsequent
read can latch stale data, causing the polling logic to terminate earlier
than expected.

To work around this hardware issue, insert a dummy read after each write
operation. This ensures that the next actual read returns the correct
data and prevents premature polling exit.

This workaround has been verified to stabilize MDIO transactions on
affected Aspeed platforms.

Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v3:
- Remove (void)
- Link to v2: https://lore.kernel.org/r/20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com

Changes in v2:
- Updated the Fixes: tag
- Link to v1: https://lore.kernel.org/r/20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com
---
 drivers/net/mdio/mdio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..d6b9004c61dc 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -63,6 +63,13 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	ioread32(ctx->base + ASPEED_MDIO_CTRL);
+
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
 				ASPEED_MDIO_INTERVAL_US,

---
base-commit: 6bcb7727d9e612011b70d64a34401688b986d6ab
change-id: 20251208-aspeed_mdio_add_dummy_read-587ab8808817

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


