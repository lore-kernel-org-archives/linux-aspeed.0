From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Sun, 26 Feb 2023 11:13:20 +0800
Subject: [PATCH v6 1/2] dt-bindings: i2c: aspeed: support for AST2600-i2cv2
In-Reply-To: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
References: <20230226031321.3126756-1-ryan_chen@aspeedtech.com>
Message-ID: <20230226031321.3126756-2-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add ast2600-i2cv2 compatible and aspeed,global-regs, aspeed,timeout
aspeed,xfer-mode description for ast2600-i2cv2.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index f597f73ccd87..75de3ce41cf5 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -49,6 +49,25 @@ properties:
     description:
       states that there is another master active on this bus
 
+  aspeed,timeout:
+    type: boolean
+    description: I2C bus timeout enable for master/slave mode
+
+  aspeed,xfer-mode:
+    description: |
+      I2C bus transfer mode selection.
+      - "byte": I2C bus byte transfer mode.
+      - "buffered": I2C bus buffer register transfer mode.
+      - "dma": I2C bus dma transfer mode (default)
+    items:
+      enum: [byte, buffered, dma]
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+
+  aspeed,global-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of i2c global register node.
+
 required:
   - reg
   - compatible
@@ -57,6 +76,19 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2600-i2cv2
+
+then:
+  properties:
+    reg:
+      minItems: 2
+  required:
+    - aspeed,global-regs
+
 examples:
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
@@ -71,3 +103,15 @@ examples:
       interrupts = <0>;
       interrupt-parent = <&i2c_ic>;
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c1: i2c at 80 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "aspeed,ast2600-i2cv2";
+      reg = <0x80 0x80>, <0xc00 0x20>;
+      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+      aspeed,global-regs = <&i2c_global>;
+      clocks = <&syscon ASPEED_CLK_APB>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+    };
-- 
2.34.1

