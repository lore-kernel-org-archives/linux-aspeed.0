From: George Liu <liuxiwei1013@gmail.com>
Date: Mon,  8 Jul 2024 11:48:48 +0800
Subject: [PATCH v2] dt-bindings: arm: aspeed: add IEIT x86 platform BMC boards
Message-ID: <20240708034848.100930-1-liuxiwei@ieisystem.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on the ieisystems

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e386d0ebfb14..818fbe9c45fc 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
+              - ieit,nf5280m7-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-- 
2.34.1

