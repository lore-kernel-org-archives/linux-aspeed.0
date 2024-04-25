From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:48 -0500
Subject: [PATCH v3 01/14] dt-bindings: spi: Document the IBM Power SPI controller
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <20240425213701.655540-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The IBM Power chips have a basic SPI controller. Document it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/spi/ibm,p10-spi.yaml  | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml b/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
new file mode 100644
index 000000000000..9bf57b621c1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ibm,p10-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM SPI Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  A basic SPI controller found on IBM Power chips, accessed over FSI. This
+  node will always be a child node of an ibm,fsi2spi node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p10-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi2spi at 1c00 {
+        compatible = "ibm,fsi2spi";
+        reg = <0x1c00 0x400>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi at 0 {
+            compatible = "ibm,p10-spi";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom at 0 {
+                compatible = "atmel,at25";
+                reg = <0>;
+                size = <0x80000>;
+                address-width = <24>;
+                pagesize = <256>;
+                spi-max-frequency = <1000000>;
+            };
+        };
+    };
-- 
2.39.3

