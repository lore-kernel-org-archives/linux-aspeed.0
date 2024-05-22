From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:14 -0500
Subject: [PATCH v6 10/20] dt-bindings: fsi: Document the FSI Hub Controller
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-11-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the FSI Hub Controller CFAM engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fsi/ibm,p9-fsi-controller.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
new file mode 100644
index 0000000000000..29ea80ff915ef
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

