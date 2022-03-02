From: Cédric Le Goater <clg@kaod.org>
Date: Wed,  2 Mar 2022 18:31:07 +0100
Subject: [PATCH v2 03/10] dt-bindings: spi: Add Aspeed SMC controllers device
 tree binding
In-Reply-To: <20220302173114.927476-1-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
Message-ID: <20220302173114.927476-4-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "interrupt" property is optional because it is only necessary for
controllers supporting DMAs (Not implemented yet in the new driver).

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../bindings/spi/aspeed,ast2600-fmc.yaml      | 90 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
new file mode 100644
index 000000000000..0289a4f52196
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SMC controllers bindings
+
+maintainers:
+  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+  - C?dric Le Goater <clg@kaod.org>
+
+description: |
+  This binding describes the Aspeed Static Memory Controllers (FMC and
+  SPI) of the AST2400, AST2500 and AST2600 SOCs.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-fmc
+      - aspeed,ast2600-spi
+      - aspeed,ast2500-fmc
+      - aspeed,ast2500-spi
+      - aspeed,ast2400-fmc
+      - aspeed,ast2400-spi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  "@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        enum: [1, 2, 4]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    spi at 1e620000 {
+        reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "aspeed,ast2600-fmc";
+        clocks = <&syscon ASPEED_CLK_AHB>;
+        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        flash at 0 {
+                reg = < 0 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+        flash at 1 {
+                reg = < 1 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+        flash at 2 {
+                reg = < 2 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4175103e928d..f5ab77548ef6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2925,6 +2925,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 F:	drivers/mmc/host/sdhci-of-aspeed*
 
+ASPEED SMC SPI DRIVER
+M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+M:	C?dric Le Goater <clg@kaod.org>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-spi at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media at vger.kernel.org
-- 
2.34.1

