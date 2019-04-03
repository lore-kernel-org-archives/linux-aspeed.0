From: Joel Stanley <joel@jms.id.au>
Date: Wed,  3 Apr 2019 10:49:07 +1030
Subject: [PATCH v3 1/3] dt-bindings: gpu: Add ASPEED GFX bindings document
In-Reply-To: <20190403001909.31637-1-joel@jms.id.au>
References: <20190403001909.31637-1-joel@jms.id.au>
Message-ID: <20190403001909.31637-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This describes the ASPEED BMC SoC's display controller.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
v3:
 Add Andrew's reviewed-by

 .../devicetree/bindings/gpu/aspeed-gfx.txt    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt

diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
new file mode 100644
index 000000000000..a74033332668
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
@@ -0,0 +1,41 @@
+Device tree configuration for the GFX display deivce on the AST2500 SoCs.
+
+Required properties:
+  - compatible
+    * Must be one of the following:
+      + aspeed,ast2500-gfx
+      + aspeed,ast2400-gfx
+    * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
+      be present
+
+  - reg: Physical base address and length of the GFX registers
+
+  - interrupts: interrupt number for the GFX device
+
+  - clocks: clock number used to generate the pixel clock
+
+  - resets: reset line that must be released to use the GFX device
+
+  - memory-region:
+    Phandle to a memory region to allocate from, as defined in
+    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+
+
+Example:
+
+gfx: display at 1e6e6000 {
+	compatible = "aspeed,ast2500-gfx", "syscon";
+	reg = <0x1e6e6000 0x1000>;
+	reg-io-width = <4>;
+	clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
+	resets = <&syscon ASPEED_RESET_CRT1>;
+	interrupts = <0x19>;
+	memory-region = <&gfx_memory>;
+};
+
+gfx_memory: framebuffer {
+	size = <0x01000000>;
+	alignment = <0x01000000>;
+	compatible = "shared-dma-pool";
+	reusable;
+};
-- 
2.20.1

