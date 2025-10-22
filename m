Return-Path: <linux-aspeed+bounces-2554-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5954CCCD1BE
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 06:55:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs0Kp6jhpz2yjx;
	Wed, 22 Oct 2025 17:55:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761116126;
	cv=none; b=lRLnoWikRPc6QTG+Fuj6OdXRCnmpqYRjgbXVyXqLHICT6CZ01nuBikbkrHslI3NLshKIiGOSgpPprgJOCLm5bGYXMGFn5kfP3TkyIJz8RWAmawk/ub4Wx3GZRc3PD/xU31UbB7iclibnuJFfamY2ryBpEDYhTKgo56cw1BZpczMWj7ydXQjOtrwbOHxCy9qHicGgnHfVkJCZPPbN1i7pI8x6lWpSk2KsXRjFGvC/Qda1jLxGiNTxgIpBnB17uR67PHSH35uBAc1QJYqlmNABxENt1zKAkKrQyMHFJnqs1Mr1unjXscVJ9icbaTcyTUBvT5B48p0z7x3MUQAJspWvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761116126; c=relaxed/relaxed;
	bh=Vc2ENupPSvUHAQCJO8a03DHUyd9OoZeBWm+ElENjpmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nom5qhlewDwzUVwfrnr8FfdBihyGqfwwreid+rJ6ZbDPvEQLPs3vwcfREfQb/fLpaWA6yoQjLSX//rfGej3Fese6I+u+KZZzpbVuw1sQmscaxZ9LPlnH3K8mT4O2tw56/EdadsSFPJWJSECTxlPtfb27ToTmv1LfQYdOV0IiuYtwqsEdd+7OOzL1EjUFubg85jgLGkTqgX+pjzbtufWiF6T55XNbCC2ZLWgR7yoRORoD39M4T/T4mjsBa/xya104+oiT//YxGM3Gx9k84v0LaytoCHWyyE8NJ1i//43CqEyd1CYibcZlxAERd6NskNAdFiOhQ7bLMh8wTxX65WVTFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs0Kn6N90z2yFT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 17:55:25 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 14:55:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 14:55:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 1/3] dt-bindings: interrupt-controller: aspeed,ast2700: Add support for INTC hierarchy
Date: Wed, 22 Oct 2025 14:55:05 +0800
Message-ID: <20251022065507.1152071-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
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

AST2700 contains two-level interrupt controllers (INTC0 and INTC1),
each with its own register space and handling different sets of
peripherals.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../aspeed,ast2700-intc0.yaml                 | 97 +++++++++++++++++++
 .../aspeed,ast2700-intc1.yaml                 | 94 ++++++++++++++++++
 2 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
new file mode 100644
index 000000000000..93a5b142b0a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+title: ASPEED AST2700 Interrupt Controller 0
+
+description:
+  This interrupt controller hardware is first level interrupt controller that
+  is hooked to the GIC interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to GIC interrupt controller.
+
+properties:
+  compatible:
+    const: aspeed,ast2700-intc0
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^interrupt-controller@":
+    type: object
+    description: A child interrupt controller node
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2700-intc0-ic
+
+      reg:
+        maxItems: 1
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+      interrupts:
+        minItems: 1
+        maxItems: 10
+
+    required:
+      - compatible
+      - reg
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    intc0: interrupt-controller@12100000 {
+        compatible = "aspeed,ast2700-intc0";
+        reg = <0x12100000 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x12100000 0x4000>;
+
+        intc0_11: interrupt-controller@1b00 {
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            compatible = "aspeed,ast2700-intc0-ic";
+            reg = <0x1b00 0x10>;
+            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
new file mode 100644
index 000000000000..2f807d074211
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+title: ASPEED AST2700 Interrupt Controller 1
+
+description:
+  This interrupt controller hardware is second level interrupt controller that
+  is hooked to a parent interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to parent interrupt controller.
+
+properties:
+  compatible:
+    const: aspeed,ast2700-intc1
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^interrupt-controller@":
+    type: object
+    description: A child interrupt controller node
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - aspeed,ast2700-intc1-ic
+
+      reg:
+        maxItems: 1
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+      interrupts-extended:
+        minItems: 1
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - interrupt-controller
+      - '#interrupt-cells'
+      - interrupts-extended
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    intc1: interrupt-controller@14c18000 {
+        compatible = "aspeed,ast2700-intc1";
+        reg = <0x14c18000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x14c18000 0x400>;
+
+        intc1_0: interrupt-controller@100 {
+            compatible = "aspeed,ast2700-intc1-ic";
+            reg = <0x100 0x10>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            interrupts-extended = <&intc0_11 0>;
+        };
+
+        intc1_1: interrupt-controller@110 {
+            compatible = "aspeed,ast2700-intc1-ic";
+            reg = <0x110 0x10>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            interrupts-extended = <&intc0_11 1>;
+        };
+    };
\ No newline at end of file
-- 
2.34.1


