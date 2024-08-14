From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 14 Aug 2024 19:41:05 +0800
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
In-Reply-To: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
Message-ID: <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ASPEED AST27XX interrupt controller(INTC) contain second level and
third level interrupt controller. The third level INTC combines 32 interrupt
sources into 1 interrupt into parent interrupt controller. The second
level INTC doing hand shake with third level INTC.
---
 .../aspeed,ast2700-intc.yaml                  | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..9a76d5c3b66b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2700 Interrupt Controller
+
+description:
+  This interrupt controller hardware is second level interrupt controller that
+  is hooked to a parent interrupt controller. It's useful to combine multiple
+  interrupt sources into 1 interrupt to parent interrupt controller.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2700-intc-ic
+
+  reg:
+    minItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+    description:
+      It contains two types of interrupt controller. The first type is multiple
+      interrupt sources into parent interrupt controller. The second type is 
+      1 interrupt source to parent interrupt controller.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+    
+        interrupt-controller at 12101b00 {
+          compatible = "aspeed,ast2700-intc-ic";
+          reg = <0 0x12101b00 0 0x10>;
+          #interrupt-cells = <2>;
+          interrupt-controller;
+          interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                       <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.34.1

