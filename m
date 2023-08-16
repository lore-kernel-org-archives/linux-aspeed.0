From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 16 Aug 2023 14:05:46 +0800
Subject: [PATCH linux dev-6.1 v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite 4 board
In-Reply-To: <20230816060547.40489-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230816060547.40489-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <20230816060547.40489-2-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Meta Yosemite 4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index fb4ce5df2fa0..6b0a6683ccae 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

