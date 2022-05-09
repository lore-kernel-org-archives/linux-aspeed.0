From: Cédric Le Goater <clg@kaod.org>
Date: Mon,  9 May 2022 19:56:07 +0200
Subject: [PATCH v7 02/11] dt-bindings: spi: Convert the Aspeed SMC controllers
 device tree binding
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
Message-ID: <20220509175616.1089346-3-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The "interrupt" property is optional because it is only necessary for
controllers supporting DMAs (Not implemented yet in the new driver).

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../devicetree/bindings/mtd/aspeed-smc.txt    | 51 ------------
 .../bindings/spi/aspeed,ast2600-fmc.yaml      | 82 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 3 files changed, 91 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

diff --git a/Documentation/devicetree/bindings/mtd/aspeed-smc.txt b/Documentation/devicetree/bindings/mtd/aspeed-smc.txt
deleted file mode 100644
index 49f6528ef547..000000000000
--- a/Documentation/devicetree/bindings/mtd/aspeed-smc.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* Aspeed Firmware Memory controller
-* Aspeed SPI Flash Memory Controller
-
-The Firmware Memory Controller in the Aspeed AST2500 SoC supports
-three chip selects, two of which are always of SPI type and the third
-can be SPI or NOR type flash. These bindings only describe SPI.
-
-The two SPI flash memory controllers in the AST2500 each support two
-chip selects.
-
-Required properties:
-  - compatible : Should be one of
-	"aspeed,ast2400-fmc" for the AST2400 Firmware Memory Controller
-	"aspeed,ast2400-spi" for the AST2400 SPI Flash memory Controller
-	"aspeed,ast2500-fmc" for the AST2500 Firmware Memory Controller
-	"aspeed,ast2500-spi" for the AST2500 SPI flash memory controllers
-
-  - reg : the first contains the control register location and length,
-          the second contains the memory window mapping address and length
-  - #address-cells : must be 1 corresponding to chip select child binding
-  - #size-cells : must be 0 corresponding to chip select child binding
-
-Optional properties:
-  - interrupts : Should contain the interrupt for the dma device if an
-    FMC
-
-The child nodes are the SPI flash modules which must have a compatible
-property as specified in bindings/mtd/jedec,spi-nor.txt
-
-Optionally, the child node can contain properties for SPI mode (may be
-ignored):
-  - spi-max-frequency - max frequency of spi bus
-
-
-Example:
-fmc: fmc at 1e620000 {
-	compatible = "aspeed,ast2500-fmc";
-	reg = < 0x1e620000 0x94
-		0x20000000 0x02000000 >;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	interrupts = <19>;
-	flash at 0 {
-		reg = < 0 >;
-		compatible = "jedec,spi-nor";
-		/* spi-max-frequency = <>; */
-		/* m25p,fast-read; */
-		#address-cells = <1>;
-		#size-cells = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
new file mode 100644
index 000000000000..fa8f4ac20985
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -0,0 +1,82 @@
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
+
+        flash at 0 {
+                reg = < 0 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+
+        flash at 1 {
+                reg = < 1 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+
+        flash at 2 {
+                reg = < 2 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d47c5e7c6ae..149e84d32293 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3101,6 +3101,15 @@ S:	Maintained
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
2.35.1

