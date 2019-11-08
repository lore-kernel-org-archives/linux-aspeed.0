From: Eddie James <eajames@linux.ibm.com>
Date: Fri,  8 Nov 2019 14:18:30 -0600
Subject: [PATCH 09/12] ARM: dts: aspeed: ast2600: Add XDMA Engine
In-Reply-To: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1573244313-9190-10-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the XDMA engine with all the necessary information.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 65ea2b2..61bd717 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/ast2600-clock.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
 
 / {
 	model = "Aspeed BMC";
@@ -315,6 +316,16 @@
 				quality = <100>;
 			};
 
+			xdma: xdma at 1e6e7000 {
+				compatible = "aspeed,ast2600-xdma";
+				reg = <0x1e6e7000 0x100>;
+				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+				resets = <&syscon ASPEED_RESET_DEV_XDMA>;
+				interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+						      <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
+				status = "disabled";
+			};
+
 			gpio0: gpio at 1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
1.8.3.1

