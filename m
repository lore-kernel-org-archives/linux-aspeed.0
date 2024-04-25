From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:56 -0500
Subject: [PATCH v3 09/14] dt-bindings: fsi: Document the FSI Hub Controller
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <20240425213701.655540-10-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the FSI Hub Controller CFAM engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../bindings/fsi/ibm,hub-fsi-controller.yaml  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
new file mode 100644
index 000000000000..d96d777d4d9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,hub-fsi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached FSI Hub Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  The FSI Hub Controller is an FSI controller, providing a number of FSI links,
+  located on a CFAM. Therefore this node will always be a child of an FSI CFAM
+  node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,hub-fsi-controller
+
+  reg:
+    items:
+      - description: FSI slave address
+
+allOf:
+  - $ref: fsi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   fsi at 3400 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "ibm,hub-fsi-controller";
+        reg = <0x3400 0x400>;
+
+        cfam at 0,0 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0 0>;
+        };
+    };
-- 
2.39.3

