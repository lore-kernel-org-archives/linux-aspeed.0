From: Troy Lee <troy_lee@aspeedtech.com>
Date: Mon, 18 Jan 2021 06:50:49 +0000
Subject: [PATCH v3 1/4] dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
In-Reply-To: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
Message-ID: <20210118065059.2478078-2-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We add binding for supporting a new AST2600 PWM/Fan hwmon driver.

Changes since v2:
 - Fixed yamllint warnings/errors

Changes since v1:
 - dt binding with DT schema format

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Reported-by: Rob Herring <robh@kernel.org>
---
 .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
new file mode 100644
index 000000000000..fa5340f5a43f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-pwm-tachometer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 PWM and Fan Tacho controller device driver
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support upto 16 PWM outputs. The ASPEED Fan Tacho
+  controller can support upto 16 Fan tachometer inputs.
+  There can be upto 16 fans supported. Each fan can have one PWM output and
+  one Fan tach inputs.
+
+properties:
+  compatible:
+    const: aspeed,ast2600-pwm-tachometer
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#cooling-cells":
+    const: 2
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
+patternProperties:
+  "^fan@[0-9a-f]$":
+    type: object
+    description:
+      Under fan subnode there can upto 16 child nodes, with each child node
+      representing a fan. There are 16 fans each fan can have one PWM port and one
+      Fan tach inputs.
+      For PWM port can be configured cooling-levels to create cooling device.
+      Cooling device could be bound to a thermal zone for the thermal control.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 15
+        description:
+          This property identify the PWM control channel of this fan.
+
+      fan-tach-ch:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        minimum: 0
+        maximum: 15
+        description:
+          This property identify the fan tach input channel.
+
+      pulses-per-revolution:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        default: 2
+        minimum: 1
+        description:
+          Specify tacho pulse per revolution of the fan.
+
+      cooling-levels:
+        description:
+          PWM duty cycle values in a range from 0 to 255
+          which correspond to thermal cooling states.
+
+      aspeed,pwm-freq-hz:
+        default: 25000
+        minimum: 24
+        maximum: 780000
+        description:
+          Specify the frequency of PWM.
+
+      aspeed,inverse-pin:
+        type: boolean
+        description:
+          Inverse PWM output signal.
+
+      aspeed,falling-point:
+        $ref: /schemas/types.yaml#/definitions/uint8
+        default: 10
+        description:
+          Initialize the pulse width.
+
+    required:
+      - fan-tach-ch
+      - reg
+
+    additionalProperties: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm_tacho: pwm-tacho-controller at 1e610000 {
+        compatible = "aspeed,ast2600-pwm-tachometer";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x1e610000 0x100>;
+
+        fan at 1 {
+            reg = <0x00>;
+            aspeed,pwm-freq-hz = <25000>;
+            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+            fan-tach-ch = /bits/ 8 <0x00>;
+            pulses-per-revolution = <2>;
+        };
+
+        fan at 2 {
+            reg = <0x01>;
+            aspeed,pwm-freq-hz = <25000>;
+            cooling-levels = /bits/ 8 <125 151 177 203 229 255>;
+            fan-tach-ch = /bits/ 8 <0x01>;
+            pulses-per-revolution = <2>;
+        };
+    };
+...
-- 
2.25.1

