Return-Path: <linux-aspeed+bounces-4056-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B5ECD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 09:58:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJtWs27X7z2yL8;
	Mon, 18 May 2026 19:57:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779098249;
	cv=none; b=dDnbtWHEMITI6ILuG0KC51EgKeVXd0DcsToe/1bWwFO+R0vjgc+VpqpnQT1NhmEYDWTI9ko3QFFXCRib06W/JyFdL0/Xj7aXjTd+RNdelLYynh6n+1zwQzgaO0wOrywhQN4z3uuyMAlhSolvHBc8HElgX92GFyELsLXstL8J8dd3fcMGdERFUx/grWqlIRb6f2N4b0uauzlb2AnzNh0ObE5oxtXn47jbCRPICkAQ1yuapnnluybawkHRmxDtfblNOb3+yfzBoDgyjb7bskP6Ij1PYa6PI8MGIlIwK99spfky3dWUBi1IxrsrDDPzLM//gMSmPrILz5oEQGOKD9xKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779098249; c=relaxed/relaxed;
	bh=CGKzWf+IggAIyFqPlXrr+f/Do4zgUMe2dKKFWQ+E5PY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQl5TrObgM30cyHSRRD57HrVNuJOL8lT84VBw0lRayPzpQg24NakTlauM/z8uVHBQESg1qRojsxSBkD2BcBXL67dOhfzlPn9atxnxNmM2Ipd6tR7jJ4P4WgZbB0vOWJ1cZLILmjG0aJgQmwUVbzTiFEeUnSBz6X2W7kSuLnNgibk8pcZ6OpdQBpWKusfDmsLJ5YfkKGsALDggyvy/CFRwmsqmfI5LWaRC6BgK0D/8IqrpD+zV9yun/cJDI1oyatVkRO3ac3Gtza9Dk/OVfzf0ASGBRC49CmoagNrFt/MSxbQiM4qqa1/U/4WVOXeL22xRf166vPs/lFDukkFowkn2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJtWr3wZbz2yRM;
	Mon, 18 May 2026 19:57:28 +1000 (AEST)
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
Subject: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper
Date: Mon, 18 May 2026 17:57:08 +0800
Message-ID: <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
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

aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
variable-length array parameter (u8 buf[rows][cols]), which causes a
sparse warning. Replace the VLA parameter with a plain u8 * and compute
the 2-D index manually. The corresponding call site is also updated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 808659a1f460..c5275700de3d 100644
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
+			while (k < cols && buf[i * cols + k])
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


