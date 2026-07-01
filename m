Return-Path: <linux-aspeed+bounces-4329-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E954EC44501
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Jul 2026 06:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqrTZ4WMgz2yQG;
	Wed, 01 Jul 2026 16:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782889138;
	cv=none; b=YeasWdET9tGKeKPCxTsDEQ8YBTcbRQBqA2Zd1gdUELevfEgP24ePzustMcux+MzcwX+yo8zAIJhMrLFyaQm4b8M7AyGKavC5TxyTs9mml/f7EF0C9Y72+elm4Z6yvrq8MayYnYiYjq62JhDGB3fExXx7nunoRYzOCxyzoatss2V77rGwKNeChrx2lYdZIJVdVmG1t1gZafpABPHy/V4Ud9GiFgv+44bjC7Jl5+LoPZYBWUBaehub3afLKpSi427aFe2eIPFWRfaYt7ho6Qulh4OH347W42taRUrTItA9XcA1qSCXDUT3E1s1Wgsb5Yj99ABL9WFJSq6pJ0qsg4cqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782889138; c=relaxed/relaxed;
	bh=H238V0QExqBvf0uJiuwC+fETVw8Dlnlqw5zEkkvMXsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j24Kls1kzlj3ccSpYhx1nU7RNf951Xp+gcWLTvrBqMN12Kr9q72dO5rZ/T56SLS0PA86HlC2JFZ4W24AorNR67FTtEPbGkYS4tL6ME8pfZtEiWZpQGH2MC/VOT20wPa7bdVYFbjSAo95sTtoCR7UbP08VVSL5zOOXBAArd4/R2Jcu9RlAeIoypSG5SFbo2iz5tR+5V88tlqFSRMaMjILEXIuTcBDeFAgUKocqGNr13+3zMVhKWw85AFpq46aCdKzGV63uQsg6eGJyUxyAxnEKvqi/s4UmzgtFJDbp8Z2h6m00aJxXHBWd8/Jx1gJjkLASzckD5UgvmBthuzt0OrBbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqrTY6k3Cz2xF8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Jul 2026 16:58:57 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 1 Jul
 2026 14:58:18 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 1 Jul 2026 14:58:18 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 1 Jul 2026 14:58:19 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add ASPEED USB3 PHY driver
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
Message-ID: <20260701-upstream_usb3phy-v3-3-00e12315b6f9@aspeedtech.com>
References: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
In-Reply-To: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782889098; l=861;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=njRESqLfQG7J4os1F1U/PJtipN00LX9glpTZuXwuxRE=;
 b=9nDC6roHxfGcpoe43h1qTGG9AwTHok6mjgtTbKiriMRNV5LYvorZCkvRv1RyoRS7m+iQGHzcm
 V8uVk5DQGeSBKe0/CjGZXbG8nfFOos6gvV42A+70KRo+SPXsxdJ0+vv
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add maintainer entry for ASPEED USB3 PHY driver.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 895a87b571c3..10c08f322618 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4062,6 +4062,14 @@ S:	Maintained
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


