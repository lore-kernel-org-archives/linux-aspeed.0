From: yangchen.openbmc@gmail.com <yangchen.openbmc@gmail.com>
Date: Tue, 12 Sep 2023 22:05:31 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
Message-ID: <20230912140532.3797736-2-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yangchen.openbmc@gmail.com>

Document the new compatibles used on the Facebook Minerva Chassis
Management Controller (CMC).

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 68f717670f78..749ee54a3ff8 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-cmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.34.1

