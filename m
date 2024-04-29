From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Apr 2024 16:01:16 -0500
Subject: [PATCH v4 02/17] dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
In-Reply-To: <20240429210131.373487-1-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
Message-ID: <20240429210131.373487-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The FSI2SPI bridge has several SPI controllers behind it, which
should be documented. Also, therefore the node needs to specify
address and size cells.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
index e2ca0b000471..ad5c83f48425 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -9,11 +9,10 @@ title: IBM FSI-attached SPI controllers
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
 
-description: |
+description:
   This binding describes an FSI CFAM engine called the FSI2SPI. Therefore this
-  node will always be a child of an FSI CFAM node; see fsi.txt for details on
-  FSI slave and CFAM nodes. This FSI2SPI engine provides access to a number of
-  SPI controllers.
+  node will always be a child of an FSI CFAM node. This FSI2SPI engine provides
+  access to a number of SPI controllers.
 
 properties:
   compatible:
@@ -24,6 +23,17 @@ properties:
     items:
       - description: FSI slave address
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^spi@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/spi/ibm,spi-fsi.yaml
+
 required:
   - compatible
   - reg
@@ -35,4 +45,22 @@ examples:
     fsi2spi at 1c00 {
         compatible = "ibm,fsi2spi";
         reg = <0x1c00 0x400>;
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
+                address-width = <24>;
+                pagesize = <256>;
+                size = <0x80000>;
+                spi-max-frequency = <1000000>;
+            };
+        };
     };
-- 
2.39.3

