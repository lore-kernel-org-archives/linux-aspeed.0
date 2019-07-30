From: Oskar Senft <osk@google.com>
Date: Mon, 29 Jul 2019 21:49:54 -0400
Subject: [PATCH v2 2/3] dt-bindings: misc: Bindings doc for aspeed-uart-routing
In-Reply-To: <20190730014955.34059-1-osk@google.com>
References: <20190730014955.34059-1-osk@google.com>
Message-ID: <20190730014955.34059-2-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Device tree bindings documentation for the aspeed-uart-routing driver.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes since v1:
 Split out bindings documentation from driver commit.
 Added bindings for AST2400.

 .../bindings/misc/aspeed-uart-routing.txt     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-uart-routing.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-uart-routing.txt b/Documentation/devicetree/bindings/misc/aspeed-uart-routing.txt
new file mode 100644
index 000000000000..bb9ce689d56b
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-uart-routing.txt
@@ -0,0 +1,39 @@
+======================================================================
+Device tree bindings for Aspeed AST2400/AST2500 UART Routing Control Driver
+======================================================================
+
+The Aspeed AST2500 allows to dynamically route the inputs for the built-in
+UARTS and physical serial I/O ports.
+
+Required properties:
+===================
+
+ - compatible: must be one of:
+	- "aspeed,ast2400-uart-routing"
+	- "aspeed,ast2500-uart-routing"
+
+Optional properties:
+===================
+
+The uart-routing node should be the child of a lpc node with the required
+property:
+
+- compatible : Should be one of the following:
+		"aspeed,ast2400-lpc", "simple-mfd"
+		"aspeed,ast2500-lpc", "simple-mfd"
+
+Example
+===================
+
+g5 Example
+----------
+
+lpc: lpc at 1e789000 {
+	compatible = "aspeed,ast2500-lpc", "simple-mfd";
+	reg = <0x1e789000 0x1000>;
+
+	uart_routing: uart_routing at 9c {
+		compatible = "aspeed,ast2500-uart-routing";
+		reg = <0x9c 0x4>;
+	};
+};
-- 
2.22.0.709.g102302147b-goog

