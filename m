From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 16 Feb 2023 15:41:52 +0800
Subject: [PATCH 1/4] dt-bindings: i3c: Add AST2600 i3c controller
In-Reply-To: <cover.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <82d750f53df622d8986e9a07053c7ee27dee61a2.1676532146.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a devicetree binding for the ast2600 i3c controller hardware. This
is heavily based on the designware i3c core, plus a reset facility
and two platform-specific properties:

 - sda-pullup-ohms: to specify the value of the configurable pullup
   resistors on the SDA line

 - aspeed,global-regs: to reference the (ast2600-specific) i3c global
   register block, and the device index to use within it.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
changes from RFC:
 - add vendor prefix to global-regs properties
 - add item description on global-regs property
 - drop global reg node from example
---
 .../bindings/i3c/aspeed,ast2600-i3c.yaml      | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
new file mode 100644
index 000000000000..920428f243b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/aspeed,ast2600-i3c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 i3c controller
+
+maintainers:
+  - Jeremy Kerr <jk@codeconstruct.com.au>
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+    const: aspeed,ast2600-i3c
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sda-pullup-ohms:
+    enum: [545, 750, 2000]
+    default: 2000
+    description: |
+      Value to configure SDA pullup resistor, in Ohms.
+
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to i3c global register syscon node
+          - description: index of this i3c controller in the global register set
+    description: |
+      A (phandle, controller index) reference to the i3c global register set
+      used for this device.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - aspeed,global-regs
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c-master at 2000 {
+        compatible = "aspeed,ast2600-i3c";
+        reg = <0x2000 0x1000>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+        clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+        resets = <&syscon ASPEED_RESET_I3C0>;
+        aspeed,global-regs = <&i3c_global 0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i3c1_default>;
+        interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.39.1

