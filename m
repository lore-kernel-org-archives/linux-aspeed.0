From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 23 Nov 2022 14:16:32 +0800
Subject: [v4 2/5] dt-bindings: pwm: Add bindings for aspeed pwm controller
In-Reply-To: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
Message-ID: <20221123061635.32025-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the aspeed pwm device bindings which should be the child-node of
pwm-tach mfd.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
new file mode 100644
index 000000000000..68a60fc73902
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Ast2600 PWM controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The Aspeed PWM controller supports up to 16 PWM outputs.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm
+
+  "#pwm-cells":
+    const: 3
+patternProperties:
+  "^pwm@[a-z0-9]+$":
+    description: Set extend properties for each pwm channel.
+    type: object
+    properties:
+      reg:
+        description:
+          The pwm channel index.
+        maxItems: 1
+
+      aspeed,wdt-reload-enable:
+        type: boolean
+        description:
+          Enable the function of wdt reset reload duty point.
+
+      aspeed,wdt-reload-duty-point:
+        description:
+          Define the duty point after wdt reset, 0 = 100%
+        minimum: 0
+        maximum: 255
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.25.1

