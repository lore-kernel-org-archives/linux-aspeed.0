From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 24 Jul 2019 17:43:13 +0930
Subject: [PATCH 3/3] dt-bindings: aspeed: Remove mention of deprecated
 compatibles
In-Reply-To: <20190724081313.12934-1-andrew@aj.id.au>
References: <20190724081313.12934-1-andrew@aj.id.au>
Message-ID: <20190724081313.12934-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Guide readers away from using the aspeed,g[45].* compatible patterns.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mfd/aspeed-scu.txt         | 2 --
 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt   | 2 --
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml  | 5 +----
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml  | 4 +---
 4 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
index ce8cf0ec6279..4d92c0bb6687 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
@@ -4,9 +4,7 @@ configuring elements such as clocks, pinmux, and reset.
 Required properties:
 - compatible:	One of:
 		"aspeed,ast2400-scu", "syscon", "simple-mfd"
-		"aspeed,g4-scu", "syscon", "simple-mfd"
 		"aspeed,ast2500-scu", "syscon", "simple-mfd"
-		"aspeed,g5-scu", "syscon", "simple-mfd"
 
 - reg:		contains the offset and length of the SCU memory region
 - #clock-cells: should be set to <1> - the system controller is also a
diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
index 854bd67ffec6..0e1fa5bc6a30 100644
--- a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -26,9 +26,7 @@ property:
 
 - compatible : Should be one of the following:
 		"aspeed,ast2400-scu", "syscon", "simple-mfd"
-		"aspeed,g4-scu", "syscon", "simple-mfd"
 		"aspeed,ast2500-scu", "syscon", "simple-mfd"
-		"aspeed,g5-scu", "syscon", "simple-mfd"
 
 Example
 ===================
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index 125599a2dc5e..9368e4b6d4d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -15,16 +15,13 @@ description: |+
 
   - compatible:     Should be one of the following:
                     "aspeed,ast2400-scu", "syscon", "simple-mfd"
-                    "aspeed,g4-scu", "syscon", "simple-mfd"
 
   Refer to the the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.txt
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2400-pinctrl
-      - aspeed,g4-pinctrl
+    const: aspeed,ast2400-pinctrl
 
 patternProperties:
   '^.*$':
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 3e6d85318577..939fb755a6db 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -22,9 +22,7 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2500-pinctrl
-      - aspeed,g5-pinctrl
+    const: aspeed,ast2500-pinctrl
   aspeed,external-nodes:
     minItems: 2
     maxItems: 2
-- 
2.20.1

