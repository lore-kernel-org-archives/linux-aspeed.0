From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 25 Feb 2021 17:18:51 +0700
Subject: [PATCH 1/4] dt-bindings: mfd: Add bindings for Ampere Altra SMPro
 drivers
In-Reply-To: <20210225101854.13896-1-quan@os.amperecomputing.com>
References: <20210225101854.13896-1-quan@os.amperecomputing.com>
Message-ID: <20210225101854.13896-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adds device tree bindings for SMPro drivers found on the Mt.Jade hardware
reference platform with Ampere's Altra Processor family.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
 .../bindings/hwmon/ampere,ac01-hwmon.yaml     | 27 ++++++
 .../bindings/mfd/ampere,ac01-smpro.yaml       | 82 +++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,ac01-smpro.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
new file mode 100644
index 000000000000..d13862ba646b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ampere,ac01-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hardware monitoring driver for the Ampere Altra SMPro
+
+maintainers:
+  - Quan Nguyen <quan@os.amperecomputing.com>
+
+description: |
+  This module is part of the Ampere Altra SMPro multi-function device. For more
+  details see ../mfd/ampere,ac01-smpro.yaml.
+
+properties:
+  compatible:
+    enum:
+      - ampere,ac01-hwmon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/ampere,ac01-smpro.yaml b/Documentation/devicetree/bindings/mfd/ampere,ac01-smpro.yaml
new file mode 100644
index 000000000000..06b0239413ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ampere,ac01-smpro.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ampere,ac01-smpro.yaml#
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
+    const: ampere,ac01-smpro
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
+patternProperties:
+  "^hwmon(@[0-9a-f]+)?$":
+    $ref: ../hwmon/ampere,ac01-hwmon.yaml
+
+  "^misc(@[0-9a-f]+)?$":
+    type: object
+    description: Ampere Altra SMPro Misc driver
+    properties:
+      compatible:
+        const: "ampere,ac01-misc"
+
+  "^errmon(@[0-9a-f]+)?$":
+    type: object
+    description: Ampere Altra SMPro Error Monitor driver
+    properties:
+      compatible:
+        const: "ampere,ac01-errmon"
+
+required:
+  - "#address-cells"
+  - "#size-cells"
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
+            compatible = "ampere,ac01-smpro";
+            reg = <0x4f>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            hwmon {
+                compatible = "ampere,ac01-hwmon";
+            };
+
+            misc {
+                compatible = "ampere,ac01-misc";
+            };
+
+            errmon {
+                compatible = "ampere,ac01-errmon";
+            };
+
+        };
+    };
-- 
2.28.0

