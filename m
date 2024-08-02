From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 15:06:31 +0930
Subject: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to DT
 schema
In-Reply-To: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
References: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Address warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interrupt-controller at 1e6c0080: 'valid-sources' does not match any of the regexes: 'pinctrl-[0-9]+'

and

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/copro-interrupt-controller at 1e6c2000: failed to match any schema with compatible: ['aspeed,ast2400-cvic', 'aspeed-cvic']

Note that the conversion to DT schema causes some further warnings to
be emitted, because the Aspeed devicetrees are not in great shape. These
new warnings are resolved in a separate series:

https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd at codeconstruct.com.au/

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++++++++++
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
new file mode 100644
index 000000000000..3c85b4924c05
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/aspeed,ast2400-cvic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Coprocessor Vectored Interrupt Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+description:
+  The Aspeed AST2400 and AST2500 SoCs have a controller that provides interrupts
+  to the ColdFire coprocessor. It's not a normal interrupt controller and it
+  would be rather inconvenient to create an interrupt tree for it, as it
+  somewhat shares some of the same sources as the main ARM interrupt controller
+  but with different numbers.
+
+  The AST2500 also supports a software generated interrupt.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-cvic
+          - aspeed,ast2500-cvic
+      - const: aspeed,cvic
+
+  reg:
+    maxItems: 1
+
+  valid-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      One cell, bitmap of support sources for the implementation.
+
+  copro-sw-interrupts:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      A list of interrupt numbers that can be used as software interrupts from
+      the ARM to the coprocessor.
+
+required:
+  - compatible
+  - reg
+  - valid-sources
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller at 1e6c2000 {
+        compatible = "aspeed,ast2500-cvic", "aspeed,cvic";
+        reg = <0x1e6c2000 0x80>;
+        valid-sources = <0xffffffff>;
+        copro-sw-interrupts = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt b/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
deleted file mode 100644
index d62c783d1d5e..000000000000
--- a/Documentation/devicetree/bindings/misc/aspeed,cvic.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* ASPEED AST2400 and AST2500 coprocessor interrupt controller
-
-This file describes the bindings for the interrupt controller present
-in the AST2400 and AST2500 BMC SoCs which provides interrupt to the
-ColdFire coprocessor.
-
-It is not a normal interrupt controller and it would be rather
-inconvenient to create an interrupt tree for it as it somewhat shares
-some of the same sources as the main ARM interrupt controller but with
-different numbers.
-
-The AST2500 supports a SW generated interrupt
-
-Required properties:
-- reg: address and length of the register for the device.
-- compatible: "aspeed,cvic" and one of:
-		"aspeed,ast2400-cvic"
-	      or
-		"aspeed,ast2500-cvic"
-
-- valid-sources: One cell, bitmap of supported sources for the implementation
-
-Optional properties;
-- copro-sw-interrupts: List of interrupt numbers that can be used as
-		       SW interrupts from the ARM to the coprocessor.
-		       (AST2500 only)
-
-Example:
-
-	cvic: copro-interrupt-controller at 1e6c2000 {
-		compatible = "aspeed,ast2500-cvic";
-		valid-sources = <0xffffffff>;
-		copro-sw-interrupts = <1>;
-		reg = <0x1e6c2000 0x80>;
-	};

-- 
2.39.2

