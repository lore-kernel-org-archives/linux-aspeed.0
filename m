Return-Path: <linux-aspeed+bounces-3650-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894E0106FD7D
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 05:28:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXCgk3txHz3cK4;
	Fri, 13 Mar 2026 16:28:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773379698;
	cv=none; b=OP0qghrbhy2BdKdQLWzDJsJ1yvKMy8pmVM+e/f52vLqTjTrAt65PSjQeVuKhenA9rXFPUK+6PdrQptqhF0gqUeimKBUbxHxoYKDzu4ybHG5ZuEjMKk7DA6siNXz1vvtpgVg92JbV3KjyLbM8lkxrI8l+xO9+HrWwALzloKRs0hJDGnrwIB3YCDpnefkU3Z598SM7dijrtfJv6ZHwHKOHtARu2OSIkitlxEcQSI0hSM9et4AZmxQ9yt7D+bl8giZENhzOjM3DMu6rxUs07BVB1tvo6tJpNjKXR5MP3ZXWeSWql3LrYRCz/s4vMNUvJCJ6TqI9bkzxTtBEP2AZO9IKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773379698; c=relaxed/relaxed;
	bh=Tj1vQp/OZqFigt0p+7kevEE400SH3+d2YJ4SVBK5lwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nAFHf9MQ+WO6/bYspA6cDvJsILoPVtf5X9yO3LSNa4oal3v0HZUl6GNPdPxMeMjA80YZSYhzgyA3FQgwtKkQlC2lQiyTsInt9GzL1ci8eciUeLbBYdA131VYwnae27Tz7gY/RzKYea6BynnG1+dHktcE3RQStzdC+MVbRjKKuosvp1RsMnups3b0BhAPwSbxGEGoX5C6MaFF/YUaGedHdc5VqElTHmRWxGi0RFhRLFWNPRis+EcZkOG1KzouMebWFprB0LLudR07Onu15UlDtofOU9H4p72xMdroy3f+H+IbAgAsmH08wFOdrw8BeOU/TAb3n2YXSiz0nrlRdXMQIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXCgj5bfFz3cKj;
	Fri, 13 Mar 2026 16:28:17 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 13 Mar 2026 13:27:57 +0800
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
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
Message-ID: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
In-Reply-To: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=1605;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=hRhcm7i6Ipu+U8ypFOSg4nwRS0+xKrmtHEwCMOzK03U=;
 b=+CWnn9LIycIPd3L9+5pOLuYnU8iouEreNTfMj0wiRQr+N0l2JHaHUTeKm+G/aSNdNmiUtEa/o
 T8y8ZEVTBEqD8KG2ovwz7ONlHR17cotJYowKSXpJxzY+ZQwvUj2CbSq
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add support for the AST2700 SOC in the sd controller driver. AST2700 sd
controller requires an reset line, so hook up the optional reset control
and deassert it during probe.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ca97b01996b1..91c36245e506 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -520,6 +520,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
 	struct device_node *parent, *child;
+	struct reset_control *reset;
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -529,6 +530,15 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sdc->lock);
 
+	reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "unable to acquire reset\n");
+	ret = reset_control_deassert(sdc->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "reset deassert failed\n");
+
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk))
 		return PTR_ERR(sdc->clk);
@@ -577,6 +587,7 @@ static const struct of_device_id aspeed_sdc_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sd-controller", },
 	{ .compatible = "aspeed,ast2500-sd-controller", },
 	{ .compatible = "aspeed,ast2600-sd-controller", },
+	{ .compatible = "aspeed,ast2700-sd-controller", },
 	{ }
 };
 

-- 
2.34.1


