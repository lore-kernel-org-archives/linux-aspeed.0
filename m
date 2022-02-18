From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 18 Feb 2022 10:33:17 +0100
Subject: [PATCH] dt-bindings: soc: aspeed XDMA fixes
Message-ID: <20220218093317.664559-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is to address warnings reported by make dt_binding_check.

Cc: Eddie James <eajames@linux.ibm.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
index 495743581e2d..b3d2aeb5a9b9 100644
--- a/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Aspeed AST25XX and AST26XX XDMA Engine
 
 maintainers:
- - Eddie James <eajames@linux.ibm.com>
+  - Eddie James <eajames@linux.ibm.com>
 
 description: |
   This binding describes the XDMA Engine embedded in the AST2500 and AST2600
@@ -31,13 +31,11 @@ properties:
     maxItems: 2
 
   reset-names:
-    maxItems: 2
     items:
       - const: device
       - const: root-complex
 
   interrupts:
-    maxItems: 2
     items:
       - description: global interrupt for the XDMA engine
       - description: PCI-E reset or PERST interrupt
@@ -71,6 +69,8 @@ then:
   required:
     - reset-names
 
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/ast2600-clock.h>
-- 
2.34.1

