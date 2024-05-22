From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:07 -0500
Subject: [PATCH v6 03/20] dt-bindings: fsi: Document the IBM SCOM engine
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SCOM engine provides an interface to the POWER processor PIB
(Pervasive Interconnect Bus).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/fsi/ibm,p9-scom.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
new file mode 100644
index 0000000000000..8cd14a70bedf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,p9-scom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SCOM engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The SCOM engine is an interface to the POWER processor PIB (Pervasive
+  Interconnect Bus). This node will always be a child of an FSI CFAM node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-scom
+      - ibm,i2cr-scom
+
+  reg:
+    items:
+      - description: FSI slave address
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    scom at 1000 {
+        compatible = "ibm,p9-scom";
+        reg = <0x1000 0x400>;
+    };
-- 
2.39.3

