From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 Apr 2020 15:03:35 -0500
Subject: [PATCH v9 1/5] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
References: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1587067419-5107-2-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
Changes since v8:
 - dropped Rob's tag since this has changed significantly since he last looked
   it over.

 .../devicetree/bindings/soc/aspeed/xdma.txt        | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
new file mode 100644
index 0000000..35d0507
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
@@ -0,0 +1,45 @@
+Aspeed AST25XX and AST26XX XDMA Engine
+
+The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform automatic
+DMA operations over PCI between the SOC (acting as a BMC) and a host processor.
+
+Required properties:
+ - compatible		: must be "aspeed,ast2500-xdma" or
+			  "aspeed,ast2600-xdma"
+ - reg			: contains the address and size of the memory region
+			  associated with the XDMA engine registers
+ - clocks		: clock specifier for the clock associated with the
+			  XDMA engine
+ - resets		: reset specifier for the syscon reset associated with
+			  the XDMA engine, and, for the AST2600, a second reset
+			  associated with the PCI-E root complex
+ - reset-names		: required only for the AST2600; must be
+			  "device", "root-complex"
+ - interrupts-extended	: two interrupt cells; the first specifies the global
+			  interrupt for the XDMA engine and the second
+			  specifies the PCI-E reset or PERST interrupt.
+ - aspeed,scu		: a phandle to the syscon node for the system control
+			  unit of the SOC
+ - memory-region	: a phandle to the reserved memory region to be used by
+			  the XDMA engine for DMA operations
+
+Optional properties:
+ - pcie-device		: should be either "bmc" or "vga", corresponding to
+			  which device should be used by the XDMA engine for
+			  DMA operations. If this property is not set, the XDMA
+			  engine will use the BMC PCI-E device.
+
+Example:
+
+    xdma at 1e6e7000 {
+        compatible = "aspeed,ast2600-xdma";
+        reg = <0x1e6e7000 0x100>;
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
+        reset-names = "device", "root-complex";
+        interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                              <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
+        aspeed,scu = <&syscon>;
+        pcie-device = "bmc";
+        memory-region = <&vga_memory>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e10560..66f82a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2771,6 +2771,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed-video.c
 
+ASPEED XDMA ENGINE DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user at lists.sourceforge.net
-- 
1.8.3.1

