From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:39:05 -0500
Subject: [PATCH v2 1/3] dt-bindings: fsi: Document the IBM SBEFIFO engine
In-Reply-To: <20240415153907.10051-1-eajames@linux.ibm.com>
References: <20240415153907.10051-1-eajames@linux.ibm.com>
Message-ID: <20240415153907.10051-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SBEFIFO engine provides an interface to the POWER processor
Self Boot Engine (SBE).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Chance "ody" to "odyssey"
 - Fix typo in commit message
 - Reword description to describe the hardware only

 .../devicetree/bindings/fsi/ibm,sbefifo.yaml  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
new file mode 100644
index 000000000000..69521b1cfb25
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,sbefifo.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,sbefifo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SBEFIFO engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  The SBEFIFO is an FSI CFAM engine that provides an interface to the
+  POWER processor Self Boot Engine (SBE). This node will always be a child
+  of an FSI CFAM node; see fsi.txt for details on FSI slave and CFAM
+  nodes.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-sbefifo
+      - ibm,odyssey-sbefifo
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
+    sbefifo at 2400 {
+        compatible = "ibm,p9-sbefifo";
+        reg = <0x2400 0x400>;
+    };
-- 
2.39.3

