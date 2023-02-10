From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 10 Feb 2023 15:26:40 +0800
Subject: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
In-Reply-To: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
Message-ID: <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dt-bindings for Aspeed UART controller.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../bindings/serial/aspeed,uart.yaml          | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/aspeed,uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/aspeed,uart.yaml b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
new file mode 100644
index 000000000000..10c457d6a72e
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/aspeed,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Universal Asynchronous Receiver/Transmitter
+
+maintainers:
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+description: |
+  The Aspeed UART is based on the basic 8250 UART and compatible
+  with 16550A, with support for DMA
+
+properties:
+  compatible:
+    const: aspeed,ast2600-uart
+
+  reg:
+    description: The base address of the UART register bank
+    maxItems: 1
+
+  clocks:
+    description: The clock the baudrate is derived from
+    maxItems: 1
+
+  interrupts:
+    description: The IRQ number of the device
+    maxItems: 1
+
+  dma-mode:
+    type: boolean
+    description: Enable DMA
+
+  dma-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The channel number to be used in the DMA engine
+
+  virtual:
+    type: boolean
+    description: Indicate virtual UART
+
+  sirq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The serial IRQ number on LPC bus interface
+
+  sirq-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The serial IRQ polarity on LPC bus interface
+
+  pinctrl-0: true
+
+  pinctrl_names:
+    const: default
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    serial at 1e783000 {
+        compatible = "aspeed,ast2600-uart";
+        reg = <0x1e783000 0x20>;
+        interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_LOW>;
+        clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+        pinctrl-0 = <&pinctrl_txd1_default &pinctrl_rxd1_default>;
+        dma-mode;
+        dma-channel = <0>;
+    };
-- 
2.25.1

