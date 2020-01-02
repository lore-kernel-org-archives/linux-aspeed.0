From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  2 Jan 2020 13:27:47 -0600
Subject: [PATCH v4 03/12] ARM: dts: aspeed: ast2500: Add SCU interrupt
 controller
In-Reply-To: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1577993276-2184-4-git-send-email-eajames@linux.ibm.com>
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
index a259c63fff06..4791a50e37ee 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -231,6 +231,13 @@ p2a: p2a-control {
 					compatible = "aspeed,ast2500-p2a-ctrl";
 					status = "disabled";
 				};
+
+				scu_ic: interrupt-controller at 18 {
+					#interrupt-cells = <1>;
+					compatible = "aspeed,ast2500-scu-ic";
+					interrupts = <21>;
+					interrupt-controller;
+				};
 			};
 
 			rng: hwrng at 1e6e2078 {
-- 
2.24.0

