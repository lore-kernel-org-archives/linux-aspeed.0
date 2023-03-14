From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 14 Mar 2023 10:18:14 +0800
Subject: [PATCH v2 2/5] dt-bindings: dmaengine: Add AST2600 UDMA bindings
In-Reply-To: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
References: <20230314021817.30446-1-chiawei_wang@aspeedtech.com>
Message-ID: <20230314021817.30446-3-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the dmaengine bindings for the UART DMA engine of Aspeed AST2600 SoC.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../bindings/dma/aspeed,ast2600-udma.yaml     | 56 +++++++++++++++++++
 include/dt-bindings/dma/ast2600-udma.h        | 40 +++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
 create mode 100644 include/dt-bindings/dma/ast2600-udma.h

diff --git a/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml b/Documentation/devicetree/bindings/dma/aspeed,ast2600-udma.yaml
new file mode 100644
index 000000000000..f92e06ac9f39
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
+description: |
+  The Aspeed AST2600 UDMA controller provides direct memory access capabilities
+  for the NS16550A-compatible UART devices inside AST2600 SoCs. UDMA supports 28
+  DMA channels and each UART device has its dedicated pair of TX and RX channels.
+
+allOf:
+  - $ref: "dma-controller.yaml#"
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
+    udma: dma-controller at 1e79e000 {
+        compatible = "aspeed,ast2600-udma";
+        reg = <0x1e79e000 0x1000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        dma-channels = <28>;
+        #dma-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/dma/ast2600-udma.h b/include/dt-bindings/dma/ast2600-udma.h
new file mode 100644
index 000000000000..0b92035b94f1
--- /dev/null
+++ b/include/dt-bindings/dma/ast2600-udma.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides macros for Aspeed AST2600 UDMA bindings
+ *
+ * Copyright (c) 2023 Aspeed Technology Inc.
+ */
+
+#ifndef __DT_BINDINGS_DMA_AST2600_UDMA_H__
+#define __DT_BINDINGS_DMA_AST2600_UDMA_H__
+
+#define AST2600_UDMA_UART1_TX		0
+#define AST2600_UDMA_UART1_RX		1
+#define AST2600_UDMA_UART2_TX		2
+#define AST2600_UDMA_UART2_RX		3
+#define AST2600_UDMA_UART3_TX		4
+#define AST2600_UDMA_UART3_RX		5
+#define AST2600_UDMA_UART4_TX		6
+#define AST2600_UDMA_UART4_RX		7
+#define AST2600_UDMA_UART6_TX		8
+#define AST2600_UDMA_UART6_RX		9
+#define AST2600_UDMA_UART7_TX		10
+#define AST2600_UDMA_UART7_RX		11
+#define AST2600_UDMA_UART8_TX		12
+#define AST2600_UDMA_UART8_RX		13
+#define AST2600_UDMA_UART9_TX		14
+#define AST2600_UDMA_UART9_RX		15
+#define AST2600_UDMA_UART10_TX		16
+#define AST2600_UDMA_UART10_RX		17
+#define AST2600_UDMA_UART11_TX		18
+#define AST2600_UDMA_UART11_RX		19
+#define AST2600_UDMA_UART12_TX		20
+#define AST2600_UDMA_UART12_RX		21
+#define AST2600_UDMA_UART13_TX		22
+#define AST2600_UDMA_UART13_RX		23
+#define AST2600_UDMA_VUART1_TX		24
+#define AST2600_UDMA_VUART1_RX		25
+#define AST2600_UDMA_VUART2_TX		26
+#define AST2600_UDMA_VUART2_RX		27
+
+#endif /* __DT_BINDINGS_DMA_AST2600_UDMA_H__ */
-- 
2.25.1

