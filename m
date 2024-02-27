From: Kelly Hung <ppighouse@gmail.com>
Date: Tue, 27 Feb 2024 09:29:31 -0000
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240227092922.1734998-1-Kelly_Hung@asus.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on ASUS X4TF.

Changelog
Changes in v3
- correct string to asus,x4tf-bmc

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0d72a1a9d 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1

