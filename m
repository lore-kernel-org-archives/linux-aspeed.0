From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 13 Aug 2024 15:43:37 +0800
Subject: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
In-Reply-To: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
Message-ID: <20240813074338.969883-2-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupt
sources into 1 interrupt into GIC from CPU die to CPU die.
The INTC design contains soc0_intc and soc1_intc module doing hand shake
between CPU die and IO die INTC.

In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
In soc1_intcX, each bit represent 1 device interrupt in IO die.

By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
1 interrupt source in soc0_intc11 in CPU die, which achieve the
interrupt passing between the different die in AST27XX.
---
 .../aspeed,ast2700-intc.yaml                  | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..93d7141bf9f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2700-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Interrupt Controller driver
+
+description:
+  These bindings are for the Aspeed interrupt controller. The AST2700
+  SoC families include a legacy register layout before a re-designed
+  layout, but the bindings do not prescribe the use of one or the other.
+
+maintainers:
+  - Kevin Chen <kevin_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - aspeed,ast2700-intc-ic
+          - aspeed,ast2700-intc-icv2
+        description: |
+          Use "aspeed,ast2700-intc-ic" for soc1 INTC in IO die
+          Use "aspeed,ast2700-intc-icv2" for soc0 INTC in CPU die
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 3
+    description:
+      Specifies which contexts are connected to the INTC, with "-1" specifying
+      that a context is not present. Each node pointed to should be a
+      aspeed,ast2700-intc-ic or aspeed,ast2700-intc-icv2 nodes which are pointed
+      to gic node.
+
+  "#address-cells":
+    const: 2
+  "#size-cells":
+    const: 2
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The first cell cell is the interrupt source IRQ number, and the second cell
+      is the trigger type as defined in interrupt.txt in this directory.
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      The first cell cell is the interrupt enable register, and the second cell
+      is the status register.
+
+  ranges: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 10
+    description: |
+      Interrupt source of the CPU interrupts. In soc0_intc in CPU die INTC each bit
+      represent soc1_intc interrupt source. soc0_intc take care 10 interrupt source
+      from soc1_intc0~5 and ltpi0/1_soc1_intc0/1.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+example:
+  - |
+    soc0_intc: interrupt-controller at 12100000 {
+      compatible = "simple-mfd";
+      reg = <0 0x12100000 0 0x4000>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges = <0x0 0x0 0x0 0x12100000 0x0 0x4000>;
+
+      soc0_intc11: interrupt-controller at 1b00 {
+        compatible = "aspeed,ast2700-intc-icv2";
+        interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        reg = <0x0 0x1b00 0x0 0x10>;
+      };
+    };
+
+  - |
+    soc1_intc: interrupt-controller at 14c18000 {
+      compatible = "simple-mfd";
+      reg = <0 0x14c18000 0 0x400>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ranges = <0x0 0x0 0x0 0x14c18000 0x0 0x400>;
+
+      soc1_intc0: interrupt-controller at 100 {
+       compatible = "aspeed,ast2700-intc-ic";
+        interrupts-extended = <&soc0_intc11 0 IRQ_TYPE_LEVEL_HIGH>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        reg = <0x0 0x100 0x0 0x10>;
+      };
+    };
-- 
2.34.1

