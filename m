From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 16 Oct 2020 14:26:02 +0800
Subject: [PATCH 3/3] dt-bindings: Change the meaning of clock-frequency
In-Reply-To: <20201016062602.20014-1-billy_tsai@aspeedtech.com>
References: <20201016062602.20014-1-billy_tsai@aspeedtech.com>
Message-ID: <20201016062602.20014-4-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Integration of the usage of msg-timing and addr-timing to clock-frequency.
User can just set it to adjust the peci work efficient.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/peci/peci-aspeed.yaml | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
index 0f5c2993fe9b..7c6c895784af 100644
--- a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
+++ b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
@@ -40,31 +40,33 @@ properties:
     maxItems: 1
 
   clock-frequency:
-    # Operation frequency of PECI controller in units of Hz.
-    minimum: 187500
-    maximum: 24000000
-
-  msg-timing:
-    description: |
-      Message timing negotiation period. This value will determine the period
-      of message timing negotiation to be issued by PECI controller. The unit
-      of the programmed value is four times of PECI clock period.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 255
-        default: 1
-
-  addr-timing:
-    description: |
-      Address timing negotiation period. This value will determine the period
-      of address timing negotiation to be issued by PECI controller. The unit
-      of the programmed value is four times of PECI clock period.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - minimum: 0
-        maximum: 255
-        default: 1
+    # The bit frequency of PECI negotiation stage in units of Hz.
+    # Driver will calculate the best divisor setting of msg-timing and
+    # addr-timing to meet the value.
+    minimum: 2000
+    maximum: 2000000
+
+  # msg-timing:
+  #   description: |
+  #     Message timing negotiation period. This value will determine the period
+  #     of message timing negotiation to be issued by PECI controller. The unit
+  #     of the programmed value is four times of PECI clock period.
+  #   allOf:
+  #     - $ref: /schemas/types.yaml#/definitions/uint32
+  #     - minimum: 0
+  #       maximum: 255
+  #       default: 1
+
+  # addr-timing:
+  #   description: |
+  #     Address timing negotiation period. This value will determine the period
+  #     of address timing negotiation to be issued by PECI controller. The unit
+  #     of the programmed value is four times of PECI clock period.
+  #   allOf:
+  #     - $ref: /schemas/types.yaml#/definitions/uint32
+  #     - minimum: 0
+  #       maximum: 255
+  #       default: 1
 
   rd-sampling-point:
     description: |
@@ -114,9 +116,7 @@ examples:
             interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
             clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
             resets = <&syscon ASPEED_RESET_PECI>;
-            clock-frequency = <24000000>;
-            msg-timing = <1>;
-            addr-timing = <1>;
+            clock-frequency = <2000000>;
             rd-sampling-point = <8>;
             cmd-timeout-ms = <1000>;
         };
-- 
2.17.1

