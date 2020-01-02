From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  2 Jan 2020 13:27:49 -0600
Subject: [PATCH v4 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
In-Reply-To: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1577993276-2184-6-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v3:
 - Switch "scu" property to "aspeed,scu"

 .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
new file mode 100644
index 000000000000..e0740ccfa910
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
@@ -0,0 +1,40 @@
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
+			  the XDMA engine
+ - interrupts-extended	: two interrupt cells; the first specifies the global
+			  interrupt for the XDMA engine and the second
+			  specifies the PCI-E reset or PERST interrupt.
+ - aspeed,scu		: a phandle to the syscon node for the system control
+			  unit of the SOC
+ - memory		: contains the address and size of the memory area to
+			  be used by the XDMA engine for DMA operations
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
+        compatible = "aspeed,ast2500-xdma";
+        reg = <0x1e6e7000 0x100>;
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        resets = <&syscon ASPEED_RESET_XDMA>;
+        interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+        scu = <&syscon>;
+        pcie-device = "bmc";
+        memory = <0x9f000000 0x01000000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b1048799508..0ed53fcfb181 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2709,6 +2709,12 @@ S:	Maintained
 F:	drivers/media/platform/aspeed-video.c
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 
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
2.24.0

