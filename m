From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Aug 2022 10:16:35 -0600
Subject: [PATCH 2/2] dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT schema format
In-Reply-To: <20220810161635.73936-1-robh@kernel.org>
References: <20220810161635.73936-1-robh@kernel.org>
Message-ID: <20220810161635.73936-3-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the aspeed,ast2[456]00-scu binding to DT schema format.

The original binding was missing '#address-cells', '#size-cells',
'ranges', and child nodes, so add them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 110 ++++++++++++++++++
 .../devicetree/bindings/mfd/aspeed-scu.txt    |  48 --------
 2 files changed, 110 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
new file mode 100644
index 000000000000..1689b986f441
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed System Control Unit
+
+description:
+  The Aspeed System Control Unit manages the global behaviour of the SoC,
+  configuring elements such as clocks, pinmux, and reset.
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+  - Andrew Jeffery <andrew@aj.id.au>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-scu
+          - aspeed,ast2500-scu
+          - aspeed,ast2600-scu
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+patternProperties:
+  '^p2a-control@[0-9a-f]+$':
+    description: See Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+    type: object
+
+  '^pinctrl(@[0-9a-f]+)?$':
+    oneOf:
+      - $ref: /schemas/pinctrl/aspeed,ast2400-pinctrl.yaml
+      - $ref: /schemas/pinctrl/aspeed,ast2500-pinctrl.yaml
+      - $ref: /schemas/pinctrl/aspeed,ast2600-pinctrl.yaml
+
+  '^interrupt-controller@[0-9a-f]+$':
+    description: See Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+    type: object
+
+  '^silicon-id@[0-9a-f]+$':
+    description: Unique hardware silicon identifiers within the SoC
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2400-silicon-id
+              - aspeed,ast2500-silicon-id
+              - aspeed,ast2600-silicon-id
+          - const: aspeed,silicon-id
+
+      reg:
+        description:
+          The reg should be the unique silicon id register, and not backwards
+          compatible one in eg. the 2600.
+        minItems: 1
+        items:
+          - description: silicon id information registers
+          - description: unique chip id registers
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon at 1e6e2000 {
+        compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
+        reg = <0x1e6e2000 0x1a8>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
+
+        silicon-id at 7c {
+            compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
+            reg = <0x7c 0x4>, <0x150 0x8>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
deleted file mode 100644
index 857ee33f7329..000000000000
--- a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-The Aspeed System Control Unit manages the global behaviour of the SoC,
-configuring elements such as clocks, pinmux, and reset.
-
-Required properties:
-- compatible:	One of:
-		"aspeed,ast2400-scu", "syscon", "simple-mfd"
-		"aspeed,ast2500-scu", "syscon", "simple-mfd"
-
-- reg:		contains the offset and length of the SCU memory region
-- #clock-cells: should be set to <1> - the system controller is also a
-	clock provider
-- #reset-cells: should be set to <1> - the system controller is also a
-	reset line provider
-
-Example:
-
-syscon: syscon at 1e6e2000 {
-	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
-	reg = <0x1e6e2000 0x1a8>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
-
-Silicon ID
------------------
-
-Families have unique hardware silicon identifiers within the SoC.
-
-Required properties:
-
- - compatible:		"aspeed,silicon-id" or:
-			"aspeed,ast2400-silicon-id" or
-			"aspeed,ast2500-silicon-id" or
-			"aspeed,ast2600-silicon-id"
-
- - reg:			offset and length of the silicon id information
-			optionally, a second offset and length describes the unique chip id
-
-			The reg should be the unique silicon id register, and
-			not backwards compatible one in eg. the 2600.
-
-Example:
-
-
-silicon-id at 7c {
-        compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
-        reg = <0x7c 0x4 0x150 0x8>;
-};
-- 
2.34.1

