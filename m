From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 1 Sep 2021 11:30:12 +0800
Subject: [PATCH v4 1/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
References: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210901033015.910-2-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dt-bindings for Aspeed eSPI controller

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
new file mode 100644
index 000000000000..aa91ec8caf6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Aspeed eSPI Controller
+
+maintainers:
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description:
+  Aspeed eSPI controller implements a slave side eSPI endpoint device
+  supporting the four eSPI channels, namely peripheral, virtual wire,
+  out-of-band, and flash.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2500-espi
+          - aspeed,ast2600-espi
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^espi-ctrl@[0-9a-f]+$":
+    type: object
+
+    description: Control of the four basic eSPI channels
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - aspeed,ast2500-espi-ctrl
+              - aspeed,ast2600-espi-ctrl
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      perif,memcyc-enable:
+        type: boolean
+        description: Enable memory cycle over eSPI peripheral channel
+
+      perif,memcyc-src-addr:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The Host side address to be decoded into the memory cycle over eSPI peripheral channel
+
+      perif,memcyc-size:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: The size of the memory region allocated for the memory cycle over eSPI peripheral channel
+        minimum: 65536
+
+      perif,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI peripheral channel
+
+      oob,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI out-of-band channel
+
+      oob,dma-tx-desc-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 2
+        maximum: 1023
+        description: The number of TX descriptors available for eSPI OOB DMA engine
+
+      oob,dma-rx-desc-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 2
+        maximum: 1023
+        description: The number of RX descriptors available for eSPI OOB DMA engine
+
+      flash,dma-mode:
+        type: boolean
+        description: Enable DMA support for eSPI flash channel
+
+      flash,safs-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1, 2 ]
+        default: 0
+        description: Slave-Attached-Sharing-Flash mode, 0->Mix, 1->SW, 2->HW
+
+    dependencies:
+      perif,memcyc-src-addr: [ "perif,memcyc-enable" ]
+      perif,memcyc-size: [ "perif,memcyc-enable" ]
+      oob,dma-tx-desc-num: [ "oob,dma-mode" ]
+      oob,dma-rx-desc-num: [ "oob,dma-mode" ]
+
+    required:
+      - compatible
+      - interrupts
+      - clocks
+
+  "^espi-mmbi@[0-9a-f]+$":
+    type: object
+
+    description: Control of the PCH-BMC data exchange over eSPI peripheral memory cycle
+
+    properties:
+      compatible:
+        const: aspeed,ast2600-espi-mmbi
+
+      interrupts:
+        maxItems: 1
+
+    required:
+      - compatible
+      - interrupts
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    espi: espi at 1e6ee000 {
+        compatible = "aspeed,ast2600-espi", "simple-mfd", "syscon";
+        reg = <0x1e6ee000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6ee000 0x1000>;
+
+        espi_ctrl: espi-ctrl at 0 {
+            compatible = "aspeed,ast2600-espi-ctrl";
+            reg = <0x0 0x800>;
+            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+        };
+
+        espi_mmbi: espi-mmbi at 800 {
+            compatible = "aspeed,ast2600-espi-mmbi";
+            reg = <0x800 0x50>;
+            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.17.1

