Return-Path: <linux-aspeed+bounces-3059-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963B1D3B7DD
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Dec 2025 06:50:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dPt0M0S96z2yGD;
	Mon, 08 Dec 2025 17:50:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765176627;
	cv=none; b=YazbLTVLvxnh24U/g6R31p0i09mmmL/wcvh0G8InAzb+sVNu1ioMod/UwEKYKrUPxep6viNZkOSsVv1Y3kh72BOxuqTLph/CD8ED4nnluf7i2fFTQb9/GbbD+aIY3p/W0qw1XPTqd6/MQxuZBRbcjW2nIzkOd7MWWyuPmwQN926IB0Dsg7Uj8epDpVn4N0TcaVjqWDTk7Za+7piqiIbhUwFuhU2Lr0afM5REn5PHIU7rjiFIRbk0GQxa1n/+Ig8wa/Alv3ontyp8qbZt+P7NNaXhuqQct1/DtzkCiHELufqy05grwEZseTDkKKUpIV1Aq5NlZhH2Bj+E4m4xm18ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765176627; c=relaxed/relaxed;
	bh=XCJR9swgHzHfYMJ+M8ZgfcfJUdNeaqkdgbzM1Ymi5Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=PK+SPIUtphduXqDa6Ancis+ekPiUYND+aVWbdSfWfSXmZft+h896Aot1VZJpDBuvqJi1x2v/gOfcAUue28FWI4Qs8Dg5uwikfncDcp8Z6+l9TDMkAY2H1YzYfPrshwZDg7S0OrkFu8t/jANvv5TyCCJ8FjC+4BbmFqrvHIyl5weuIXfI877SbnI/xRF3fS6lAMOV/7Lls4cmnHBKdfiKEwqMGb12Ed1Hj44IhQCRU4UNoIziI1fdmS/TAO/2ZouK0cVCpK36T+WAL5jqjMFnkBnF57L504NvBORKRZ4zS025Xdc/Ba730u+tDigqTtjP/790VEdPvaGGmmuvIRfMQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dPt0L16llz2yG7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Dec 2025 17:50:25 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Dec
 2025 14:50:07 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Dec 2025 14:50:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 8 Dec 2025 14:49:56 +0800
Subject: [PATCH net] net: mdio: aspeed: add dummy read to avoid
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
Message-ID: <20251208-aspeed_mdio_add_dummy_read-v1-1-0a1861ad2161@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIABN1NmkC/x3MQQrCMBAF0KuUWRtIAqWDVxEJo/Ors0haEhWl9
 O6GLt/mbdRQDY3Ow0YVH2u2lI5wGuj+lPKAM+2m6OMYomcnbQU0ZbUliWrSd86/VCHqRp7kxuy
 Zw0Q9WCtm+x75hQpedN33Px2NPj5xAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765176607; l=1761;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Fifsoq6L0rsVImG8RoDFYXbWdp8xBrChzw1XsvErTOs=;
 b=9ew34t6mAacKgfcW7cQqS3ktVoIHh8IJ1JL7IPVqkV6mjia6haubldqw8OoYpIrooiBORT2ax
 eOZ9BTZwTU/AZMQO7Vjv++X9wYuBk7+ILuD+kvzOdFTEkl1jhqJMi5D
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

Fixes: 737ca352569e ("net: mdio: aspeed: move reg accessing part into separate functions")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
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


