From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  9 Jan 2020 14:58:54 -0600
Subject: [PATCH v5 03/12] ARM: dts: aspeed: ast2500: Add SCU interrupt
 controller
In-Reply-To: <20200109205903.27036-1-eajames@linux.ibm.com>
References: <20200109205903.27036-1-eajames@linux.ibm.com>
Message-ID: <20200109205903.27036-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the interrupt controller provided by the SCU.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ebec0fa8baa7..1c40c8f5b431 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -222,6 +222,13 @@ syscon: syscon at 1e6e2000 {
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
+				scu_ic: interrupt-controller at 18 {
+					#interrupt-cells = <1>;
+					compatible = "aspeed,ast2500-scu-ic";
+					interrupts = <21>;
+					interrupt-controller;
+				};
+
 				p2a: p2a-control at 2c {
 					compatible = "aspeed,ast2500-p2a-ctrl";
 					reg = <0x2c 0x4>;
-- 
2.24.0

