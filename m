From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Fri,  7 Oct 2022 13:50:05 +0800
Subject: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Message-ID: <20221007055008.3468691-1-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Facebook Greatlakes

---
--- v2 - Add binding document
---
--- v1 - Initial draft
---

Signed-off-by: Bonnie Lo <Bonnie_Lo@Wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..f12b94ddb9ec 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -75,6 +75,7 @@ properties:
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
+              - facebook,greatlakes-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

