From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:39:58 -0600
Subject: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
Message-ID: <20231212164004.1683589-3-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Johannes Holland <johannes.holland@infineon.com>

Add a dt schema to support device tree bindings for the generic I2C
physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
Specification for TPM 2.0 v1.04 Revision 14.

This includes descriptions for the Nuvoton and Infineon devices.

OpenBMC-Staging-Count: 3
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..de1e34065748
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Devices
+
+maintainers:
+  - Johannes Holland <johannes.holland@infineon.com>
+
+description:
+  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
+
+properties:
+  $nodename:
+    pattern: "^tpm(@[0-9a-f]+)?$"
+
+  compatible:
+    oneOf:
+      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
+        items:
+          - const: infineon,slb9673
+          - const: tcg,tpm-tis-i2c
+      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
+        items:
+          - const: nuvoton,npct75x
+          - const: tcg,tpm-tis-i2c
+      - const: tcg,tpm-tis-i2c
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      tpm at 2e {
+        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+      };
+    };
+...
-- 
2.39.2

