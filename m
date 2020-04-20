From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 20 Apr 2020 15:26:05 -0500
Subject: [PATCH v10 1/7] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <20200420202611.17776-1-eajames@linux.ibm.com>
References: <20200420202611.17776-1-eajames@linux.ibm.com>
Message-ID: <20200420202611.17776-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../devicetree/bindings/soc/aspeed/xdma.yaml  | 108 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
new file mode 100644
index 000000000000..428a575da1be
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/xdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST25XX and AST26XX XDMA Engine
+
+maintainers:
+ - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  This binding describes the XDMA Engine embedded in the AST2500 and AST2600
+  SOCs. The XDMA engine can perform automatic DMA operations over PCI between
+  the SOC (acting as a BMC) and a host processor.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2500-xdma
+      - aspeed,ast2600-xdma
+
+  reg:
+    items:
+      - description: engine register space
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    maxItems: 2
+    items:
+      - const: device
+      - const: root-complex
+
+  interrupts-extended:
+    maxItems: 2
+    items:
+      - description: global interrupt for the XDMA engine
+      - description: PCI-E reset or PERST interrupt
+
+  aspeed,scu:
+    description: a reference to the System Control Unit node of the Aspeed SOC.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+
+  aspeed,pcie-device:
+    description: describes which PCI-E device the XDMA engine should use
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/string
+      - oneOf:
+        - items:
+          - const: bmc
+        - items:
+          - const: vga
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts-extended
+  - aspeed,scu
+  - memory-region
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2600-xdma
+then:
+  required:
+    - reset-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+    syscon: syscon at 1e6e2000 {
+        reg = <0x1e6e2000 0x1000>;
+        ranges = <0 0x1e6e2000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        scu_ic0: interrupt-controller at 560 {
+            reg = <0x560 0x4>;
+            interrupt-controller;
+            #interrupt-cells = <1>;
+        };
+    };
+    xdma at 1e6e7000 {
+        compatible = "aspeed,ast2600-xdma";
+        reg = <0x1e6e7000 0x100>;
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
+        reset-names = "device", "root-complex";
+        interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                              <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
+        aspeed,scu = <&syscon>;
+        aspeed,pcie-device = "bmc";
+        memory-region = <&vga_memory>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ecd7def6ff4b..b1963e01a75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2774,6 +2774,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed-video.c
 
+ASPEED XDMA ENGINE DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user at lists.sourceforge.net
-- 
2.24.0

