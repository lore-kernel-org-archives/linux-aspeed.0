From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 29 Aug 2024 14:45:07 +0800
Subject: [PATCH v6 1/2] dt-bindings: media: convert aspeed-video.txt to dt-schema
In-Reply-To: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
References: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
Message-ID: <20240829064508.3706672-2-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert the ASPEED SoCs video txt bindings to dt-schema.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 .../bindings/media/aspeed,video-engine.yaml   | 78 +++++++++++++++++++
 .../bindings/media/aspeed-video.txt           | 33 --------
 2 files changed, 78 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt

diff --git a/Documentation/devicetree/bindings/media/aspeed,video-engine.yaml b/Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
new file mode 100644
index 000000000000..837e15edb9b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/aspeed,video-engine.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/aspeed,video-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED Video Engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+  - Jammy Huang <jammy_huang@aspeedtech.com>
+
+description:
+  The Video Engine (VE) embedded in the ASPEED SOCs can be configured to
+  capture and compress video data from digital or analog sources.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-video-engine
+      - aspeed,ast2500-video-engine
+      - aspeed,ast2600-video-engine
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: vclk
+      - const: eclk
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  memory-region:
+    description: |
+      Phandle to a memory region to allocate from, as defined in
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+
+  aspeed,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Specifies the scu node that is needed if video wants to capture
+      from sources other than Host VGA.
+
+  aspeed,gfx:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Specifies the Soc Display(gfx) node that needs to be queried to get
+      related information if video wants to use gfx as capture source.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    video-engine at 1e700000 {
+      compatible = "aspeed,ast2600-video-engine";
+      reg = <0x1e700000 0x1000>;
+      clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+               <&syscon ASPEED_CLK_GATE_ECLK>;
+      clock-names = "vclk", "eclk";
+      interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+      aspeed,scu = <&syscon>;
+      aspeed,gfx = <&gfx>;
+    };
diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
deleted file mode 100644
index d2ca32512272..000000000000
--- a/Documentation/devicetree/bindings/media/aspeed-video.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Device tree bindings for Aspeed Video Engine
-
-The Video Engine (VE) embedded in the Aspeed AST2400/2500/2600 SOCs can
-capture and compress video data from digital or analog sources.
-
-Required properties:
- - compatible:		"aspeed,ast2400-video-engine" or
-			"aspeed,ast2500-video-engine" or
-			"aspeed,ast2600-video-engine"
- - reg:			contains the offset and length of the VE memory region
- - clocks:		clock specifiers for the syscon clocks associated with
-			the VE (ordering must match the clock-names property)
- - clock-names:		"vclk" and "eclk"
- - resets:		reset specifier for the syscon reset associated with
-			the VE
- - interrupts:		the interrupt associated with the VE on this platform
-
-Optional properties:
- - memory-region:
-	phandle to a memory region to allocate from, as defined in
-	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-
-Example:
-
-video-engine at 1e700000 {
-    compatible = "aspeed,ast2500-video-engine";
-    reg = <0x1e700000 0x20000>;
-    clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
-    clock-names = "vclk", "eclk";
-    resets = <&syscon ASPEED_RESET_VIDEO>;
-    interrupts = <7>;
-    memory-region = <&video_engine_memory>;
-};
-- 
2.25.1

