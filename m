From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 14 Dec 2022 15:01:13 +0800
Subject: [PATCH v4 3/4] dt-bindings: crypto: add documentation for Aspeed ACRY
In-Reply-To: <20221214070114.3966155-1-neal_liu@aspeedtech.com>
References: <20221214070114.3966155-1-neal_liu@aspeedtech.com>
Message-ID: <20221214070114.3966155-4-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add device tree binding documentation for the Aspeed
ECDSA/RSA ACRY Engines Controller.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/crypto/aspeed,ast2600-acry.yaml  | 49 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 2 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml

diff --git a/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
new file mode 100644
index 000000000000..b18f178aac06
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED ACRY ECDSA/RSA Hardware Accelerator Engines
+
+maintainers:
+  - Neal Liu <neal_liu@aspeedtech.com>
+
+description:
+  The ACRY ECDSA/RSA engines is designed to accelerate the throughput
+  of ECDSA/RSA signature and verification. Basically, ACRY can be
+  divided into two independent engines - ECC Engine and RSA Engine.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-acry
+
+  reg:
+    items:
+      - description: acry base address & size
+      - description: acry sram base address & size
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    acry: crypto at 1e6fa000 {
+        compatible = "aspeed,ast2600-acry";
+        reg = <0x1e6fa000 0x400>, <0x1e710000 0x1800>;
+        interrupts = <160>;
+        clocks = <&syscon ASPEED_CLK_GATE_RSACLK>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 164f67e59e5f..e6157d18d804 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3214,7 +3214,7 @@ ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
 L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
+F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
-- 
2.25.1

