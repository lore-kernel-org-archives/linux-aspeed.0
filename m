Return-Path: <linux-aspeed+bounces-4055-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2243CCD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 09:57:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJtWr2dDcz2yRF;
	Mon, 18 May 2026 19:57:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779098248;
	cv=none; b=BjSK4kKOEWh471gDAMqTlkExvvxho89IHlMLux9mQpt+lM57mUsMelNpjVkLnwDDSdRODMdygwzABX5crEt0cLngPWlTpqSzmnOaZahNmq6zUmhYRDFX+A7uaBfMESbyPADGAHTseBeRTjF3vvss2xKsNCN/MH/i65wrfhmT+f5XnHUglYpJv7P9TDR9q6bJOe2cBRzRrLxqyYu/Domrq5A554CMpGcPSSxZ2n7O+o7sMnV+4c3VnF0jPt9lJlMHxyG1/VfrNfFFFtbduygI6hd606D13qzhe8NQy0JkYYP/Wy6gfJutifU/4PH/O621+PcqDtz8frmOTSRiB5s+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779098248; c=relaxed/relaxed;
	bh=HnnG9FAo9t009uu90C/CT6JGmA+az9Y3sKnZeAWU8yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvoMeDPLdoHYc2EeUYBgrtUGm2QhzB03hwnR3wetZhWvYyuE8kgVYFPNauKwio0KbFVz0kpc6sMVvTGe50kSL7gxjmXlKjfcqG49CCnFJQ89nFX33g2Tp4pHcVYygEiYoPCyS4wsQDrUdzmAcMZb0+jMgypR/kS5dFYQl+9h6IwT+CiD58h0cXpEDMILYh5FBWs6UWzPlShmjMZi7WfD1bRLMjRv8Mh3XqPbXjA+R6chB/YvzHqXKlSwP2fMYtOMQch/gnDgzAGgJdnXQHjerMqzhuSoJhav76ZwOzHJESFCYCzxSV+6Sx9Q29oLzibtvhoTSfyPgZQ6b0sRh9F+xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJtWq4HLFz2yL8;
	Mon, 18 May 2026 19:57:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 May
 2026 17:57:08 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 May 2026 17:57:08 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
Date: Mon, 18 May 2026 17:57:07 +0800
Message-ID: <20260518095708.2502537-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
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

The dst parameter of aspeed_spi_user_transfer_tx() is an MMIO address
obtained from chip->ahb_base, but it was typed as void * instead of
void __iomem *.  This caused a sparse warning report. Fix the
parameter type to void __iomem * and drop the now-unnecessary
cast at the call site.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index c21323e07d3c..808659a1f460 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -891,7 +891,7 @@ static int aspeed_spi_user_unprepare_msg(struct spi_controller *ctlr,
 static void aspeed_spi_user_transfer_tx(struct aspeed_spi *aspi,
 					struct spi_device *spi,
 					const u8 *tx_buf, u8 *rx_buf,
-					void *dst, u32 len)
+					void __iomem *dst, u32 len)
 {
 	const struct aspeed_spi_data *data = aspi->data;
 	bool full_duplex_transfer = data->full_duplex && tx_buf == rx_buf;
@@ -936,7 +936,7 @@ static int aspeed_spi_user_transfer(struct spi_controller *ctlr,
 			aspeed_spi_set_io_mode(chip, CTRL_IO_QUAD_DATA);
 
 		aspeed_spi_user_transfer_tx(aspi, spi, tx_buf, rx_buf,
-					    (void *)ahb_base, xfer->len);
+					    ahb_base, xfer->len);
 	}
 
 	if (rx_buf && rx_buf != tx_buf) {
-- 
2.34.1


