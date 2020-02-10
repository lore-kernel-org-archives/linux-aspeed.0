From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 10 Feb 2020 13:32:26 -0600
Subject: [PATCH v2 1/2] ARM: dts: aspeed: ast2500: Fix SCU IRQ controller node
In-Reply-To: <1581363147-19310-1-git-send-email-eajames@linux.ibm.com>
References: <1581363147-19310-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1581363147-19310-2-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The node was defined with a unit address but had no reg property,
resulting in a warning. Add a reg property for consistency to fix the
warning.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 569f9d7..9db7bde 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -225,6 +225,7 @@
 				scu_ic: interrupt-controller at 18 {
 					#interrupt-cells = <1>;
 					compatible = "aspeed,ast2500-scu-ic";
+					reg = <0x18 0x4>;
 					interrupts = <21>;
 					interrupt-controller;
 				};
-- 
1.8.3.1

