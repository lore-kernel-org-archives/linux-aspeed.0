From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  8 Sep 2020 15:00:57 -0500
Subject: [PATCH v2 1/5] dt-bindings: input: Add documentation for IBM
 Operation Panel
In-Reply-To: <20200908200101.64974-1-eajames@linux.ibm.com>
References: <20200908200101.64974-1-eajames@linux.ibm.com>
Message-ID: <20200908200101.64974-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the bindings for the IBM Operation Panel, which provides
a simple interface to control a server. It has a display and three
buttons.
Also update MAINTAINERS for the new file.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/input/ibm,op-panel.yaml          | 39 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml

diff --git a/Documentation/devicetree/bindings/input/ibm,op-panel.yaml b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
new file mode 100644
index 000000000000..5f068fce93ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ibm,op-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM Operation Panel
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  The IBM Operation Panel provides a simple interface to control the connected
+  server. It has a display and three buttons: two directional arrows and one
+  'Enter' button.
+
+properties:
+  compatible:
+    const: ibm,op-panel
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/i2c/i2c.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ibm-op-panel at 62 {
+            compatible = "ibm,op-panel";
+            reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a5d6797a206..0d83eada50e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8345,6 +8345,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
 F:	Documentation/ia64/
 F:	arch/ia64/
 
+IBM Operation Panel Input Driver
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-input at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/ibm,op-panel.yaml
+
 IBM Power 842 compression accelerator
 M:	Haren Myneni <haren@us.ibm.com>
 S:	Supported
-- 
2.26.2

