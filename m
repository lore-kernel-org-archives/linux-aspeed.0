From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  5 Dec 2019 11:15:08 -0600
Subject: [PATCH v2 08/12] ARM: dts: aspeed: ast2500: Add XDMA Engine
In-Reply-To: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1575566112-11658-9-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the XDMA engine with all the necessary information. Also
make the EDAC node compatible with syscon.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Add syscon compatible to the SDRAM controller so we can grab it in the
   XDMA driver
 - Add the new properties to the XDMA node

 arch/arm/boot/dts/aspeed-g5.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index df44022..6a83cd2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dt-bindings/clock/aspeed-clock.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
 
 / {
 	model = "Aspeed BMC";
@@ -48,7 +49,7 @@
 	};
 
 	edac: sdram at 1e6e0000 {
-		compatible = "aspeed,ast2500-sdram-edac";
+		compatible = "aspeed,ast2500-sdram-edac", "syscon";
 		reg = <0x1e6e0000 0x174>;
 		interrupts = <0>;
 		status = "disabled";
@@ -258,6 +259,18 @@
 				interrupts = <0x19>;
 			};
 
+			xdma: xdma at 1e6e7000 {
+				compatible = "aspeed,ast2500-xdma";
+				reg = <0x1e6e7000 0x100>;
+				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+				resets = <&syscon ASPEED_RESET_XDMA>;
+				interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+				pcie-device = "bmc";
+				scu = <&syscon>;
+				sdmc = <&edac>;
+				status = "disabled";
+			};
+
 			adc: adc at 1e6e9000 {
 				compatible = "aspeed,ast2500-adc";
 				reg = <0x1e6e9000 0xb0>;
-- 
1.8.3.1

