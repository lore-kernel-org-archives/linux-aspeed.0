From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:15 -0500
Subject: [PATCH v6 11/20] dt-bindings: i2c: i2c-fsi: Convert to json-schema
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-12-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert to json-schema for the FSI-attached I2C controller.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v5:
 - Use more specific regex for node names

 .../devicetree/bindings/i2c/i2c-fsi.txt       | 40 ----------
 .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  | 76 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 77 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
deleted file mode 100644
index b1be2ceb7e696..0000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Device-tree bindings for FSI-attached I2C master and busses
------------------------------------------------------------
-
-Required properties:
- - compatible = "ibm,i2c-fsi";
- - reg = < address size >;		: The FSI CFAM address and address
-					  space size.
- - #address-cells = <1>;		: Number of address cells in child
-					  nodes.
- - #size-cells = <0>;			: Number of size cells in child nodes.
- - child nodes				: Nodes to describe busses off the I2C
-					  master.
-
-Child node required properties:
- - reg = < port number >		: The port number on the I2C master.
-
-Child node optional properties:
- - child nodes				: Nodes to describe devices on the I2C
-					  bus.
-
-Examples:
-
-    i2c at 1800 {
-        compatible = "ibm,i2c-fsi";
-        reg = < 0x1800 0x400 >;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        i2c-bus at 0 {
-            reg = <0>;
-        };
-
-        i2c-bus at 1 {
-            reg = <1>;
-
-            eeprom at 50 {
-                compatible = "vendor,dev-name";
-            };
-        };
-    };
diff --git a/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
new file mode 100644
index 0000000000000..40ea82942e4d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/ibm,i2c-fsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached I2C controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  This I2C controller is an FSI CFAM engine, providing access to a number of
+  I2C busses. Therefore this node will always be a child of an FSI CFAM node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,i2c-fsi
+
+  reg:
+    items:
+      - description: FSI slave address
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^i2c-bus@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+    allOf:
+      - $ref: /schemas/i2c/i2c-controller.yaml#
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c at 1800 {
+        compatible = "ibm,i2c-fsi";
+        reg = <0x1800 0x400>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-bus at 0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c-bus at 1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom at 50 {
+                compatible = "atmel,24c64";
+                reg = <0x50>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f0fe6b2032a21..7884dbe2374c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8977,7 +8977,7 @@ M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-i2c at vger.kernel.org
 L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-fsi.txt
+F:	Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
 F:	drivers/i2c/busses/i2c-fsi.c
 
 FSI-ATTACHED SPI DRIVER
-- 
2.39.3

