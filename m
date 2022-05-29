From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 12:49:24 +0200
Subject: [PATCH 3/7] dt-bindings: arm: aspeed: add Aspeed Evaluation boards
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220529104928.79636-3-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Aspeed Evaluation boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index f214b57d5ae1..fe71cb10ba6e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -29,6 +29,7 @@ properties:
       - description: AST2500 based boards
         items:
           - enum:
+              - aspeed,ast2500-evb
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - asrock,e3c246d4i-bmc
@@ -68,6 +69,8 @@ properties:
       - description: AST2600 based boards
         items:
           - enum:
+              - aspeed,ast2600-evb
+              - aspeed,ast2600-evb-a1
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.34.1

