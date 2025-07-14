Return-Path: <linux-aspeed+bounces-1691-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CCCC83F17
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Jul 2025 07:18:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgYZG255Kz3bsT;
	Mon, 14 Jul 2025 17:18:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752477494;
	cv=none; b=nP4lZlrzy8/1tz3T8nRcUbP0BimI8FulY3vhqLe1poYOW59wo0IkY0Js+0mjQ0HQ0z3sIdg0wQtrxaIfQy/Q0oWKo5ljhMrx+uwii0OrhmyWfstAXMzlSH5tx6dVWx4wUfsUCw4ctxEA0PWHsmD34UqMXprzucAX0+65sGuWD2Rg8Fawe1XpP2ZRX3U6abFlLhc/lPmiT05cHpBIyxPQ7ruEITmUTobd2ASiNQnWbFdZKNznbFAmJ168p5PQd/NFwJQDL3LvOvpD6/kdwxlLdpqMQsjtGr8tc9zR+h1BrRtiVP23YOrPkPmm8g1NLLgelHUdCgrZ36g5S2bObRtyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752477494; c=relaxed/relaxed;
	bh=glYySSu5bOt/NAhJDzz3/8dWdR+IuTirRor33nYnHck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RzzKeYmT4P96PorhUmolTu1+IKbh1hKJizhYau6gHxwPTTzDVpX0Md9YTzHgyKh+LwplS+g1ZTjiLTNl17Sr545waJUXh5sHV0BgjLmFsdPJqUNI1mkNIJV3CC9xW2HDvMliLUV+1cX9n82RDlm5VwKs0LryuFLOThuUyPJr7bk6ouAnyaM3y+WC1cXnJ/hjYcH8njd31CNKi+UgDujxQODIggsOywSojdIFQmO/J+8Uv8DJuPtHZI72fccR7+/Sh3wxXzkoRA4kRWIMF/SV+O1VMWgj2VQJCdFo0NRSG6wzbmKKv2DV5Ysl5WZYiKW8l3z6BVeY2OV5nSVTRbP63g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgYZF2SkHz3bsM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Jul 2025 17:18:12 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 14 Jul
 2025 15:17:53 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 14 Jul 2025 15:17:53 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH] dt-bindings: interrupt-controller: aspeed: Refine AST2700 binding description and example
Date: Mon, 14 Jul 2025 15:17:53 +0800
Message-ID: <20250714071753.2653620-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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

- Update block diagram for better readability and accuracy.
- Clarify the relationship and function of INTC0, INTC1, and the GIC.
- Documentation and example refine.

This enhances the documentation quality and helps developers understand
the interrupt controller hierarchy and usage.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../aspeed,ast2700-intc.yaml                  | 155 +++++++++++++-----
 1 file changed, 112 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..751a07d49c90 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -10,6 +10,33 @@ description:
   This interrupt controller hardware is second level interrupt controller that
   is hooked to a parent interrupt controller. It's useful to combine multiple
   interrupt sources into 1 interrupt to parent interrupt controller.
+  Depend to which INTC0 or INTC1 used.
+  INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
+  status registers for use.
+  INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+  INTC1 is used to assert INTC0 if interrupt of modules asserted.
+  +-----+   +---------+
+  | GIC |---|  INTC0  |
+  +-----+   +---------+
+            +---------+
+            |         |---module0
+            | INTC0_0 |---module1
+            |         |---...
+            +---------+---module31
+            |---....  |
+            +---------+
+            |         |     +---------+
+            | INTC0_11| +---| INTC1   |
+            |         |     +---------+
+            +---------+     +---------+---module0
+                            | INTC1_0 |---module1
+                            |         |---...
+                            +---------+---module31
+                            ...
+                            +---------+---module0
+                            | INTC1_5 |---module1
+                            |         |---...
+                            +---------+---module31
 
 maintainers:
   - Kevin Chen <kevin_chen@aspeedtech.com>
@@ -17,49 +44,67 @@ maintainers:
 properties:
   compatible:
     enum:
-      - aspeed,ast2700-intc-ic
+      - aspeed,ast2700-intc0
+      - aspeed,ast2700-intc1
 
   reg:
     maxItems: 1
 
-  interrupt-controller: true
+  'address-cells':
+    const: 2
 
-  '#interrupt-cells':
+  'size-cells':
     const: 2
-    description:
-      The first cell is the IRQ number, the second cell is the trigger
-      type as defined in interrupt.txt in this directory.
-
-  interrupts:
-    maxItems: 6
-    description: |
-      Depend to which INTC0 or INTC1 used.
-      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
-      status registers for use.
-      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
-      INTC1 is used to assert INTC0 if interrupt of modules asserted.
-      +-----+   +-------+     +---------+---module0
-      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
-      |     |   |       |  |  |         |---...
-      +-----+   +-------+  |  +---------+---module31
-                           |
-                           |   +---------+---module0
-                           +---| INTC1_1 |---module2
-                           |   |         |---...
-                           |   +---------+---module31
-                          ...
-                           |   +---------+---module0
-                           +---| INTC1_5 |---module2
-                               |         |---...
-                               +---------+---module31
 
+  ranges: true
+
+patternProperties:
+  "^interrupt-controller@":
+    type: object
+    description: Interrupt group child nodes
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2700-intc-ic
+
+      reg:
+        maxItems: 1
+
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 2
+        description: |
+          The first cell is the IRQ number, the second cell is the trigger
+          type as defined in interrupt.txt in this directory.
+
+      interrupts:
+        minItems: 1
+        maxItems: 6
+        description: |
+          The interrupts provided by this interrupt controller.
+
+      interrupts-extended:
+        minItems: 1
+        maxItems: 6
+        description: |
+          This property is required when defining a cascaded interrupt controller
+          that is connected under another interrupt controller. It specifies the
+          parent interrupt(s) in the upstream controller to which this controller
+          is connected.
+
+    required:
+      - compatible
+      - reg
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts
 
 required:
   - compatible
   - reg
-  - interrupt-controller
-  - '#interrupt-cells'
-  - interrupts
 
 additionalProperties: false
 
@@ -68,19 +113,43 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      intc0: interrupt-controller@12100000 {
+        compatible = "aspeed,ast2700-intc0";
+        reg = <0 0x12100000 0 0x4000>;
+        ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        intc0_11: interrupt-controller@1b00 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0 0x12101b00 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts = <GIC_SPI 192 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 193 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 194 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 195 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 196 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+                       <GIC_SPI 197 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+        };
+      };
+
+      intc1: interrupt-controller@14c18000 {
+        compatible = "aspeed,ast2700-intc1";
+        reg = <0 0x14c18000 0 0x400>;
+        ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
         #address-cells = <2>;
         #size-cells = <2>;
 
-        interrupt-controller@12101b00 {
-            compatible = "aspeed,ast2700-intc-ic";
-            reg = <0 0x12101b00 0 0x10>;
-            #interrupt-cells = <2>;
-            interrupt-controller;
-            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        intc1_0: interrupt-controller@100 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0x0 0x100 0x0 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts-extended = <&intc0_11 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
         };
+      };
     };
-- 
2.34.1


