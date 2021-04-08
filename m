From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  7 Apr 2021 20:16:37 -0500
Subject: [PATCH v5 4/4] dt-bindings: serial: 8250: add aspeed,
 lpc-io-reg and aspeed, lpc-interrupts
In-Reply-To: <20210408011637.5361-1-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
Message-ID: <20210408011637.5361-5-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These correspond to the existing lpc_address, sirq, and sirq_polarity
sysfs attributes; the second element of aspeed,lpc-interrupts provides
a replacement for the deprecated aspeed,sirq-polarity-sense property.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 491b9297432d..0e82b076e199 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -12,8 +12,13 @@ maintainers:
 allOf:
   - $ref: /schemas/serial.yaml#
   - if:
-      required:
-        - aspeed,sirq-polarity-sense
+      anyOf:
+        - required:
+            - aspeed,lpc-io-reg
+        - required:
+            - aspeed,lpc-interrupts
+        - required:
+            - aspeed,sirq-polarity-sense
     then:
       properties:
         compatible:
@@ -190,6 +195,20 @@ properties:
       applicable to aspeed,ast2500-vuart.
     deprecated: true
 
+  aspeed,lpc-io-reg:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+
+  aspeed,lpc-interrupts:
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    minItems: 2
+    maxItems: 2
+    description: |
+      A 2-cell property describing the VUART SIRQ number and SIRQ
+      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
+      applicable to aspeed,ast2500-vuart.
+
 required:
   - reg
   - interrupts
@@ -221,6 +240,7 @@ examples:
     };
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     serial at 1e787000 {
         compatible = "aspeed,ast2500-vuart";
         reg = <0x1e787000 0x40>;
@@ -228,7 +248,8 @@ examples:
         interrupts = <8>;
         clocks = <&syscon ASPEED_CLK_APB>;
         no-loopback-test;
-        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
+        aspeed,lpc-io-reg = <0x3f8>;
+        aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
     };
 
 ...
-- 
2.31.1

