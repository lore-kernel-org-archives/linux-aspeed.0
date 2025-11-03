Return-Path: <linux-aspeed+bounces-2711-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E23CCF9F8
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 07:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0NlV4zLXz3bcb;
	Mon,  3 Nov 2025 18:39:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762155590;
	cv=none; b=mcE0YtBJJaVrFlzcZCNfta2HeHyHQDpVx9jxix+KBVScbO9bQIRxZuu38imCsAwc9h4eR+xMGxSekfPr6RY2P/cl4SduyJjk0GlKeikgKI10VLRK6Q8tcyaWSH/6AVffcUhIdPkwFbQWieRI5xvrMVwSJuXxyKTzC+mNBSjZTGjYgRSuxGCyta4V462msjAoH3nhSYIqp9V7FPOtj7upmGzl0iYYy1omd2nS/4ZJTuQ9cNJSMdzCLLLW7z+JX0h3GEnLiLH7/B06JarVm7iBqxYLfYEZhJrDsVrtZVJRN4VwNL7FMo1DseZ/FiNNHt/aV/SHiEU3wopolNIVRULpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762155590; c=relaxed/relaxed;
	bh=73M7tW49m2K8uMh9lDk/bmUgfp3JFhduDvFKOahFF2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LvMyjFCOt/KTYogGDgbaIq5QJJ90qvTGzm7RIq3oj1CmHCnf6uop7TbYWc7gY5B9KAMeN1P3Ia9ZleR0FdWn0envo7AX+vcVUBwBqu417z1sR/eL58CoFcnnP/HB5RHCG/FlJ0TXqKDGchQZF7ws/W/Kyc8ZaOWWWsnqPWpSC7jzNymOl8/cdq4TaUtsoOE3+4idQ7nc7yNdFHAOoLgvkOuZJH1HuYH0da3GdcakFJ9aNcBHF7bFFTWKgj1owImCdUy6CJX8fjtQeFi8fUZJn37LDO6rIcSFs5FNKqDI6wk612pRU+XFGEzKNAIUFdhKIZeptIEqLIkPN2e2W9rqtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0NlV1HP3z30RN
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 18:39:50 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 15:39:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 15:39:31 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 3 Nov 2025 15:39:16 +0800
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
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
Message-ID: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
In-Reply-To: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762155571; l=2708;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=PYQ6XsN2gnhIp8Xo10NhHRhhYIWg1cOPkDhVccPlR7M=;
 b=8dQN9gN9ej9i43GElLGYbszMymHwxeJW2OmcXiRvmXcYj/4GFfTzTlHQ1YGAWaPxG5n5BDaN+
 FO4ETMfGFPwAKTnDiLBELXw5qtDywwUeN9fTojTTX8W6/F85DDzewjc
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
  with 45ps step.
- For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
  with 250ps step.
- Both require the "scu" property.
Other compatible values remain unrestricted.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..de646e7e3bca 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -19,6 +19,12 @@ properties:
               - aspeed,ast2500-mac
               - aspeed,ast2600-mac
           - const: faraday,ftgmac100
+      - items:
+          - enum:
+              - aspeed,ast2600-mac01
+              - aspeed,ast2600-mac23
+          - const: aspeed,ast2600-mac
+          - const: faraday,ftgmac100
 
   reg:
     maxItems: 1
@@ -69,6 +75,12 @@ properties:
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
@@ -88,6 +100,44 @@ allOf:
     else:
       properties:
         resets: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-mac01
+    then:
+      properties:
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
+        - rx-internal-delay-ps
+        - tx-internal-delay-ps
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
+        - rx-internal-delay-ps
+        - tx-internal-delay-ps
 
 unevaluatedProperties: false
 

-- 
2.34.1


