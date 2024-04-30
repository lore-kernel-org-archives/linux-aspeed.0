From: Rob Herring (Arm) <robh@kernel.org>
Date: Tue, 30 Apr 2024 12:25:19 -0500
Subject: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
Message-ID: <20240430172520.535179-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The use of 'oneOf' to include 1 of 3 possible child node schemas results
in error messages containing the actual error message(s) for the correct
SoC buried in the tons of error messages from the 2 schemas that don't
apply. It also causes the pinctrl schema to be applied twice as it will
be applied when the compatible matches.

All that's really needed in the parent schema is to ensure one of the
possible compatible strings is present in the pinctrl node so that its
schema will be applied separately.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/mfd/aspeed,ast2x00-scu.yaml         | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 1689b986f441..86ee69c0f45b 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -47,10 +47,18 @@ patternProperties:
     type: object
 
   '^pinctrl(@[0-9a-f]+)?$':
-    oneOf:
-      - $ref: /schemas/pinctrl/aspeed,ast2400-pinctrl.yaml
-      - $ref: /schemas/pinctrl/aspeed,ast2500-pinctrl.yaml
-      - $ref: /schemas/pinctrl/aspeed,ast2600-pinctrl.yaml
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          enum:
+            - aspeed,ast2400-pinctrl
+            - aspeed,ast2500-pinctrl
+            - aspeed,ast2600-pinctrl
+
+    required:
+      - compatible
 
   '^interrupt-controller@[0-9a-f]+$':
     description: See Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
-- 
2.43.0

