From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 26 Sep 2022 14:58:47 +0700
Subject: [PATCH v3 RESEND 1/2] dt-bindings: arm: aspeed: document Ampere Mt.Mitchell BMC compatibles
In-Reply-To: <20220926075848.206918-1-quan@os.amperecomputing.com>
References: <20220926075848.206918-1-quan@os.amperecomputing.com>
Message-ID: <20220926075848.206918-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document Ampere Mt.Mitchell BMC board compatible.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3:
  + Fixed the alphabetical order                              [Krzysztof]

v2:
  + Introduce in v2 to add Ampere Mt. Mitchell BMC compatible [Krzysztof]

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..59811e4a084c 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -69,6 +69,7 @@ properties:
       - description: AST2600 based boards
         items:
           - enum:
+              - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - facebook,bletchley-bmc
-- 
2.35.1

