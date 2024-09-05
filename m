From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 5 Sep 2024 19:47:53 +0800
Subject: [PATCH 1/2] dt-bindings: net: aspeed: Add binding for ASPEED AST2700 MDIO
In-Reply-To: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
References: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
Message-ID: <20240905114754.519609-2-jacky_chou@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new compatible for ASPEED AST2700 MDIO.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index d6ef468495c5..6dadca099875 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -19,7 +19,9 @@ allOf:
 
 properties:
   compatible:
-    const: aspeed,ast2600-mdio
+    enum:
+      - aspeed,ast2600-mdio
+      - aspeed,ast2700-mdio
 
   reg:
     maxItems: 1
-- 
2.25.1

