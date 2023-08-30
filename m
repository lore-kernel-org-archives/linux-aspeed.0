From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 30 Aug 2023 20:32:00 +0800
Subject: [PATCH v8 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
In-Reply-To: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
Message-ID: <20230830123202.3408318-2-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Naresh Solanki <naresh.solanki@9elements.com>

Add common fan properties bindings to a schema.

Bindings for fan controllers can reference the common schema for the
fan

child nodes:

  patternProperties:
    "^fan@[0-2]":
      type: object
      $ref: fan-common.yaml#

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/hwmon/fan-common.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..a69b4d553e45
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Fan Properties
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+properties:
+  max-rpm:
+    description:
+      Max RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  min-rpm:
+    description:
+      Min RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  pulses-per-revolution:
+    description:
+      The number of pulse from fan sensor per revolution.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  div:
+    description:
+      Fan clock divisor
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  target-rpm:
+    description:
+      Target RPM the fan should be configured during driver probe.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mode:
+    description:
+      Select the operational mode of the fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  pwms:
+    description:
+      PWM provider.
+
+  tach-ch:
+    description:
+      The tach channel used for the fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  label:
+    description:
+      Optional fan label
+
+  fan-supply:
+    description:
+      Power supply for fan.
+
+additionalProperties: true
+
+...
-- 
2.25.1

