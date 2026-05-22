Return-Path: <linux-aspeed+bounces-4117-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8237CCD4F3D
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 May 2026 07:16:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMGmQ6wZfz2yS4;
	Fri, 22 May 2026 17:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779434198;
	cv=none; b=GJc+2/a7xrY6U8lAsi+IKinR75n1j7Cj0/Bx4h6lUbW201CXmUm44I9rjWrYRbkN5j4/u8lx4rVGrK0zCTD5PsQPSGf+ZBO/KTPjevvvyc6USB2KP00OAqGM1S+cgLy8gzPRjGeLgksVr0RyMkLk6jWqs3yOSYp4WcTHRnnrHjiCZYmCkJlzJvncP9DvgJglaad/+sgQ1Td/t52agvZ5NlYErn+R2e6QtC3oIz+hVYKq9WS8jKiNcrD2SkWAQPPLazlo5dBLHmhWVYUh1UIJN0kZ5CoA/JTg88oQ99XslGSliEtFZ7ZK+rxJdVbiH1q0bx8V6SIv3IZD4TYZg+z3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779434198; c=relaxed/relaxed;
	bh=N6QmoT3amoxN5v8xK9e4KZdgvjcvpzj4dTLMdbcKqKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/PQ9apfUQm6FhXWztNBunlO/jgZ4NIO86J+CeJ84QT39yuf+C0de/SlDN/S6VCYtsT5SxzMZcilrtlHYHtTUgKEj1UZVnWYjARWooXuxnbcQEj/X8SvkcIsuwCFGtPE8vCljr3v6kLDew8V/XMlqYBEDBhTTtgj8yuFrxFei0rAo681EN15JcZRgseM76T3h3eBzh1pypiT+y0ydQl47PvFvJUOVbZmnqFFTcD4soHJZPfDS9gRKyNGOt5iMv0nFw9OzrnFpWGwSG24OUaBULZWub5r54mtfLGBwL1sDyM9iMbS+vfOLIgs9+LPpZx4UQxHzP8kwaHJffKQlRc4qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMGmQ1NrDz2yC9;
	Fri, 22 May 2026 17:16:38 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 May
 2026 15:16:21 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 May 2026 15:16:21 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<david.laight.linux@gmail.com>, <BMC-SW@aspeedtech.com>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
Date: Fri, 22 May 2026 15:16:20 +0800
Message-ID: <20260522071621.102507-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The dst parameter of aspeed_spi_user_transfer_tx() is an MMIO address
obtained from chip->ahb_base, but it was typed as void * instead of
void __iomem *.  This caused a sparse warning report. Fix the
parameter type to void __iomem * and drop the now-unnecessary
cast at the call site.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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


