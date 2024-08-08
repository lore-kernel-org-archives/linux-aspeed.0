From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 08 Aug 2024 13:44:24 +0930
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
Message-ID: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller at 1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']

The YAML DT schema defines an optional property, valid-sources, which
was not previously described in the prose binding. It is added to
document existing practice in the Aspeed devicetrees. Unfortunately
the property seems to predate the requirement that vendor-specific
properties be prefixed.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
 .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
deleted file mode 100644
index e3fea0758d25..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Aspeed Vectored Interrupt Controller
-
-These bindings are for the Aspeed interrupt controller. The AST2400 and
-AST2500 SoC families include a legacy register layout before a re-designed
-layout, but the bindings do not prescribe the use of one or the other.
-
-Required properties:
-
-- compatible : "aspeed,ast2400-vic"
-               "aspeed,ast2500-vic"
-
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 1.
-
-Example:
-
- vic: interrupt-controller at 1e6c0080 {
-      compatible = "aspeed,ast2400-vic";
-      interrupt-controller;
-      #interrupt-cells = <1>;
-      reg = <0x1e6c0080 0x80>;
- };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
new file mode 100644
index 000000000000..73e8b9a39bd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/aspeed,ast2400-vic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Vectored Interrupt Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+description:
+  The AST2400 and AST2500 SoC families include a legacy register layout before
+  a redesigned layout, but the bindings do not prescribe the use of one or the
+  other.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-vic
+      - aspeed,ast2500-vic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+    description:
+      Specifies the number of cells needed to encode an interrupt source. It
+      must be 1 as the VIC has no configuration options for interrupt sources.
+      The single cell defines the interrupt number.
+
+  valid-sources:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    description:
+      A bitmap of supported sources for the implementation.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller at 1e6c0080 {
+         compatible = "aspeed,ast2400-vic";
+         reg = <0x1e6c0080 0x80>;
+         interrupt-controller;
+         #interrupt-cells = <1>;
+         valid-sources = <0xffffffff 0x0007ffff>;
+    };
+
+...

-- 
2.39.2

