From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Mon, 19 Aug 2024 16:08:58 +0800
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: Add aspeed,video binding
In-Reply-To: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
References: <20240819080859.1304671-1-jammy_huang@aspeedtech.com>
Message-ID: <20240819080859.1304671-2-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Video Engine block in ASPEED Silicon SoCs is responsible for video
compressions with a wide range of video quality and compression
ratio options. It can capture and compress video data from digital or
analog sources.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 .../bindings/arm/aspeed/aspeed,video.yaml     | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
new file mode 100644
index 000000000000..bef7bd2f310a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed,video.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/aspeed/aspeed,video.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED Video Engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+  - Jammy Huang <jammy_huang@aspeedtech.com>
+
+description: |
+  The ASPEED video engine can be configured to capture and compress video
+  data from digital or analog sources.
+
+select:
+  properties:
+    compatible:
+      pattern: "^aspeed,ast[0-9]+-video-engine$"
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - description: Preferred naming style for compatibles of video components
+        pattern: "^aspeed,ast[0-9]+-video-engine$"
+
+      - enum:
+          - aspeed,ast2400-video-engine
+          - aspeed,ast2500-video-engine
+          - aspeed,ast2600-video-engine
+
+  reg:
+    minItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: vclk
+      - const: eclk
+
+  interrupts:
+    minItems: 1
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
+additionalProperties: true
+
+examples:
+  - |
+    video: video at 1e700000 {
+          	compatible = "aspeed,ast2600-video-engine";
+          	reg = <0x1e700000 0x1000>;
+          	clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+          	         <&syscon ASPEED_CLK_GATE_ECLK>;
+          	clock-names = "vclk", "eclk";
+          	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+          	aspeed,scu = <&syscon>;
+          	aspeed,gfx = <&gfx>;
+    };
-- 
2.25.1

