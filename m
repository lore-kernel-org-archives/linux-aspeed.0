Return-Path: <linux-aspeed+bounces-3747-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27B6F532C0
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Mar 2026 01:59:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fftWN3nW2z2yks;
	Tue, 24 Mar 2026 12:59:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774317552;
	cv=none; b=gUJNW+ffYujb0wSG7CysIT/XZm6P7HOON+umRCxDbNVcuYkUJh0h89lrS1wxCTPDFywX/Eyu+ke5k6D+VXfj/Ek3tB3kaOqCwmz+o43Vu7EWsjcPvGEvJX4oh6SKaX3G3emNqctm4rMH9rvWVj0RkyBbr4XNSMDn+cAjPudPzbv4T71jvjQZCIcNI95YYvlRWAoEsx5oXUNkVjvGoMgQUELWtPtwEThL9rcJQM+xh63J27uXWPmgzor1iEInFuXIEJfoWWT/IFKj/i4wU6X6sHe3mRFwL0jglKojG1oV46woC5EF1xnm0Ke8JripwAs0QRH24Izos1UlIe3JYgD5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774317552; c=relaxed/relaxed;
	bh=YyM5rRNjcVV3czh5+aRe7NOC3Lwt/0jnRpSysakwEY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N2rRrWmJ3IFSVdAahIeXw4PbnYJQae4vZ7wkLhthwgazIVryAuG+b30mjD5pDtAwORN8nuKsHOPj8pJmea58BRSBAz2LWcrFR4Cy0G1SLR4t3eIOL330q360HcNkEjxo1K6/UqRv53WyyQ8Jfi0xahLTKPjmBH92j7Afuol0KJT4hBfrBA5eBlcHcpI8kZLXDu/iBAF5anxbcPlC7koyOxF+DqHRrlnyTv9xyBjzNqlMLeU+oN0BPB7i/5znypN0SKi2gQ3OfqHElOtLlYcBbdH2zLw3ww9tq9gD6rFPVcooUVHxGO1Nnr4vOX2ikEw3l/tbdStknERM7eAAi5Tsag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fftWM4kDhz2yk6;
	Tue, 24 Mar 2026 12:59:11 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 24 Mar
 2026 09:58:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 09:58:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 24 Mar 2026 09:58:50 +0800
Subject: [PATCH v4 2/2] mmc: sdhci-of-aspeed: Handle optional controller
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
Message-ID: <20260324-sdhci-v4-2-c8c2060ccb5c@aspeedtech.com>
References: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
In-Reply-To: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774317530; l=1827;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=yTcAx3NAX05a2PPdk/ad8cZuE2IR4g+b9LdPiaLiA/A=;
 b=MrgtEjbFQCFNWXmMIdrLZxoiBifWfguS1h4SY1cutKwXP3miq5WzhUXtZrjM6Bmi03aNYkmWg
 Av7r8hBQHHkChhAr4t/wfNJvImB/FeLmU2szrgd/v+1n0jxaabx+eTE
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Get the optional reset line for the ASPEED SD controller during probe by
using devm_reset_control_get_optional_exclusive_deasserted().

This allows platforms such as AST2700, which require the SD controller
to be taken out of reset before use, to work with the existing driver.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v4:
- rebase git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  next branch fix the conflit.
Changes in v2:
- use devm_reset_control_get_optional_exclusive_deasserted replace
  reset_control_get_optional_exclusive.
- add include reset.h
---
 drivers/mmc/host/sdhci-of-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 4296def69436..f5d973783cbe 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include "sdhci-pltfm.h"
@@ -519,6 +520,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
+	struct reset_control *reset;
 	struct device_node *parent;
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


