From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:08 -0500
Subject: [PATCH v6 04/20] dt-bindings: fsi: p9-occ: Convert to json-schema
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Conver to json-schema for the OCC documentation. Also document the fact
that the OCC "bridge" device will often have the hwmon node as a
child.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/fsi/ibm,p9-occ.txt    | 16 --------
 .../devicetree/bindings/fsi/ibm,p9-occ.yaml   | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
deleted file mode 100644
index e73358075a903..0000000000000
--- a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Device-tree bindings for FSI-attached POWER9/POWER10 On-Chip Controller (OCC)
------------------------------------------------------------------------------
-
-This is the binding for the P9 or P10 On-Chip Controller accessed over FSI from
-a service processor. See fsi.txt for details on bindings for FSI slave and CFAM
-nodes. The OCC is not an FSI slave device itself, rather it is accessed
-through the SBE FIFO.
-
-Required properties:
- - compatible = "ibm,p9-occ" or "ibm,p10-occ"
-
-Examples:
-
-    occ {
-        compatible = "ibm,p9-occ";
-    };
diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
new file mode 100644
index 0000000000000..537eac70447c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,p9-occ.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached On-Chip Controller (OCC)
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The POWER processor On-Chip Controller (OCC) helps manage power and
+  thermals for the system, accessed through the FSI-attached SBEFIFO
+  from a service processor.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-occ
+      - ibm,p10-occ
+
+  hwmon:
+    type: object
+    $ref: /schemas/hwmon/ibm,occ-hwmon.yaml
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    occ {
+        compatible = "ibm,p9-occ";
+
+        hwmon {
+            compatible = "ibm,p9-occ-hwmon";
+        };
+    };
-- 
2.39.3

