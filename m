Return-Path: <linux-aspeed+bounces-1689-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4FCC83F1A
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Jul 2025 03:16:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfDHx1fDyz2y8W;
	Sat, 12 Jul 2025 13:16:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751957766;
	cv=none; b=mecsK1UYT3X06hPVOyJLGaHEYgVpFLLVQa9m70+pjDS7DhPq2wmJnPG9Uq5YOyMl7t2DxLbLrzeZ0icMZF8WSdSDMKaMxuYirxnLvcxsgEuvNVtNHWTkU65p2y0KEAHu5B6PzuTvY+BzOuViDR7n8MP7dQn71fkE6oWmHQoRzvtgnVGEn/cfsEPYri+XhQZVRLV05XuhWbPliE6OWNf+wOTFfABPMVn4zs91CrV6ywDlr5siPgPpas75d4toYBZn+ZCvUU3WeXrIC6xv0qWnpqS7m51FRGerXQeKzkfey2aAXpe95p63oGU9Mc+zZ713FtGPpQFLKMSEb7czq83Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751957766; c=relaxed/relaxed;
	bh=xKjFwYg9ZQQxfjXsi9oN89dsMs+vx9jQgYZKL6hYutQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk55KgON/i7lhQPrMGClT84nJ2rdULEb1sjOboVwkbKj9PQNKyZ5ULCNjTd0G24COB6FyTYRtfaZFxhxWgZ04m0+wPaXsBwU2fz8fvipyx+NSDXuuS8eS9a2sxtfp3GULz+qQPui7Rg8fGorGfjvPieuIpcaA9t99fVh7ow9LPEdJr5cQS+uVTqCCJpfU9E/h9eW/IRfFkcZP09oRLfURCzXOpryXFFHx/N1loUFEYWbiDqxyGhJUAqXovro+pPgzYCdEeA2iY1y08mrf7fK7Zi5obc+vWlicWN0kQrRntg0SpxEXsxR7JHGiweOQbuIFF1bQtBzq7nP/HXwneOg9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbsMT12FRz3bTf
	for <linux-aspeed@lists.ozlabs.org>; Tue,  8 Jul 2025 16:56:05 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 8 Jul
 2025 14:55:44 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 8 Jul 2025 14:55:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <hkallweit1@gmail.com>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next v3 1/4] dt-bindings: net: ftgmac100: Add resets property
Date: Tue, 8 Jul 2025 14:55:41 +0800
Message-ID: <20250708065544.201896-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
References: <20250708065544.201896-1-jacky_chou@aspeedtech.com>
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
 .../bindings/net/faraday,ftgmac100.yaml       | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..a2e7d439074a 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Faraday Technology FTGMAC100 gigabit ethernet controller
 
-allOf:
-  - $ref: ethernet-controller.yaml#
-
 maintainers:
   - Po-Yu Chuang <ratbert@faraday-tech.com>
 
@@ -35,6 +32,11 @@ properties:
       - description: MAC IP clock
       - description: RMII RCLK gate for AST2500/2600
 
+  resets:
+    maxItems: 1
+    description:
+      Optional reset control for the MAC controller
+
   clock-names:
     minItems: 1
     items:
@@ -74,6 +76,21 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - aspeed,ast2600-mac
+    then:
+      properties:
+        resets: true
+    else:
+      properties:
+        resets: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


