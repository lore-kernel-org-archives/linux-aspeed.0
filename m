From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 26 Jul 2019 15:09:52 +0930
Subject: [RFC PATCH 10/17] dt-bindings: pinctrl: aspeed: Add reg property as a
 hint
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
Message-ID: <20190726053959.2003-11-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The pinctrl node sits under a syscon device, and can assume offsets from
the base of the syscon based on the compatible. However, for devicetree
correctness allow a reg property to be specified, which an associated
driver may choose to use to discover associated resources.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio at vger.kernel.org
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml    | 3 +++
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index 125599a2dc5e..629a55c167ae 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -25,6 +25,9 @@ properties:
     enum:
       - aspeed,ast2400-pinctrl
       - aspeed,g4-pinctrl
+  reg:
+    description: |
+      A hint for the memory regions associated with the pin-controller
 
 patternProperties:
   '^.*$':
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 3e6d85318577..2e8971e23a02 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -25,6 +25,9 @@ properties:
     enum:
       - aspeed,ast2500-pinctrl
       - aspeed,g5-pinctrl
+  reg:
+    description: |
+      A hint for the memory regions associated with the pin-controller
   aspeed,external-nodes:
     minItems: 2
     maxItems: 2
-- 
2.20.1

