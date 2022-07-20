From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 20 Jul 2022 15:52:29 +0700
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: document Ampere Mt.Mitchell BMC compatibles
In-Reply-To: <20220720085230.3801945-1-quan@os.amperecomputing.com>
References: <20220720085230.3801945-1-quan@os.amperecomputing.com>
Message-ID: <20220720085230.3801945-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document Ampere Mt.Mitchell BMC board compatible.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v2:
  + Introduce in v2 to add Ampere Mt. Mitchell BMC compatible [Krzysztof]

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index d61408194998..b8146d5c4431 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -71,6 +71,7 @@ properties:
           - enum:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - ampere,mtmitchell-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.35.1

