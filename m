Return-Path: <linux-aspeed+bounces-3360-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95428D4A5F6
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 02:53:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dskvD73LMz309H;
	Fri, 16 Jan 2026 13:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768532024;
	cv=none; b=kTETqOfqSvRyQb7hwI3JYazZUqNQ+ykguEqi8VNfjYEpch346MQ3gqZsNNpU8OQjvd/vXs+vZDM8WTbNXWT/niXP5WGKbtgd1A3iZ0XuThHa6t0/fevfWNXNMxWP69NS3Dpqo2Y19/gm+PvlgzXXBh5sPEZ5nREQR45f7twv2ZoCnj7s2l/UtWZpBInq3ujkeWI9ag/Dqgvyovk7iZ1dAvknN7vtMfWw/SzgP5/jM08stJLnaSYC/zOKwZdE+hYizXbdOiTShZ9pDN8B24IN39BTcWu7QYlqj8MCW0hWkuT3p5Alg2WqD1E/Ayqej36WY88UtXqU8C6FEYUhyRxK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768532024; c=relaxed/relaxed;
	bh=Uss/QpmYPVd/dS0/PkfMLWFDUOUhv3WjodDOPx7uSew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ohuOueiqj1xasTqDavosAAPv7zohuCqFCgNPaQ4N6hyypWPo7d8ekTlaiPGwECQ3Qx6MvBXTLWca2e5bZ7j2Cy6l3Q+ehuT+xHRxszVgXcYKNXVdSWKj2Wige6bhP0sxgbK9C9yTrg24UBQiS4j/3rT3rflXnrUwhlDfckPuH/QMvf6eUI9uppAoobBD8qvk1tvtXgFDONqwQ/OG0glXMsfgIZArqP2ebFAFE3/LHK2IokRC2OXkAO9Tq44wIhBtGf36SIPPskrrbibdl2+DZwa5FT/mb6WKLXPySVFmKdrBcR/R7w+INGMbt8PFNUCAo71BDxdmWUp1yA3AeqBHlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dskvD3Tgnz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 13:53:44 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:53:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:53:26 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 16 Jan 2026 10:53:26 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add ASPEED USB3 PHY driver
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
Message-ID: <20260116-upstream_usb3phy-v2-3-0b0c9f3eb6f4@aspeedtech.com>
References: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
In-Reply-To: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768532005; l=861;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=QIuVZToJwsol7VdY+5pSQWFYnqd8me80J57qWsI+AEA=;
 b=7vGbc2YKRv3P5Cdpi4dbHki6edSiimkSoqQt2ayS1DAMWLyhUFcYAqYMzBIYw9rcYaoBp6aR6
 sYljnV8q6z+BhPgiiKcj8ASywERueoioB1bcDaI/5/ydLWqGmwOUEQE
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add maintainer entry for ASPEED USB3 PHY driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..ad1d12f346f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3894,6 +3894,14 @@ S:	Maintained
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


