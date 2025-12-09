Return-Path: <linux-aspeed+bounces-3063-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67744D1CDC6
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Dec 2025 11:15:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQbr70ZHQz2y5T;
	Tue, 09 Dec 2025 22:15:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765278951;
	cv=none; b=SI/ApIfH0H/9D+aRi/wr8lDVzpxecAelcRBygodXF/YDn2jYoWXddzIXEe+jqftvAharJhKPh+7Stn/r9+gZDJy77T9AWdEX0AhUIWzbklaNBaxy0twLVgrgzglOcHf0GUXGPFmkVTSK6PBItmMj3nJClYkDRO+vpvLl2+aLb1JwWvJ2HBFr/6pain1xOGygFBgq/EPkQqPjLEqxfQZA9qUROKNAHjFEL62AAVrPXBC/WaINN2Stltof4TaFDek/O+g3w9AdABo6lnco60Lv3+HRCq8JP0Dcpo2XJa3pGCKTEzREhPUiJbHc3f3BIpE5yMLuepnlJKD/gtojojzlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765278951; c=relaxed/relaxed;
	bh=jvBQmXdDaTJ4bqlV98BV9Mp3YssdzJrV1kGBuaoOX1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PkUoky/rROj0MdRbKIUDtSAJ8Nd5PkqrmJ8LprU3agzm5zRBIb7Weyxmt+iGeSydC81ciS+iR9Ifnsq4s+TqHeUeAYk72WQd6kq2hJENp/LOUix0VkEMv4dz8FCVMG5/aDxHMgsBbEAwoiSG4nPWeMdypJffrCZS2bfjWNYy41WNPbBrp9Sk20+s5ZsZF52fsT5x91ZNruOVDN2gjq4mOVfFql/N97zaJcDJkiFwfum8bhVzqu4p5DYWXgT69EN16kaXMn7Yks5V3DVZahh6V9H6+VqS8gSbQFNwxyZXy72HFma3TTeGUVDEd7ooOKSl5d3XS7yPZW6BHi18c5nmRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQbr61H1gz2xPf
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Dec 2025 22:15:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 9 Dec
 2025 19:15:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 9 Dec 2025 19:15:32 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 9 Dec 2025 19:15:31 +0800
Subject: [PATCH net v2] net: mdio: aspeed: add dummy read to avoid
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
Message-ID: <20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIANIEOGkC/42NQQqDMBBFryKzbkomoIaueo8iYepMaxYxkqhUx
 Ls32At0+f7/vL9DluQlw63aIcnqs49jAXOpoB9ofIvyXBiMNjUabRXlSYRdYB8dMTteQthcEmJ
 V25ae1mprsYUimJK8/OeUP2CUGboSDj7PMW3n4Ypn9Y97RYVKE9oGiQ02eP+NZ+mHax8DdMdxf
 AG3JDDXzgAAAA==
X-Change-ID: 20251208-aspeed_mdio_add_dummy_read-587ab8808817
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Potin Lai
	<potin.lai@quantatw.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765278932; l=1877;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Mg8PdAkgzIWHVGruAAz0jujfLeSjM7YjkzAbXqHp61U=;
 b=cIXKNFH4KlPuUxu8VYrzWB6g8Jw7ZigbsZTBDriQL/xeLWFu/8lzf993F8cPv+2+thMgn7WFZ
 5ipiglIvxodDFOOpgnU/meEZJqwxMa6GpKHdo8UkSyqAU4WdN8iAItD
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
Changes in v2:
- Updated the Fixes: tag
- Link to v1: https://lore.kernel.org/r/20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com
---
 drivers/net/mdio/mdio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..7d11add3c05e 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -63,6 +63,13 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
+
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
 				ASPEED_MDIO_INTERVAL_US,

---
base-commit: 0373d5c387f24de749cc22e694a14b3a7c7eb515
change-id: 20251208-aspeed_mdio_add_dummy_read-587ab8808817

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


