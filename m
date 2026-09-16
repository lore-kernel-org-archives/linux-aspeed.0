Return-Path: <linux-aspeed+bounces-4998-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74601C982CA
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 00:38:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl0P13jBKz2yhD;
	Wed, 16 Sep 2026 10:38:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789519109;
	cv=none; b=UmhZOsLwRJaLpepWg5GNI7xVX16J71ax5o5+sTg9hY0IPVmclEy8OxdT+no5UDDQKvJETKrgG0yAXemnwKHLVS2ApZh1YgVIOATlScb6sPXS3nVLZXOC7JRl3x7Kgb0cU1lLt6Puw3vx1/6MX7vuvxX5spxJt49rh8PjazFJy3QDkksHIXSYFxbDJdnXD2+LuCwm3vZ06av03w4iRwRD1NKMs1BMj9g54YWxiMv747JnWQpnFMHAEC7LE47JuZNKLlfHZgFEmQdibgruZRV1/E74tQJluYz7yoVT2uCf6bbR42MV1EXGV4/2p46kHzvoWmdcP9SeZVqiVJvSSDJqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789519109; c=relaxed/relaxed;
	bh=qWqknZdcQhdeJ3cusKZn9xll6uj9AfBii96LLhPluG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cWHlh7czyple/YyMcosDgVJ3Up45lYMKGqXDwblral91aa6Hh8JiTbF1le8lim0kpGKLIRzZwDS0ge76/cZOId3zYxNHG8CvG7tirMhr2l8L2EU+yOR6DXUCEwKACo4xxLkjPXVuQtP8srlf1RxZXip4adDcjB/UYTCKc3rvtF2twzkAew/wb2hmlmGOVyHcirpfkQPyLRsrM1GbGQo6mwGtd7MDoNW4Q4zCl2tjY8rdRF6brYYdkX9uB4l+46HQhIiuMvoh1aWjbV2R5Hm17sKagSXZOaa6z7KhYpo/v55XPJvKr1FXQnXKCTW2IYG03KglfLZDkCu8vVYqk0sdFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl0P05Z1Rz2xkr
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 10:38:28 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 16 Sep
 2026 08:38:02 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 16 Sep 2026 08:38:02 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 16 Sep 2026 08:38:03 +0800
Subject: [PATCH v4 3/3] MAINTAINERS: Add ASPEED USB3 PHY driver
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
Message-ID: <20260916-upstream_usb3phy-v4-3-812e76037d01@aspeedtech.com>
References: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
In-Reply-To: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Manivannan Sadhasivam <mani@kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789519082; l=938;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=EVwN71wwvZW6YXvP8NIxr+H0Thmoc9M41v8NtPW4CyY=;
 b=I3XcJ6lH056nVbxCeR1AxRKmCn1q+W8ECtAu22NciH6/1pPCvrxWPWjdJ6i3B62pvkhUqtiIu
 2Jd9r6PTMcLAwQ7G9JEpgatjVC5/q8FgQOIuFqn7aXhlkmbx90MtML4
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add maintainer entry for ASPEED USB3 PHY driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe10d29b7657..01d893612abb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4096,6 +4096,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
 F:	drivers/usb/gadget/udc/aspeed_udc.c
 
+ASPEED USB3 PHY DRIVER
+M:	Ryan Chen <ryan_chen@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-phy@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2700-usb3-phy.yaml
+F:	drivers/phy/aspeed/phy-aspeed-usb3.c
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org

-- 
2.34.1


