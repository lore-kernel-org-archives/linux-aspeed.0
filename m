From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:23 -0500
Subject: [PATCH v4 09/17] dt-bindings: fsi: Document the FSI Hub Controller
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-10-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the FSI Hub Controller CFAM engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v3:
 - Change name from ibm,hub-fsi-controller to ibm,p9-fsi-controller

 .../bindings/fsi/ibm,p9-fsi-controller.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
new file mode 100644
index 000000000000..29ea80ff915e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,p9-fsi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached FSI Hub Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The FSI Hub Controller is an FSI controller, providing a number of FSI links,
+  located on a CFAM. Therefore this node will always be a child of an FSI CFAM
+  node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-fsi-controller
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
+    fsi at 3400 {
+        compatible = "ibm,p9-fsi-controller";
+        reg = <0x3400 0x400>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cfam at 0,0 {
+            reg = <0 0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            chip-id = <0>;
+        };
+    };
-- 
2.39.3

