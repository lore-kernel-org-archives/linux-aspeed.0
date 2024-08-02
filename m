From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 02 Aug 2024 09:06:29 -0000
Subject: [PATCH v2 1/9] dt-bindings: mfd: aspeed,ast2x00-scu: Add ASPEED AST2700-SCUX schema
In-Reply-To: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
Message-ID: <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add compatible for two SCU of SCU0 and SCU1 in AST2700.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 70 +++++++++++++------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..3426b1c84132 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -13,33 +13,62 @@ description:
 maintainers:
   - Joel Stanley <joel@jms.id.au>
   - Andrew Jeffery <andrew@aj.id.au>
+  - Kevin Chen <kevin_chen@aspeedtech.com>
 
-properties:
-  compatible:
-    items:
-      - enum:
-          - aspeed,ast2400-scu
-          - aspeed,ast2500-scu
-          - aspeed,ast2600-scu
-      - const: syscon
-      - const: simple-mfd
+scu at ast2xx00-scu:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - aspeed,ast2400-scu
+            - aspeed,ast2500-scu
+            - aspeed,ast2600-scu
+        - const: syscon
+        - const: simple-mfd
 
-  reg:
-    maxItems: 1
+    reg:
+      maxItems: 1
 
-  ranges: true
+    ranges: true
 
-  '#address-cells':
-    const: 1
+    '#address-cells':
+      const: 1
 
-  '#size-cells':
-    const: 1
+    '#size-cells':
+      const: 1
 
-  '#clock-cells':
-    const: 1
+    '#clock-cells':
+      const: 1
 
-  '#reset-cells':
-    const: 1
+    '#reset-cells':
+      const: 1
+
+scu at ast2xx00-scux:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - aspeed,ast2700-scu0
+            - aspeed,ast2700-scu1
+        - const: syscon
+        - const: simple-mfd
+
+    reg:
+      maxItems: 1
+
+    ranges: true
+
+    '#address-cells':
+      const: 2
+
+    '#size-cells':
+      const: 2
+
+    '#clock-cells':
+      const: 1
+
+    '#reset-cells':
+      const: 1
 
 patternProperties:
   '^p2a-control@[0-9a-f]+$':
@@ -76,6 +105,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
-- 
2.34.1

