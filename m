From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 19 May 2021 14:49:34 +0700
Subject: [PATCH v3 7/7] bindings: ipmi: Add binding for Aspeed SSIF BMC driver
In-Reply-To: <20210519074934.20712-1-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
Message-ID: <20210519074934.20712-8-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add device tree binding document for the Aspeed SSIF BMC driver.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v3:
  + Switched to use DT schema format [Rob]

 .../bindings/ipmi/aspeed-ssif-bmc.yaml        | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.yaml

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.yaml
new file mode 100644
index 000000000000..8608041fbf7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ipmi/aspeed-ssif-bmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SSIF IPMI interface
+
+description: SSIF IPMI device bindings for Aspeed
+
+maintainers:
+  - Thang Nguyen <thang@os.amperecomputing.com>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2500-ssif-bmc
+
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
+    ssif-bmc at 10 {
+        compatible = "aspeed,ast2500-ssif-bmc";
+        reg = <0x10>;
+    };
-- 
2.28.0

