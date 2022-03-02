From: Joel Stanley <joel@jms.id.au>
Date: Wed,  2 Mar 2022 15:40:56 +1030
Subject: [PATCH] dt-bindings: gpu: Convert aspeed-gfx bindings to yaml
Message-ID: <20220302051056.678367-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the bindings to yaml and add the ast2600 compatible string.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/gpu/aspeed,gfx.yaml   | 69 +++++++++++++++++++
 .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 -----------
 2 files changed, 69 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt

diff --git a/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml b/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
new file mode 100644
index 000000000000..8ddc4fa6e8e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/aspeed,gfx.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/aspeed,gfx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED GFX display device
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-gfx
+          - aspeed,ast2500-gfx
+          - aspeed,ast2600-gfx
+      - const: syscon
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  memory-region: true
+
+  syscon: true
+
+  reg-io-width: true
+
+required:
+  - reg
+  - compatible
+  - interrupts
+  - clocks
+  - resets
+  - memory-region
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/clock/aspeed-clock.h>
+   gfx: display at 1e6e6000 {
+       compatible = "aspeed,ast2500-gfx", "syscon";
+       reg = <0x1e6e6000 0x1000>;
+       reg-io-width = <4>;
+       clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+       resets = <&syscon ASPEED_RESET_CRT1>;
+       interrupts = <0x19>;
+       syscon = <&syscon>;
+       memory-region = <&gfx_memory>;
+   };
+
+   gfx_memory: framebuffer {
+       size = <0x01000000>;
+       alignment = <0x01000000>;
+       compatible = "shared-dma-pool";
+       reusable;
+   };
diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
deleted file mode 100644
index 958bdf962339..000000000000
--- a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Device tree configuration for the GFX display device on the ASPEED SoCs
-
-Required properties:
-  - compatible
-    * Must be one of the following:
-      + aspeed,ast2500-gfx
-      + aspeed,ast2400-gfx
-    * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
-      be present
-
-  - reg: Physical base address and length of the GFX registers
-
-  - interrupts: interrupt number for the GFX device
-
-  - clocks: clock number used to generate the pixel clock
-
-  - resets: reset line that must be released to use the GFX device
-
-  - memory-region:
-    Phandle to a memory region to allocate from, as defined in
-    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-
-
-Example:
-
-gfx: display at 1e6e6000 {
-	compatible = "aspeed,ast2500-gfx", "syscon";
-	reg = <0x1e6e6000 0x1000>;
-	reg-io-width = <4>;
-	clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-	resets = <&syscon ASPEED_RESET_CRT1>;
-	interrupts = <0x19>;
-	memory-region = <&gfx_memory>;
-};
-
-gfx_memory: framebuffer {
-	size = <0x01000000>;
-	alignment = <0x01000000>;
-	compatible = "shared-dma-pool";
-	reusable;
-};
-- 
2.34.1

