From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 26 Jul 2024 11:09:34 -0000
Subject: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700 SCU
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Message-ID: <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
index 86ee69c0f45b..3fc991e4514d 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
@@ -13,6 +13,7 @@ description:
 maintainers:
   - Joel Stanley <joel@jms.id.au>
   - Andrew Jeffery <andrew@aj.id.au>
+  - Kevin Chen <kevin_chen@aspeedtech.com>
 
 properties:
   compatible:
@@ -21,6 +22,7 @@ properties:
           - aspeed,ast2400-scu
           - aspeed,ast2500-scu
           - aspeed,ast2600-scu
+          - aspeed,ast2700-scu
       - const: syscon
       - const: simple-mfd
 
@@ -76,6 +78,7 @@ patternProperties:
               - aspeed,ast2400-silicon-id
               - aspeed,ast2500-silicon-id
               - aspeed,ast2600-silicon-id
+              - aspeed,ast2700-silicon-id
           - const: aspeed,silicon-id
 
       reg:
-- 
2.34.1

