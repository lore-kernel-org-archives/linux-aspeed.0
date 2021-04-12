From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Apr 2021 17:54:55 +0800
Subject: [PATCH 2/4] dt-bindings: Add bindings for aspeed pwm
In-Reply-To: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
Message-ID: <20210412095457.15095-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds device bindings for aspeed pwm device which should be
the sub-node of aspeed,ast2600-pwm-tach.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
new file mode 100644
index 000000000000..7a7ff0260d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 PWM controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support upto 16 PWM outputs.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm
+
+  "#pwm-cells":
+    const: 3
+
+pwm-cells:
+  - channel
+# period in terms of nanoseconds
+  - period
+# PWM_POLARITY_INVERTED
+  - flag
+
+additionalProperties: false
+
+examples:
+  - |
+    // The PWM should be a subnode of a "aspeed,ast2600-pwn-tach" compatible node.
+    pwm_tach at 1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "simple-mfd", "syscon";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      reg = <0x1e610000 0x100>;
+      ranges = <0 0x1e610000 0x100>;
+      pwm: pwm at 0 {
+        compatible = "aspeed,ast2600-pwm";
+        #pwm-cells = <3>;
+        reg = <0x0 0x100>;
+      };
+    };
-- 
2.25.1

