From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 27 Jul 2023 11:34:32 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Message-ID: <20230727033435.1904180-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Facebook Yosemite V4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e0eff4c05879..2ef6821e3648 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemitev4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

