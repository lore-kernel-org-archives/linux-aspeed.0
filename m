From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 20 Mar 2023 16:11:30 +0800
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
In-Reply-To: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
Message-ID: <20230320081133.23655-3-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml

diff --git a/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
new file mode 100644
index 000000000000..4c0a5edf2168
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/aspeed,ast2600-udma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed AST2600 UART DMA controller
+
+maintainers:
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+description:
+  The Aspeed AST2600 UDMA controller provides direct memory access capabilities
+  for the NS16550A-compatible UART devices inside AST2600 SoCs. UDMA supports 28
+  DMA channels and each UART device has its dedicated pair of TX and RX channels.
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: aspeed,ast2600-udma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  dma-channels:
+    maximum: 28
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#dma-cells"
+  - dma-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    dma-controller at 1e79e000 {
+        compatible = "aspeed,ast2600-udma";
+        reg = <0x1e79e000 0x1000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        dma-channels = <28>;
+        #dma-cells = <1>;
+    };
+
+...
-- 
2.25.1

