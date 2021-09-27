From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 27 Sep 2021 10:30:51 +0800
Subject: [PATCH v7 3/5] dt-bindings: aspeed: Add UART routing controller
In-Reply-To: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210927023053.6728-4-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add dt-bindings for Aspeed UART routing controller.

Signed-off-by: Oskar Senft <osk@google.com>
Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
 .../bindings/soc/aspeed/uart-routing.yaml     | 56 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
index 03d417762752..f1538038c045 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
@@ -142,6 +142,10 @@ patternProperties:
       - interrupts
       - snoop-ports
 
+  "^uart-routing@[0-9a-f]+$":
+    $ref: /schemas/soc/aspeed/uart-routing.yaml#
+    description: The UART routing control under LPC register space
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
new file mode 100644
index 000000000000..6876407124dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# # Copyright (c) 2018 Google LLC
+# # Copyright (c) 2021 Aspeed Technology Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/aspeed/uart-routing.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Aspeed UART Routing Controller
+
+maintainers:
+  - Oskar Senft <osk@google.com>
+  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
+
+description:
+  The Aspeed UART routing control allow to dynamically route the inputs for
+  the built-in UARTS and physical serial I/O ports.
+
+  This allows, for example, to connect the output of UART to another UART.
+  This can be used to enable Host <-> BMC communication via UARTs, e.g. to
+  allow access to the Host's serial console.
+
+  This driver is for the BMC side. The sysfs files allow the BMC userspace
+  which owns the system configuration policy, to configure how UARTs and
+  physical serial I/O ports are routed.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2400-uart-routing
+          - aspeed,ast2500-uart-routing
+          - aspeed,ast2600-uart-routing
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    lpc: lpc at 1e789000 {
+        compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
+        reg = <0x1e789000 0x1000>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e789000 0x1000>;
+
+        uart_routing: uart-routing at 98 {
+            compatible = "aspeed,ast2600-uart-routing";
+            reg = <0x98 0x8>;
+        };
+    };
-- 
2.17.1

