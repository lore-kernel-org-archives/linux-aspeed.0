From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Wed, 16 Oct 2024 10:24:09 +0800
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
In-Reply-To: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
Message-ID: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ASPEED AST27XX interrupt controller(INTC) contains second level and
third level interrupt controller.

INTC0:
The second level INTC, which used to assert GIC if interrupt in INTC1 asserted.

INTC1_x:
The third level INTC, which used to assert INTC0 if interrupt in modules
of INTC asserted.

The relationship is like the following:
  +-----+   +-------+     +---------+---module0
  | GIC |---| INTC0 |--+--| INTC1_0 |---module1
  |     |   |       |  |  |         |---...
  +-----+   +-------+  |  +---------+---module31
                       |
                       |   +---------+---module0
                       +---| INTC1_1 |---module1
                       |   |         |---...
                       |   +---------+---module31
                      ...
                       |   +---------+---module0
                       +---| INTC1_5 |---module1
                           |         |---...
                           +---------+---module31

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../aspeed,ast2700-intc.yaml                  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
new file mode 100644
index 000000000000..55636d06a674
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
@@ -0,0 +1,86 @@
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
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
+
+  interrupts:
+    maxItems: 6
+    description: |
+      Depend to which INTC0 or INTC1 used.
+      INTC0 and INTC1 are two kinds of interrupt controller with enable and raw
+      status registers for use.
+      INTC0 is used to assert GIC if interrupt in INTC1 asserted.
+      INTC1 is used to assert INTC0 if interrupt of modules asserted.
+      +-----+   +-------+     +---------+---module0
+      | GIC |---| INTC0 |--+--| INTC1_0 |---module2
+      |     |   |       |  |  |         |---...
+      +-----+   +-------+  |  +---------+---module31
+                           |
+                           |   +---------+---module0
+                           +---| INTC1_1 |---module2
+                           |   |         |---...
+                           |   +---------+---module31
+                          ...
+                           |   +---------+---module0
+                           +---| INTC1_5 |---module2
+                               |         |---...
+                               +---------+---module31
+
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
+            compatible = "aspeed,ast2700-intc-ic";
+            reg = <0 0x12101b00 0 0x10>;
+            #interrupt-cells = <2>;
+            interrupt-controller;
+            interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.34.1

