From: Joel Stanley <joel@jms.id.au>
Date: Fri,  4 Mar 2022 10:33:10 +1030
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: aspeed: Update gfx node in
 example
In-Reply-To: <20220304000311.970267-1-joel@jms.id.au>
References: <20220304000311.970267-1-joel@jms.id.au>
Message-ID: <20220304000311.970267-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The example needs updating to match the to be added yaml bindings for
the gfx node.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index d316cc082107..9969997c2f1b 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -73,6 +73,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/aspeed-clock.h>
     apb {
         compatible = "simple-bus";
         #address-cells = <1>;
@@ -82,6 +83,8 @@ examples:
         syscon: scu at 1e6e2000 {
             compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
             reg = <0x1e6e2000 0x1a8>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
 
             pinctrl: pinctrl {
                 compatible = "aspeed,ast2500-pinctrl";
@@ -102,6 +105,12 @@ examples:
         gfx: display at 1e6e6000 {
             compatible = "aspeed,ast2500-gfx", "syscon";
             reg = <0x1e6e6000 0x1000>;
+            reg-io-width = <4>;
+            clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+            resets = <&syscon ASPEED_RESET_CRT1>;
+            interrupts = <0x19>;
+            syscon = <&syscon>;
+            memory-region = <&gfx_memory>;
         };
     };
 
@@ -128,3 +137,10 @@ examples:
             };
         };
     };
+
+    gfx_memory: framebuffer {
+        size = <0x01000000>;
+        alignment = <0x01000000>;
+        compatible = "shared-dma-pool";
+        reusable;
+    };
-- 
2.34.1

