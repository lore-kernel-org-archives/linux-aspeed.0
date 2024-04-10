From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 15:55:52 -0000
Subject: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
In-Reply-To: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
Message-ID: <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert existing binding to dtschema to support validation.

Add the undocumented 'clocks' property.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
 .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
deleted file mode 100644
index a87a1e9bc060..000000000000
--- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* NXP LPC32xx SoC Real Time Clock controller
-
-Required properties:
-- compatible: must be "nxp,lpc3220-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: The RTC interrupt
-
-Example:
-
-	rtc at 40024000 {
-		compatible = "nxp,lpc3220-rtc";
-		reg = <0x40024000 0x1000>;
-		interrupts = <52 0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
new file mode 100644
index 000000000000..62ddeef961e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx SoC Real Time Clock
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: nxp,lpc3220-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc at 40024000 {
+        compatible = "nxp,lpc3220-rtc";
+        reg = <0x40024000 0x1000>;
+        interrupts = <52 0>;
+    };

-- 
2.40.1

