From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Apr 2022 14:21:38 -0500
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Drop referenced nodes in
 examples
Message-ID: <20220422192139.2592632-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The additional nodes in the example referenced from the pinctrl node
'aspeed,external-nodes' properties are either incorrect (aspeed,ast2500-lpc)
or not documented with a schema (aspeed,ast2500-gfx). There's no need to
show these nodes as part of the pinctrl example, so just remove them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 81 ++++---------------
 1 file changed, 16 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 7c25c8d51116..9db904a528ee 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -76,73 +76,24 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
-    apb {
-        compatible = "simple-bus";
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges;
-
-        syscon: scu at 1e6e2000 {
-            compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
-            reg = <0x1e6e2000 0x1a8>;
-            #clock-cells = <1>;
-            #reset-cells = <1>;
-
-            pinctrl: pinctrl {
-                compatible = "aspeed,ast2500-pinctrl";
-                aspeed,external-nodes = <&gfx>, <&lhc>;
-
-                pinctrl_i2c3_default: i2c3_default {
-                    function = "I2C3";
-                    groups = "I2C3";
-                };
-
-                pinctrl_gpioh0_unbiased_default: gpioh0 {
-                    pins = "A18";
-                    bias-disable;
-                };
+    scu at 1e6e2000 {
+        compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
+        reg = <0x1e6e2000 0x1a8>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        pinctrl: pinctrl {
+            compatible = "aspeed,ast2500-pinctrl";
+            aspeed,external-nodes = <&gfx>, <&lhc>;
+
+            pinctrl_i2c3_default: i2c3_default {
+                function = "I2C3";
+                groups = "I2C3";
             };
-        };
-
-        gfx: display at 1e6e6000 {
-            compatible = "aspeed,ast2500-gfx", "syscon";
-            reg = <0x1e6e6000 0x1000>;
-            reg-io-width = <4>;
-            clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-            resets = <&syscon ASPEED_RESET_CRT1>;
-            interrupts = <0x19>;
-            syscon = <&syscon>;
-            memory-region = <&gfx_memory>;
-        };
-    };
-
-    lpc: lpc at 1e789000 {
-        compatible = "aspeed,ast2500-lpc", "simple-mfd";
-        reg = <0x1e789000 0x1000>;
-
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0x0 0x1e789000 0x1000>;
-
-        lpc_host: lpc-host at 80 {
-            compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
-            reg = <0x80 0x1e0>;
-            reg-io-width = <4>;
 
-            #address-cells = <1>;
-            #size-cells = <1>;
-            ranges = <0x0 0x80 0x1e0>;
-
-            lhc: lhc at 20 {
-                   compatible = "aspeed,ast2500-lhc";
-                   reg = <0x20 0x24>, <0x48 0x8>;
+            pinctrl_gpioh0_unbiased_default: gpioh0 {
+                pins = "A18";
+                bias-disable;
             };
         };
     };
-
-    gfx_memory: framebuffer {
-        size = <0x01000000>;
-        alignment = <0x01000000>;
-        compatible = "shared-dma-pool";
-        reusable;
-    };
-- 
2.32.0

