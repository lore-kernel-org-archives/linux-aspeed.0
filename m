From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Jul 2018 13:48:43 +1000
Subject: [PATCH v3 1/5] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
In-Reply-To: <20180712034847.12878-1-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
Message-ID: <20180712034847.12878-2-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This isn't per-se a real device, it's a pseudo-device that
represents the use of the Aspeed built-in ColdFire to
implement the FSI protocol by bitbanging the GPIOs instead
of doing it from the ARM core.

Thus it's a drop-in replacement for the existing
fsi-master-gpio pseudo-device for use on systems based
on the Aspeed chips. It has most of the same properties,
plus some more needed to operate the coprocessor.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
new file mode 100644
index 000000000000..431bf8a423ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
@@ -0,0 +1,36 @@
+Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
+------------------------------------------------------------------------
+
+Required properties:
+ - compatible =
+	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
+   or
+	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
+
+ - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
+ - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
+ - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
+ - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
+ - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
+                                          functions (eg, external FSI masters)
+ - memory-region = <phandle>;		: Reference to the reserved memory for
+                                          the ColdFire. Must be 2M aligned on
+					  AST2400 and 1M aligned on AST2500
+ - aspeed,sram = <phandle>;		: Reference to the SRAM node.
+ - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
+
+Examples:
+
+    fsi-master {
+        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
+
+	clock-gpios = <&gpio 0>;
+        data-gpios = <&gpio 1>;
+        enable-gpios = <&gpio 2>;
+        trans-gpios = <&gpio 3>;
+        mux-gpios = <&gpio 4>;
+
+	memory-region = <&coldfire_memory>;
+	sram = <&sram>;
+	cvic = <&cvic>;
+    }
-- 
2.17.1

