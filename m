Return-Path: <linux-aspeed+bounces-4118-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B00CD5BB3
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 May 2026 07:17:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMGmR6z7mz3bpG;
	Fri, 22 May 2026 17:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779434199;
	cv=none; b=njpyHvQEe58mLBHt+QdhmVVk8rYYdolbhGbEaD3u9GIaHf/v9IqKY0hQ9DtRdsevj9vgJt5PSAJsJULe5aAAYO88ryPcGGZhOPFWHHV7O63vf8MwHSLmQHzO3DFCG7FjugHrZyM7eje6G+SmZetyw58bM7eamTGpGbKgTMRRNBBIBNuMvFtsCPaOtskO8qwoxQVlFdLo1Zg91Efiv6Xlz+LSnzK8ZRyq6/CfcQ105daL2NF7FblTrEwpzJoBRnDNoJKh74fUSpGF5BR2x2XgdonL180AoTBZ4ZOMS+XYDrK8vk9sIGzTwtg7BH7yIMMpma5pa6xgOAF8o+9ZVUA+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779434199; c=relaxed/relaxed;
	bh=/FT3+k5kDyjvitsFzhLncaoS8WLkL1l2pXmOhypcq3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2EaF7W+mZ1+pLAuXFeHisJd9zxhVORnodlfjBxmY01QEQHU9SXgyQ5W54mpbWyVJ2L+zG8L2ZdqpA/xrRiblwBp74IMBjGIPTD0siqUx+GTsIMJP3+oWIF7IZZNYMtJdlN7iyjs1LhYFCLHX3K74dlCNgtysb/E1nqyzNAKR1eyxJRfhn3/bH8jby4gWJjHRoBa0QJdfOUteVIWw1eAlyWcoo1L82xF5Ut/zxhgul1XKq73GkGhqRbDW0F51Io0BSnSV/hJoeDFVojRDEI5149fFJ0Ze40sJ0NyLt7YZrpA4xbPKcFJ9b5w8q5qnkRJPfYpuH1URUo8NANFqN2sbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMGmR14jyz2yfD;
	Fri, 22 May 2026 17:16:39 +1000 (AEST)
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
Subject: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper
Date: Fri, 22 May 2026 15:16:21 +0800
Message-ID: <20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
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

aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
variable-length array parameter (u8 buf[rows][cols]), which causes a
sparse warning. Replace the VLA parameter with a plain u8 * and compute
the 2-D index manually. The corresponding call site is also updated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 808659a1f460..027caa2eeb5c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1467,8 +1467,7 @@ static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
  * must contains the highest number of consecutive "pass"
  * results and not span across multiple rows.
  */
-static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
-					       u8 buf[rows][cols])
+static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols, u8 *buf)
 {
 	int r = 0, c = 0;
 	int max = 0;
@@ -1478,7 +1477,7 @@ static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
 		for (j = 0; j < cols;) {
 			int k = j;
 
-			while (k < cols && buf[i][k])
+			while (k < cols && buf[(i * cols) + k])
 				k++;
 
 			if (k - j > max) {
@@ -1541,7 +1540,7 @@ static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
 		}
 	}
 
-	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
+	calib_point = aspeed_spi_ast2600_optimized_timing(6, 17, &calib_res[0][0]);
 	/* No good setting for this frequency */
 	if (calib_point == 0)
 		return -1;
-- 
2.34.1


