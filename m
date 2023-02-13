From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 15:41:52 +0800
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
Message-ID: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change adds a devicetree binding for the ast2600 i3c controller
hardware. This is heavily based on the designware i3c hardware, plus a
reset facility and two platform-specific properties:

 - sda-pullup-ohms: to specify the value of the configurable pullup
   resistors on the SDA line

 - global-regs: to reference the (ast2600-specific) i3c global register
   block, and the device index to use within it.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
RFC: the example in this depends on some not-yet-accepted patches for
the clock and reset linkages:

  https://lore.kernel.org/linux-devicetree/cover.1676267865.git.jk at codeconstruct.com.au/T/

I'm also keen to get some review on the pullup configuration too.

---
 .../bindings/i3c/aspeed,ast2600-i3c.yaml      | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
new file mode 100644
index 000000000000..ef28a8b77c94
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
@@ -0,0 +1,75 @@
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
+      Value of SDA pullup resistor in Ohms
+
+  global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      A (phandle, controller index) reference to the i3c global register set
+      used for this device.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - global-regs
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c-master at 2000 {
+        #address-cells = <3>;
+        #size-cells = <0>;
+        compatible = "aspeed,ast2600-i3c";
+        reg = <0x2000 0x1000>;
+        clocks = <&syscon ASPEED_CLK_GATE_I3C0CLK>;
+        resets = <&syscon ASPEED_RESET_I3C0>;
+        global-regs = <&i3c_global 0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_i3c1_default>;
+        interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    i3c_global: i3c-global at 0 {
+        compatible = "aspeed,ast2600-i3c-global", "simple-mfd", "syscon";
+        resets = <&syscon ASPEED_RESET_I3C_DMA>;
+        reg = <0x0 0x1000>;
+    };
+...
-- 
2.39.1

