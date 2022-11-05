From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri,  4 Nov 2022 18:33:20 -0700
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
In-Reply-To: <20221105013321.2719-1-zev@bewilderbeest.net>
References: <20221105013321.2719-1-zev@bewilderbeest.net>
Message-ID: <20221105013321.2719-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document Delta AHE-50DC BMC board compatible.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 217a1d674863..272626937ecd 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -17,6 +17,7 @@ properties:
       - description: AST2400 based boards
         items:
           - enum:
+              - delta,ahe50dc-bmc
               - facebook,galaxy100-bmc
               - facebook,wedge100-bmc
               - facebook,wedge40-bmc
-- 
2.38.1

