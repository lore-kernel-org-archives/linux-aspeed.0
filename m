From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 24 Sep 2019 11:14:31 -0500
Subject: [PATCH 3/4] ARM: dts: aspeed: ast2500: Add SCU interrupt controller
In-Reply-To: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
References: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
Message-ID: <1569341672-27632-4-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a node for the interrupt controller provided by the SCU.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index e8feb8b..450c2d2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -209,8 +209,9 @@
 			syscon: syscon at 1e6e2000 {
 				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
+				ranges = <0 0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
@@ -224,6 +225,14 @@
 					compatible = "aspeed,ast2500-p2a-ctrl";
 					status = "disabled";
 				};
+
+				scu_ic: interrupt-controller at 18 {
+					#interrupt-cells = <1>;
+					compatible = "aspeed,ast2500-scu-ic";
+					reg = <0x18 0x04>;
+					interrupts = <21>;
+					interrupt-controller;
+				};
 			};
 
 			rng: hwrng at 1e6e2078 {
-- 
1.8.3.1

