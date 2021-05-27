From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Thu, 27 May 2021 18:25:05 +0800
Subject: [PATCH v2 1/1] dt-bindings: aspeed-i2c: Convert txt to yaml format
In-Reply-To: <20210527102512.20684-1-jamin_lin@aspeedtech.com>
References: <20210527102512.20684-1-jamin_lin@aspeedtech.com>
Message-ID: <20210527102512.20684-2-jamin_lin@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert aspeed i2c to yaml.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 86 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-aspeed.txt    | 49 -----------
 2 files changed, 86 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
new file mode 100644
index 000000000000..1f7064d77708
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED I2C on the AST24XX, AST25XX, and AST26XX SoCs Device Tree Bindings
+
+maintainers:
+  - Rayn Chen <rayn_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-i2c-bus
+      - aspeed,ast2500-i2c-bus
+      - aspeed,ast2600-i2c-bus
+
+  "#size-cells":
+    const: 0
+
+  "#address-cells":
+    const: 1
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: address offset and range of bus
+      - description: address offset and range of bus buffer
+
+  interrupts:
+    maxItems: 1
+    description: interrupt number
+
+  clocks:
+    maxItems: 1
+    description:
+      root clock of bus, should reference the APB
+      clock in the second cell
+
+  reset:
+    maxItems: 1
+    description: phandle to reset controller with the reset number in
+      the second cell
+
+  bus-frequency:
+    minimum: 500
+    maximum: 4000000
+    default: 100000
+    description: frequency of the bus clock in Hz defaults to 100 kHz when not
+      specified
+
+  multi-master:
+    type: boolean
+    description:
+      states that there is another master active on this bus
+
+required:
+  - reg
+  - compatible
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    i2c0: i2c-bus at 40 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <1>;
+      reg = <0x40 0x40>;
+      compatible = "aspeed,ast2500-i2c-bus";
+      clocks = <&syscon ASPEED_CLK_APB>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+      bus-frequency = <100000>;
+      interrupts = <0>;
+      interrupt-parent = <&i2c_ic>;
+      status = "disabled";
+      /* Does not need pinctrl properties */
+    };
diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
deleted file mode 100644
index b47f6ccb196a..000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Device tree configuration for the I2C busses on the AST24XX, AST25XX, and AST26XX SoCs.
-
-Required Properties:
-- #address-cells	: should be 1
-- #size-cells		: should be 0
-- reg			: address offset and range of bus
-- compatible		: should be "aspeed,ast2400-i2c-bus"
-			  or "aspeed,ast2500-i2c-bus"
-			  or "aspeed,ast2600-i2c-bus"
-- clocks		: root clock of bus, should reference the APB
-			  clock in the second cell
-- resets		: phandle to reset controller with the reset number in
-			  the second cell
-- interrupts		: interrupt number
-
-Optional Properties:
-- bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
-		  specified
-- multi-master	: states that there is another master active on this bus.
-
-Example:
-
-i2c {
-	compatible = "simple-bus";
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges = <0 0x1e78a000 0x1000>;
-
-	i2c_ic: interrupt-controller at 0 {
-		#interrupt-cells = <1>;
-		compatible = "aspeed,ast2400-i2c-ic";
-		reg = <0x0 0x40>;
-		interrupts = <12>;
-		interrupt-controller;
-	};
-
-	i2c0: i2c-bus at 40 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#interrupt-cells = <1>;
-		reg = <0x40 0x40>;
-		compatible = "aspeed,ast2400-i2c-bus";
-		clocks = <&syscon ASPEED_CLK_APB>;
-		resets = <&syscon ASPEED_RESET_I2C>;
-		bus-frequency = <100000>;
-		interrupts = <0>;
-		interrupt-parent = <&i2c_ic>;
-	};
-};
-- 
2.17.1

