From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 20 Feb 2023 14:17:44 +0800
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
Message-ID: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 support new register set for I2Cv2 controller, add bindings
document to support driver of i2cv2 new register mode controller.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
new file mode 100644
index 000000000000..913fb45d5fbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED I2Cv2 Controller on the AST26XX SoCs
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-i2cv2
+
+  reg:
+    minItems: 1
+    items:
+      - description: address offset and range of register
+      - description: address offset and range of buffer register
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Reference clock for the I2C bus
+
+  resets:
+    maxItems: 1
+
+  clock-frequency:
+    description:
+      Desired I2C bus clock frequency in Hz. default 100khz.
+
+  multi-master:
+    type: boolean
+    description:
+      states that there is another master active on this bus
+
+  timeout:
+    type: boolean
+    description: Enable i2c bus timeout for master/slave (35ms)
+
+  byte-mode:
+    type: boolean
+    description: Force i2c driver use byte mode transmit
+
+  buff-mode:
+    type: boolean
+    description: Force i2c driver use buffer mode transmit
+
+  aspeed,gr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of i2c global register node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - aspeed,gr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+    i2c: i2c-bus at 80 {
+      compatible = "aspeed,ast2600-i2cv2";
+      reg = <0x80 0x80>, <0xc00 0x20>;
+      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+      aspeed,gr = <&i2c_gr>;
+      clocks = <&syscon ASPEED_CLK_APB2>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+    };
-- 
2.34.1

