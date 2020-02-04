From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  4 Feb 2020 16:49:07 -0600
Subject: [PATCH 1/2] ARM: dts: aspeed: ast2500: Fix SCU IRQ controller node
 address
In-Reply-To: <20200204224908.19967-1-eajames@linux.ibm.com>
References: <20200204224908.19967-1-eajames@linux.ibm.com>
Message-ID: <20200204224908.19967-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The node was defined with a unit address but had no reg property,
resulting in a warning. The address is unecessary, so drop it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 569f9d74c696..aeee18fc1e7e 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -222,7 +222,7 @@ syscon: syscon at 1e6e2000 {
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
-				scu_ic: interrupt-controller at 18 {
+				scu_ic: interrupt-controller {
 					#interrupt-cells = <1>;
 					compatible = "aspeed,ast2500-scu-ic";
 					interrupts = <21>;
-- 
2.24.0

