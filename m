From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  5 May 2020 11:58:23 -0500
Subject: [PATCH v11 6/8] ARM: dts: Aspeed: AST2500: Update XDMA engine node
In-Reply-To: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
References: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1588697905-23444-7-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correct the pcie-device property, and add the Aspeed SCU interrupt
controller include.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 284face..8d9eeef 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dt-bindings/clock/aspeed-clock.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
 
 / {
 	model = "Aspeed BMC";
@@ -267,8 +268,8 @@
 				reg = <0x1e6e7000 0x100>;
 				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
 				resets = <&syscon ASPEED_RESET_XDMA>;
-				interrupts-extended = <&vic 6>, <&scu_ic 2>;
-				pcie-device = "bmc";
+				interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+				aspeed,pcie-device = "bmc";
 				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
-- 
1.8.3.1

