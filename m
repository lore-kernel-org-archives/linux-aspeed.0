From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 24 Dec 2021 11:13:44 +0700
Subject: [PATCH v6 1/9] dt-bindings: mfd: Add bindings for Ampere Altra SMPro
 MFD driver
In-Reply-To: <20211224041352.29405-1-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
Message-ID: <20211224041352.29405-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
hardware reference platform with Ampere's Altra Processor family.

The SMpro co-processor on Ampere Altra processor family is to monitor
and report various data included hwmon-related info, RAS errors, and
other miscellaneous information.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v6:
  + None

Changes in v5:
  + Dropped ../bindings/hwmon/ampere,ac01-hwmon.yaml file [Quan]
  + Removed patternProperties section and child DT nodes in example
  section [Quan]
  + Revised commit message [Quan]

Changes in v4:
  + Revised the commit message to clarify how the specific info will
    be handled commented by Rob.

Changes in v3:
  + Supported list of compatible string [Rob]
  + Introduced reg property in DT to specify reg offset [Rob]
  + Updated description and other minor changes in yaml file [Rob]

Changes in v2:
  + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]

 .../devicetree/bindings/mfd/ampere,smpro.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
new file mode 100644
index 000000000000..c29d975c1bc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ampere,smpro.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ampere Altra SMPro firmware driver
+
+maintainers:
+  - Quan Nguyen <quan@os.amperecomputing.com>
+
+description: |
+  Ampere Altra SMPro firmware may contain different blocks like hardware
+  monitoring, error monitoring and other miscellaneous features.
+
+properties:
+  compatible:
+    enum:
+      - ampere,smpro
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        smpro at 4f {
+            compatible = "ampere,smpro";
+            reg = <0x4f>;
+        };
+    };
-- 
2.28.0

