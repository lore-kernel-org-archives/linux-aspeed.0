From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 10 Oct 2024 16:53:31 +0530
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20241010112337.3840703-1-naresh.solanki@9elements.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V4:
- Retain Acked-by from v2.
- Fix alphabetic order
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..c79c74ab3d78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
-- 
2.42.0

