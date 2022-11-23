From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 23 Nov 2022 14:16:33 +0800
Subject: [v4 3/5] dt-bindings: hwmon: Add bindings for aspeed tach controller
In-Reply-To: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
Message-ID: <20221123061635.32025-4-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the aspeed tach device bindings which should be the child-node of
pwm-tach mfd.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
new file mode 100644
index 000000000000..f42114f8e3c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Ast2600 Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The Aspeed Tach controller can support upto 16 fan input.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-tach
+patternProperties:
+  "^fan@[a-z0-9]+$":
+    type: object
+    properties:
+      reg:
+        description:
+          The tach channel used for this node.
+        maxItems: 1
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.25.1

