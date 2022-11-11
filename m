From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Fri, 11 Nov 2022 11:48:25 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Facebook Greatlakes board
In-Reply-To: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
References: <20221007055346.3484180-1-Delphine_CC_Chiu@Wiwynn.com>
Message-ID: <20221111034828.2377-2-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Facebook Greatlakes

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 217a1d674863..3e6373aa3841 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -77,6 +77,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,greatlakes-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.17.1

