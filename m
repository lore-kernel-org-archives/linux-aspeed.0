From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 15 Jan 2020 15:29:41 -0600
Subject: [PATCH v6 03/12] ARM: dts: aspeed: ast2500: Add SCU interrupt
 controller
In-Reply-To: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1579123790-6894-4-git-send-email-eajames@linux.ibm.com>
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
index ebec0fa..1c40c8f 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -222,6 +222,13 @@
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
1.8.3.1

