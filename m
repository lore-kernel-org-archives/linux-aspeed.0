From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 24 May 2024 16:29:23 +0530
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20240524105929.557129-1-naresh.solanki@9elements.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..307232336629 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc

base-commit: d976c6f4b32c2d273d44ff9ad7099efe16279a39
-- 
2.42.0

