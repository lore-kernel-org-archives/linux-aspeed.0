Return-Path: <linux-aspeed+bounces-1227-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298FBC54E65
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 11:06:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1sDj507Yz3blb;
	Tue, 20 May 2025 21:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747733767;
	cv=none; b=D1S57gAUeF/RSiTk+B4/MV6a+0Nwk+bm0ok3o2yX7qvkbXOCoMZlSDB3FTfcaimFMCQ4nRndOq/NVKXQ9fjZQgwpTGoQ/lqV+wXmmRZA+1kUbJpDWfGQrfEdcInKqvFNDvO5FTj8AuZxM1fZJITSwuNbEVI6CHm9YNh/wvU6Qsu9JE++zXRQgOLYa2sfuuqBtYvjjqjfeupxrlM9blvoqxVrGVJnlR1RNTPmLayznmoXlt/IH1/9++UwA4hC9QvUPwczajDL8u6EQ3+PO88IbK9WjnyFQUscr11ZvCQWOqIsUOMpO+ZoVSWa7C5Daw1bwxEQwKLp7Piz2Un0NljofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747733767; c=relaxed/relaxed;
	bh=KAe5bq7uM/N/La4BH66i218d2H2kxrQKMMhOdSxj6fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTbd7GXMJQTTeqRrX1foUPw5IbFyOLmTBOpWpO6AxbvThOwXRQCA0aaLR8FcvaVy2m/YgqZ5fJJltLk4rdoNN9dC5hrPDEAbl3rGhzO74GzCe51++qw77H7OM2JAVLIHLXQ1rPqLtTfzgRaXjUt+EwBOkUWMqaNAjIqBXCuRd/IdsS5YG4CDUiBbVNt+jw8MPyLVW/PL4u+PA/VgDpW4jwCl+qIyHI9JMHRXt0Lw08MMTCTzoDUv5tC9Ig8f9OX8r+l3xDne7eAHm1HN1eGpWMvHx8DU05rn7N6S/m7rzmKT1lbWjkVJhgyPVLsKu5mLnR0DD5HGtN3xTS8QbfLjVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 412 seconds by postgrey-1.37 at boromir; Tue, 20 May 2025 19:36:00 AEST
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1qDc0W4Wz2ygY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 May 2025 19:35:59 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 17:28:49 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 17:28:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Date: Tue, 20 May 2025 17:28:45 +0800
Message-ID: <20250520092848.531070-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
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

Add optional resets property for Aspeed SoCs to reset the MAC and
RGMII/RMII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..f7af2cd432d3 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -35,6 +35,11 @@ properties:
       - description: MAC IP clock
       - description: RMII RCLK gate for AST2500/2600
 
+  resets:
+    maxItems: 1
+    description:
+      Optional reset control for the MAC controller (e.g. Aspeed SoCs)
+
   clock-names:
     minItems: 1
     items:
-- 
2.34.1


