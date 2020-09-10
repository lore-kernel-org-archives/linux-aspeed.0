From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 19:57:28 +0200
Subject: [PATCH v2 10/15] ARM: dts: am3874: iceboard: fix GPIO expander reset
 GPIOs
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Message-ID: <20200910175733.11046-11-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Correct the property for reset GPIOs of the GPIO expander.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/am3874-iceboard.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index 1bb57019d082..9423e9feaa10 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -195,7 +195,7 @@
 					"FMCA_PG_C2M", "FMCA_PRSNT_M2C_L", "FMCA_CLK_DIR", "SFP_LOS",
 					"FMCB_EN_12V0", "FMCB_EN_3V3", "FMCB_EN_VADJ", "FMCB_PG_M2C",
 					"FMCB_PG_C2M", "FMCB_PRSNT_M2C_L", "FMCB_CLK_DIR", "SFP_ModPrsL";
-				reset_gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			};
 
 			u42: pca9575 at 21 {
@@ -208,7 +208,7 @@
 					"QSFPA_LPMode", "QSFPB_ModPrsL", "QSFPB_IntL", "QSFPB_ResetL",
 					"SFP_TxFault", "SFP_TxDisable", "SFP_RS0", "SFP_RS1",
 					"QSFPB_ModSelL", "QSFPB_LPMode", "SEL_SFP", "ARM_MR";
-				reset_gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			};
 
 			u48: pca9575 at 22 {
@@ -227,7 +227,7 @@
 					"GP_SW5", "GP_SW6", "GP_SW7", "GP_SW8",
 					"GP_LED8", "GP_LED7", "GP_LED6", "GP_LED5",
 					"GP_LED4", "GP_LED3", "GP_LED2", "GP_LED1";
-				reset_gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			};
 
 			u59: pca9575 at 23 {
@@ -240,7 +240,7 @@
 					"GTX1V8PowerFault", "PHYAPowerFault", "PHYBPowerFault", "ArmPowerFault",
 					"BP_SLOW_GPIO0", "BP_SLOW_GPIO1", "BP_SLOW_GPIO2", "BP_SLOW_GPIO3",
 					"BP_SLOW_GPIO4", "BP_SLOW_GPIO5", "__unused_u59_p16", "__unused_u59_p17";
-				reset_gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+				reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			};
 
 			tmp100 at 48 { compatible = "ti,tmp100"; reg = <0x48>; };
-- 
2.17.1

