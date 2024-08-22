From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 22 Aug 2024 15:27:08 +0200
Subject: [PATCH] dt-bindings: i2c: aspeed: drop redundant multi-master
Message-ID: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'multi-master' property is defined by core i2c-controller schema in
dtschema package, so binding which references it and has
unevaluatedProperties:false, does not need to mention it.  It is
completely redundant here.

Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Reference:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/i2c/i2c-controller.yaml#L114
---
 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index 6df27b47b922..5b9bd2feda3b 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -44,11 +44,6 @@ properties:
     description: frequency of the bus clock in Hz defaults to 100 kHz when not
       specified
 
-  multi-master:
-    type: boolean
-    description:
-      states that there is another master active on this bus
-
 required:
   - reg
   - compatible
-- 
2.43.0

