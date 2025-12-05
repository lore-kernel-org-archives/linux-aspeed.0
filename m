Return-Path: <linux-aspeed+bounces-3044-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0637D2CDF2
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Dec 2025 01:37:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMvBy0M6wz2xqm;
	Fri, 05 Dec 2025 12:37:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764898665;
	cv=none; b=Fdb5m7TOupplLFv8tIlu+UGr0w+j2a534zFY8DD3B7AgAYoqcYQv9MfM9vxFJ9JNmsVD/owGMcO9W7NlTxNsNeLIHrX7fANEvBbXe6iOul77oDx4RTF7xJJdp+YRKOKpNhz5FJNkqzxt96yPtYWRIWEnLBe0RFs7n7ftd8w9HWlOeTqRSot8DGmTdMbpXSexdvTZJDb/vHyumhyrviBVDeM+Xr/XGYr5jHytRfTnmwsUCgHasD6XmZ/FjIJU++j8hf9FiHJLSbsnySSfZHGLTsrcGSqYe9XFLaJ/NUpfUkMsXTQYlLd8qN8i2I6XAtWQ6u/4JDB2VTv+5BlcY8lrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764898665; c=relaxed/relaxed;
	bh=I15V66zB1T31cGXD0lOmzQuynlP2Pen5WcKwz023y0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LPe4FJQXEB0ZnJqzioE/Y4C+1yMc5B8eKDcC1wO1UZe85Q5Yr9uX5YDg4kvtc7NaaHjl3nuDEbCESKIAXYNSaJhSIgtavfFDB847U6feAgtDtgZ8g+ITU6/oQ4Ic7QD839IuZY+vPVFTSGfJ3YA2ZQSD9wao8VsxpzKas+6T1XGQ6Ap+pK3BazO+w7JVkjlWMGrS2/C/qhjUMKxzXP8hhWYsyh/yesbYVRfhunoOQI04rXZr/AvlQBAMcmc6CDqroNEoGNgfu2T2dkZRl2YIYURz0xwwzbgZZXJ2P+0Gw9XDzmyVN8xkWGvLntYv2Ft+TWT8KsL1iP6zhAF2EOLhKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMvBx0s99z2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 12:37:44 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 09:37:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 09:37:27 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 09:37:22 +0800
Subject: [PATCH net-next] net: mdio: aspeed: add dummy read to avoid
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
Message-ID: <20251205-aspeed_mdio_add_dummy_read-v1-1-60145ae20ea7@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAFE3MmkC/x3MQQqDMBAF0KvIrBswwUDbq5QSQv9vO4tESaxYx
 LsbXL7N26SyKKvcu00KF6065gZ76eT1jflDo2gW1ztvXe9NrBOJkKBjiEDAL6V/KIww8FdYDrf
 BOkgLpsK3rmf+kMzZZK6zPPf9AIb4G/R2AAAA
X-Change-ID: 20251205-aspeed_mdio_add_dummy_read-d58d1e49412d
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764898647; l=1685;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=S7YMglq8xDZ86NvHllMwMpita0VXT5NdJ+3b28QfTZA=;
 b=Ps7Hi70frz0jQRXPVvsI7ldWRC/vUIB2+MlTS0A8qMwi2htDxw+IuUKtQFWJ/D4fb+S5YT/WU
 +6J+70lg37kB2/KkYTcqTd2EYPL6bmdnjhSrYXB//9EmSRmeEb1bkfX
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

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e55be6dc9ae7..00e61b922876 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -62,6 +62,12 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
 		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
+	/* Workaround for read-after-write issue.
+	 * The controller may return stale data if a read follows immediately
+	 * after a write. A dummy read forces the hardware to update its
+	 * internal state, ensuring that the next real read returns correct data.
+	 */
+	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);
 
 	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),

---
base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
change-id: 20251205-aspeed_mdio_add_dummy_read-d58d1e49412d

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


