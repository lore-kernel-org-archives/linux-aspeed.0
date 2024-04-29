From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:15 -0500
Subject: [PATCH v4 01/17] spi: dt-bindings: Document the IBM FSI-attached SPI controller
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

IBM Power processors have a SPI controller that can be accessed
over FSI from a service processor. Document it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2: 
 - Change name from ibm,p10-spi to ibm,spi-fsi for two reasons. One, this
   matches the I2C controller binding (ibm,i2c-fsi), and two, this binding
   is specifically for the FSI-attached SPI controllers on the P10 but
   accessed from the service processor. P10 SPI controllers accessed from
   the P10 would have different bindings.
 - Fix warnings by using generic FSI parent node
 - Fix prefix

 .../devicetree/bindings/spi/ibm,spi-fsi.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml

diff --git a/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml b/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
new file mode 100644
index 000000000000..d7fec4c3a801
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ibm,spi-fsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SPI Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  A SPI controller found on IBM Power processors, accessed over FSI from a
+  service processor. This node will always be a child node of an ibm,fsi2spi
+  node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,spi-fsi
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
+    fsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi at 0 {
+            compatible = "ibm,spi-fsi";
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

