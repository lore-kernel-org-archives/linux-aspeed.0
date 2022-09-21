From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Thu, 22 Sep 2022 00:09:46 +0300
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
In-Reply-To: <20220921210950.10568-1-aladyshev22@gmail.com>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
Message-ID: <20220921210950.10568-2-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document AMD DaytonaX board compatible.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..cb9bc65df82a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -29,6 +29,7 @@ properties:
       - description: AST2500 based boards
         items:
           - enum:
+              - amd,daytonax-bmc
               - amd,ethanolx-bmc
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
-- 
2.25.1

