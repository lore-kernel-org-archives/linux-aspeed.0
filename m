From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Wed, 18 Sep 2024 18:17:41 +0800
Subject: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Message-ID: <20240918101742.1346788-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable interrupt setting and add GPIO line name for pca9555 for the I/O
expanders on Medusa board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..9292f42a39dc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -298,6 +298,20 @@ gpio at 20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "P48V_OCP_GPIO1", "P48V_OCP_GPIO2",
+				  "P48V_OCP_GPIO3", "FAN_BOARD_0_REVISION_0_R",
+				  "FAN_BOARD_0_REVISION_1_R",
+				  "FAN_BOARD_1_REVISION_0_R",
+				  "FAN_BOARD_1_REVISION_1_R", "RST_MUX_R_N",
+				  "RST_LED_CONTROL_FAN_BOARD_0_N",
+				  "RST_LED_CONTROL_FAN_BOARD_1_N",
+				  "RST_IOEXP_FAN_BOARD_0_N",
+				  "RST_IOEXP_FAN_BOARD_1_N",
+				  "PWRGD_LOAD_SWITCH_FAN_BOARD_0_R",
+				  "PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
+				  "", "";
 	};
 
 	gpio at 21 {
@@ -305,6 +319,19 @@ gpio at 21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "HSC_OCP_SLOT_ODD_GPIO1",
+				  "HSC_OCP_SLOT_ODD_GPIO2",
+				  "HSC_OCP_SLOT_ODD_GPIO3",
+				  "HSC_OCP_SLOT_EVEN_GPIO1",
+				  "HSC_OCP_SLOT_EVEN_GPIO2",
+				  "HSC_OCP_SLOT_EVEN_GPIO3",
+				  "ADC_TYPE_0_R", "ADC_TYPE_1_R",
+				  "MEDUSA_BOARD_REV_0", "MEDUSA_BOARD_REV_1",
+				  "MEDUSA_BOARD_REV_2", "MEDUSA_BOARD_TYPE",
+				  "DELTA_MODULE_TYPE", "P12V_HSC_TYPE",
+				  "", "";
 	};
 
 	gpio at 22 {
@@ -312,6 +339,16 @@ gpio at 22 {
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "CARD_TYPE_SLOT1", "CARD_TYPE_SLOT2",
+				  "CARD_TYPE_SLOT3", "CARD_TYPE_SLOT4",
+				  "CARD_TYPE_SLOT5", "CARD_TYPE_SLOT6",
+				  "CARD_TYPE_SLOT7", "CARD_TYPE_SLOT8",
+				  "OC_P48V_HSC_0_N", "FLT_P48V_HSC_0_N",
+				  "OC_P48V_HSC_1_N", "FLT_P48V_HSC_1_N",
+				  "EN_P48V_AUX_0", "EN_P48V_AUX_1",
+				  "PWRGD_P12V_AUX_0", "PWRGD_P12V_AUX_1";
 	};
 
 	gpio at 23 {
@@ -319,6 +356,16 @@ gpio at 23 {
 		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "HSC1_ALERT1_R_N", "HSC2_ALERT1_R_N",
+				  "HSC3_ALERT1_R_N", "HSC4_ALERT1_R_N",
+				  "HSC5_ALERT1_R_N", "HSC6_ALERT1_R_N",
+				  "HSC7_ALERT1_R_N", "HSC8_ALERT1_R_N",
+				  "HSC1_ALERT2_R_N", "HSC2_ALERT2_R_N",
+				  "HSC3_ALERT2_R_N", "HSC4_ALERT2_R_N",
+				  "HSC5_ALERT2_R_N", "HSC6_ALERT2_R_N",
+				  "HSC7_ALERT2_R_N", "HSC8_ALERT2_R_N";
 	};
 
 	temperature-sensor at 48 {
-- 
2.25.1

