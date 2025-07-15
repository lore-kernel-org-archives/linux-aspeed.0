Return-Path: <linux-aspeed+bounces-1699-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD11C83F1A
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Jul 2025 02:43:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bh3QZ24cqz3byT;
	Tue, 15 Jul 2025 12:43:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752547398;
	cv=none; b=d5TroBxdvIam2ssvjfnKNQArfFytS3Frtr4xHTc6+fH46d0N7Kax6gGe/30Byk6iIW7IqItBKGA4zv7DLrk8RO4ClOmIedphGAwOgAikTkRII0XJa23QIv91uqF1GLQ3ohSlBmKXeGpZcn7U/JVE/fxVlcX+/ytBCRMO3LnTCY3iBG/rNEPbCS62/uBDHcn4oFZ/Dwt57ma/b9FkdnLDNtWOwJwLgEnOHRYvYF6JY7kQZ17qXNo3Lrn68OX7RnAEJlQYK1Mh9k0lErolw/hy9Icgf1yalIKzmeA36doSUcOP1mIXBMwg3xbj99fWz2cICMr4VA+8u22KVRozk8vS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752547398; c=relaxed/relaxed;
	bh=PhXHdhDcXOJLnI2JuGKILPdOtW88b3jLAjqiNscaQ4s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8V/H5uQazQ7OBkn4CY6eC9XuxoAmqxmt7lOqkmtPa8jpP4zICi56o4CR0Fxtn04tX+kLCZjEs1FS3SPG8yfbY/tXWQ+qQhWSNmVysF+p9RGZixBSI3ZTsPkv3s2mOGDk1dWOTt7m5/c1U5p5c0IeSqkG+cHmkCE3XMGC+Rwmhrve4azrMnFPGvCRRWKNgD6bfl+mJIujHvCQGio4uOolBMs2hyGWrdF2hwyrZSrnk379NjFZZ4CcnpFmcOeJM+rdbfejJyVWEoabWfGCMrvHg8VKE1tf0UNsXstCWifh3XWhYuE1FaNSAiZt63GK5vKZuRp/bDOQHtUbTvzU2B0GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh3QY14BYz3byF
	for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Jul 2025 12:43:14 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 10:42:58 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 10:42:58 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: aspeed: Add parent node compatibles and refine documentation
Date: Tue, 15 Jul 2025 10:42:58 +0800
Message-ID: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>
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

- Add 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
strings for parent interrupt controller nodes, in addition to the
existing 'aspeed,ast2700-intc-ic' for child nodes.
- Clarify the relationship and function of INTC0, INTC1, and the GIC.
- Update and clarify documentation, block diagram, and examples
to reflect the hierarchy and compatible usage.
- Documentation and example refine.

This change allows the device tree and driver to distinguish between
parent (top-level) and child (group) interrupt controller nodes,
enabling more precise driver matching SOC register space allocation.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---

v2:
make dt_binding_check check
 address-cells,size-cells -> #address-cells,#size-cells.
 add oneOf required, parent us interrupts, child use interrupts-extended.
 fix intc0_11 size-cells.

---
 .../aspeed,ast2700-intc.yaml                  | 158 +++++++++++++-----
 1 file changed, 115 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
index 55636d06a674..bdc4d8835843 100644
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
@@ -17,49 +44,70 @@ maintainers:
 properties:
   compatible:
     enum:
-      - aspeed,ast2700-intc-ic
+      - aspeed,ast2700-intc0
+      - aspeed,ast2700-intc1
 
   reg:
     maxItems: 1
 
-  interrupt-controller: true
+  '#address-cells':
+    const: 2
 
-  '#interrupt-cells':
+  '#size-cells':
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
+    oneOf:
+      - required: [interrupts]
+      - required: [interrupts-extended]
+
+    required:
+      - compatible
+      - reg
+      - interrupt-controller
+      - '#interrupt-cells'
 
 required:
   - compatible
   - reg
-  - interrupt-controller
-  - '#interrupt-cells'
-  - interrupts
 
 additionalProperties: false
 
@@ -68,19 +116,43 @@ examples:
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
+          reg = <0 0x12101b00 0 0x10>;
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


