Return-Path: <linux-aspeed+bounces-3738-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0EED58CBE
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 02:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffGlQ12qVz2ySc;
	Mon, 23 Mar 2026 13:07:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774231650;
	cv=none; b=ZSEosYUrs0A3hmo6n53IMrnbQ97n+lUB0hu6hzsjwqC+o3Nj0vWjnDpxOLgS5VR4iUnLOVNfqSSl/B0HLVIhTf6+s7NOc+M/0O9pA5pg2fcmawBolTzt9X76kBqs/rcH4Sue4SxG6v5pOoaHdRCw1BmBXKA5meE0Q6ASUonavLba37dBIv8VMFOHNl7xaFzepzthbhYnm9DUcG3GxM4qNFMJ4PMOAdP04hErELX4tCY80CXPhKkabnnYfSrXk6qVLmwwXITYYhsSF6mkfoOAWEFkCUB+bv+VmlGeEmGXo9/5ywtITWJ7AgRgT88FAt1n74eSydm2kihXg/+dBzXG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774231650; c=relaxed/relaxed;
	bh=BHtZECZh1lccSMdvYoO6Obq74NAnMNmsVszX85g9OrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VMA0+kKkWCssjiR4vW8cZrwNetykiquwzIqrJNfxeIB889RNCvfaIwXunQYFQ7GpqA6PMYsa+fjwnNRcIuZBXeHTuv/lyz4FheW5Uy06Yu868Lk2DADCKIzmIAX7gOHehxVua1+oc7MbIst+51jVzkgfkwTevoeTEkmRgvTN3iMhHDCotWzxQgyZkMBXhCo3x6LCFL1CDQqBPGg/BzGUeb6PX3+i5M8WSKsYyWdgBKfW3hv8OTdbx3n+WK+h7GqxcnZokbPcBC2ouTpymJKmccqxX5+yYNS8OE2ruFHFFCbII2mP+TqdchnhYeKHDXpXpEOzbzYxVgtDHj89at0xCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffGlP2XnWz2ybR;
	Mon, 23 Mar 2026 13:07:29 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Mar
 2026 10:07:08 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 10:07:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 23 Mar 2026 10:07:08 +0800
Subject: [PATCH v3 2/2] mmc: sdhci-of-aspeed: Handle optional controller
 reset
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
Message-ID: <20260323-sdhci-v3-2-93555b8f6411@aspeedtech.com>
References: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
In-Reply-To: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774231627; l=1614;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=DSoqlna8u7OCuF3/5m/l2C6jTM9r0dUx3ka7UV6Fe8A=;
 b=2NOHNRMbWSjIf/Q/IGPuiAKn1Vu1+RK6ULNl8RyuYHEoNAv7haKXCiQvAHzYZcUQ3tQiauXL/
 l/4s4jb0FsODeF4YQjLp1AJ3x4lXXyFKlTC9oyYeNVjOoky+husJTOm
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Get the optional reset line for the ASPEED SD controller during probe by
using devm_reset_control_get_optional_exclusive_deasserted().

This allows platforms such as AST2700, which require the SD controller
to be taken out of reset before use, to work with the existing driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- use devm_reset_control_get_optional_exclusive_deasserted replace
  reset_control_get_optional_exclusive.
- add include reset.h
---
 drivers/mmc/host/sdhci-of-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ca97b01996b1..8f638ffb55ae 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include "sdhci-pltfm.h"
@@ -520,6 +521,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
 	struct device_node *parent, *child;
+	struct reset_control *reset;
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -529,6 +531,10 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sdc->lock);
 
+	reset = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset), "unable to acquire reset\n");
+
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk))
 		return PTR_ERR(sdc->clk);

-- 
2.34.1


