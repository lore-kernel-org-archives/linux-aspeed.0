From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:13 -0500
Subject: [PATCH v6 09/20] dt-bindings: fsi: Document the AST2700 FSI controller
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-10-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the appropriate compatible string, and document the new reg
properties of the AST2700 FSI controller, which can directly access
the FSI controller registers as well as the FSI link address space.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v5:
 - Add the AST2700-specific regs properties since that controller can
   map the FSI control registers and FSI link space.

 .../fsi/aspeed,ast2600-fsi-master.yaml        | 47 +++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
index 2f531c47994bc..dfcc2fafa68dc 100644
--- a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
+++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
@@ -17,9 +17,7 @@ properties:
   compatible:
     enum:
       - aspeed,ast2600-fsi-master
-
-  reg:
-    maxItems: 1
+      - aspeed,ast2700-fsi-master
 
   clocks:
     maxItems: 1
@@ -42,6 +40,30 @@ properties:
   interrupts:
     maxItems: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - aspeed,ast2600-fsi-master
+then:
+  properties:
+    reg:
+      maxItems: 1
+else:
+  properties:
+    reg:
+      minItems: 1
+      items:
+        - description: OPB control registers
+        - description: FSI controller registers
+        - description: FSI link address space
+    reg-names:
+      items:
+        - const: opb
+        - const: ctrl
+        - const: fsi
+
 required:
   - compatible
   - reg
@@ -78,3 +100,22 @@ examples:
             chip-id = <0>;
         };
     };
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        fsi-master at 21800000 {
+            compatible = "aspeed,ast2700-fsi-master";
+            reg = <0x0 0x21800000 0x0 0x100>,
+                  <0x0 0x21000000 0x0 0x1000>,
+                  <0x0 0x20000000 0x0 0x1000000>;
+            reg-names = "opb", "ctrl", "fsi";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            interrupts-extended = <&intc 6>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_fsi0_default>;
+            clocks = <&syscon 40>;
+        };
+    };
-- 
2.39.3

