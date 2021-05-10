From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 10 May 2021 15:35:10 +0800
Subject: [v4 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <20210510073511.7291-1-billy_tsai@aspeedtech.com>
References: <20210510073511.7291-1-billy_tsai@aspeedtech.com>
Message-ID: <20210510073511.7291-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds device binding for aspeed pwm-tach device which is a
multi-function device include pwm and tach function and pwm/tach device
bindings which should be the child-node of pwm-tach device.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 66 +++++++++++++++
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 82 +++++++++++++++++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 62 ++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
new file mode 100644
index 000000000000..1b502cccb362
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED Tach controller can support upto 16 fan input.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-tach
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+child-node:
+  type: object
+  properties:
+    reg:
+      description:
+        The tach channel used for this fan.
+      maxItems: 1
+    aspeed,min-rpm:
+      description:
+        define the minimal revolutions per minute of the measure fan
+        used to calculate the sample period of tach
+      default: 1000
+    aspeed,pulse-pr:
+      description:
+        Value specifying the number of pulses per revolution of the
+        monitored FAN.
+      default: 2
+    aspeed,tach-div:
+      description:
+        define the tachometer clock divider as an integer. Formula of
+        tach clock = clock source / (2^tach-div)^2
+      minimum: 0
+      maximum: 15
+      # The value that should be used if the property is not present
+      default: 5
+  required:
+    - reg
diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
new file mode 100644
index 000000000000..97edc50b149b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM Tach controller Device Tree Bindings
+
+description: |
+  The PWM Tach controller is represented as a multi-function device which
+  includes:
+    PWM
+    Tach
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2600-pwm-tach
+      - const: syscon
+      - const: simple-mfd
+  reg:
+    maxItems: 1
+  clocks:
+    maxItems: 1
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+child-node:
+  "^pwm(@[0-9a-f]+)?$":
+    $ref: ../pwm/aspeed,ast2600-pwm.yaml
+
+  "^tach(@[0-9a-f]+)?$":
+    $ref: ../hwmon/aspeed,ast2600-tach.yaml
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    pwm_tach: pwm_tach at 1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+
+      pwm: pwm {
+        compatible = "aspeed,ast2600-pwm";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #pwm-cells = <3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm0_default>;
+        pwm-ch at 0 {
+          reg = <0>;
+          aspeed,wdt-reload-enable;
+          aspeed,wdt-reload-duty-point = <32>;
+        };
+      };
+
+      tach: tach {
+        compatible = "aspeed,ast2600-tach";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tach0_default>;
+        fan at 0 {
+          reg = <0>;
+          aspeed,min-rpm = <1000>;
+          aspeed,pulse-pr = <2>;
+          aspeed,tach-div = <5>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
new file mode 100644
index 000000000000..f863b2866871
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
@@ -0,0 +1,62 @@
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
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm
+
+  "#pwm-cells":
+    const: 3
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+
+required:
+  - compatible
+  - "#pwm-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+child-node:
+  description: Set extend properties for each pwm channel.
+  type: object
+  properties:
+    reg:
+      description:
+        The pwm channel index.
+      maxItems: 1
+    aspeed,wdt-reload-enable:
+      type: boolean
+      description:
+        Enable the function of wdt reset reload duty point.
+    aspeed,wdt-reload-duty-point:
+      description:
+        Define the duty point after wdt reset, 0 = 100%
+      minimum: 0
+      maximum: 255
+  required:
+    - reg
-- 
2.25.1

