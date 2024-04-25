From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:50 -0500
Subject: [PATCH v3 03/14] dt-bindings: fsi: Document the FSI2PIB engine
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <20240425213701.655540-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The FSI2PIB or SCOM engine provides an interface to the POWER processor
PIB (Pervasive Interconnect Bus).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/fsi/ibm,fsi2pib.yaml  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
new file mode 100644
index 000000000000..4d557150c2e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,fsi2pib.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SCOM engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The SCOM engine is an interface to the POWER processor PIB (Pervasive
+  Interconnect Bus). This node will always be a child of an FSI CFAM node;
+  see fsi.txt for details on FSI slave and CFAM nodes.
+
+properties:
+  compatible:
+    enum:
+      - ibm,fsi2pib
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
+        compatible = "ibm,fsi2pib";
+        reg = <0x1000 0x400>;
+    };
-- 
2.39.3

