From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 3 Jul 2019 16:01:09 -0400
Subject: [linux,dev-5.1 v1] dt-bindings: gpio: aspeed: Add SGPIO support
Message-ID: <1562184069-22332-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add bindings to support SGPIO on AST2400 or AST2500.

Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 .../devicetree/bindings/gpio/sgpio-aspeed.txt      | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
new file mode 100644
index 0000000..f5fc6ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
@@ -0,0 +1,36 @@
+Aspeed SGPIO controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- compatible		: Either "aspeed,ast2400-sgpio" or "aspeed,ast2500-sgpio"
+
+- #gpio-cells 		: Should be two
+			  - First cell is the GPIO line number
+			  - Second cell is used to specify optional
+			    parameters (unused)
+
+- reg			: Address and length of the register set for the device
+- gpio-controller	: Marks the device node as a GPIO controller.
+- interrupts		: Interrupt specifier (see interrupt bindings for
+			  details)
+- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
+
+Optional properties:
+
+- clocks                : A phandle to the clock to use for debounce timings
+
+The sgpio and interrupt properties are further described in their respective
+bindings documentation:
+
+- Documentation/devicetree/bindings/sgpio/gpio.txt
+- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+  Example:
+	sgpio at 1e780200 {
+		#gpio-cells = <2>;
+		compatible = "aspeed,ast2500-sgpio";
+		gpio-controller;
+		interrupts = <40>;
+		reg = <0x1e780200 0x0100>;
+		interrupt-controller;
+	};
-- 
2.7.4

