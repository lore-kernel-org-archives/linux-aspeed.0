From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 8 Aug 2023 23:42:40 +0800
Subject: [PATCH 2/3] dt-bindings: i3c: ast2600: Add resets and reset-names
In-Reply-To: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
Message-ID: <20230808154241.749641-3-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add two reset lines to the AST2600 I3C controller:
- core_rst: the reset line of the controller itself
- global_rst: the reset line of the I3C global register block. Since all
six I3C controllers in AST2600 share this global register block, the
driver needs to handle this carefully. Generally, this reset line should
only need to be de-asserted.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 .../devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
index fcc3dbff9c9a..3166d6f3a39c 100644
--- a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
@@ -23,7 +23,12 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: core_rst
+      - const: global_rst
 
   interrupts:
     maxItems: 1
@@ -48,6 +53,8 @@ required:
   - compatible
   - reg
   - clocks
+  - resets
+  - reset-names
   - interrupts
   - aspeed,global-regs
 
@@ -63,7 +70,8 @@ examples:
         #address-cells = <3>;
         #size-cells = <0>;
         clocks = <&syscon 0>;
-        resets = <&syscon 0>;
+        resets = <&syscon 40>, <&syscon 39>;
+        reset-names = "core_rst", "global_rst";
         aspeed,global-regs = <&i3c_global 0>;
         pinctrl-names = "default";
         pinctrl-0 = <&pinctrl_i3c1_default>;
-- 
2.25.1

