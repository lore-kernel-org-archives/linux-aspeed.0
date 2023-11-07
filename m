From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 7 Nov 2023 18:39:54 +0800
Subject: [PATCH v10 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
In-Reply-To: <20231107103955.1166655-1-billy_tsai@aspeedtech.com>
References: <20231107103955.1166655-1-billy_tsai@aspeedtech.com>
Message-ID: <20231107103955.1166655-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the compatible for aspeed,ast2600-pwm-tach device, which can
support up to 16 PWM outputs and 16 fan tach input.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
new file mode 100644
index 000000000000..c615fb10705c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2023 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED G6 PWM and Fan Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support up to 16 PWM outputs.
+  The ASPEED Fan Tacho controller can support up to 16 fan tach input.
+  They are independent hardware blocks, which are different from the
+  previous version of the ASPEED chip.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm-tach
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - tach-ch
+
+required:
+  - reg
+  - clocks
+  - resets
+  - "#pwm-cells"
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    pwm_tach: pwm-tach-controller at 1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+      #pwm-cells = <3>;
+
+      fan-0 {
+        tach-ch = /bits/ 8 <0x0>;
+      };
+
+      fan-1 {
+        tach-ch = /bits/ 8 <0x1 0x2>;
+      };
+    };
-- 
2.25.1

