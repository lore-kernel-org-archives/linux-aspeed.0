From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Apr 2021 17:54:54 +0800
Subject: [PATCH 1/4] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
Message-ID: <20210412095457.15095-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds device bindings for aspeed pwm-tach device which is a
multi-function device include pwn and tach function.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
new file mode 100644
index 000000000000..73512ff71d23
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwn-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM Tach controller Device Tree Bindings
+
+description: |
+  The PWM Tach controller is represented as a multi-function device which includes:
+    PWM
+    Tach
+
+maintainers:
+  - Billy Tsai <billy_tasi@aspeedtech.com>
+
+properties:
+  compatible:
+    - items:
+        - enum:
+            - aspeed,ast2600-pwn-tach
+        - const: syscon
+        - const: simple-mfd
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
+    pwm_tach: pwm_tach at 1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "simple-mfd", "syscon";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      reg = <0x1e610000 0x100>;
+
+      pwm: pwm at 0 {
+        compatible = "aspeed,ast2600-pwm";
+        #pwm-cells = <3>;
+        reg = <0x0 0x100>;
+      };
+
+      tach: tach at 0 {
+        compatible = "aspeed,ast2600-tach";
+        reg = <0x0 0x100>;
+      };
+    };
-- 
2.25.1

