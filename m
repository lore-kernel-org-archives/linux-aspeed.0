From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 8 Oct 2024 16:14:49 +0800
Subject: [PATCH v7 6/7] dt-bindings: gpio: aspeed,ast2400-gpio: Support ast2700
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
Message-ID: <20241008081450.1490955-7-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2700 is the 7th generation SoC from Aspeed, featuring two GPIO
controllers: one with 12 GPIO pins and another with 216 GPIO pins.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index cf11aa7ec8c7..b9afd07a9d24 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -15,6 +15,7 @@ properties:
       - aspeed,ast2400-gpio
       - aspeed,ast2500-gpio
       - aspeed,ast2600-gpio
+      - aspeed,ast2700-gpio
 
   reg:
     maxItems: 1
@@ -25,7 +26,7 @@ properties:
 
   gpio-controller: true
   gpio-line-names:
-    minItems: 36
+    minItems: 12
     maxItems: 232
 
   gpio-ranges: true
@@ -42,7 +43,7 @@ properties:
     const: 2
 
   ngpios:
-    minimum: 36
+    minimum: 12
     maximum: 232
 
 required:
@@ -93,6 +94,20 @@ allOf:
           enum: [ 36, 208 ]
       required:
         - ngpios
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2700-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 12
+          maxItems: 216
+        ngpios:
+          enum: [ 12, 216 ]
+      required:
+        - ngpios
 
 additionalProperties: false
 
-- 
2.25.1

