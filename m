From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 11:51:04 +0800
Subject: [PATCH 1/3] dt-bindings: aspeed: Add Secure Boot Controller bindings
In-Reply-To: <20211117035106.321454-1-joel@jms.id.au>
References: <20211117035106.321454-1-joel@jms.id.au>
Message-ID: <20211117035106.321454-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The secure boot controller was first introduced in the AST2600.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../bindings/arm/aspeed/aspeed,sbc.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
new file mode 100644
index 000000000000..c72aab706484
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+# Copyright 2021 Joel Stanley, IBM Corp.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/aspeed/aspeed,sbc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ASPEED Secure Boot Controller
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+  - Andrew Jeffery <andrew@aj.id.au>
+
+description: |
+  The ASPEED SoCs have a register bank for interacting with the secure boot
+  controller.
+
+properties:
+  compatible:
+    items:
+      - const: aspeed,ast2600-sbc
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
+    sbc: secure-boot-controller at 1e6f2000 {
+            compatible = "aspeed,ast2600-sbc";
+            reg = <0x1e6f2000 0x1000>;
+    };
-- 
2.33.0

