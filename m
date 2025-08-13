Return-Path: <linux-aspeed+bounces-1946-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6BDCA0EE0
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:51:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBF6XZpz2xHp;
	Thu, 14 Aug 2025 09:51:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755066800;
	cv=none; b=cuHpZcUq9RRIDPynaeDHv4PYvT3mzDwLGJqdgkxx15Qf5KlovhYCLDOgdyNgQaFuYRKX1nUuaJIlyepcAErnF4RW153K86O9URkfs4nEnVL3OJajW7ypggHCGbLTWdkqMGhEDuuwLw7/6VKGLSjEUwTV3DCYQzbvx2+2x+M9vo5kGoPYXAiTTqQcoCHCapRcVA6T9qssAvpWn7i2WJYJR+6/sCcep+rWszNbvbQm2NuavKOg4c41tEXOzD6GO6KI/5c8QIO+HqU+XHxXkmvlALNu6QBMCAQoBHW/Ik22H4PxiJO7S8VzA66V20O9O7TDgRj+t6J/uwo6OcoerQZxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755066800; c=relaxed/relaxed;
	bh=iQKMkzuKZ8aQNaYA0xm+uguK3peEC/PfCD9otnle504=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBsLZ6e0r7UQBL6Y2z0V7YLhrynq22vNiHyCg+kxASf+SiP1uORu9AbDr0CTAAT65QMr5qFGKxcPDC9bX8ID/YMbrcKTvKIzI1kwvBGCQdtmNCPXHGeZs67tCBZywXRTdJgDMvm+lrWu6IeSv/Xf4cbDr0s+fcvuH8IQCLoXdXjkJKqvuQIidzh2W/D2QxP4XVVDzJhVVxbCgvLkyxfRkH5SeUVXoWGRKNa/ac+c4vxggJZsOFNmbkTX9s/Dm2rDuQK/beYrw9G7yDnFHc5Z0QeJgccKPH4KSh/zkT7WMyMvymrS/Lp2O+4zm2Uy2ZoLf+dR2ifPwvy3q/1q6nmmTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c1z8Z66Fyz30Vs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 16:33:18 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 13 Aug
 2025 14:33:01 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 13 Aug 2025 14:33:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: [net-next v2 1/4] dt-bindings: net: ftgmac100: Restrict phy-mode and delay properties for AST2600
Date: Wed, 13 Aug 2025 14:32:58 +0800
Message-ID: <20250813063301.338851-2-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
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

Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For "aspeed,ast2600-mac01", restrict phy-mode to "rgmii-id" and
  "rgmii-rxid", and require rx/tx-internal-delay-ps properties with 45ps
  step.
- For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
  with 250ps step.
- Both require the "scu" property.
Other compatible values remain unrestricted.

Because the RGMII delay on AST2600 MAC0/1 is 45ps and its total delay
step is 32, cannot cover 2ns delay for RGMII to meet center. We need
the PHY side enables RX internal delay and the phy_mode must be
"rgmii-id" or "rgmii-rxid".

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../bindings/net/faraday,ftgmac100.yaml       | 50 +++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index 55d6a8379025..82c7c81eab10 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Faraday Technology FTGMAC100 gigabit ethernet controller
 
-allOf:
-  - $ref: ethernet-controller.yaml#
-
 maintainers:
   - Po-Yu Chuang <ratbert@faraday-tech.com>
 
@@ -21,6 +18,8 @@ properties:
               - aspeed,ast2400-mac
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
+              - aspeed,ast2600-mac01
+              - aspeed,ast2600-mac23
           - const: faraday,ftgmac100
 
   reg:
@@ -69,6 +68,12 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
+  scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
+      This reference is used by the MAC controller to configure the RGMII delays.
+
 required:
   - compatible
   - reg
@@ -76,6 +81,45 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-mac01
+    then:
+      properties:
+        phy-mode:
+          enum: [rgmii-id, rgmii-rxid]
+        rx-internal-delay-ps:
+          minimum: 0
+          maximum: 1395
+          multipleOf: 45
+        tx-internal-delay-ps:
+          minimum: 0
+          maximum: 1395
+          multipleOf: 45
+      required:
+        - scu
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-mac23
+    then:
+      properties:
+        rx-internal-delay-ps:
+          minimum: 0
+          maximum: 7750
+          multipleOf: 250
+        tx-internal-delay-ps:
+          minimum: 0
+          maximum: 7750
+          multipleOf: 250
+      required:
+        - scu
+
 examples:
   - |
     ethernet@1e660000 {
-- 
2.43.0


