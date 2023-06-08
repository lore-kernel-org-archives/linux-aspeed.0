From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Jun 2023 10:18:37 +0800
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control documentation
In-Reply-To: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
Message-ID: <20230608021839.12769-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the compatible for aspeed,ast2600-tach device.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
new file mode 100644
index 000000000000..627aa00f2e92
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
@@ -0,0 +1,32 @@
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
+  The Aspeed Tach controller can support upto 1 fan input.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-tach
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - resets
+
+additionalProperties: false
-- 
2.25.1

