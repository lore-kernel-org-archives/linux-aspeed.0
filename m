From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  4 Feb 2020 16:49:08 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: ast2600: Fix SCU IRQ controller node
 addresses
In-Reply-To: <20200204224908.19967-1-eajames@linux.ibm.com>
References: <20200204224908.19967-1-eajames@linux.ibm.com>
Message-ID: <20200204224908.19967-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The nodes were defined with a unit address but had no reg property,
resulting in a warning. The address is unecessary, so drop it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 82a3cd10cc2b..6f6a2d0217dc 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -269,14 +269,14 @@ smp-memram at 180 {
 					reg = <0x180 0x40>;
 				};
 
-				scu_ic0: interrupt-controller at 0 {
+				scu_ic0: interrupt-controller {
 					#interrupt-cells = <1>;
 					compatible = "aspeed,ast2600-scu-ic0";
 					interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 					interrupt-controller;
 				};
 
-				scu_ic1: interrupt-controller at 1 {
+				scu_ic1: interrupt-controller {
 					#interrupt-cells = <1>;
 					compatible = "aspeed,ast2600-scu-ic1";
 					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.24.0

