From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Tue, 19 Mar 2024 09:35:45 -0000
Subject: [PATCH v2 4/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <20240319093405.39833-1-manojkiran.eda@gmail.com>
References: <20240319093405.39833-1-manojkiran.eda@gmail.com>
Message-ID: <20240319093405.39833-5-manojkiran.eda@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds the device tree bindings for aspeed eSPI
controller.

Although aspeed eSPI hardware supports 4 different channels,
this commit only adds the support for flash channel, the
bindings for other channels could be upstreamed when the driver
support for those are added.

Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
---
 .../bindings/soc/aspeed/aspeed,espi.yaml      | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml

diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
new file mode 100644
index 000000000000..3d3ad528e3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2024 IBM Corporation.
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/aspeed/aspeed,espi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed eSPI Controller
+
+maintainers:
+  - Manojkiran Eda <manojkiran.eda@gmail.com>
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description:
+  Aspeed eSPI controller implements a device side eSPI endpoint device
+  supporting the flash channel.
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
+    description: Controls the flash channel of eSPI hardware
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
+    required:
+      - compatible
+      - interrupts
+      - clocks
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
+            reg = <0x0 0x800>,<0x0 0x4000000>;
+            reg-names = "espi_ctrl","espi_flash";
+            interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon ASPEED_CLK_GATE_ESPICLK>;
+        };
+    };
-- 
2.40.1

